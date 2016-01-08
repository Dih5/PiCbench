BeginPackage["PiCbench`Parameters`"]
(* Exported symbols added here with SymbolName::usage *) 

$dx::usage="Length of cell size in the x dimenssion";
$nx::usage="Number of cells";
$qp::usage="Charge of a macroparticle (absolute value)";
$mp::usage="Mass of electron macroparticle";
$np::usage="Number of particles";
$ionMass::usage="Relative mass of ion species/mass of electrons";
$dt::usage="Temporal step";
$a::usage="Charge dimenssion in the Maxwell equations";
$b::usage="Relative dimension of the magnetic field in the maxwell equations";
$c::usage="Speed of light";

$charSpeed::usage="A characteristic speed of the electrons in the plasma.";

$charSpeedIons::usage="Ion characteristic speed (derived magnitude)";
$lx::usage="System length (derived magnitude)";
$wp::usage="Plasma frecuency (derived magnitude)";
$debyeLength::usage="Debye length (derived magnitude)";

MagnitudeList::usage="Prints a list of the PiC magnitudes"
PrintConditions::usage="Print a priori scale conditions on the PiC magnitudes"

Begin["`Private`"]

$dx = 1;
$nx = 1024;
$qp = 4.0*^-4;
$mp = 4.0*^-4;
$np = 3000;
$ionMass = 1836.15267;
$dt = 1;
$a = $b = $c = 1;
$charSpeed = 0.5;(*Note this is used to estimate adequateness. Particles must be initializated according to this to work*)


(*Derived magnitudes*)
$charSpeedIons := $charSpeed/Sqrt[$ionMass]
$lx := $dx*$nx
$wp := Sqrt[$np/$lx*$qp^2/$mp*$a]
$debyeLength := $charSpeed/$wp

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

(*TODO: Add usage of variables here*)
MagnitudeList[]:=TableForm[{#, Symbol[#], Definition[#]} & /@ {"$dx","$nx","$qp","$mp","$np","$ionMass","$dt","$a","$b","$c","$charSpeed","$charSpeedIons",
				  "$lx","$wp","$debyeLength"},TableHeadings -> {None, {"Variable", "Value", "Definition"}}]

PrintConditions[]:={PrintMuchLessCondition[
   "Small cell condition - ($dx<<$lx)", $dx, $lx], 
  PrintMuchLessCondition[
   "Small time-step condition - ($dt<<$wp^-1)", $dt, $wp^-1], 
  PrintMuchLessCondition[
   "Big world condition - ($debyeLength<<$lx)", $debyeLength, $lx]};

End[]

EndPackage[]

