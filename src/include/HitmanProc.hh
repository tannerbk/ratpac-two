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
#include <RAT/DS/FitResult.hh>
#include <string>

namespace EOS {

class HitmanProc : public RAT::Processor {
    public:
        HitmanProc();
        virtual ~HitmanProc() {}
        void BeginOfRun(RAT::DS::Run *run);
        virtual RAT::Processor::Result Event(RAT::DS::Root *ds, RAT::DS::EV *ev);
        RAT::DS::PMTInfo *run_pmtinfo;

        void Optimize(std::vector<double> seed, RAT::DS::FitResult *fit);
        double NLLH(const std::vector<double> &hypothesis);

    private:
        std::vector<double> hitman_hits;
        std::vector<double> hitman_charge;
        std::vector<double> x_pos_pmt;
        std::vector<double> y_pos_pmt;
        std::vector<double> z_pos_pmt;

    protected:
        cppflow::model *hitnet;
        cppflow::model *chargenet;

};

}

#endif
#endif
