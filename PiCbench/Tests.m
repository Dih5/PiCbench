(* Mathematica package *)
BeginPackage["PiCbench`Tests`"]

(*Subpackage with functionality used in tests, accesed by the private Context*)



Begin["`Private`"] (* Begin Private Context *) 
AbsDif[a_, b_] := Total[MapThread[Abs[#1 - #2] &, {a, b}]]/Length[a]
AbsDif::usage="AbsDif[a, b] calculates the mean absolute difference between elements of argument lists a,b."

RelDif[a_, b_] := 
 Total[MapThread[
    If[#1 == #2, 0, Abs[#1 - #2]/Max[Abs[#1], Abs[#2]]] &, {a, b}]]/
  Length[a]
RelDif::usage="RelDif[a, b] calculates the mean relative difference between elements of argument lists a,b."
  
  End[] (* End Private Context *)

EndPackage[]