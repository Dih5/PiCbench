BeginPackage["PiCbench`Particle2Grid`", { "PiCbench`Parameters`"}]


GetRho1D::usage = "GetRho1D[] returns a function that calculates rho(particleList).
Relevant parameters are dx,nx,qc.
Can also be used with qc=1 to find number density."


Begin["`Private`"] (* Begin Private Context *) 
Options[GetRho1D] = {PicParameters->PicPar, 
   Method -> "First-order"};
Options[GetRho1DFirstOrder] = 
  Options[GetRho1DZeroOrder] = Options[GetRho1D];
  
  GetRho1D::bdmtd = 
  "The Method option `1` is not recognized. Using the default \
Method.";

GetRho1D[opts : OptionsPattern[]] :=
    Block[ {f},
        ReplaceAll[
         f[opts], {f -> 
           Switch[OptionValue[Method], "First-order", GetRho1DFirstOrder, 
            "Zeroth-order", GetRho1DZeroOrder, _, 
            Message[GetRho1D::bdmtd, OptionValue[Method]];
            GetRho1DFirstOrder]
          }]
    ]
    
 GetRho1DFirstOrder[opts : OptionsPattern[]] :=
     Block[ {p=OptionValue[PicParameters],rho0, dx, qp, nx},
         ReplaceAll[Function[{particles}, Block[ {rho, pos, x, i},
                                              rho = rho0;
                                              For[i = 1, i <= Length[particles], i++,
                                               x = particles[[i, 1]];
                                               pos = Floor[x];
                                               rho[[pos + 1]] += (pos + 1 - x);
                                               rho[[pos + 2]] += (x - pos);
                                               ];
                                              rho[[1]] += rho[[nx + 1]];
                                              Drop[rho, -1]*qp/dx
                                          ]], {rho0 -> 
            Table[0.0, {p["nx"] + 1}], dx -> p["dx"], 
           nx -> p["nx"], qp -> p["qp"]}]
     ]
    
GetRho1DZeroOrder[opts : OptionsPattern[]] :=
    Block[ {p=OptionValue[PicParameters],rho0, dx, qp, nx},
        ReplaceAll[Function[{particles}, Block[ {rho, pos, x, i},
                                             rho = rho0;
                                             For[i = 1, i <= Length[particles], i++,
                                              x = particles[[i, 1]];
                                              pos = Round[x];
                                              rho[[pos + 1]] += 1;
                                              ];
                                             rho[[1]] += rho[[nx + 1]];
                                             Drop[rho, -1]*qp/dx
                                         ]], {rho0 -> 
           Table[0.0, {p["nx"] + 1}], dx -> p["dx"], 
           nx -> p["nx"], qp -> p["qp"]}]
    ]
End[] (* End Private Context *)

EndPackage[]