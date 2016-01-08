(* Mathematica Package *)

BeginPackage["PiCbench`Initialization`",{"PiCbench`Parameters`"}]
(* Exported symbols added here with SymbolName::usage *)  

UniformParticles1D::usage="Generates a uniform particle distribution in [0, lx] x [-vmax,vmax]."
CounterDriftParticles1D::usage="Generates a uniform particle distribution Uniform distribution in [0, lx], while |v| uniform in vmean \[PlusMinus] vsigma and random sign."
(*TODO: Document this distribution*)
GaussianParticles1D::usage="Generates a gaussian particle distribution."

Begin["`Private`"] (* Begin Private Context *) 

Options[UniformParticles1D] = {lx -> $lx, np -> $np, vmax -> 2*$charSpeed}
 
UniformParticles1D[opts : OptionsPattern[]] := 
 Transpose[{RandomVariate[UniformDistribution[{0, OptionValue[lx]}], 
    OptionValue[np]], 
   RandomVariate[
    UniformDistribution[{-OptionValue[vmax], OptionValue[vmax]}], 
    OptionValue[np]]}]
    
Options[CounterDriftParticles1D] = {lx -> $lx, np -> $np, 
  vmean -> $charSpeed, vsigma -> 0.1}
  
  CounterDriftParticles1D[opts : OptionsPattern[]] := 
 Transpose[{RandomVariate[UniformDistribution[{0, OptionValue[lx]}], 
    OptionValue[np]], 
   RandomVariate[
    TransformedDistribution[
     u*2*(v - 1/2), {u \[Distributed] UniformDistribution[{OptionValue[vmean] - OptionValue[vsigma], 
         OptionValue[vmean] + OptionValue[vsigma]}], 
      v \[Distributed] BernoulliDistribution[0.5]}], 
    OptionValue[np]]}]
    
 Options[GaussianParticles1D] = {lx -> $lx, np -> $np, vsigma -> 0.1, 
  relsigma -> 0.1}
  
  GaussianParticles1D[opts : OptionsPattern[]] := 
 Transpose[{RandomVariate[
    TruncatedDistribution[{0, OptionValue[lx]}, 
     NormalDistribution[OptionValue[lx]/2, 
      OptionValue[lx]*OptionValue[relsigma]]], OptionValue[np]], 
   RandomVariate[NormalDistribution[0.0, OptionValue[vsigma]], 
    OptionValue[np]]}]

End[] (* End Private Context *)

EndPackage[]