#include <RAT/AnyParse.hh>
#include <Eos.hh>
#include <string>
#include <iostream>
#include <stdlib.h>

int main(int argc, char** argv) {
  auto parser = new RAT::AnyParse(argc, argv);
  auto eos = EOS::Eos( parser, argc, argv );
  eos.Begin();
  eos.Report();
}
