#!/usr/local/bin/WolframScript -script

(*Example of PiCbench simulation from script*)

(*Output directory (must exist)*)
ExportDirectory = FileNameJoin[{$HomeDirectory, "Desktop","PiCbenchRuns","demo"}];

Needs["PiCbench`"]

(* 1- Compile the functions *)
compileTime=First[AbsoluteTiming[
getRho = 
 FCompile[GetRho1D[], {_Real}, {2}, CompilationTarget -> "C", 
  RuntimeOptions -> "Speed"];
  
getE = FCompile[GetE1D[], {_Real}, {1}, {{Re[__], _Real, 1}}, 
  CompilationTarget -> "C", RuntimeOptions -> "Speed"];
  
stepElectrons = 
  FCompile[StepParticles1DES[], {_Real, _Real}, {1, 2}, 
   CompilationTarget -> "C", RuntimeOptions -> "Speed"];
stepIons = 
  FCompile[StepParticles1DES[UseIonDefaults -> True], {_Real, _Real}, {1, 2}, 
   CompilationTarget -> "C", RuntimeOptions -> "Speed"];
   ]];
   
Print["Compilation finished in "<>ToString[compileTime]]

(* 2- Simulation cycle *)
electrons = UniformParticles1D[];
ions = UniformParticles1D[UseIonDefaults -> True];
nSubsteps = 3;(*Steps in time dt done before saving data for diagnostics*)
nSteps = 30;(*Number of cycles repeating the previous*)

eFieldList = Table[0, {nSteps}];
RhoElectronList = Table[0, {nSteps}];
RhoIonList = Table[0, {nSteps}];
electronsList = Table[0, {nSteps}];
ionsList = Table[0, {nSteps}];
executionTime=First[AbsoluteTiming[Do[
   Do[ (*PiC cycle:*)
    (*Particle to grid*)
    RhoElectron = 
     getRho[electrons]; RhoIon = getRho[ions];
    (*Solve Maxwell*)
    
    eField = getE[(RhoIon - RhoElectron)];
    (*Move particles (includes field interpolation)*)
    
    electrons = stepElectrons[eField, electrons]; 
    ions = stepIons[eField, ions];
    , {nSubsteps}];
   (*Save data*)
   eFieldList[[i]] = eField;
   RhoElectronList[[i]] = RhoElectron;
   RhoIonList[[i]] = RhoIon;
   electronsList[[i]] = electrons;
   ionsList[[i]] = ions;, {i, nSteps}];]]
   
Print["Execution finished in "<>ToString[executionTime]]


(* 3- Export some results as animated gifs *)
exportTime = 
 First[AbsoluteTiming[
   Export[FileNameJoin[{ExportDirectory, "rho.gif"}], 
    Table[ListPlot[{DebyeMovingAverage[RhoElectronList[[i]]], 
       DebyeMovingAverage[RhoIonList[[i]]]}, 
      PlotLabel -> "Charge density", AxesLabel -> {"x", "Rho"}, 
      Joined -> True, 
      PlotLegends -> {"\!\(\*SuperscriptBox[\(e\), \(-\)]\)", 
        "ions"}], {i, 1, Length[RhoElectronList], 1}]];
   Export[FileNameJoin[{ExportDirectory, "electricField.gif"}], 
    Table[ListPlot[eFieldList[[i]], PlotLabel -> "Electric Field", 
      AxesLabel -> {"x", "E"}, PlotRange -> {-0.01, 0.01}], {i, 1, 
      Length[eFieldList], 1}]];
   Export[FileNameJoin[{ExportDirectory, "electrons.gif"}], 
    Table[ListPlot[electronsList[[i]], AxesLabel -> {"x", "v"}, 
      PlotLabel -> 
       "Electron Phase Space\nt = " <> ToString[i*PicPar["dt"]]], {i, 1, 
      Length[electronsList], 1}]];
   Export[FileNameJoin[{ExportDirectory, "electronsSmooth.gif"}], 
    Table[
     SmoothPhaseSpacePlot[electronsList[[i]], AxesLabel -> {"x", "v"},
       PlotLabel -> 
       "Electron Phase Space\nt = " <> ToString[i*PicPar["dt"]]], {i, 1, 
      Length[electronsList], 1}]];]]

Print["Exporting finished in "<>ToString[exportTime]]
   
Print["End of simulation."]
