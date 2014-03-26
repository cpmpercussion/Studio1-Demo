// Demo of Ambisonic Functions in Supercollider "Piteå Forest"

~soundsPath = thisProcess.nowExecutingPath.dirname +/+ "../sounds/";

~ambience = Buffer.read(s, ~soundsPath ++ "20111206-PiteaFirstSnowWalkAmbience.wav");
~footsteps = Buffer.read(s, ~soundsPath ++ "snowsteps-short-mono.wav");
~snowcrush = Buffer.read(s, ~soundsPath ++ "snow-crushing-1.wav");
~crotaleC = Buffer.read(s, ~soundsPath ++ "crotale-C.wav");

~decoder = FoaDecoderMatrix.newStereo;
// ~decoder = FoaDecoderMatrix.newPeri(numChanPairs: 4, elevation: 0.61547970867039, orientation: 'flat', k: 'dual');



// Ambience Player
(
play({
	var sig = PanB.ar(PlayBuf.ar(~ambience.numChannels,~ambience.bufnum,loop:1)[0],pi,0,0.5) +
	PanB.ar(PlayBuf.ar(~ambience.numChannels,~ambience.bufnum,loop:1)[1],-pi,0,0.3);
	FoaDecode.ar(sig,~decoder);
});
)

// Footsteps player
(
play({
    var sig = PanB.ar(PlayBuf.ar(~footsteps.numChannels,~footsteps.bufnum,loop:1),
		0,-0.5pi,0.4);
	FoaDecode.ar(sig,~decoder);
});
)

// Snow in hands
(
play({
	var sig = PanB.ar(PlayBuf.ar(~snowcrush.numChannels,~snowcrush.bufnum,loop:1),
		MouseX.kr(pi, -pi),MouseY.kr(pi/2, 0),0.8);
	FoaDecode.ar(sig,~decoder);
});
)

// Bells Falling
// each should choose a different note and a different azimuth and have a smoothly falling elevation.

~playBell = {
	SynthDef("BellFalling",{
		arg out = 0;
		var source = PlayBuf.ar(
			soundArray[busNum].numChannels,
			soundArray[busNum].bufnum,
			rate: 0.9 + (20.rand/100),
			//doneAction: 2,
			loop: 0
		);
		var az = -1.125 + (platform * 0.125);
		var bFormatSource = PanB2.ar(source[0],az,0.3);
}


	// Play a bus sound from platform in direction
	// New Playbus synthdef with envelopes
	~playBus = {arg platform, direction, hour;
		//var soundArray = [~busArray,~nightBusArray,~nightLoopArray,~nightPeopleArray].wchoose([0.5,0.3,0.2,0.1]);
		var soundArray = ~getSoundArray.value(hour);
		var busNum = soundArray.size.rand; //array location of bus sound
		var busLoop = 1;
		var length = soundArray[busNum].numFrames / soundArray[busNum].sampleRate;
		if (~shortsounds, {length = 1.5 + (20.rand/10)});
		//Play a bus sound
		SynthDef("bus" ++ busNum ++ "_Player", {
			arg out = 0;
			//var env = EnvGen.kr(Env.asr(3,0.15 + (0.01*40.rand),5),doneAction:2);
			var env = EnvGen.kr(
				Env.linen(length*0.5,length*0.1,length*0.5),
				//Env.perc(length*0.3,length*0.7),
				levelScale:0.15 + (0.01*40.rand),
				doneAction:2);

			var source = PlayBuf.ar(
				soundArray[busNum].numChannels,
				soundArray[busNum].bufnum,
				rate: 0.9 + (20.rand/100),
				startPos:soundArray[busNum].numFrames.rand,
				//doneAction: 2,
				loop: busLoop
			) * env;

			var az = -1.125 + (platform * 0.125);
			var shift = 0.05;
			var bFormatSource = PanB2.ar(source[0],az,0.3) + PanB2.ar(source[1],az+shift,0.3);
			var rotateSpeed = 0.005 * 5.rand;
			//rotateSpeed.postln;
			// Rotating the sound based on Direction.
			var rotatedSource = Rotate2.ar(bFormatSource[1],bFormatSource[2],direction * LFSaw.kr(rotateSpeed));
			Out.ar(
				out,
				//Balance2.ar(source[0],source[1],0,0.3)
				//DecodeB2.ar(~outChannels,bFormatSource[0],bFormatSource[1],bFormatSource[2]);
				DecodeB2.ar(~outChannels,bFormatSource[0],rotatedSource[0],rotatedSource[1]);
			)
		}).play(s);
	};