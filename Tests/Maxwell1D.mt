(* Mathematica Test File *)

(* Child test to compare solutions obtain from GetE1D with the theoric ones.
The test passes iff the mean relative difference is less than 1%.
Parameters:
	fun: pure function describing rho(x). MUST BE PERIODIC in [0,lx) and its AVERAGE MUST VANISH. Examples:
		UnitBox[(2 #/PicPar["lx"] - 1)] - 1/2&
		Sin[2 Pi * #/PicPar["lx"]] &
	opt: options to pass to GetE1D

*)
Test[
	With[{fun=fun,
		opt=opt}, 
		theoric = Integrate[fun[x], x];
		theoric = theoric /. x -> i*PicPar["dx"];
		theoricTable=Table[theoric, {i, PicPar["nx"]}];
		calcTable = GetE1D[opt][Table[fun[i*PicPar["dx"]], {i, PicPar["nx"]}]]
		];
	PiCbench`Tests`Private`RelDif[theoricTable,calcTable]<0.01
	,
	True
	,
	TestID->"Maxwell1D"<>label
]
