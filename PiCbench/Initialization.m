(* Mathematica Package *)

BeginPackage["PiCbench`Initialization`",{"PiCbench`Parameters`"}]


UniformParticles1D::usage="UniformParticles1D[vMax] generates a uniform particle distribution in [0, lx] x [-vMax,vMax].
By default vMax is 2 times the charSpeed parameter."

CounterDriftParticles1D::usage="CounterDriftParticles1D[vMean,vSigma] generates a spatial uniform distribution in [0, lx], while |v| is uniform in vMean \[PlusMinus] vSigma and random sign.
By default vMean is the charSpeed parameter and vSigma is 10% of this."

GaussianParticles1D::usage="GaussianParticles1D[xSigma,vSigma] Generates a gaussian particle distribution in the phase space with mean (lx/2,0), variances (xSigma^2,vSigma^2) and no correlation.
By default xSigma is 10% of the lx parameter and vSigma is the charSpeed parameter."

Begin["`Private`"] (* Begin Private Context *) 

Options[UniformParticles1D] := {PicParameters->PicPar,UseIonDefaults->False}

UniformParticles1D[opts:OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 UniformParticles1D[2*p[If[OptionValue[UseIonDefaults]===True,"charSpeedIons","charSpeed"]],opts]]
 
UniformParticles1D[vMax_,opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 Transpose[{RandomVariate[UniformDistribution[{0, p["lx"]}], 
    p["np"]], 
   RandomVariate[
    UniformDistribution[{-vMax, vMax}], 
    p["np"]]}]]
    

    
Options[CounterDriftParticles1D] := {PicParameters->PicPar,UseIonDefaults->False}

CounterDriftParticles1D[opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 CounterDriftParticles1D[p[If[OptionValue[UseIonDefaults]===True,"charSpeedIons","charSpeed"]],opts]]

CounterDriftParticles1D[vMean_,opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 CounterDriftParticles1D[vMean,0.1*vMean,opts]]
 
  CounterDriftParticles1D[vMean_,vSigma_,opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 Transpose[{RandomVariate[UniformDistribution[{0, p["lx"]}], 
    p["np"]], 
   RandomVariate[
    TransformedDistribution[
     u*2*(v - 1/2), {u \[Distributed] UniformDistribution[{vMean - vSigma, 
         vMean + vSigma}], 
      v \[Distributed] BernoulliDistribution[0.5]}], 
    p["np"]]}]]
    

 

    
 Options[GaussianParticles1D] := {PicParameters->PicPar,UseIonDefaults->False}
 
 GaussianParticles1D[opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 GaussianParticles1D[0.1*p["lx"],opts]]
 
 GaussianParticles1D[xSigma_,opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 GaussianParticles1D[xSigma,p[If[OptionValue[UseIonDefaults]===True,"charSpeedIons","charSpeed"]],opts]]
  
  GaussianParticles1D[xSigma_,vSigma_,opts : OptionsPattern[]] := Block[{p=OptionValue[PicParameters]},
 Transpose[{RandomVariate[
    TruncatedDistribution[{0, p["lx"]}, 
     NormalDistribution[p["lx"]/2, 
      xSigma]], p["np"]], 
   RandomVariate[NormalDistribution[0.0, vSigma], 
    p["np"]]}]]




End[] (* End Private Context *)

EndPackage[]