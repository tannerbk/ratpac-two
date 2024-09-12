import ROOT
import sys
import math

# Speed of light in water in mm/ns
SPEED_OF_LIGHT = 254.0

def open_ntuple(filename):

    htmc = ROOT.TH1D("","",500,-20,80)
    htev = ROOT.TH1D("","",500,-20,80)
    htdigit = ROOT.TH1D("","",500,-20,80)

    f = ROOT.TFile.Open(filename) # Input the ntuple file
    tree = f.Get("output")
    meta = f.Get("meta")

    for i in range(tree.GetEntries()):

        tree.GetEntry(i)
        meta.GetEntry(i)

        # True position of the simulated particle
        mcx = tree.mcx
        mcy = tree.mcy
        mcz = tree.mcz

        # Here we look at truth information
        mcpetime = list(tree.mcPEFrontEndTime)
        mcpeprocess = list(tree.mcPEProcess)
        mcpex = list(tree.mcPEx)
        mcpey = list(tree.mcPEy)
        mcpez = list(tree.mcPEz)

        print (i, len(mcpetime))

        # Loop over the MCPEs
        for iPE in range(len(mcpetime)):

            # PMT position
            pmt_x = mcpex[iPE]
            pmt_y = mcpey[iPE]
            pmt_z = mcpez[iPE]

            pmtpos = math.sqrt((pmt_x-mcx)**2 +
                               (pmt_y-mcy)**2 +
                               (pmt_z-mcz)**2)

            # An example of using the PE Process
            if mcpeprocess[iPE] == 0: # Dark noise
                pass
            if mcpeprocess[iPE] == 1: # Cherenkov
                pass
            if mcpeprocess[iPE] == 2: # Scintillation
                pass
            if mcpeprocess[iPE] == 3: # Reemission
                pass

            residuals = mcpetime[iPE] - pmtpos/SPEED_OF_LIGHT

            htmc.Fill(residuals)

        # Here we look at the triggered event information
        pmtid = list(tree.hitPMTID)
        pmttime = list(tree.hitPMTTime)
        pmtx = list(meta.pmtX)
        pmty = list(meta.pmtY)
        pmtz = list(meta.pmtZ)

        # Loop over the PMT hits
        for iPMT in range(len(pmtid)):

            # How to get the PMT positions
            pid = pmtid[iPMT]
            pmt_x = pmtx[pid]
            pmt_y = pmty[pid]
            pmt_z = pmtz[pid]

            pmtpos = math.sqrt((pmt_x-mcx)**2 +
                               (pmt_y-mcy)**2 +
                               (pmt_z-mcz)**2)

            residuals = pmttime[iPMT] - pmtpos/SPEED_OF_LIGHT

            htev.Fill(residuals)

    return htev, htmc

if __name__=='__main__':

    htev, htmc = open_ntuple(sys.argv[1])

    # Draw everything
    c1 = ROOT.TCanvas("c1","c1",800,600)

    htev.SetStats(0)
    htev.GetXaxis().SetTitle("Time (ns)")
    htev.SetLineColor(ROOT.kBlack)
    htev.Draw("")

    htmc.SetLineColor(ROOT.kRed)
    htmc.Draw("same")

    t = ROOT.TLegend(0.55, 0.55, 0.85, 0.85)
    t.SetTextFont(132)
    t.SetBorderSize(0)
    t.SetFillStyle(0)
    t.AddEntry(htev, "PMT hit time", "L")
    t.AddEntry(htmc, "PE hit time", "L")
    t.Draw("")

    c1.Update()

    input()

