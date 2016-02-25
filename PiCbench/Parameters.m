BeginPackage["PiCbench`Parameters`"]
(* Exported symbols added here with SymbolName::usage *) 

PicPar::usage="Default parameters used by PiCbench. To set them use e.g. PicPar[\"dx\"]=1.";
CreatePicPar::usage="CreatePicPar[] creates a new parameter set. Useful if working with more than one, otherwise stick to PicPar, which is used by default."

PicParameters::usage="PicParameters is an option for some PicBench functions determining which parameter set to use."
UseIonDefaults::usage="UseIonDefaults is an option for some PicBench functions determining whether ion or electron parameters are used."

MagnitudeList::usage="Prints a list of the PiC magnitudes"
PrintConditions::usage="Print a priori scale conditions on the PiC magnitudes"

Begin["`Private`"]

(*TODO: add options to override values on call*)
CreatePicPar[PicPar_]:=Block[{},
(*Descriptions*)
PicPar["dx","Description"]="Length of cell size in the x dimension";
PicPar["nx","Description"]="Number of cells";
PicPar["qp","Description"]="Charge of a macroparticle (absolute value)";
PicPar["mp","Description"]="Mass of electron macroparticle";
PicPar["np","Description"]="Number of particles";
PicPar["ionRelMass","Description"]="Relative mass of ion species/mass of electrons";
PicPar["dt","Description"]="Temporal step";
PicPar["a","Description"]="Charge dimenssion in the Maxwell equations";
PicPar["b","Description"]="Relative dimension of the magnetic field in the maxwell equations";
PicPar["c","Description"]="Speed of light";
PicPar["charSpeed","Description"]="A characteristic speed of the electrons in the plasma.";

PicPar["charSpeedIons","Description"]="Ion characteristic speed (derived magnitude)";
PicPar["lx","Description"]="System length (derived magnitude)";
PicPar["wp","Description"]="Plasma frecuency (derived magnitude)";
PicPar["debyeLength","Description"]="Debye length (derived magnitude)";

(*Default values*)
PicPar["dx"]=1;
PicPar["nx"]=1024;
PicPar["qp"]=4.0*^-4;
PicPar["mp"]=4.0*^-4;
PicPar["np"]=3000;
PicPar["ionRelMass"]=1836.15267;
PicPar["dt"]=1;
PicPar["a"]=1;
PicPar["b"]=1;
PicPar["c"]=1;
PicPar["charSpeed"]=0.5;(*Note this is used to estimate adequateness. Particles must be initializated according to this to work*)

(*Derived*)
PicPar["charSpeedIons"] := PicPar["charSpeed"]/Sqrt[PicPar["ionRelMass"]];
PicPar["lx"] := PicPar["dx"]*PicPar["nx"];
PicPar["wp"] := Sqrt[PicPar["np"]/PicPar["lx"]*PicPar["qp"]^2/PicPar["mp"]*PicPar["a"]];
PicPar["debyeLength"] := PicPar["charSpeed"]/PicPar["wp"];
]

CreatePicPar[PicPar_,AddedRules_List]:=Block[{},CreatePicPar[PicPar];(PicPar[#[[1]]] = #[[2]]) & /@ AddedRules]

CreatePicPar[PicPar]


PrintMuchLessCondition[name_String, less_, more_] := 
 Print[Style[
   StringJoin[name, " - ", ToString[less], " << ", ToString[more]], 
   Switch[more/less, a_ /; a > 1000, Green, a_ /; a > 10, Orange, _, 
    Red]]]

PrintAroundCondition[name_String, t1_, t2_] := 
 Print[Style[
   StringJoin[name, " - ", ToString[t1], " ~ ", ToString[t2]], 
   Switch[Max[t1, t2]/Min[t1, t2], a_ /; a < 5, Green, a_ /; a < 10, 
    Orange, _, Red]]]


MagnitudeList[]:=MagnitudeList[PicPar]
MagnitudeList[PicPar_]:=TableForm[{#, PicPar[#], PicPar[#, "Description"]} & /@ {"dx", "nx", 
   "qp", "mp", "np", "ionRelMass", "dt", "a", "b", "c", "charSpeed", 
   "charSpeedIons", "lx", "wp", "debyeLength"}, 
 TableHeadings -> {None, {"Variable", "Value", "Description"}}]

PrintConditions[]:=PrintConditions[PicPar]
PrintConditions[PicPar_]:=Block[{},{PrintMuchLessCondition[
   "Small cell condition - (dx<<lx)", PicPar["dx"], PicPar["lx"]], 
  PrintMuchLessCondition[
   "Small time-step condition - (dt<<wp^-1)", PicPar["dt"], PicPar["wp"]^-1], 
  PrintMuchLessCondition[
   "Big world condition - (debyeLength<<lx)", PicPar["debyeLength"], PicPar["lx"]]};]

End[]

EndPackage[]

