#ifndef __EOS_HitmanProc__
#define __EOS_HitmanProc__

#include <Config.hh>
#if TENSORFLOW_Enabled
#include <cppflow/cppflow.h>
#include <cppflow/model.h>
#include <RAT/Processor.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/EV.hh>
#include <RAT/DS/PMTInfo.hh>
#include <string>

namespace EOS {

class HitmanProc : public RAT::Processor {
    public:
        HitmanProc();
        virtual ~HitmanProc() {}
        void BeginOfRun(RAT::DS::Run *run);
        virtual RAT::Processor::Result Event(RAT::DS::Root *ds, RAT::DS::EV *ev);
        RAT::DS::PMTInfo *run_pmtinfo;

    private:
        std::vector<float> x_pos_pmt;
        std::vector<float> y_pos_pmt;
        std::vector<float> z_pos_pmt;

    protected:
        cppflow::model *hitnet;
        cppflow::model *chargenet;

};

}

#endif
#endif
