(* Mathematica Test File *)

Test[
	With[{fun=fun,
		opt=opt}, 
		theoric = Integrate[fun[x], x];
		theoric = theoric /. x -> i*PicPar["dx"];
		theoricTable=Table[theoric, {i, PicPar["nx"]}];
		calcTable = GetE1D[opt][Table[fun[i*PicPar["dx"]], {i, PicPar["nx"]}]]
		];
	PiCbench`Tests`Private`AbsDif[theoricTable,calcTable]<0.01
	,
	True
	,
	TestID->"Maxwell1D"<>label
]
