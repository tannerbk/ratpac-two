#include <HitmanProc.hh>

#if TENSORFLOW_Enabled
#include <cppflow/cppflow.h>
#include <cppflow/model.h>
#include <filesystem>
#include <RAT/DB.hh>
#include <RAT/DS/EV.hh>
#include <RAT/DS/FitResult.hh>
#include <RAT/DS/PMTInfo.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/RunStore.hh>
#include <RAT/Rat.hh>
#include <RAT/Processor.hh>
#include <RAT/Log.hh>
//#include <Minuit2/Minuit2Minimizer.h>

#include <RAT/DS/Run.hh>
#include <RAT/DS/PMT.hh>
#include <iostream>

namespace EOS {

    HitmanProc::HitmanProc() : RAT::Processor("hitman") {    }

    RAT::Processor::Result HitmanProc::Event(RAT::DS::Root* ds, RAT::DS::EV* ev) {
        //
        // Testing network evaluation with dummy data
        //
        auto input_1 = cppflow::fill({10, 5}, 1.0f);
        auto input_2 = cppflow::fill({10, 7}, -1.0f);
        std::cout << "Just before the crash" <<std::endl;
        auto output = (*hitnet)({{ "serving_default_input_1:0", input_1 },{ "serving_default_input_2:0", input_2}},{ "StatefulPartitionedCall:0" });
        std::cout << "Hitnet output: " << output << std::endl;
        return RAT::Processor::OK;
    }

    void HitmanProc::BeginOfRun(RAT::DS::Run* run) {
        RAT::DB* db = RAT::DB::Get();
        // Hitman variables stored in ratdb
        RAT::DBLinkPtr table = db->GetLink("Fitter","HITMAN");
        std::string directory = table->GetS("directory");
        std::cout<<directory<<std::endl;

        //load HITMAN models
        cppflow::model* hitnet = new cppflow::model(directory + "/hitnet/");


        auto input_1 = cppflow::fill({10, 5}, 1.0f);
        auto input_2 = cppflow::fill({10, 7}, -1.0f);
        auto output = (*hitnet)({{ "serving_default_input_1:0", input_1 },{ "serving_default_input_2:0", input_2}},{ "StatefulPartitionedCall:0" })[0];
        std::cout << "Hitnet output: " << output << std::endl;
    }

} // namespace EOS
#endif