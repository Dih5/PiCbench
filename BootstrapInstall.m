(* ::Package:: *)

Get["https://raw.githubusercontent.com/jkuczm/MathematicaBootstrapInstaller/v0.1.1/BootstrapInstaller.m"]


BootstrapInstall[
	"SyntaxAnnotations",
	"https://github.com/dih5/PiCbench/releases/download/v0.1.0/PiCbench.zip",
	"AdditionalFailureMessage" ->
		Sequence[
			"You can ",
			Hyperlink[
				"install the PiCbench package manually",
				"https://github.com/dih5/PiCbench#manual-installation"
			],
			"."
		]
]