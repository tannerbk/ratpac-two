#include <stdlib.h>

#include <Eos.hh>
#include <RAT/AnyParse.hh>
#include <iostream>
#include <string>

int main(int argc, char** argv) {
  auto parser = new RAT::AnyParse(argc, argv);
  std::cout << "Eos version: " << RAT::EOSVERSION << std::endl;
  auto eos = EOS::Eos(parser, argc, argv);
  eos.Begin();
  eos.Report();
}
