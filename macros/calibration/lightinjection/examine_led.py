import numpy as np
import matplotlib.pyplot as plt
import uproot
import pandas as pd
import awkward as ak

#|%%--%%| <1ySE3cRtJW|BHtCFCAIWM>

tfile = uproot.open("output.ntuple.root")
ttree = tfile['output']

photon_energy = ttree['trackKE'].array()
primary_photon = ak.flatten(photon_energy[:,:,0])

expected_wavelength_intensity = lambda x: np.cos(np.pi * x / 100)**2 / 50

hbarc = 197.3269718 # MeV fm
convert_to_wavelength = lambda x: hbarc / x * 2 * np.pi / 1e6
wl_bins = np.arange(350, 450, 1)
plt.hist(convert_to_wavelength(primary_photon), bins=wl_bins, density=True, label='MC')
plt.plot(wl_bins, expected_wavelength_intensity(wl_bins), label='Input')
plt.xlabel("Wavelength (nm)")
plt.xlim(wl_bins.min(), wl_bins.max())
plt.ylim(bottom=0)
plt.legend()
plt.savefig("wavelength.svg")
plt.show()

expected_time_intensity = lambda x: np.exp(-x/10)/10

akw = ttree['trackTime'].array()
tm_bins = np.arange(0, 101, 1)
plt.hist(ak.flatten(akw[:,:,0]), bins=tm_bins, density=True, label='MC')
plt.plot(tm_bins, expected_time_intensity(tm_bins), label='Input')
plt.xlabel("Time (ns)")
plt.xlim(tm_bins.min(), tm_bins.max())
plt.ylim(bottom=0)
plt.legend()
plt.savefig("time.svg")
plt.show()
