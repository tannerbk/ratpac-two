import numpy as np
import uproot
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers

def DirectionLossFunction(y_true, y_pred):
    c = (tf.cast(y_pred, tf.float64))
    d = (tf.cast(y_true, tf.float64))
    constraint = tf.square( tf.sqrt(tf.reduce_sum(tf.square(c), axis=1)) - 1 )*100
    dotproduct = -(tf.reduce_sum(tf.multiply(c,d), axis=1))
    return tf.reduce_mean( tf.add(dotproduct, constraint) )

class eostf:
    xdim = 26
    ydim = 26
    rail = 10.0
    tmod = 10.0
    split = 0.8
    def __init__(self, trainingFile, **kwargs):
        self.training_file = trainingFile
        self.batchsize = kwargs.get("batchsize", 10000)
        self.module = kwargs.get("module", "position")
        self.optimizer = kwargs.get("optimizer", "adam")
        self.iterations = kwargs.get("iterations", 500)
        if self.module not in ["position", "direction"]:
            raise AttributeError
        self.loss = 'mse' if self.module == "position" else DirectionLossFunction
        self.labels = ['mcx', 'mcy', 'mcz'] if self.module == "position" else ['mcu', 'mcv', 'mcw']
        self.dims = len(self.labels)
        self.modelShape = (self.xdim, self.ydim, self.dims)
        self.define_model()

    def generateImages(self, data, meta):
        images = []
        for(idx, (htime, event, pmtid)) in enumerate(
                zip(data["hitPMTTime"], data["hitPMTCharge"], data["hitPMTID"])):
            xx = meta['pmtX'][0][pmtid]
            yy = meta['pmtY'][0][pmtid]
            zz = meta['pmtZ'][0][pmtid]
            rr = np.sqrt(xx**2 + yy**2 + zz**2)
            theta = ((zz/rr + 1-1e-9)/2 * self.xdim).astype(int)
            phi = np.floor((np.arctan2(yy,xx)+np.pi-1e-9)/2/np.pi*self.ydim).astype(int)
            red = np.zeros((self.xdim,self.ydim))
            green = np.zeros((self.xdim,self.ydim))
            red[theta,phi] = htime*self.tmod/255
            green[theta,phi] = event/self.rail
            images.append(np.dstack([red,green]))
        return np.array(images)

    def prepData(self, df):
        rho = np.sqrt(df['mcu']**2 + df['mcv']**2 + df['mcw']**2)
        df['mctheta'] = df['mcw'] / rho
        df['mcphi'] = np.arctan2(df['mcv'], df['mcu'])

    def load_data(self, tfileName, index):
        tfile = uproot.open(tfileName)
        meta = tfile['meta'].arrays(library="np")
        self.batchgen_size = int(meta['dsentries'][0] / self.batchsize)
        data = tfile['output'].arrays(
                ['mcx','mcy','mcz','mcu','mcv','mcw','hitPMTTime','hitPMTCharge','hitPMTID'],
                library="np",
                entry_start=self.batchsize*index,
                entry_stop=int(self.batchsize*self.split) - 1 + self.batchsize*index)
        self.prepData(data)
        imageSet = self.generateImages(data, meta)
        dataLabel = np.dstack([data[lbl] for lbl in self.labels]).astype(float)
        dataLabel = dataLabel.reshape(len(data[self.labels[0]]), len(self.labels))
        return imageSet, dataLabel

    def load_validation(self, tfileName, index):
        tfile = uproot.open(tfileName)
        meta = tfile['meta'].arrays(library="np")
        self.validgen_size = int(meta['dsentries'][0] / self.batchsize)
        data = tfile['output'].arrays(
                ['mcx','mcy','mcz','mcu','mcv','mcw','hitPMTTime','hitPMTCharge','hitPMTID'],
                library="np",
                entry_start=self.batchsize*index + int(self.batchsize*self.split),
                entry_stop=self.batchsize*(index + 1) - 1)
        self.prepData(data)
        imageSet = self.generateImages(data, meta)
        dataLabel = np.dstack([data[lbl] for lbl in self.labels]).astype(float)
        dataLabel = dataLabel.reshape(len(data[self.labels[0]]), len(self.labels))
        return imageSet, dataLabel

    def batch_generator(self, tfileName):
        self.batchgen_size = 1
        index = 1
        while True:
            yield self.load_data(tfileName, index-1)
            if index < self.batchgen_size:
                index += 1
            else:
                index = 1

    def validation_generator(self, tfileName):
        self.validgen_size = 1
        index = 1
        while True:
            yield self.load_validation(tfileName, index-1)
            if index < self.validgen_size:
                index += 1
            else:
                index = 1

    def define_model(self):
        self.model = keras.models.Sequential()

        dropLevel = 0.0
        self.model.add(layers.Conv2D(16, (3,3), activation='relu', input_shape=(self.xdim,self.ydim,2) ))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Conv2D(32, (3,3), activation='relu' ))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Conv2D(64, (3,3), activation='relu' ))
        self.model.add(layers.MaxPooling2D((2,2)))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Dropout(dropLevel))
        self.model.add(layers.Conv2D(128, (3,3), activation='relu' ))
        self.model.add(layers.MaxPooling2D((2,2)))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Dropout(dropLevel))
        self.model.add(layers.Flatten())
        self.model.add(layers.Dense(64, activation='relu'))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Dropout(dropLevel))
        self.model.add(layers.Dense(32, activation='relu'))
        self.model.add(layers.BatchNormalization())
        self.model.add(layers.Dropout(dropLevel))
        self.model.add(layers.Dense(16, activation='relu'))
        self.model.add(layers.BatchNormalization())
        
        self.model.add(layers.Dense(self.dims, activation='linear'))

    def train_model(self):
        datagen = self.batch_generator(self.training_file)
        valigen = self.validation_generator(self.training_file)

        self.model.compile(optimizer=self.optimizer, loss=self.loss, metrics=[self.loss])
        self.histories = []
        for i in range(self.iterations):
            training_set, training_labels = next(datagen)
            validation_set, validation_labels = next(valigen)
            history = self.model.fit( training_set, training_labels, epochs=10, verbose=0,
                                 validation_data=(validation_set, validation_labels))
            self.histories.append(history)
            print(f"Done with: {i}/{self.iterations}", end="\r")
        print(f"\n** Complete **")

    def save_model(self, directory):
        self.model.save(directory)

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("training", type=str)
    parser.add_argument("-d", "--directory", type=str)
    parser.add_argument("-m", "--module", type=str, choices=["position", "direction"], default="position")
    parser.add_argument("-i", "--iterations", type=int, default=500)
    args = parser.parse_args()

    model = eostf( args.training, module=args.module, iterations=args.iterations )
    model.train_model()
    model.save_model(args.directory)
