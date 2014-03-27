// Demo of Ambisonic Functions in Supercollider "Piteå Forest"
// Requires "ATK" SuperCollider Plugin (in the SC3 Plugins Package).

Server.default = s = Server.local;
s.boot();

(
~soundsPath = thisProcess.nowExecutingPath.dirname +/+ "../sounds/";

~ambience = Buffer.read(s, ~soundsPath ++ "20111206-PiteaFirstSnowWalkAmbience.wav");
~footsteps = Buffer.read(s, ~soundsPath ++ "snowsteps-short-mono.wav");
~snowcrush = Buffer.read(s, ~soundsPath ++ "snow-crushing-1.wav");
~crotaleC = Buffer.read(s, ~soundsPath ++ "crotale-C.wav");

//
// The ~decoder object changes the "b-format" signal into signals for each speaker
// only use one of these!

// Stereo Decoder
//~decoder = FoaDecoderMatrix.newStereo();

// Quad Surround Decoder
// ~decoder = FoaDecoderMatrix.newQuad();

// 3D Surround Decoder (8 speakers for the listening room)
~decoder = FoaDecoderMatrix.newPeri();
)

// ~decoder = FoaDecoderMatrix.newPeri()
// ~decoder.dirChannels()

// Ambience Player
(
play({
	var sig = PanB.ar(PlayBuf.ar(~ambience.numChannels,~ambience.bufnum,loop:1)[0],pi,0,0.5) +
	PanB.ar(PlayBuf.ar(~ambience.numChannels,~ambience.bufnum,loop:1)[1],-pi,-0.5pi,0.1);
	FoaDecode.ar(sig,~decoder);
});
)

// Footsteps player
(
play({
    var sig = PanB.ar(PlayBuf.ar(~footsteps.numChannels,~footsteps.bufnum,loop:1),
		0,-0.5pi,0.1);
	FoaDecode.ar(sig,~decoder);
});
)

// Snow in hands
(
play({
	var sig = PanB.ar(PlayBuf.ar(~snowcrush.numChannels,~snowcrush.bufnum,loop:1),
		MouseX.kr(pi, -pi),MouseY.kr(pi/2, 0),0.3);
	FoaDecode.ar(sig,~decoder);
});
)

// Bells Falling
// each should choose a different note and a different azimuth and have a smoothly falling elevation.
(

SynthDef("BellFalling",{
	arg out = 0;
	var source = PlayBuf.ar(
		~crotaleC.numChannels,
		~crotaleC.bufnum,
		rate: 1.5 + (200.rand/100),
		doneAction: 2,
		loop: 0
	);
	var azimuth = ((200.rand/100) -1)*pi;
	var elevation = EnvGen.kr(Env.perc(0,3,0.5pi));
	var bFormatSource = PanB.ar(source,azimuth,elevation,0.3);
	Out.ar(out,FoaDecode.ar(bFormatSource,~decoder);)
}).play(s);

)

// Alternative Version with Mouse Control
(
play({
	var source = PlayBuf.ar(
		~crotaleC.numChannels,
		~crotaleC.bufnum,
		rate: 1.5 + (200.rand/100),
		doneAction: 2,
		loop: 0
	);
	var azimuth = MouseX.kr(pi, -pi) * ((200.rand/100) -1)*pi;
	var elevation = MouseY.kr(pi/4, -pi/4);
	var bFormatSource = PanB.ar(source,azimuth,elevation,0.3);
	FoaDecode.ar(bFormatSource,~decoder);
});


)