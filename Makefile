OBJ_DIR := objects
SRC_DIR := src
INC_DIR := include
BIN_DIR := bin
UTL_DIR := utilities

SRC := $(wildcard *.cpp)
EXE := $(patsubst %.cpp, %, $(SRC))
EOS := $(shell pwd)
RAT := -L$(RATROOT)/lib -lRATPAC -I$(INC_DIR) -I$(RATROOT)/include
ROOT := $(shell root-config --libs --cflags)
G4 := $(shell geant4-config --libs --cflags)
FLAGS := --std=c++17 -w
GCC := g++

_OBJS := $(patsubst $(SRC_DIR)/%.cc, %.o, $(wildcard $(SRC_DIR)/*.cc))
OBJS := $(patsubst %,$(OBJ_DIR)/%,$(_OBJS))

_UTILITIES := $(patsubst $(UTL_DIR)/%.cpp, %, $(wildcard $(UTL_DIR)/*.cpp))
UTILITIES := $(patsubst %.cpp, $(BIN_DIR)/%, $(_UTILITIES))

all: $(SRC) $(EXE) $(OBJS) $(UTILITIES)

%: %.cpp $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(GCC) $(FLAGS) $(OBJS) $@.cpp -o $(BIN_DIR)/$@ $(ROOT) $(G4) $(RAT) 
	printf "export EOSDATA=$(EOS)\nexport PATH=$(EOS)/$(BIN_DIR):$$""PATH\n" > env.sh

%: $(UTL_DIR)/%.cpp $(OBJS)
	$(GCC) $(FLAGS) $(ROOT) $(G4) $(RAT) $(OBJS) $(UTL_DIR)/$@.cpp -o $(BIN_DIR)/$@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cc
	$(GCC) $(FLAGS) $(ROOT) $(G4) $(RAT) -shared -c -fPIC $(SRC_DIR)/$*.cc -o $(OBJ_DIR)/$*.o

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(BIN_DIR)/*
