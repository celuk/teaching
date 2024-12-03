/* 
 * TOBB Ekonomi ve Teknoloji Universitesi 
 * Bilgisayar Muhendisligi Bolumu 
 * BIL361 – Bilgisayar Mimarisi ve Organizasyonu 
 * 2022-2023 Ogretim Yili Bahar Donemi 
 * Odev 2 
 * 13.03.2023 
 */

#ifndef __CPU_PRED_KASIRGA_HH__
#define __CPU_PRED_KASIRGA_HH__

#include <vector>

#include "cpu/pred/bpred_unit.hh"
#include "base/sat_counter.hh"

#include "params/KasirgaBP.hh"

namespace gem5
{

namespace branch_prediction
{

class KasirgaBP: public BPredUnit
{
    public:

        KasirgaBP(const KasirgaBPParams &params);

        bool lookup(ThreadID tid, Addr branch_addr, void * &bp_history);

        void uncondBranch(ThreadID tid, Addr pc, void * &bp_history);

        void btbUpdate(ThreadID tid, Addr branch_addr, void * &bp_history);

        void update(ThreadID tid, Addr branch_addr, bool taken, void *bp_history, bool squashed, const StaticInstPtr & inst, Addr corrTarget);

        void squash(ThreadID tid, void *bp_history);

    private:

         void updateGlobalHistReg(ThreadID tid, bool taken);


         struct BPHistory {
            unsigned globalHistory;
            /*
                the final taken/not-taken prediction
                true: predict taken
                false: predict not-taken
            */
            bool finalPredictionResult;
        };

	    std::vector<unsigned> globalHistory;

        unsigned historyRegisterMask;

        unsigned globalHistoryBits;

        unsigned globalPredictorSize;

        std::vector<SatCounter8> PHTCtrs;

        unsigned PHTPredictorSize;

        unsigned PHTCtrBits;

        unsigned PHTThreshold;
};

} // namespace branch_prediction
} // namespace gem5

#endif // __CPU_PRED_KASIRGA_HH__

