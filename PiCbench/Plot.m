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


Options[SmoothPhaseSpacePlot] := Union[Options[ContourPlot],{PicParameters->PicPar}];

SmoothPhaseSpacePlot[particles_, opts : OptionsPattern[]] := 
 Block[{p,d, minV, maxV},p=OptionValue[PicParameters]; d = SmoothKernelDistribution[particles]; 
  minV = Min[particles[[All, 2]]]; maxV = Max[particles[[All, 2]]]; 
  ContourPlot[
   PDF[d, {x, v}], {x, 0, p["lx"]}, {v, minV, maxV}, opts,
    FrameLabel -> {"x", "v"}, PlotRange -> All]]
    
Options[DebyeMovingAverage]:={PicParameters->PicPar}
DebyeMovingAverage[particle_,factor_:1,opts : OptionsPattern[]]:=Block[{p},p=OptionValue[PicParameters];
	MovingAverage[particle, Max[Floor[factor*p["debyeLength"]],1]]
]
  
End[] (* End Private Context *)

EndPackage[]