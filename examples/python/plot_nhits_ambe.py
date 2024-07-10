import ROOT
import sys

def open_ntuple(filename):

    hnhits_prompt = ROOT.TH1D("","",200,0,200)
    hnhits_delayed = ROOT.TH1D("","",200,0,200)

    f = ROOT.TFile.Open(filename) # Input the ntuple file
    tree = f.Get("output")
    meta = f.Get("meta")

    for i in range(tree.GetEntries()):

        try:
            tree.GetEntry(i)
            meta.GetEntry(i)
        except AttributeError:
            print ("Error with opening file!")
            sys.exit(1)

        # Neither the gamma nor neutron triggered
        # the detector
        if tree.evid == -1:
            continue

        # Select the first triggered event within
        # the simulated event.
        # This is the 4.4 MeV gamma
        if (tree.subev == 0):
            hnhits_prompt.Fill(tree.nhits)

        # Select the second triggered event (if
        # there is one) within the simulated event.
        # This is the 2.2 MeV gammas from the neutron
        # capture on hydrogen.
        if (tree.subev == 1):
            hnhits_delayed.Fill(tree.nhits)
           
    return hnhits_prompt, hnhits_delayed


if __name__=='__main__':


    hnhits1, hnhits2 = open_ntuple(sys.argv[1])

    c1 = ROOT.TCanvas("c1","c1",800,600)

    hnhits1.GetXaxis().SetTitle("Nhits")
    hnhits1.SetLineColor(ROOT.kBlack)
    hnhits1.Draw("")

    hnhits2.SetLineColor(ROOT.kRed)
    hnhits2.Draw("same")

    c1.Update()

    input()

