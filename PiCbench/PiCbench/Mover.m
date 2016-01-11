BeginPackage["PiCbench`Mover`", { "PiCbench`Parameters`"}]

StepParticles1DES::usage="StepParticles1DES[r] returns a function that calculates nextParticles(ElectricField,Particles) for particles with chargemass ratio=r*qp/mp.
Options include lx,dt,qp,mp.
Methods available are ExplicitEuler and SemiImplicitEuler";

Begin["`Private`"] (* Begin Private Context *) 

Options[StepParticles1DES] = {lx -> $lx, dt -> $dt, qp -> $qp, 
  mp -> $mp, Method -> "SemiImplicitEuler"}
StepParticles1DES::bdmtd = "The Method option `1` is not recognized. \
Using the default Method."

(*Notice Listable property is widely used here*)
StepParticles1DES[relChargeMass_, opts : OptionsPattern[]] := 
 Block[{vMethod, qp, mp, lx, dt}, 
  ReplaceAll[
   Function[{eField, particles}, 
    Block[{xList, vList, pointLeft, pointRight, EInterp, v2},
     xList = particles[[All, 1]];
     vList = particles[[All, 2]];
     pointLeft = Floor[xList];
     pointRight = Mod[pointLeft + 1, lx] + 1;
     EInterp = 
      eField[[pointLeft + 1]] (pointLeft + 1 - xList) + 
       eField[[pointRight]] (xList - pointLeft);
     v2 = vList + relChargeMass*qp/mp* EInterp*dt;
     Transpose[{Mod[xList + vMethod[vList, v2]*dt, lx], v2}]
     ]], {lx -> OptionValue[lx], dt -> OptionValue[dt], 
    qp -> OptionValue[qp], mp -> OptionValue[mp], 
    vMethod[a_, b_] -> 
     Switch[OptionValue[Method], "ExplicitEuler", a, 
      "SemiImplicitEuler", b, _, 
      Message[StepParticle1DES::bdmtd, OptionValue[Method]]; b
      ]}]]

End[] (* End Private Context *)

EndPackage[]