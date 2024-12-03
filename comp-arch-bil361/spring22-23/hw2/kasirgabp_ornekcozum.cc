/* 
 * TOBB Ekonomi ve Teknoloji Universitesi 
 * Bilgisayar Muhendisligi Bolumu 
 * BIL361 – Bilgisayar Mimarisi ve Organizasyonu 
 * 2022-2023 Ogretim Yili Bahar Donemi 
 * Odev 2 
 * 13.03.2023 
 */

// Kodu hazir verdigim icin sizin anlayarak TODO kisimlarini degistirmenizi bekliyorum
// Degistirmeniz gereken 4 TODO satiri var
// TODO'lari yapmasaniz da build olacak ama GShare ongorusu yapmis olmayacak
// PHT --> Pattern History Table --> sayaclarin tutuldugu tablo
// historyRegisterMask, sonucun kac bitini alacagini belirliyor, sonuclari hep bu yuzden bu degiskenle and'liyoruz

#include "cpu/pred/kasirgabp.hh"

#include "base/bitfield.hh"
#include "base/intmath.hh"

namespace gem5
{

namespace branch_prediction
{

KasirgaBP::KasirgaBP(const KasirgaBPParams &params)
    : BPredUnit(params),
      globalHistory(params.numThreads, 0),
      globalHistoryBits(ceilLog2(params.globalPredictorSize)),
      globalPredictorSize(params.globalPredictorSize),
      PHTPredictorSize(params.globalPredictorSize),
      PHTCtrBits(params.globalCtrBits),
      PHTCtrs(globalPredictorSize, SatCounter8(params.globalCtrBits))
{
    historyRegisterMask = mask(globalHistoryBits);

    PHTThreshold = (1ULL << (PHTCtrBits - 1)) - 1;
}

bool
KasirgaBP::lookup(ThreadID tid, Addr branch_addr, void * &bp_history)
{
    // TODO indeksi bulurken historyRegisterMask'i 1 ile degil de baska bir degisken ile and'lemeniz gerekiyor
    // IPUCU: branch_addr ve globalHistory[tid] degiskenlerini kullanmaniz gerek
    unsigned PHTCtrsIdx = historyRegisterMask & (branch_addr ^ globalHistory[tid]);

    assert(PHTCtrsIdx < PHTPredictorSize);

    bool final_Prediction = (PHTCtrs[PHTCtrsIdx] > PHTThreshold);

    BPHistory *history = new BPHistory;
    history->finalPredictionResult = final_Prediction;
    history->globalHistory = globalHistory[tid];
    bp_history = static_cast<void*>(history);

    return final_Prediction;
    
}

void
KasirgaBP::update(ThreadID tid, Addr branch_addr, bool taken, void *bp_history, bool squashed, const StaticInstPtr & inst, Addr corrTarget)
{
    assert(bp_history);

    BPHistory *history = static_cast<BPHistory *>(bp_history);

    // TODO ayni sekilde indeksi bulurken historyRegisterMask'i 1 ile degil de baska bir degisken ile and'lemeniz gerekiyor
    // IPUCU: branch_addr ve globalHistory[tid] degiskenlerini kullanmaniz gerek
    unsigned PHTCtrsIdx = historyRegisterMask & (branch_addr ^ globalHistory[tid]);

    assert(PHTCtrsIdx < PHTPredictorSize);

    if(squashed)
    {
        if(taken)
			globalHistory[tid] = (history->globalHistory << 1) | taken;
		else
			globalHistory[tid] = (history->globalHistory << 1);
		globalHistory[tid] &= historyRegisterMask;
        return;
    }

    if(taken){ // atlar durumu
        // TODO PHTCtrs[PHTCtrsIdx] degiskenini tekrar kendisine esitlemek yerine 1 arttirmaniz ya da 1 azaltmaniz gerekiyor
        PHTCtrs[PHTCtrsIdx]++;
    } else{ // atlamaz durumu
        // TODO PHTCtrs[PHTCtrsIdx] degiskenini tekrar kendisine esitlemek yerine 1 arttirmaniz ya da 1 azaltmaniz gerekiyor
        PHTCtrs[PHTCtrsIdx]--;
    }

    delete history;
}

void
KasirgaBP::btbUpdate(ThreadID tid, Addr branch_addr, void * &bp_history)
{
    globalHistory[tid] &= (historyRegisterMask & ~1ULL);
}

void
KasirgaBP::uncondBranch(ThreadID tid, Addr pc, void * &bp_history)
{
    BPHistory *history = new BPHistory;
    history->globalHistory = globalHistory[tid];
    history->finalPredictionResult = true;
    bp_history = static_cast<void*>(history);
    updateGlobalHistReg(tid, true);
}

void
KasirgaBP::squash(ThreadID tid, void *bp_history)
{
    BPHistory *history = static_cast<BPHistory*>(bp_history);
    globalHistory[tid] = history->globalHistory;
    delete history;
}

void
KasirgaBP::updateGlobalHistReg(ThreadID tid, bool taken)
{
	//shift the register and insert the new value.
	globalHistory[tid] = taken ? (globalHistory[tid] << 1) | 1 :
								(globalHistory[tid] << 1);
	globalHistory[tid] &= historyRegisterMask;
}

} // namespace branch_prediction
} // namespace gem5

