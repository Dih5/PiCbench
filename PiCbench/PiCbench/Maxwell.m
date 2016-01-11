BeginPackage["PiCbench`Maxwell`", { "PiCbench`Parameters`"}]

(*TODO: Add Finite Element solving.*)
GetE1D::usage="GetE1D[] returns a function that calculates E(rho). Options include dx and EMUnitSystem in the form {a,b,c}.
Available Methods are Fourier and Fourier-diff.";

Begin["`Private`"] (* Begin Private Context *) 

Options[GetE1D] = {nx -> $nx, EMUnitSystem -> {$a, $b, $c}, 
   Method -> "Fourier"};
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
      Message[getRho1D::bdmtd, OptionValue[Method]]; GetE1DFourier]
    }]]
    
GetE1DFourier[opts : OptionsPattern[]] := 
 Block[{kFactor, a, nxVal}, nxVal = OptionValue[nx]; 
  ReplaceAll[Function[{rho}, Block[{EFourier},
     EFourier = {0.0} ~Join~ (Drop[Fourier[rho], 1]*Drop[kFactor]*(I));
     Re[InverseFourier[a* EFourier]]
     ]], {kFactor -> 
     Table[(Sin[ 2 \[Pi] n/ nxVal]/(2.0 Sin[ \[Pi] n/ nxVal])^2), {n, 
       1, nxVal - 1}], a -> (OptionValue[EMUnitSystem])[[1]]}]]
       
GetE1DFourierDiff[opts : OptionsPattern[]] := 
 Block[{k2, a, nxVal}, nxVal = OptionValue[nx]; 
  ReplaceAll[Function[{rho}, Block[{\[CapitalPhi], re},
     \[CapitalPhi] = {0.0} ~
       Join~ (Drop[Fourier[rho], 1]/Drop[k2, 1]);
     re = Re[InverseFourier[a \[CapitalPhi]]];
     (RotateRight[re] - RotateLeft[re])/2
     ]], {k2 -> 
     Table[(2.0 Sin[ \[Pi] n/ nxVal])^2, {n, 0, nxVal - 1}], 
    a -> (OptionValue[EMUnitSystem])[[1]]}]]
End[] (* End Private Context *)

EndPackage[]