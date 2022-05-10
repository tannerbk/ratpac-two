OBJ_DIR := objects
SRC_DIR := src
INC_DIR := include

SRC := $(wildcard *.cpp)
EXE := $(patsubst %.cpp, %, $(SRC))
EOS := $(shell pwd)/data
RAT := -L$(RATROOT)/lib -lRATPAC -I$(INC_DIR) -I$(RATROOT)/include
ROOT := $(shell root-config --libs --cflags)
G4 := $(shell geant4-config --libs --cflags)
FLAGS := --std=c++17 -w
GCC := g++

_OBJS := $(patsubst $(SRC_DIR)/%.cc, %.o, $(wildcard $(SRC_DIR)/*.cc))
OBJS := $(patsubst %,$(OBJ_DIR)/%,$(_OBJS))

all: $(SRC) $(EXE) $(OBJS)

%: %.cpp $(OBJS)
	$(GCC) $(FLAGS) $(ROOT) $(G4) $(RAT) $(OBJS) $@.cpp -o $@
	printf "export EOSDATA=$(EOS)\n" > env.sh

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cc
	$(GCC) $(FLAGS) $(ROOT) $(G4) $(RAT) -shared -c -fPIC $(SRC_DIR)/$*.cc -o $(OBJ_DIR)/$*.o

clean:
	rm -f $(EXE)
	rm -f $(OBJ_DIR)/*.o
