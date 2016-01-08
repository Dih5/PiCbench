(* Mathematica Package *)

BeginPackage["PiCbench`Compile`"]
RemoveIdentities::usage="RemoveIdentities is a boolean option for FCompile which sets whether some elementary algebraic simplifications are performed."
FCompile::usage="FCompile(f,types,ranks, addedAsumptions) compiles the function f assuming arguments have given types and ranks."
BenchmarkFCompile::usage="BenchmarkFCompile({f,types,ranks, addedAsumptions},args,times) bencharmks different compilation methods returning the mean AbsoluteTiming of calling the compiled function with args the given times."


Begin["`Private`"] (* Begin Private Context *) 

Options[FCompile] = Union[Options[Compile], {RemoveIdentities -> True}]

(*Some algebraic simplifications. To check their effect one may use CompilePrint*)
IdentityRules = {HoldPattern[
     Times[x_, a_, Power[Times[a_, y_], -1]]] :> x/y, 
   HoldPattern[Times[a_, Power[Times[a_, y_], -1]]] :> 1/y, 
   HoldPattern[Times[x_, a_, Power[a_, -1]]] :> x, 
   HoldPattern[Times[a_, Power[a_, -1]]] :> 1, 
   HoldPattern[Times[a_, 1.]] :> a, HoldPattern[Times[a_, 1]] :> a, 
   HoldPattern[x_ + 0.] :> x, HoldPattern[x_ + 0] :> x};
   
FCompile[f_Function, types_List, ranks_List, addedAsumptions_List: {},
   opts : OptionsPattern[]] := Block[{fTemp},
  fTemp = 
   Hold @@ If[OptionValue[RemoveIdentities] === True, 
     ReplaceRepeated[f, IdentityRules], f];
  fTemp[[1]] = Join[MapThread[List, {f[[1]], types, ranks}]];
  Compile @@ 
   Join[fTemp, Hold[addedAsumptions], 
    Hold @@ FilterRules[{opts}, Options[Compile]]]
  ]

(*Modes of compilation used by the bencharmk function*)
FCompileFlavours[f_Function, types_List, ranks_List, 
  addedAsumptions_List: {}] := 
 Block[{comp, compC, compCSpeed},
  comp = FCompile[f, types, ranks, addedAsumptions];
  compC = 
   FCompile[f, types, ranks, addedAsumptions, 
    CompilationTarget -> "C"];
  compCSpeed = 
   FCompile[f, types, ranks, addedAsumptions, 
    CompilationTarget -> "C", RuntimeOptions -> "Speed"];
  {f, comp, compC, compCSpeed}]
  
BenchmarkFCompile[{f_Function, types_List, ranks_List, 
   addedAsumptions_List: {}}, args_List, times_Integer] := 
 Block[{comp, compC, compCSpeed},
  {comp, compC, compCSpeed} = 
   Drop[FCompileFlavours[f, types, ranks], 1];
  {(Table[f @@ args ;, {times}]; // AbsoluteTiming // First)/times,
   (Table[comp @@ args; , {times}]; // AbsoluteTiming // First)/
    times,
   (Table[compC @@ args; , {times}]; // AbsoluteTiming // First)/times,
   (Table[compCSpeed @@ args; , {times}]; // AbsoluteTiming // First)/
    times
   }]
   
End[] (* End Private Context *)

EndPackage[]