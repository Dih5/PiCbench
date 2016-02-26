BeginPackage["PiCbench`Maxwell`", { "PiCbench`Parameters`"}]

(*TODO: Add Finite Element solving.*)
GetE1D::usage="GetE1D[] returns a function that calculates E(rho).
Relevant parameters are nx, a.
Available Methods are Fourier and Fourier-diff.";

Begin["`Private`"] (* Begin Private Context *) 

Options[GetE1D] = {PicParameters->PicPar, Method -> "Fourier"};
Options[GetE1DFourier] = Options[GetE1DFourierDiff] = Options[GetE1D];

GetE1D::bdmtd = 
  "The Method option `1` is not recognized. Using the default \
Method.";

GetE1D[opts : OptionsPattern[]] := 
 Block[{f}, 
  ReplaceAll[
   f[opts], {f -> 
     Switch[OptionValue[Method], "Fourier", GetE1DFourier, 
      "Fourier-diff", GetE1DFourierDiff, _, 
      Message[GetE1D::bdmtd, OptionValue[Method]]; GetE1DFourier]
    }]]
    
GetE1DFourier[opts : OptionsPattern[]] := 
 Block[{p=OptionValue[PicParameters],kFactor, a, nx,i}, nx = p["nx"]; 
  ReplaceAll[Function[{rho}, Block[{EFourier},
     EFourier = {0.0} ~Join~ (Drop[Fourier[rho], 1]*Drop[kFactor]*(I));
     Re[InverseFourier[a* EFourier]]
     ]], {kFactor -> 
     Table[(Sin[ 2 \[Pi] i/ nx]/(2.0 Sin[ \[Pi] i/ nx])^2), {i, 
       1, nx - 1}], a -> p["a"]}]]
       
GetE1DFourierDiff[opts : OptionsPattern[]] := 
 Block[{p=OptionValue[PicParameters],k2, a, nx,i}, nx = p["nx"]; 
  ReplaceAll[Function[{rho}, Block[{\[CapitalPhi], re},
     \[CapitalPhi] = {0.0} ~
       Join~ (Drop[Fourier[rho], 1]/Drop[k2, 1]);
     re = Re[InverseFourier[a \[CapitalPhi]]];
     (RotateRight[re] - RotateLeft[re])/2
     ]], {k2 -> 
     Table[(2.0 Sin[ \[Pi] i/ nx])^2, {i, 0, nx - 1}], 
    a -> p["a"]}]]
End[] (* End Private Context *)

EndPackage[]