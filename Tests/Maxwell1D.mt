(* Mathematica Test File *)

Test[
	With[{fun=fun,
		opt=opt}, 
		theoric = Integrate[fun[i], i];
		theoricTable=Table[theoric, {i, PicPar["nx"]}];
		calcTable=GetE1D[opt][Table[fun[i], {i, PicPar["nx"]}]]
		];
	PiCbench`Tests`Private`AbsDif[theoricTable,calcTable]<0.01
	,
	True
	,
	TestID->"Maxwell1D"<>label
]
