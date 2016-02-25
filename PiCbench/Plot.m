(* Mathematica Package *)

BeginPackage["PiCbench`Plot`",{"PiCbench`Parameters`"}]

PhaseSpacePlot::usage="Plot some lists of particles in the phase space.";
SmoothPhaseSpacePlot::usage="Plot a smooth kernel distribution of the phase space of the list of particles.";

DebyeMovingAverage::usage="DebyeMovingAverage[list,factor:1] calculates the moving average of the list using blocks of Floor[factor*debyeLength] cells. The result is returned as a list of coordinates in the plane.";

Begin["`Private`"] (* Begin Private Context *) 


Options[PhaseSpacePlot] := Union[Options[ListPlot],{PicParameters->PicPar}];
PhaseSpacePlot[particleLists_, opts : OptionsPattern[]] :=
 Block[{p},p=OptionValue[PicParameters];  
   ListPlot[particleLists, opts, AxesLabel -> {"x", "v"}, 
     PlotLabel -> "Particle Phase Space",PlotRange -> {{0, p["lx"]}, Automatic}]]
   


Options[SmoothPhaseSpacePlot] := Union[Options[ContourPlot],{PicParameters->PicPar}];

SmoothPhaseSpacePlot[particles_, opts : OptionsPattern[]] := 
 Block[{p,d, minV, maxV},p=OptionValue[PicParameters]; d = SmoothKernelDistribution[particles]; 
  minV = Min[particles[[All, 2]]]; maxV = Max[particles[[All, 2]]]; 
  ContourPlot[
   PDF[d, {x, v}], {x, 0, p["lx"]}, {v, minV, maxV}, opts,
    FrameLabel -> {"x", "v"}, PlotRange -> All]]
    
Options[DebyeMovingAverage]:={PicParameters->PicPar}
DebyeMovingAverage[lst_,factor_:1,opts : OptionsPattern[]]:=Block[{p},p=OptionValue[PicParameters];
	Transpose[{MovingAverage[Range[Length[lst]], Max[Floor[factor*p["debyeLength"]],1]],MovingAverage[lst, Max[Floor[factor*p["debyeLength"]],1]]}]
]
  
End[] (* End Private Context *)

EndPackage[]