(* Mathematica Package *)

BeginPackage["PiCbench`Plot`",{"PiCbench`Parameters`"}]

PhaseSpacePlot::usage="Plot some lists of particles in the phase space.";
SmoothPhaseSpacePlot::usage="Plot a smooth kernel distribution of the phase space of the list of particles.";

DebyeMovingAverage::usage="DebyeMovingAverage[particle,factor:1] calculates the moving average using blocks of Floor[factor*$debyeLength] cells.";

Begin["`Private`"] (* Begin Private Context *) 

Options[PhaseSpacePlot] := Options[ListPlot];
PhaseSpacePlot[particleLists_, opts : OptionsPattern[]] :=
    ListPlot[particleLists, opts, AxesLabel -> {"x", "v"}, 
     PlotLabel -> "Particle Phase Space"]


Options[SmoothPhaseSpacePlot] := Options[ContourPlot];
SmoothPhaseSpacePlot[particles_, opts : OptionsPattern[]] := 
 Block[{d, minV, maxV}, d = SmoothKernelDistribution[particles]; 
  minV = Min[particles[[All, 2]]]; maxV = Max[particles[[All, 2]]]; 
  ContourPlot[
   PDF[d, {x, v}], {x, 0, $lx}, {v, minV, maxV}, opts,
    FrameLabel -> {"x", "v"}, PlotRange -> All]]
    
    
DebyeMovingAverage[particle_,factor_:1]:=MovingAverage[particle, Max[Floor[factor*$debyeLength],1]]
  
End[] (* End Private Context *)

EndPackage[]