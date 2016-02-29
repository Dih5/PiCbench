(* Mathematica Test File *)

	PicPar["dx"]=2.5

	fun=Sin[2 \[Pi]*#/PicPar["lx"]] &
	opt=Method->"Fourier"
	label="Sin - Fourier"
	Get["Tests/Maxwell1D.mt"]
	
	fun=Cos[2 \[Pi]*#/PicPar["lx"]] &
	opt=Method->"Fourier"
	label="Cos - Fourier"
	Get["Tests/Maxwell1D.mt"]


	fun=Sin[2 \[Pi]*#/PicPar["lx"]] &
	opt=Method->"Fourier-diff"
	label="Sin - Fourier-diff"
	Get["Tests/Maxwell1D.mt"]
	
	fun=Cos[2 \[Pi]*#/PicPar["lx"]] &
	opt=Method->"Fourier-diff"
	label="Cos - Fourier-diff"
	Get["Tests/Maxwell1D.mt"]
