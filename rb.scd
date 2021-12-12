
/* Requiem for Beauty */
/* performance June 7, 2019 */
/* rev Aug 9, 2019 */
/* rev Dec 2, 2021 */

/* This script generates electronics part in the Requiem for Beauty. Pianist will trigger using Akai MPK mini midi controller. Electronics performer will trigger using a push button midi controller, Akai APC mini, Akai LPD 8. This piece will involve 9 speakers and 2 subs in which 2 and the 2 subs will be placed beside the performers at the right and left of the stage (stereo L and R with chained sub for each). In addition, 1 speaker will be placed below the grand piano (piano needs to be opened to the largest without taking it apart). A dynamic microphone, Shure SM58, will be placed in front of the soprano in order to pick up vocal sound. A condenser microphone, Rode NT 5 (or Sontronics STC-10), will be placed at piano aiming at the soundboard. Third microphone will be placed in front of the piano for the actor. */


//////////////////////////////////////// preparation and setup ////////////////////////////////////////
/* 1. Setup speakers. Specify number of input and output channels (line X). Specify channel/ouput bus number (line X) if necessary
2. Setup input and output device (audio interface) (line X).
3. Change buffer directories of pre-recorded sound files (lines x-x).
4. Change microphone input channel number if necessary. (lines x-x)
5. If you are using different midi controllers from the ones used to compose the Requiem, change the names of the midi controllers (from lines 1104) and corresponding midi number of each button or slider (lines x-x, x-x).

For detailed intruction, please refere to the documentation for the electornics of the Requiem.

Tip: cmd + shift + library to recompile class library, this will include reboot

*/

(
{
	/* start up file */
	Server.local.options.numOutputBusChannels = 11; // change number of input and output channels
	Server.local.options.numInputBusChannels = 3;
	Server.internal.options.numOutputBusChannels = 11;
	Server.internal.options.numInputBusChannels = 3;
	//Server.local.options.device = "MOTU 896mk3 Hybrid";
	//Server.local.options.inDevice = "Scarlett 2i4 USB"; // other possible audio interfaces
	Server.local.options.outDevice = "Built-in Output";
	//Server.local.options.outDevice = "Orpheus (0979)";

	{s.meter;}.defer; // make sure number of channels is correct
	MIDIClient.init; // start midi
	MIDIIn.connectAll; // connect all midi devices

	s.waitForBoot { // go through becore booting server

		"buffers".postln;

		/* allocate buffers */
		~bufLength1 = 19;
		~bufLength2 = 8;
		~buf1 = Buffer.alloc(s, 44100 * ~bufLength1, 1); // allocate buffer to record for 19 seconds for Rec 1 in Sec 2
		s.sync;
		~buf2 = Buffer.alloc(s, 44100 * ~bufLength2, 1); // allocate buffer to record for 8 seconds for Rec 2 in Sec 2
		s.sync;
		~bufSec1 = Buffer.read(s, "/Users/shuyulin/Desktop/1.wav"); // load soundfile
		s.sync;
		~bufSec2 = Buffer.read(s, "/Users/shuyulin/Desktop/2.wav");
		s.sync;
		~bufSec3 = Buffer.read(s, "/Users/shuyulin/Desktop/3.wav");
		s.sync;
		~bufSec5 = Buffer.read(s, "/Users/shuyulin/Desktop/5.wav");
		s.sync;
		~bufSec6 = Buffer.read(s, "/Users/shuyulin/Desktop/6.wav");
		s.sync;
		~bufSec7 = Buffer.read(s, "/Users/shuyulin/Desktop/7.wav");
		s.sync;
		~bufSec8 = Buffer.read(s, "/Users/shuyulin/Desktop/8.wav");
		s.sync;
		~bufSec9 = Buffer.read(s, "/Users/shuyulin/Desktop/9.wav");
		s.sync;
		~bufSec10 = Buffer.read(s, "/Users/shuyulin/Desktop/10.wav");
		s.sync;
		~bufSec11 = Buffer.read(s, "/Users/shuyulin/Desktop/11.wav");
		s.sync;
		~bufSec12 = Buffer.read(s, "/Users/shuyulin/Desktop/12.wav");
		s.sync;
		~bufSec13 = Buffer.read(s, "/Users/shuyulin/Desktop/13.wav");
		s.sync;
		~bufSec13_hui = Buffer.read(s, "/Users/shuyulin/Desktop/13-hui.wav");
		s.sync;
		~bufSec13_sheng = Buffer.read(s, "/Users/shuyulin/Desktop/13-sheng.wav");
		s.sync;
		~bufSec13_dong = Buffer.read(s, "/Users/shuyulin/Desktop/13-dong.wav");
		s.sync;
		~bufSec13_chi = Buffer.read(s, "/Users/shuyulin/Desktop/13-chi.wav");
		s.sync;
		~bufCueBar8 = Buffer.read(s, "/Users/shuyulin/Desktop/bar8.wav"); // sound files of clarinet cues
		s.sync;
		~bufCueBar46 = Buffer.read(s, "/Users/shuyulin/Desktop/bar46.wav");
		s.sync;
		~bufCueBar108 = Buffer.read(s, "/Users/shuyulin/Desktop/bar108.wav");
		s.sync;
		~bufCueBar152 = Buffer.read(s, "/Users/shuyulin/Desktop/bar152.wav");
		s.sync;
		~bufCueBar182 = Buffer.read(s, "/Users/shuyulin/Desktop/bar182.wav");
		s.sync;
		~bufCueBar207 = Buffer.read(s, "/Users/shuyulin/Desktop/bar207.wav");
		s.sync;
		~bufCueBar230 = Buffer.read(s, "/Users/shuyulin/Desktop/bar230.wav");
		s.sync;
		~bufCueBar235 = Buffer.read(s, "/Users/shuyulin/Desktop/bar235.wav");
		s.sync;
		~bufCueBar250 = Buffer.read(s, "/Users/shuyulin/Desktop/bar250_E.wav");
		s.sync;
		~bufCueBar252 = Buffer.read(s, "/Users/shuyulin/Desktop/bar252.wav");
		s.sync;
		~bufCueBar268 = Buffer.read(s, "/Users/shuyulin/Desktop/bar268.wav");
		s.sync;
		~bufTestNoise = Buffer.read(s, "/Users/shuyulin/Desktop/test-noise.wav"); // noise for testing speakers
		s.sync;
		~bufTestSubNoise = Buffer.read(s, "/Users/shuyulin/Desktop/test-sub-noise.wav");
		s.sync;
		~bufTestSubSweep = Buffer.read(s, "/Users/shuyulin/Desktop/test-sub-sweep.wav"); // sweep for testing speakers
		s.sync;
		~bufTestSweep = Buffer.read(s, "/Users/shuyulin/Desktop/test-sweep.wav");
		s.sync;
		/*
		~bufStab = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); // default sound file for testing
		s.sync;*/

		"buffers done".postln;




		////////////////////////////* function *////////////////////////////
		/* global variables for Motu setup */
		~ch0 = 0; // channel outputs
		~ch1 = 1;
		~ch2 = 2;
		~ch3 = 3;
		~ch4 = 4;
		~ch5 = 5;
		~ch6 = 6;
		~ch7 = 7;
		~ch8 = 8;
		//~ch9 = 9; // optional variable for sub 1
		//~ch10 = 10; // optional varialbe for sub 2
		~mic1 = 0; // mic inputs
		~mic2 = 1;
		~mic3 = 2;

		/* pick up mic 1 signal (sop mic), modify amplitude etc. for output */
		~inNdef1= {
			Ndef.ar(\micIn1, 1); // 1 input from 1 mic
			//Ndef(\micIn, { Compander.ar(SoundIn.ar(2), 0, 0.7, 0.5, 0.9, 0.01, 0.1, 0.5) }); // with compressor
			Ndef(\micIn1, { SoundIn.ar(~mic1)}); // pick up from channel 2; this need to change based on tech setup
		}; // mic signal to channel 0
		~inNdef1.(); // run SoundIn ~inNdef globally

		/* pick up mic 2 signal (piano mic), modify amplitude etc. for output */
		~inNdef2 = {
			Ndef.ar(\micIn2, 1); // 1 input from 1 mic
			Ndef(\micIn2, { SoundIn.ar(~mic2)});
		}; // mic signal to channel 1
		~inNdef2.(); // run globally

		/* pick up mic 3 signal (actor mic), modify amplitude etc. for output */
		~inNdef3 = {
			Ndef.ar(\micIn3, 1); // 1 input from 1 mic
			Ndef(\micIn3, { SoundIn.ar(~mic3)});
		}; // mic signal to channel 2
		~inNdef3.(); // run globally

		/* function to record into buffer; record soprano */
		SynthDef(\SoundIn, {
			arg bufnum = 0, recLevel = 1, preLevel = 0;
			var input, rec;
			input = SoundIn.ar(~mic1); // receive soprano signal and post signal info to make sure it is recording (.poll)
			rec = RecordBuf.ar(input, bufnum, 0, recLevel, preLevel, loop: 0, doneAction: 2);
		}).add;

		/* function amplify soprano through speakers 1, 2, 5, 6, 9 */
		~sopAmp12569 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1, ~ch4, ~ch5, ~ch8], signal * vol);
		};

		/* function for bar 1; output soprano voice to speakers 9 (below piano) */
		~bar1SopToSpeaker9 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch8], signal * vol);
		};

		/* function for bar 1; output piano signal to speakers 5, 6 */
		~bar1PnoToSp56 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch4, ~ch5], signal * vol);
		};

		/* function for bar 4; for LPD 8 to control panning of soprano signal */
		~bar4PanSop = {
			arg pos = 0, level = 0.2, vol = 0.8;
			PanAz.ar(
				8, // numChans
				SoundIn.ar(~mic1), // in
				//Ndef.ar(\micIn1, 1), // alternate way of input
				pos,
				level,
				2,            // width
				0, //orientation
			) * vol;
		};

		/* function for bar 13; granularize pre-recorded section 13 */
		~bar6GranSec13 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur=1, rate, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=10;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0.95, 1.05); // * -1 to play backward
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 13; granularize pre-recorded section 13; frequency modulate on certain words */
		~bar6GranSec13_mod = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur = 1, rate, minRate = 0, maxRate = 0, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens = 50;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0.95, 1.05 + maxRate); // * -1 to playbackward
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 9; spectral filter to playback 'modulated' soprano result; output speakers 1, 2 */
		~bar9spec = {
			arg gate = 1, vol = 0.7;
			var in1, in2, chain1, chain2, copychain, copychainNewChain2, signal, fftSig, env1, env2;
			env1 = Env.dadsr(0.1, sustainLevel:1).kr;
			env2 = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			in1 = Saw.ar(900, 0.5) + Saw.ar(800, 0.5) + Saw.ar(700, 0.5) + Saw.ar(600, 0.5) + Saw.ar(500, 0.5) + Saw.ar(400, 0.5) + Saw.ar(300, 0.5) + Saw.ar(200, 0.5);
			in2 = Ndef.ar(\micIn1, 1); // * Saw.ar(rrand(-100, 100),0.8);
			chain1 = FFT(LocalBuf(1024), in1);
			chain2 = FFT(LocalBuf(1024), in2);
			copychain= PV_Copy(chain2, LocalBuf(1024)); //copy of FFT analysis of SoundIn
			chain1 = PV_MagMul(chain1, chain2);
			fftSig = [0.5 * IFFT(chain1),  0.5 * IFFT(copychain)] * env1;
			signal = FreeVerb.ar(fftSig, 0.5, 0.5, 0.9, 0.2);
			Out.ar([~ch0], signal * env2 * vol);
		};

		/* function for bar 10; granularize pre-recorded section 1 */
		~bar10GranSec1 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur=1, rate, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=40;
			var env, signal;
			// controls for grain
			numChannels = 4;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0.5, 1.5); // * -1 to playbackwards
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch2, signal * vol);
		};

		/* function for bar 16; granularize pre-recorded section 12 */
		~bar16GranSec12 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.2, numChannels, trigger, dur=1, rate, minRate = 0, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=200;
			var env, signal;
			// controls for grain
			numChannels = 2;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0 + minRate, 1); // * -1 to playbackwards
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(200);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 26; output soprano voice to speakers 3, 4, 7, 8 */
		~bar26SopToSpeaker3478 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch2, ~ch3, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 27; freq modulate to create upward gliss (control by LPD 8) on soprano signal through speaker 5, 6 */
		~bar27spec = {
			arg gate = 1, vol = 0.7, freq = 200;
			var in1, in2, chain1, chain2, copychain, copychainNewChain2, signal, fftSig, env1, env2;
			env1 = Env.dadsr(0.1, sustainLevel:1).kr;
			env2 = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			in1 = Saw.ar(freq, 0.8);
			in2 = Ndef.ar(\micIn1, 1);
			chain1 = FFT(LocalBuf(1024), in1);
			chain2 = FFT(LocalBuf(1024), in2);
			copychain= PV_Copy(chain2, LocalBuf(1024));
			chain1 = PV_MagMul(chain1, chain2);
			copychain = PV_MagFreeze(copychain, LFNoise0.kr(100));
			fftSig = [0.5 * IFFT(chain1),  0.5 * IFFT(copychain)] * env1;
			signal = FreeVerb.ar(fftSig, 0.5, 0.5, 0.9, 0.2);
			Out.ar([~ch4], signal * env2 * vol);
		};

		/* function for bar 21, 28; output soprano voice to speakers 1, 2 */
		~bar28SopToSpeaker12 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1], signal * vol);
		};

		/* function for bar 32; granularize pre-recorded section 11 */
		~bar32GranSec11 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur, rate, minRate = 0.2, maxRate = 0, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=50;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			dur = 1.5;
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(200);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 33; granularize live soprano recording rec 2 */
		~bar33GranLiveRec2 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur, rate, minRate = 0.7, maxRate = 1.3, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=20;
			var env, signal;
			// controls for grain
			numChannels = 2;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0.95, 1.05) * -1; // playbackwards
			dur = 1;
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(100);
			envbufnum = -1;
			maxGrains = 100; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 40; granularize live recording 2, Rec 2 */
		~bar40GranLiveRec2 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=1, rate, minRate = 0, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=20;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(0.7, 1.2);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(200);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 49; granularize pre-recorded section 10 */
		~bar49GranSec10 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=1, rate, minRate = 0, maxRate = 1.3, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=10;
			var env, signal;
			// controls for grain
			numChannels = 1;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = 0; // to control later
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch7, signal * vol);
		};

		/* function for bar 61; granularize pre-recorded section 10 backward; through speakers 1, 2 */
		~bar61GranSec10 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=1, rate, minRate = 0, maxRate = 1.3, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=10;
			var env, signal;
			// controls for grain
			numChannels = 2;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate) * -1;
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = 0; // to control later
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 92 */
		~bar92PanGran = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur=1, rate, minRate = 1, maxRate = 1.3, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=10;
			var env, signal, signalPan, signalPan1, signalPan2, signalPan3;
			// controls for grain
			numChannels = 3;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 2;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			signalPan1 = PanAz.ar(8, signal[0], shiftPan, orientation:0);
			signalPan = signalPan1;
			Out.ar(~ch0, signalPan * vol);
		};

		/* function for bar 92 */
		~bar92PanGran2 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur=1, rate, minRate = 1, maxRate = 1.3, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=10;
			var env, signal, signalPan, signalPan1, signalPan2, signalPan3;
			// controls for grain
			numChannels = 3;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 2;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			signalPan1 = PanAz.ar(8, signal[0], shiftPan, orientation:0);
			signalPan = signalPan1;
			Out.ar(~ch0, signalPan * vol);
		};

		/* function for bar 118; granularize pre-recorded section 7; through speakers 1, 2, 5, 6 */
		~bar118GranSec7 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=1, rate, minRate = 0, maxRate = 0.2, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=50;
			var env, signal;
			// controls for grain
			numChannels = 1;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate) * -1;
			pos = SinOsc.ar(LFNoise1.kr(50));
			interp = 1;
			pan = 0; // to control later
			envbufnum = -1;
			maxGrains = 200; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar([~ch0, ~ch1, ~ch4, ~ch5], signal * vol);
		};

		/* function for bar 135 */
		~bar135GranPanSec7 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.9, numChannels, trigger, dur=0.3, rate, minRate = 0, maxRate = 0.5, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=200;
			var env, signal, signalPan, signalPan1, signalPan2, signalPan3;
			// controls for grain
			numChannels = 3;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(100));
			interp = 2;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			signalPan1 = PanAz.ar(8, signal[0], shiftPan, orientation:0);
			signalPan = signalPan1;
			Out.ar(~ch0, signalPan * vol);
		};

		/* output piano signal to all speakers with reverb */
		~bar154SopToAllSp = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1, ~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 155; granularize pre-recorded section 6; through speakers 1, 2 */
		~bar155GranSec6 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=0.2, rate, minRate = 0, maxRate = 1.5, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=400;
			var env, signal;
			// controls for grain
			numChannels = 2;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 4;
			pan = 0; // to control later
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 176; granularize pre-recorded section 5; through all speakers */
		~bar176GranSec5 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=2, rate, minRate = 0.9, maxRate = 1.2, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=0.3;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate) * -1;
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 176; granularize pre-recorded section 9; through all speakers */
		~bar176GranSec9 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=3, rate, minRate = 0.9, maxRate = 1.2, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=0.5;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = SinOsc.kr(400);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* foot pedal button 2 */
		// high frequency output
		~bar184spec = {
			arg gate = 1, vol = 0.7;
			var in1, in2, chain1, chain2, copychain, copychainNewChain2, signal, fftSig, env1, env2;
			env1 = Env.dadsr(0.1, sustainLevel:1).kr;
			env2 = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			in1 = Saw.ar(3000, 0.5) + Saw.ar(2000, 0.5) + Saw.ar(1500, 0.5) + Saw.ar(1000, 0.5) + Saw.ar(500, 0.5);
			in2 = Ndef.ar(\micIn1, 1);
			chain1 = FFT(LocalBuf(1024), in1);
			chain2 = FFT(LocalBuf(1024), in2);
			copychain= PV_Copy(chain2, LocalBuf(1024)); //copy of FFT analysis of SoundIn
			chain1 = PV_MagMul(chain1, chain2);
			fftSig = [0.5 * IFFT(chain1),  0.5 * IFFT(copychain)] * env1;
			signal = FreeVerb.ar(fftSig, 0.5, 0.5, 0.9, 0.2);
			Out.ar([~ch0], signal * env2 * vol);
		};

		/* foot pedal button 3 */
		// low frequency output
		~bar188spec = {
			arg gate = 1, vol = 0.7;
			var in1, in2, chain1, chain2, copychain, copychainNewChain2, signal, fftSig, env1, env2;
			env1 = Env.dadsr(0.1, sustainLevel:1).kr;
			env2 = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			in1 = Saw.ar(100, 0.5) + Saw.ar(200, 0.5) + Saw.ar(300, 0.5) + Saw.ar(400, 0.5) + Saw.ar(500, 0.5);
			in2 = Ndef.ar(\micIn1, 1);
			chain1 = FFT(LocalBuf(1024), in1);
			chain2 = FFT(LocalBuf(1024), in2);
			copychain= PV_Copy(chain2, LocalBuf(1024)); //copy of FFT analysis of SoundIn
			chain1 = PV_MagMul(chain1, chain2);
			fftSig = [0.5 * IFFT(chain1),  0.5 * IFFT(copychain)] * env1;
			signal = FreeVerb.ar(fftSig, 0.5, 0.5, 0.9, 0.2);
			Out.ar([~ch0], signal * env2 * vol);
		};

		/* function for bar 198; output soprano voice to speaker 5 */
		~bar198SopToSpeaker5 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch4], signal * vol);
		};

		/* function for bar 200; output soprano voice to speaker 7 */
		~bar200SopToSpeaker7 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch6], signal * vol);
		};

		/* function for bar 202; output soprano voice to speaker 4 */
		~bar202SopToSpeaker4 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch3], signal * vol);
		};

		/* function for bar 202; output soprano voice to speaker 6 */
		~bar204SopToSpeaker6 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch5], signal * vol);
		};

		/* function for bar 1; output piano signal to speakers 1, 2 */
		~bar208PnoToSp12 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1], signal * vol);
		};

		/* function for bar 220; granularize pre-recorded section 3 */
		~bar220GranSec3 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=1, rate, minRate = 0.8, maxRate = 0.9, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=20;
			var env, signal;
			// controls for grain
			numChannels = 1;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = 0;
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch8, signal * vol);
		};

		/* function for bar 220; output piano signal to speaker 8 */
		~bar220PnoToSp8 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch7], signal * vol);
		};

		/* function for bar 222; output piano signal to speaker 7 */
		~bar222PnoToSp7 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch6], signal * vol);
		};

		/* function for bar 225; output piano signal to speaker 6 */
		~bar225PnoToSp6 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch5], signal * vol);
		};

		/* function for bar 228; output piano signal to speaker 5 */
		~bar228PnoToSp5 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch4], signal * vol);
		};

		/* function for bar 231; output piano signal to speaker 4 */
		~bar231PnoToSp4 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch3], signal * vol);
		};

		/* function for bar 238; granularize pre-recorded section 2 */
		~bar238GranSec2 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=0.2, rate, minRate = 0.8, maxRate = 0.9, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=150;
			var env, signal;
			// controls for grain
			numChannels = 1;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(200));
			interp = 1;
			pan = 0;
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch8, signal * vol);
		};

		/* function for bar 238; output piano signal to speakers 1, 2, 3, 4, 5, 6, 7, 8 */
		~bar238PnoToAllSp = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.8;
			in = Ndef.ar(\micIn2, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1, ~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 238; granularize pre-recorded section 2 */
		~bar238GranSec2_2 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=5, rate, minRate = 0.9, maxRate = 1.1, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=0.5;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(800));
			interp = 1;
			pan = SinOsc.kr(800);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 250; granularize pre-recorded section 1 */
		~bar250GranSec1 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=3, rate, minRate = 0.9, maxRate = 1.1, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=0.5;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(800));
			interp = 1;
			pan = SinOsc.kr(800);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* foot pedal button 4 */
		~bar250spec = {
			arg gate = 1, vol = 0.7;
			var in1, in2, chain1, chain2, copychain, copychainNewChain2, signal, fftSig, env1, env2;
			env1 = Env.dadsr(0.1, sustainLevel:1).kr;
			env2 = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			in1 = Saw.ar(2000, 0.5) + Saw.ar(1000, 0.5) +Saw.ar(900, 0.5) + Saw.ar(800, 0.5) + Saw.ar(600, 0.5) + Saw.ar(400, 0.5) + Saw.ar(200, 0.5) + Saw.ar(100, 0.5);
			in2 = Ndef.ar(\micIn1, 1);
			chain1 = FFT(LocalBuf(1024), in1);
			chain2 = FFT(LocalBuf(1024), in2);
			copychain= PV_Copy(chain2, LocalBuf(1024)); // copy of FFT analysis of SoundIn
			chain1 = PV_MagMul(chain1, chain2);
			fftSig = [0.5 * IFFT(chain1),  0.5 * IFFT(copychain)] * env1;
			signal = FreeVerb.ar(fftSig, 0.5, 0.5, 0.9, 0.2);
			Out.ar([~ch0, ~ch1, ~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * env2 * vol);
		};

		/* function for bar 257; granularize pre-recorded section 1 */
		~bar257GranSec1 = {
			arg sndbuf, out, gate = 1, vol = 1, amp = 0.8, numChannels, trigger, dur=2, rate, minRate = 0.8, maxRate = 1.2, pos, interp, pan, envbufnum, maxGrains, shiftPan = 0, grainDens=100;
			var env, signal;
			// controls for grain
			numChannels = 8;
			trigger = Dust.ar(grainDens); // frequency of grain or density of grain cloud
			rate = LFNoise1.kr.range(minRate, maxRate);
			pos = SinOsc.ar(LFNoise1.kr(800));
			interp = 2;
			pan = SinOsc.kr(200);
			envbufnum = -1;
			maxGrains = 512; // default value
			env = EnvGen.kr(Env.adsr, gate, levelScale: amp, doneAction: 2); // envelope to control overall amplitude of grain cloud
			signal = GrainBuf.ar(numChannels, trigger, dur, sndbuf, rate, pos, interp, pan, envbufnum, maxGrains) * env;
			Out.ar(~ch0, signal * vol);
		};

		/* function for bar 264 to playback pre-recorded hui ying */
		~bar264PlaybackRecHui = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch4, ~ch5], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function for bar 265 to playback pre-recorded sheng */
		~bar265PlaybackRecSheng = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch4, ~ch5], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function for bar 266 to playback pre-recorded dong */
		~bar266PlaybackRecDong = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch4, ~ch5], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function for bar 267 to playback pre-recorded chi */
		~bar267PlaybackRecChi = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch4, ~ch5], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function for bar 275; output snowball button release sound to all speakers */
		~bar275SnowballToAll = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.95;
			in = Ndef.ar(\micIn3, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.5, 0.8, 1, 1), 0.5, 0.8, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1, ~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 275; output snowball button release sound to all speakers */
		~bar275SnowballToAll_2 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.95;
			in = Ndef.ar(\micIn3, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.5, 0.8, 1, 1), 0.5, 0.8, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1,~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 275; output snowball button release sound to all speakers */
		~bar275SnowballToAll_3 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.95;
			in = Ndef.ar(\micIn3, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.5, 0.8, 1, 1), 0.5, 0.8, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1,~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};

		/* function for bar 275; output snowball button release sound to all speakers */
		~bar275SnowballToAll_4 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.95;
			in = Ndef.ar(\micIn3, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.5, 0.8, 1, 1), 0.5, 0.8, 1, 1) * amp * env);
			Out.ar([~ch0, ~ch1,~ch2, ~ch3, ~ch4, ~ch5, ~ch6, ~ch7], signal * vol);
		};


		/***************** playback cues *****************/
		/* function at bar 8 to playback G */
		~bar8PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 46 to playback C */
		~bar46PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 108 to playback F# */
		~bar108PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 152 to playback B */
		~bar152PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 182 to playback Bb */
		~bar182PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 207 to playback F */
		~bar207PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 230 to playback Eb */
		~bar230PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 235 to playback F */
		~bar235PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 250 to playback Bb */
		~bar250PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 252 to playback Eb */
		~bar252PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};

		/* function at bar 268 to playback Eb */
		~bar268PlayCue = {
			arg out = 0, bufnum, amp = 0.8;
			Out.ar([~ch0, ~ch1, ~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};



		/***************** soprano amplification functions *****************/
		/* function for amplify soprano signal through speaker 1 */
		~amplifySopThru1 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch0], signal * vol);
		};
		~amplifySopThru2 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch1], signal * vol);
		};
		~amplifySopThru3 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch2], signal * vol);
		};
		~amplifySopThru4 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch3], signal * vol);
		};
		~amplifySopThru5 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch4], signal * vol);
		};
		~amplifySopThru6 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch5], signal * vol);
		};
		~amplifySopThru7 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch6], signal * vol);
		};
		~amplifySopThru8 = {
			arg out, gate = 1, vol = 1;
			var in, amp, signal, env;
			env = EnvGen.kr(Env.cutoff(0.5), gate, doneAction: 2);
			amp = 0.9;
			in = Ndef.ar(\micIn1, 1); // pick up from mic 1
			signal = (FreeVerb.ar(FreeVerb.ar(Resonz.ar(in, 440, 1, 0.8), 0.3, 0.5, 1, 1), 0.3, 0.5, 1, 1) * amp * env);
			Out.ar([~ch7], signal * vol);
		};


		/***************** speaker test *****************/
		/* function speaker test */
		~sweep_sp1 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch0], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp2 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch1], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp3 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch2], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp4 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch3], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp5 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch4], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp6 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch5], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp7 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch6], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp8 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch7], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp9 = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch8], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp1sub = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch0], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};
		~sweep_sp2sub = {
			arg out = 0, bufnum, amp = 0.1;
			Out.ar([~ch1], (PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: 2)) * amp);
		};


		"func and def done".postln;


		/* get midi controller IDs */
		MIDIClient.sources.do{|item|
			if(item.name == "ActitioN MIDI Controller", {~footID = item.uid}); }; // foot controller
		MIDIClient.destinations.do{|item|
			if(item.name == "ActitioN MIDI Controller", {~footOutID = item.uid}); };
		MIDIClient.sources.do{|item|
			if(item.name == "APC MINI", {~apcID = item.uid}); }; // pad controller
		MIDIClient.destinations.do{|item|
			if(item.name == "APC MINI", {~apcOutID = item.uid}); };
		MIDIClient.sources.do{|item|
			if(item.name == "MPKmini2", {~mpkID = item.uid}); }; // keyboard controller
		MIDIClient.destinations.do{|item|
			if(item.name == "MPKmini2", {~mpkOutID = item.uid}); };
		MIDIClient.sources.do{|item|
			if(item.name == "LPD8", {~lpdID = item.uid}); }; // keyboard controller
		MIDIClient.destinations.do{|item|
			if(item.name == "LPD8", {~lpdOutID = item.uid}); };

		/* set midi outputs */
		m = MIDIOut(0, ~apcOutID);
		n = MIDIOut(0, ~mpkOutID);
		//f = MIDIOut(0, ~footOutID);
		l = MIDIOut(0, ~lpdOutID);
		"MIDIOut done".postln;

		/* APC slider controls */
		/* slider 1 */
		MIDIdef.cc(\slider1_button1, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar1SopSp9).set(\vol, num.linlin(0, 127, 0, 1)); // control amplitude output from mic 1 (sop mic) to speaker 9 (piano speaker)
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button9, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar16Gran).set(\vol, num.linlin(0, 127, 0, 1)); // control amplitude output from mic 1 (sop mic) to speaker 9 (piano speaker)
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button17, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar49Gran).set(\vol, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button25, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar176Gran2).set(\vol, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button33, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar225Pno).set(\vol, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button41, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar265Sheng).set(\amp, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button49, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar182Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button57, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru1).set(\vol, num.linlin(0, 127, 0, 1));
		}, 48, srcID: ~apcID);

		MIDIdef.cc(\slider1_button64, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep1).set(\amp, num.linlin(0, 127, 0, 0.1));
			Ndef(\sweep1sub).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 48, srcID: ~apcID);

		/* slider 2 */
		MIDIdef.cc(\slider2_button2, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar1PnoToSp).set(\vol, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button18, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar92GranWithPan).set(\vol, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button26, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar198Sop).set(\vol, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button34, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar228Pno).set(\vol, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button42, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar266Dong).set(\amp, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button50, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar207Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button58, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru2).set(\vol, num.linlin(0, 127, 0, 1));
		}, 49, srcID: ~apcID);

		MIDIdef.cc(\slider2_button66, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep2).set(\amp, num.linlin(0, 127, 0, 0.1));
			Ndef(\sweep2sub).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 49, srcID: ~apcID);

		/* slider 3 */
		MIDIdef.cc(\slider3_button3, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar4pan).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button11, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar26Sop).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button19, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar92GranWithPan2).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button27, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar200Sop).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button35, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar231Pno).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button43, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar267Chi).set(\amp, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button51, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar230Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button59, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru3).set(\vol, num.linlin(0, 127, 0, 1));
		}, 50, srcID: ~apcID);

		MIDIdef.cc(\slider3_button67, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep3).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 50, srcID: ~apcID);

		/* slider 4 */
		MIDIdef.cc(\slider4_button4, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar6Gran).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button12, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar27SopSpecGliss).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button20, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar118Gran).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button28, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar202Sop).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button36, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar238Pno).set(\vol, num.linlin(0, 127, 0, 1));
			Ndef(\bar238Gran).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button44, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar275SnowBall).set(\vol, num.linlin(0, 127, 0, 1));
			Ndef(\bar275SnowBall2).set(\vol, num.linlin(0, 127, 0, 1));
			Ndef(\bar275SnowBall3).set(\vol, num.linlin(0, 127, 0, 1));
			Ndef(\bar275SnowBall4).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button52, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar235Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button60, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru4).set(\vol, num.linlin(0, 127, 0, 1));
		}, 51, srcID: ~apcID);

		MIDIdef.cc(\slider4_button68, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep4).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 51, srcID: ~apcID);

		/* slider 5 */
		MIDIdef.cc(\slider5_button5, {
			arg num, id, chan, src;
			Ndef(\bar6GranMod).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button13, {
			arg num, id, chan, src;
			Ndef(\bar28SopTo12).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button21, {
			arg num, id, chan, src;
			Ndef(\bar135GranPan).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button29, {
			arg num, id, chan, src;
			Ndef(\bar204Sop).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button37, {
			arg num, id, chan, src;
			Ndef(\bar238Gran2).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button45, {
			arg num, id, chan, src;
			Ndef(\bar8Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button53, {
			arg num, id, chan, src;
			Ndef(\bar250Cue).set(\amp, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button61, {
			arg num, id, chan, src;
			Ndef(\sopThru5).set(\vol, num.linlin(0, 127, 0, 1));
		}, 52, srcID: ~apcID);

		MIDIdef.cc(\slider5_button69, {
			arg num, id, chan, src;
			Ndef(\sweep5).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 52, srcID: ~apcID);

		/* slider 6 */
		MIDIdef.cc(\slider6_button6, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar10Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button14, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar32Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button22, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar154SopToAll).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button30, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar208Pno).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button38, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar250Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button46, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar46Cue).set(\amp, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button54, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar252Cue).set(\amp, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button61, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru6).set(\vol, num.linlin(0,127, 0, 1));
		}, 53, srcID: ~apcID);

		MIDIdef.cc(\slider6_button70, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep6).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 53, srcID: ~apcID);

		/* slider 7 */
		MIDIdef.cc(\slider7_button15, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar33GranRec2).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button7, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar61Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button23, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar155Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button31, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar220Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button31_pno, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar220Pno).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button39, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar257Gran).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button47, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar108Cue).set(\amp, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button55, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar268Cue).set(\amp, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button63, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru7).set(\vol, num.linlin(0,127, 0, 1));
		}, 54, srcID: ~apcID);

		MIDIdef.cc(\slider7_button71, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep7).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 54, srcID: ~apcID);

		/* slider 8 */
		// foot pedal slider
		MIDIdef.cc(\slider8_footButton1, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar9SpecSop).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_footButton2, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar184SpecSop).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_footButton3, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar188SpecSop).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_footButton4, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar250SpecSop).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button16, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar40GranRec2).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button24, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar176Gran).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button32, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar222Pno).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button40, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar264Hui).set(\amp, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button48, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\bar152Cue).set(\amp, num.linlin(0,127, 0, 1));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button56, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\amp12569).set(\vol, num.linlin(0,127, 0, 1));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button64, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sopThru8).set(\vol, num.linlin(0,127, 0, 0.8));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider8_button72, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep8).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 55, srcID: ~apcID);

		MIDIdef.cc(\slider9_button89, {
			arg num, id, chan, src;
			//[num, id, chan, src].postln;
			Ndef(\sweep9).set(\amp, num.linlin(0, 127, 0, 0.1));
		}, 56, srcID: ~apcID);

		/* LPD control mapping */
		/* LPD knob 1 control frequency/ rate of granular synth */
		MIDIdef.cc(\lpdKnob1GranRateBar6, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar6GranMod).set(\maxRate, num.linlin(0, 127, 0, 2));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRateBar32, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar32Gran).set(\maxRate, num.linlin(0, 127, 0, 4));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_minRateBar16, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar16Gran).set(\minRate, num.linlin(0, 127, -1, 1.2));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_maxRateBar49, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar49Gran).set(\maxRate, num.linlin(0, 127, 0.2, 1.2));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_maxRateBar61, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar61Gran).set(\maxRate, num.linlin(0, 127, 0, 3));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_maxRateBar92, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan).set(\maxRate, num.linlin(0, 127, 1, 5));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_maxRateBar92_2, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan2).set(\maxRate, num.linlin(0, 127, 1, 5));
		}, 1, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob1GranRate_maxRateBar238, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar238Gran).set(\maxRate, num.linlin(0, 127, 0, 5));
		}, 1, srcID: ~lpdID);

		/* LPD knob 2 control duration of grain */
		MIDIdef.cc(\lpdKnob2GranDurBar32, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar32Gran).set(\dur, num.linlin(0, 127, 0.01, 3));
		}, 2, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob2GranDurBar49, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar49Gran).set(\dur, num.linlin(0, 127, 0.01, 3));
		}, 2, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob2GranDurBar61, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar61Gran).set(\dur, num.linlin(0, 127, 0.01, 3));
		}, 2, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob2GranDurBar92, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan).set(\dur, num.linlin(0, 127, 1, 3));
		}, 2, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob2GranDurBar92_2, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan2).set(\dur, num.linlin(0, 127, 1, 3));
		}, 2, srcID: ~lpdID);

		/* LPD knob 4 control soprano signal panning */
		MIDIdef.cc(\lpdKnob4, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			//~bar4pan.set(\pos, num.linlin(0, 127, 0, 2));
			Ndef(\bar4pan).set(\pos, num.linlin(0, 127, 0, 2));
		}, 4, srcID: ~lpdID);

		/* LPD knob 5 control density of grain cloud */
		MIDIdef.cc(\lpdKnob5CloudDensityBar16, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar16Gran).set(\grainDens, num.linlin(0, 127, 10, 200));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar32, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar32Gran).set(\grainDens, num.linlin(0, 127, 10, 50));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar49, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar49Gran).set(\grainDens, num.linlin(0, 127, 30, 200));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar61, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar61Gran).set(\grainDens, num.linlin(0, 127, 30, 200));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar92, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan).set(\grainDens, num.linlin(0, 127, 20, 150));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar92_2, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan2).set(\grainDens, num.linlin(0, 127, 20, 150));
		}, 5, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob5CloudDensityBar220, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar220Gran).set(\grainDens, num.linlin(0, 127, 20, 150));
		}, 5, srcID: ~lpdID);

		/* LPD knob 6 control panning (clockwise) of granular synth */
		MIDIdef.cc(\lpdKnob6GranularPanBar92, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan).set(\shiftPan, num.linlin(0, 127, 0, 2));
		}, 6, srcID: ~lpdID);

		MIDIdef.cc(\lpdKnob6GranularPanBar135, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar135GranPan).set(\shiftPan, num.linlin(0, 127, 0, 2));
		}, 6, srcID: ~lpdID);

		/* LPD knob 7 control panning (anticlockwise) of granular synth */
		MIDIdef.cc(\lpdKnob7GranularPanBar92_2, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar92GranWithPan2).set(\shiftPan, num.linlin(0, 127, 2, 0));
		}, 7, srcID: ~lpdID);

		/* LPD knob 8 control frequency modulation sop spec */
		MIDIdef.cc(\lpdKnob2SopGliss, {
			arg num, nn, chan, src;
			//[num, nn, chan, src].postln;
			Ndef(\bar27SopSpecGliss).set(\freq, num.linlin(0, 127, 200, 900));
		}, 8, srcID: ~lpdID);



		//////////////////////////////////////// BEGIN /////////////////////////////////////////

		/* foot pedal control mapping */
		~midiMapFoot = {
			~countFt = 0;
			~countFt2 = 0;
			~countFt3 = 0;
			~countFt4 = 0;
			//////////////////// foot controller //////////////////// button 1 (96)
			MIDIdef.cc(\footButton1, {
				arg vel, nn, chan, src;
				if (~countFt == 0, {
					~bar9SpecSop = Ndef(\bar9SpecSop, ~bar9spec);
					~countFt = 1;
					"on foot button1, 96".postln;
				}, {
					~bar9SpecSop.release(2);
					~countFt = 0;
					"off foot button1, 96".postln;
				});
			}, 96, srcID: ~footID); // pedal button 96

			//////////////////// foot controller //////////////////// button 2 (97)
			MIDIdef.cc(\footButton2, {
				arg vel, nn, chan, src;
				if (~countFt2 == 0, {
					~bar184SpecSop = Ndef(\bar184SpecSop, ~bar184spec);
					~countFt2= 1;
					"on foot button 2, 97".postln;
				}, {
					~bar184SpecSop.release(2);
					~countFt2 = 0;
					"off foot button 2, 97".postln;
				});
			}, 97, srcID: ~footID); // pedal button 97

			//////////////////// foot controller //////////////////// button 3 (98)
			MIDIdef.cc(\footButton3, {
				arg vel, nn, chan, src;
				if (~countFt3 == 0, {
					~bar188SpecSop = Ndef(\bar188SpecSop, ~bar188spec);
					~countFt3 = 1;
					"on foot button 3, 98".postln;
				}, {
					~bar188SpecSop.release(2);
					~countFt3 = 0;
					"off foot button 3, 98".postln;
				});
			}, 98, srcID: ~footID); // pedal button 98


			//////////////////// foot controller //////////////////// button 4 (99)
			MIDIdef.cc(\footButton4, {
				arg vel, nn, chan, src;
				if (~countFt4 == 0, {
					~bar250SpecSop = Ndef(\bar250SpecSop, ~bar250spec);
					~countFt4 = 1;
					"on foot button 4, 99".postln;
				}, {
					~bar250SpecSop.release(2);
					~countFt4 = 0;
					"off foot button 4, 99".postln;
				});
			}, 99, srcID: ~footID); // pedal button 99
		};



		/* Akai MPK mini 2 control mapping; trigger by pianist */
		~midiMapMpk = {
			~countMpk1 = 0;
			~countMpk2 = 0;
			~countMpk3 = 0;

			//////////////////// bar 1 //////////////////// MPK button 1
			MIDIdef.cc(\mpkButton24, {
				arg vel, nn, chan, src;
				/* button press for pad 5 on MPK */
				/* project soprano voice (pick up by Shure SM 58) into piano through speaker 9 (channel 8) */
				if (~countMpk1 == 0, {
					~bar1SopSp9 = Ndef(\bar1SopSp9, ~bar1SopToSpeaker9);
					"on MPK cc 24, pad 5- 1".postln;
					~countMpk1= 1;
				}, {
					~bar1SopSp9.release(1);
					"off MPK cc 24, pad 5- 1".postln;
					~countMpk1 = 0;
				});
			}, 24, srcID: ~mpkID); // MPK pad 5 midi number 24

			// MIDIdef for cc button 25
			MIDIdef.cc(\mpkButton25, {
				arg vel, nn, chan, src;
				if (~countMpk2 == 0, {
					~bar1PnoToSp = Ndef(\bar1PnoToSp, ~bar1PnoToSp56);
					"on MPK cc 25, pad 6- 2 ".postln;
					~countMpk2 = 1;
				}, {
					~bar1PnoToSp.release(1);
					"off MPK cc 25, pad 6- 2".postln;
					~countMpk2 = 0;
				});
			}, 25, srcID: ~mpkID); // MPK pad 6 midi number 25

			// MIDIdef for cc button 26
			MIDIdef.cc(\mpkButton26, {
				arg vel, nn, chan, src;
				if (~countMpk3 == 0, {
					~bar208Pno = Ndef(\bar208Pno, ~bar208PnoToSp12);
					"on MPK cc 26, pad 7- 3".postln;
					~countMpk3 = 1;
				}, {
					~bar208Pno.release(1);
					"off MPK cc 26, pad 7- 3".postln;
					~countMpk3 = 0;
				});
			}, 26, srcID: ~mpkID); // MPK pad 6 midi number 25

		};


		/* trigger sound; APC */
		~midiMapApc = {
			~countApc1 = 0;
			~countApc2 = 0;
			~countApc3 = 0;
			~countApc4 = 0;
			~countApc5 = 0;
			~countApc6 = 0;
			~countApc7 = 0;
			~countApc8 = 0;
			~countApc9 = 0;
			~countApc10 = 0;
			~countApc11 = 0;
			~countApc12 = 0;
			~countApc13 = 0;
			~countApc14 = 0;
			~countApc15 = 0;
			~countApc16 = 0;
			~countApc17 = 0;
			~countApc18 = 0;
			~countApc19 = 0;
			~countApc20 = 0;
			~countApc21 = 0;
			~countApc22 = 0;
			~countApc23 = 0;
			~countApc24 = 0;
			~countApc25 = 0;
			~countApc26 = 0;
			~countApc27 = 0;
			~countApc28 = 0;
			~countApc29 = 0;
			~countApc30 = 0;
			~countApc31 = 0;
			~countApc32 = 0;
			~countApc33 = 0;
			~countApc34 = 0;
			~countApc35 = 0;
			~countApc36 = 0;
			~countApc37 = 0;
			~countApc38 = 0;
			~countApc39 = 0;
			~countApc40 = 0;
			~countApc41 = 0;
			~countApc42 = 0;
			~countApc43 = 0;
			~countApc44 = 0;
			~countApc45 = 0;
			~countApc46 = 0;
			~countApc47 = 0;
			~countApc48 = 0;
			~countApc49 = 0;
			~countApc50 = 0;
			~countApc51 = 0;
			~countApc52 = 0;
			~countApc53 = 0;
			~countApc54 = 0;
			~countApc55 = 0;
			~countApc56 = 0;
			~countApc57 = 0;
			~countApc58 = 0;
			~countApc59 = 0;
			~countApc60 = 0;
			~countApc61 = 0;
			~countApc62 = 0;
			~countApc63 = 0;
			~countApc64 = 0;
			~countApc65 = 0;
			~countApc66 = 0;
			~countApc67 = 0;
			~countApc68 = 0;
			~countApc69 = 0;
			~countApc70 = 0;
			~countApc71 = 0;
			~countApc72 = 0;
			~countApc73 = 0;
			~countApcB1 = 0;
			~countApcB2 = 0;
			~countApcB3 = 0;
			~countApcB4 = 0;

			//////////////////// bar 1 //////////////////// button 1
			MIDIdef.noteOn(\apcButton56, {
				arg vel, nn, chan, src;
				/* output soprano voice to speaker 9  */
				if (~countApc1 == 0, {
					~bar1SopSp9 = Ndef(\bar1SopSp9, ~bar1SopToSpeaker9);
					m.noteOn(0, 56, 01); //light on
					"on 56 button 1".postln;
					~countApc1 = 1;
				}, {
					~bar1SopSp9.release(1);
					m.noteOn(0, 56, 0); //light off
					"off 56 button 1".postln;
					~countApc1 = 0;
				});
			}, 56, srcID: ~apcID);

			//////////////////// bar 1 //////////////////// button 2
			MIDIdef.noteOn(\apcButton57, {
				arg vel, nn, chan, src;
				/* output piano signal to speakers 5 and 6  */
				if (~countApc2 == 0, {
					~bar1PnoToSp = Ndef(\bar1PnoToSp, ~bar1PnoToSp56);
					m.noteOn(0, 57, 01); //light on
					"on 57 button 2".postln;
					~countApc2 = 1;
				}, {
					~bar1PnoToSp.release(1);
					m.noteOn(0, 57, 0); //light off
					"off 57 button 2".postln;
					~countApc2 = 0;
				});
			}, 57, srcID: ~apcID);

			//////////////////// bar 4 //////////////////// button 3
			MIDIdef.noteOn(\apcButton58, {
				arg vel, nn, chan, src;
				/* pan soprano signal using LPD 8 knob */
				if (~countApc3 == 0, {
					~bar4pan = Ndef(\bar4pan, ~bar4PanSop).play;
					m.noteOn(0, 58, 01); //light on
					"on 58 button 3".postln;
					~countApc3 = 1;
				}, {
					~bar4pan.release(1);
					m.noteOn(0, 58, 0); //light off
					"off 58 button 3".postln;
					~countApc3 = 0;
				});
			}, 58, srcID: ~apcID);

			//////////////////// bar 6 //////////////////// button 4
			MIDIdef.noteOn(\apcButton59, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded sec 13 */
				if (~countApc4 == 0, {
					~bar6Gran = Ndef(\bar6Gran, ~bar6GranSec13);
					Ndef(\bar6Gran).set(\sndbuf, ~bufSec13); // load buffer with pre-recorded sec 13
					m.noteOn(0, 59, 01); //light on
					"on 59 button 4".postln;
					~countApc4 = 1;
				}, {
					~bar6Gran.release(0.1);
					m.noteOn(0, 59, 0); //light off
					"off 59 button 4".postln;
					~countApc4 = 0;
				});
			}, 59, srcID: ~apcID);

			//////////////////// bar 6 //////////////////// button 5
			MIDIdef.noteOn(\apcButton60, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded sec 13, control rate / frq mod */
				if (~countApc5 == 0, {
					~bar6GranMod = Ndef(\bar6GranMod, ~bar6GranSec13_mod);
					Ndef(\bar6GranMod).set(\sndbuf, ~bufSec13);
					m.noteOn(0, 60, 01); //light on
					"on 60 button 5".postln;
					~countApc5 = 1;
				}, {
					~bar6GranMod.release(0);
					m.noteOn(0, 60, 0); //light off
					"off 60 button 5".postln;
					~countApc5 = 0;
				});
			}, 60, srcID: ~apcID);

			//////////////////// bar 10 //////////////////// button 6
			MIDIdef.noteOn(\apcButton61, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded sec 1 */
				if (~countApc6 == 0, {
					~bar10Gran = Ndef(\bar10Gran, ~bar10GranSec1);
					Ndef(\bar10Gran).set(\sndbuf, ~bufSec1);
					m.noteOn(0, 61, 01); //light on
					"on 61 button 6".postln;
					~countApc6 = 1;
				}, {
					~bar10Gran.release(8);
					m.noteOn(0, 61, 0); //light off
					"off 61 button 6".postln;
					~countApc6 = 0;
				});
			}, 61, srcID: ~apcID);


			//////////////////// bar 16 //////////////////// button 8
			MIDIdef.noteOn(\apcButton63, {
				arg vel, nn, chan, src;
				/* start recording into buffer */
				~recStart = {
					m.noteOn(0, 63, 03); // button color red
					/* record 1 */
					~bar16Rec = Synth(\SoundIn, [\bufnum, ~buf1]); // start recording (no playback)
					"recording".postln;
					~countApc8 = 1;
					~recording = true;
				};
				/* stop recording and free buffer */
				~recStop = {
					~bar16Rec.free; // stop synth for recording
					~buf1.free; // free buffer
					~recording = false;
					// realocate buffer to be recorded into again
					~waitForBufferReallocation = Routine {
						~buf1 = Buffer.alloc(s, 44100 * ~bufLength1, 1); // allocate buffer to record for 20 seconds for rec 1
						s.sync;
					}.value;
					"recording stopped, buffer reallocated".postln;
					~countApc8 = 0;
				};
				/* function to turn light off after recording */
				~recCompleteLightOff = {
					m.noteOn(0, 63, 0); // light off
					~recording = false;
					~countApc8 = 0;
				};

				/* button press for button 1 */
				/* record 19 seconds of soprano voice into ~buf through Shure SM57 dynamic mic */
				if (~countApc8 == 0, {
					// routine to start recording and turn light off after recording is completed
					~recRout = {
						~recStart.();
						"on 63 button 8".postln;
						~bufLength1.yield; // time when recording into buffer
						if(~recording, {
							"recording complete".postln;
							~recCompleteLightOff.();
							"off 63 button 8".postln;
						});
					}.fork;
				}, {
					// stop in the middle of recording and reallocate buffer for recording again; press again off
					if (~countApc8 == 1, {
						~recRout.stop; // stop routine for sanity
						~recStop.(); // call to stop recording and free buffer
						"off 63 button 8".postln;
						m.noteOn(0, 63, 0); // light off
					});
				});
			}, 63, srcID: ~apcID); // APC midi number 56

			//////////////////// bar 16 //////////////////// button 9
			MIDIdef.noteOn(\apcButton48, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded sec 1 */
				if (~countApc9 == 0, {
					~bar16Gran = Ndef(\bar16Gran, ~bar16GranSec12);
					Ndef(\bar16Gran).set(\sndbuf, ~bufSec12);
					m.noteOn(0, 48, 01); //light on
					"on 48 button 9".postln;
					~countApc9 = 1;
				}, {
					~bar16Gran.release(4);
					m.noteOn(0, 48, 0); //light off
					"off 48 button 9".postln;
					~countApc9 = 0;
				});
			}, 48, srcID: ~apcID);

			//////////////////// bar 24 //////////////////// button 10
			MIDIdef.noteOn(\apcButton49, {
				arg vel, nn, chan, src;
				/* start recording into buffer */
				~recStart = {
					m.noteOn(0, 49, 03); // button color red
					/* record 1 */
					~bar24Rec = Synth(\SoundIn, [\bufnum, ~buf2]); //start recording (no playback)
					"recording".postln;
					~countApc10 = 1;
					~recording = true;
				};
				/* stop recording and free buffer */
				~recStop = {
					~bar24Rec.free; // stop synth for recording
					~buf2.free; // free buffer
					~recording = false;
					// realocate buffer to be recorded into again
					~waitForBufferReallocation = Routine {
						~buf2 = Buffer.alloc(s, 44100 * ~bufLength2, 1); // allocate buffer to record for 20 seconds for rec 1
						s.sync;
					}.value;
					"recording stopped, buffer reallocated".postln;
					~countApc10 = 0;
				};
				/* function to turn light off after recording */
				~recCompleteLightOff = {
					m.noteOn(0, 49, 0); // light off
					~recording = false;
					~countApc10 = 0;
				};

				/* button press for button 1 */
				/* record 19 seconds of soprano voice into ~buf through Shure SM57 dynamic mic */
				if (~countApc10 == 0, {
					// routine to start recording and turn light off after recording is completed
					~recRout = {
						~recStart.();
						"on 49 button 10".postln;
						~bufLength2.yield; // time when recording into buffer
						if(~recording, {
							"recording complete".postln;
							~recCompleteLightOff.();
							"off 49 button 10".postln;
						});
					}.fork;
				}, {
					// stop in the middle of recording and reallocate buffer for recording again; press again OFF
					if (~countApc10 == 1, {
						~recRout.stop; // stop routine for sanity
						~recStop.(); // call to stop recording and free buffer
						"off 49 button 10".postln;
						m.noteOn(0, 49, 0); // light off
					});
				});
			}, 49, srcID: ~apcID); // APC midi number 49

			//////////////////// bar 26 //////////////////// button 11
			MIDIdef.noteOn(\apcButton50, {
				arg vel, nn, chan, src;
				/* soprano through speakers 3, 4, 7, 8 */
				if (~countApc11 == 0, {
					~bar26Sop = Ndef(\bar26Sop, ~bar26SopToSpeaker3478);
					m.noteOn(0, 50, 01); //light on
					"on 50 button 11".postln;
					~countApc11 = 1;
				}, {
					~bar26Sop.release(1);
					m.noteOn(0, 50, 0); //light off
					"off 50 button 11".postln;
					~countApc11 = 0;
				});
			}, 50, srcID: ~apcID);

			//////////////////// bar 27 //////////////////// button 12
			MIDIdef.noteOn(\apcButton51, {
				arg vel, nn, chan, src;
				/* soprano spectral filter + gliss */
				if (~countApc12 == 0, {
					~bar27SopSpecGliss = Ndef(\bar27SopSpecGliss, ~bar27spec);
					m.noteOn(0, 51, 01); //light on
					"on 51 button 12".postln;
					~countApc12 = 1;
				}, {
					~bar27SopSpecGliss.release(1);
					m.noteOn(0, 51, 0); //light off
					"off 51 button 12".postln;
					~countApc12 = 0;
				});
			}, 51, srcID: ~apcID);

			//////////////////// bar 28 //////////////////// button 13
			MIDIdef.noteOn(\apcButton52, {
				arg vel, nn, chan, src;
				/* soprano spectral filter + gliss */
				if (~countApc13 == 0, {
					~bar28SopTo12 = Ndef(\bar28SopTo12, ~bar28SopToSpeaker12);
					m.noteOn(0, 52, 01); //light on
					"on 52 button 13".postln;
					~countApc13 = 1;
				}, {
					~bar28SopTo12.release(0.2);
					m.noteOn(0, 52, 0); //light off
					"off 52 button 13".postln;
					~countApc13 = 0;
				});
			}, 52, srcID: ~apcID);

			//////////////////// bar 32 //////////////////// button 14
			MIDIdef.noteOn(\apcButton53, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 11; control grain density */
				if (~countApc14 == 0, {
					~bar32Gran = Ndef(\bar32Gran, ~bar32GranSec11);
					Ndef(\bar32Gran).set(\sndbuf, ~bufSec11);
					m.noteOn(0, 53, 01); //light on
					"on 53 button 14".postln;
					~countApc14 = 1;
				}, {
					~bar32Gran.release(4);
					m.noteOn(0, 53, 0); //light off
					"off 53 button 14".postln;
					~countApc14 = 0;
				});
			}, 53, srcID: ~apcID);

			//////////////////// bar 33 //////////////////// button 15
			MIDIdef.noteOn(\apcButton54, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 11; control grain density */
				if (~countApc15 == 0, {
					~bar33GranRec2 = Ndef(\bar33GranRec2, ~bar33GranLiveRec2);
					Ndef(\bar33GranRec2).set(\sndbuf, ~buf2);
					m.noteOn(0, 54, 01); //light on
					"on 54 button 15".postln;
					~countApc15 = 1;
				}, {
					~bar33GranRec2.release(4);
					m.noteOn(0, 54, 0); //light off
					"off 54 button 15".postln;
					~countApc15 = 0;
				});
			}, 54, srcID: ~apcID);

			//////////////////// bar 40 //////////////////// button 16
			MIDIdef.noteOn(\apcButton55, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 11; control grain density */
				if (~countApc16 == 0, {
					~bar40GranRec2 = Ndef(\bar40GranRec2, ~bar40GranLiveRec2);
					Ndef(\bar40GranRec2).set(\sndbuf, ~buf2);
					m.noteOn(0, 55, 01); //light on
					"on 55 button 16".postln;
					~countApc16 = 1;
				}, {
					~bar40GranRec2.release(4);
					m.noteOn(0, 55, 0); //light off
					"off 55 button 16".postln;
					~countApc16 = 0;
				});
			}, 55, srcID: ~apcID);

			//////////////////// bar 49 //////////////////// button 17
			MIDIdef.noteOn(\apcButton40, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc17 == 0, {
					~bar49Gran = Ndef(\bar49Gran, ~bar49GranSec10);
					Ndef(\bar49Gran).set(\sndbuf, ~bufSec10);
					m.noteOn(0, 40, 01); //light on
					"on 40 button 17".postln;
					~countApc17 = 1;
				}, {
					~bar49Gran.release(4);
					m.noteOn(0, 40, 0); //light off
					"off 40 button 17".postln;
					~countApc17 = 0;
				});
			}, 40, srcID: ~apcID);

			//////////////////// bar 61 //////////////////// button 7
			MIDIdef.noteOn(\apcButton62, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc7 == 0, {
					~bar61Gran = Ndef(\bar61Gran, ~bar61GranSec10);
					Ndef(\bar61Gran).set(\sndbuf, ~bufSec10);
					m.noteOn(0, 62, 01); //light on
					"on 62 button 7".postln;
					~countApc7 = 1;
				}, {
					~bar61Gran.release(4);
					m.noteOn(0, 62, 0); //light off
					"off 62 button 7".postln;
					~countApc7 = 0;
				});
			}, 62, srcID: ~apcID);

			//////////////////// bar 92 //////////////////// button 18
			MIDIdef.noteOn(\apcButton41, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc18 == 0, {
					~bar92GranWithPan = Ndef(\bar92GranWithPan, ~bar92PanGran);
					Ndef(\bar92GranWithPan).set(\sndbuf, ~bufSec8);
					m.noteOn(0, 41, 01); //light on
					"on 41 button 18".postln;
					~countApc18 = 1;
				}, {
					~bar92GranWithPan.release(4);
					m.noteOn(0, 41, 0); //light off
					"off 41 button 18".postln;
					~countApc18 = 0;
				});
			}, 41, srcID: ~apcID);

			//////////////////// bar 92 //////////////////// button 19
			MIDIdef.noteOn(\apcButton42, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc19 == 0, {
					~bar92GranWithPan2 = Ndef(\bar92GranWithPan2, ~bar92PanGran2);
					Ndef(\bar92GranWithPan2).set(\sndbuf, ~bufSec6);
					m.noteOn(0, 42, 01); //light on
					"on 42 button 19".postln;
					~countApc19 = 1;
				}, {
					~bar92GranWithPan2.release(4);
					m.noteOn(0, 42, 0); //light off
					"off 42 button 19".postln;
					~countApc19 = 0;
				});
			}, 42, srcID: ~apcID);

			//////////////////// bar 118 //////////////////// button 20
			MIDIdef.noteOn(\apcButton43, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc20 == 0, {
					~bar118Gran = Ndef(\bar118Gran, ~bar118GranSec7);
					Ndef(\bar118Gran).set(\sndbuf, ~bufSec7);
					m.noteOn(0, 43, 01); //light on
					"on 43 button 20".postln;
					~countApc20 = 1;
				}, {
					~bar118Gran.release(4);
					m.noteOn(0, 43, 0); //light off
					"off 43 button 20".postln;
					~countApc20 = 0;
				});
			}, 43, srcID: ~apcID);

			//////////////////// bar 135 //////////////////// button 21
			MIDIdef.noteOn(\apcButton44, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section 10; control parameters based on soprano's gesture */
				if (~countApc21 == 0, {
					~bar135GranPan = Ndef(\bar135GranPan, ~bar135GranPanSec7);
					Ndef(\bar135GranPan).set(\sndbuf, ~bufSec7);
					m.noteOn(0, 44, 01); //light on
					"on 44 button 21".postln;
					~countApc21 = 1;
				}, {
					~bar135GranPan.release(4);
					m.noteOn(0, 44, 0); //light off
					"off 44 button 21".postln;
					~countApc21 = 0;
				});
			}, 44, srcID: ~apcID);

			//////////////////// bar 154 //////////////////// button 22
			MIDIdef.noteOn(\apcButton45, {
				arg vel, nn, chan, src;
				/* soprano signal to all speakers expect piano speaker */
				if (~countApc22 == 0, {
					~bar154SopToAll = Ndef(\bar154SopToAll, ~bar154SopToAllSp);
					m.noteOn(0, 45, 01); //light on
					"on 45 button 22".postln;
					~countApc22 = 1;
				}, {
					~bar154SopToAll.release(4);
					m.noteOn(0, 45, 0); //light off
					"off 45 button 22".postln;
					~countApc22 = 0;
				});
			}, 45, srcID: ~apcID);

			//////////////////// bar 155 //////////////////// button 23
			MIDIdef.noteOn(\apcButton46, {
				arg vel, nn, chan, src;
				/* soprano signal to all speakers expect piano speaker */
				if (~countApc23 == 0, {
					~bar155Gran = Ndef(\bar155Gran, ~bar155GranSec6);
					Ndef(\bar155Gran).set(\sndbuf, ~bufSec6);
					m.noteOn(0, 46, 01); //light on
					"on 46 button 23".postln;
					~countApc23 = 1;
				}, {
					~bar155Gran.release(4);
					m.noteOn(0, 46, 0); //light off
					"off 46 button 23".postln;
					~countApc23 = 0;
				});
			}, 46, srcID: ~apcID);

			//////////////////// bar 176 //////////////////// button 24
			MIDIdef.noteOn(\apcButton47, {
				arg vel, nn, chan, src;
				/* granularize section 5 through all speakers; sparse */
				if (~countApc24 == 0, {
					~bar176Gran = Ndef(\bar176Gran, ~bar176GranSec5);
					Ndef(\bar176Gran).set(\sndbuf, ~bufSec5);
					m.noteOn(0, 47, 01); //light on
					"on 47 button 24".postln;
					~countApc24 = 1;
				}, {
					~bar176Gran.release(4);
					m.noteOn(0, 47, 0); //light off
					"off 47 button 24".postln;
					~countApc24 = 0;
				});
			}, 47, srcID: ~apcID);

			//////////////////// bar 176 //////////////////// button 25
			MIDIdef.noteOn(\apcButton32, {
				arg vel, nn, chan, src;
				/* granularize section 5 through all speakers; sparse */
				if (~countApc25 == 0, {
					~bar176Gran2 = Ndef(\bar176Gran2, ~bar176GranSec9);
					Ndef(\bar176Gran2).set(\sndbuf, ~bufSec9);
					m.noteOn(0, 32, 01); //light on
					"on 32 button 25".postln;
					~countApc25 = 1;
				}, {
					~bar176Gran2.release(4);
					m.noteOn(0, 32, 0); //light off
					"off 32 button 25".postln;
					~countApc25 = 0;
				});
			}, 32, srcID: ~apcID);

			//////////////////// bar 198 //////////////////// button 26
			MIDIdef.noteOn(\apcButton33, {
				arg vel, nn, chan, src;
				/* output soprano through speaker 5 */
				if (~countApc26 == 0, {
					~bar198Sop = Ndef(\bar198Sop, ~bar198SopToSpeaker5);
					m.noteOn(0, 33, 01); //light on
					"on 33 button 26".postln;
					~countApc26 = 1;
				}, {
					~bar198Sop.release(1);
					m.noteOn(0, 33, 0); //light off
					"off 33 button 26".postln;
					~countApc26 = 0;
				});
			}, 33, srcID: ~apcID);

			//////////////////// bar 200 //////////////////// button 27
			MIDIdef.noteOn(\apcButton34, {
				arg vel, nn, chan, src;
				/* output soprano through speaker 7 */
				if (~countApc27 == 0, {
					~bar200Sop = Ndef(\bar200Sop, ~bar200SopToSpeaker7);
					m.noteOn(0, 34, 01); //light on
					"on 34 button 27".postln;
					~countApc27 = 1;
				}, {
					~bar200Sop.release(1);
					m.noteOn(0, 34, 0); //light off
					"off 34 button 27".postln;
					~countApc27 = 0;
				});
			}, 34, srcID: ~apcID);
			//////////////////// bar 202 //////////////////// button 28
			MIDIdef.noteOn(\apcButton35, {
				arg vel, nn, chan, src;
				/* output soprano through speaker 4 */
				if (~countApc28 == 0, {
					~bar202Sop = Ndef(\bar202Sop, ~bar202SopToSpeaker4);
					m.noteOn(0, 35, 01); //light on
					"on 35 button 28".postln;
					~countApc28 = 1;
				}, {
					~bar202Sop.release(1);
					m.noteOn(0, 35, 0); //light off
					"off 35 button 28".postln;
					~countApc28 = 0;
				});
			}, 35, srcID: ~apcID);

			//////////////////// bar 204 //////////////////// button 29
			MIDIdef.noteOn(\apcButton36, {
				arg vel, nn, chan, src;
				/* output soprano through speaker 6 */
				if (~countApc29 == 0, {
					~bar204Sop = Ndef(\bar204Sop, ~bar204SopToSpeaker6);
					m.noteOn(0, 36, 01); //light on
					"on 36 button 29".postln;
					~countApc29 = 1;
				}, {
					~bar204Sop.release(1);
					m.noteOn(0, 36, 0); //light off
					"off 36 button 29".postln;
					~countApc29 = 0;
				});
			}, 36, srcID: ~apcID);

			//////////////////// bar 208 //////////////////// button 30
			MIDIdef.noteOn(\apcButton37, {
				arg vel, nn, chan, src;
				/* output soprano (mic 1) to speaker 9; output piano (mic 2) to speaker 1, 2 */
				if (~countApc30 == 0, {
					~bar208Pno = Ndef(\bar208Pno, ~bar208PnoToSp12);
					m.noteOn(0, 37, 01); //light on
					"on 37 button 30".postln;
					~countApc30 = 1;
				}, {
					~bar208Pno.release(1);
					m.noteOn(0, 37, 0); //light off
					"off 37 button 30".postln;
					~countApc30 = 0;
				});
			}, 37, srcID: ~apcID);

			//////////////////// bar 220 //////////////////// button 31
			MIDIdef.noteOn(\apcButton38, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section III, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 8 */
				if (~countApc31 == 0, {
					~bar220Gran = Ndef(\bar220Gran, ~bar220GranSec3); // granularize pre-recorded section III
					Ndef(\bar220Gran).set(\sndbuf, ~bufSec3);
					~bar220Pno = Ndef(\bar220Pno, ~bar220PnoToSp8); // mic 2 pick up granularized signal then output through speaker 8
					m.noteOn(0, 38, 01); //light on
					"on 38 button 31".postln;
					~countApc31 = 1;
				}, {
					~bar220Gran.release(1);
					~bar220Pno.release(1);
					m.noteOn(0, 38, 0); //light off
					"off 38 button 31".postln;
					~countApc31 = 0;
				});
			}, 38, srcID: ~apcID);

			//////////////////// bar 222 //////////////////// button 32
			MIDIdef.noteOn(\apcButton39, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section III, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 7 */
				if (~countApc32 == 0, {
					~bar220Gran = Ndef(\bar220Gran, ~bar220GranSec3); // granularize pre-recorded section III
					Ndef(\bar220Gran).set(\sndbuf, ~bufSec3);
					~bar222Pno = Ndef(\bar222Pno, ~bar222PnoToSp7); // mic 2 pick up granularized signal then output through speaker 7
					m.noteOn(0, 39, 01); //light on
					"on 39 button 32".postln;
					~countApc32 = 1;
				}, {
					~bar220Gran.release(1);
					~bar222Pno.release(1);
					m.noteOn(0, 39, 0); //light off
					"off 39 button 32".postln;
					~countApc32 = 0;
				});
			}, 39, srcID: ~apcID);

			//////////////////// bar 225 //////////////////// button 33
			MIDIdef.noteOn(\apcButton24, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section III, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 6 */
				if (~countApc33 == 0, {
					~bar220Gran = Ndef(\bar220Gran, ~bar220GranSec3); // granularize pre-recorded section III
					Ndef(\bar220Gran).set(\sndbuf, ~bufSec3);
					~bar225Pno = Ndef(\bar225Pno, ~bar225PnoToSp6); // mic 2 pick up granularized signal then output through speaker 6
					m.noteOn(0, 24, 01); //light on
					"on 24 button 33".postln;
					~countApc33 = 1;
				}, {
					~bar220Gran.release(1);
					~bar225Pno.release(1);
					m.noteOn(0, 24, 0); //light off
					"off 24 button 33".postln;
					~countApc33 = 0;
				});
			}, 24, srcID: ~apcID);

			//////////////////// bar 228 //////////////////// button 34
			MIDIdef.noteOn(\apcButton25, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section III, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 5 */
				if (~countApc34 == 0, {
					~bar220Gran = Ndef(\bar220Gran, ~bar220GranSec3); // granularize pre-recorded section III
					Ndef(\bar220Gran).set(\sndbuf, ~bufSec3);
					~bar228Pno = Ndef(\bar228Pno, ~bar228PnoToSp5); // mic 2 pick up granularized signal then output through speaker 5
					m.noteOn(0, 25, 01); //light on
					"on 25 button 34".postln;
					~countApc34 = 1;
				}, {
					~bar220Gran.release(1);
					~bar228Pno.release(1);
					m.noteOn(0, 25, 0); //light off
					"off 25 button 34".postln;
					~countApc34 = 0;
				});
			}, 25, srcID: ~apcID);

			//////////////////// bar 231 //////////////////// button 35
			MIDIdef.noteOn(\apcButton26, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section III, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 5 */
				if (~countApc35 == 0, {
					~bar220Gran = Ndef(\bar220Gran, ~bar220GranSec3); // granularize pre-recorded section III
					Ndef(\bar220Gran).set(\sndbuf, ~bufSec3);
					~bar231Pno = Ndef(\bar231Pno, ~bar231PnoToSp4); // mic 2 pick up granularized signal then output through speaker 5
					m.noteOn(0, 26, 01); //light on
					"on 26 button 35".postln;
					~countApc35 = 1;
				}, {
					~bar220Gran.release(1);
					~bar231Pno.release(1);
					m.noteOn(0, 26, 0); //light off
					"off 26 button 35".postln;
					~countApc35 = 0;
				});
			}, 26, srcID: ~apcID);

			//////////////////// bar 238 //////////////////// button 36
			MIDIdef.noteOn(\apcButton27, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section II, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 5 */
				if (~countApc36 == 0, {
					~bar238Gran = Ndef(\bar238Gran, ~bar238GranSec2); // granularize pre-recorded section II
					Ndef(\bar238Gran).set(\sndbuf, ~bufSec2);
					~bar238Pno = Ndef(\bar238Pno, ~bar238PnoToAllSp); // mic 2 pick up granularized signal then output through all speakers
					m.noteOn(0, 27, 01); //light on
					"on 27 button 36".postln;
					~countApc36 = 1;
				}, {
					~bar238Gran.release(1);
					~bar238Pno.release(1);
					m.noteOn(0, 27, 0); //light off
					"off 27 button 36".postln;
					~countApc36 = 0;
				});
			}, 27, srcID: ~apcID);

			//////////////////// bar 238 //////////////////// button 37
			MIDIdef.noteOn(\apcButton28, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section II, output through speaker 9; mic 2/ piano mic signal output thorugh speaker 5 */
				if (~countApc37 == 0, {
					~bar238Gran2 = Ndef(\bar238Gran2, ~bar238GranSec2_2); // granularize pre-recorded section II
					Ndef(\bar238Gran2).set(\sndbuf, ~bufSec2);
					m.noteOn(0, 28, 01); //light on
					"on 28 button 37".postln;
					~countApc37 = 1;
				}, {
					~bar238Gran2.release(1);
					m.noteOn(0, 28, 0); //light off
					"off 28 button 37".postln;
					~countApc37 = 0;
				});
			}, 28, srcID: ~apcID);

			//////////////////// bar 250 //////////////////// button 38
			MIDIdef.noteOn(\apcButton29, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section I; output through all speakers; sporadic identifiable words; random pan */
				if (~countApc38 == 0, {
					~bar250Gran = Ndef(\bar250Gran, ~bar250GranSec1); // granularize pre-recorded section III
					Ndef(\bar250Gran).set(\sndbuf, ~bufSec1);
					m.noteOn(0, 29, 01); //light on
					"on 29 button 38".postln;
					~countApc38 = 1;
				}, {
					~bar250Gran.release(1);
					m.noteOn(0, 29, 0); //light off
					"off 29 button 38".postln;
					~countApc38 = 0;
				});
			}, 29, srcID: ~apcID);

			//////////////////// bar 257 //////////////////// button 39
			MIDIdef.noteOn(\apcButton30, {
				arg vel, nn, chan, src;
				/* granularize pre-recorded section I; output through all speakers; dense */
				if (~countApc39 == 0, {
					~bar257Gran = Ndef(\bar257Gran, ~bar257GranSec1); // granularize pre-recorded section I
					Ndef(\bar257Gran).set(\sndbuf, ~bufSec1);
					m.noteOn(0, 30, 01); //light on
					"on 30 button 39".postln;
					~countApc39 = 1;
				}, {
					~bar257Gran.release(1);
					m.noteOn(0, 30, 0); //light off
					"off 30 button 39".postln;
					~countApc39 = 0;
				});
			}, 30, srcID: ~apcID);

			//////////////////// bar 264 //////////////////// button 40
			MIDIdef.noteOn(\apcButton31, {
				arg vel, nn, chan, src;
				if (~countApc40 == 0, {
					~bar264Hui = Ndef(\bar264Hui, ~bar264PlaybackRecHui);
					Ndef(\bar264Hui).set(\bufnum, ~bufSec13_hui);
					m.noteOn(0, 31, 01); // light on
					"on 31 button 40".postln;
					~countApc40 = 1;
				}, {
					~bar264Hui.release(1);
					m.noteOn(0, 31, 0); // light off
					"off 31 button 40".postln;
					~countApc40 = 0;
				});
			}, 31, srcID: ~apcID);

			//////////////////// bar 265 //////////////////// button 41
			MIDIdef.noteOn(\apcButton16, {
				arg vel, nn, chan, src;
				if (~countApc41 == 0, {
					~bar265Sheng = Ndef(\bar265Sheng, ~bar265PlaybackRecSheng);
					Ndef(\bar265Sheng).set(\bufnum, ~bufSec13_sheng);
					m.noteOn(0, 16, 01); // light on
					"on 16 button 41".postln;
					~countApc41 = 1;
				}, {
					~bar265Sheng.release(1);
					m.noteOn(0, 16, 0); // light off
					"off 16 button 41".postln;
					~countApc41= 0;
				});
			}, 16, srcID: ~apcID);

			//////////////////// bar 266 //////////////////// button 42
			MIDIdef.noteOn(\apcButton17, {
				arg vel, nn, chan, src;
				if (~countApc42 == 0, {
					~bar266Dong = Ndef(\bar266Dong, ~bar266PlaybackRecDong);
					Ndef(\bar266Dong).set(\bufnum, ~bufSec13_dong);
					m.noteOn(0, 17, 01); // light on
					"on 17 button 42".postln;
					~countApc42 = 1;
				}, {
					~bar266Dong.release(1);
					m.noteOn(0, 17, 0); // light off
					"off 17 button 42".postln;
					~countApc42= 0;
				});
			}, 17, srcID: ~apcID);

			//////////////////// bar 267 //////////////////// button 43
			MIDIdef.noteOn(\apcButton18, {
				arg vel, nn, chan, src;
				if (~countApc43 == 0, {
					~bar267Chi = Ndef(\bar267Chi, ~bar267PlaybackRecChi);
					Ndef(\bar267Chi).set(\bufnum, ~bufSec13_chi);
					m.noteOn(0, 18, 01); // light on
					"on 18 button 43".postln;
					~countApc43 = 1;
				}, {
					~bar267Chi.release(1);
					m.noteOn(0, 18, 0); // light off
					"off 18 button 43".postln;
					~countApc43= 0;
				});
			}, 18, srcID: ~apcID);

			//////////////////// bar 275 //////////////////// button 44
			MIDIdef.noteOn(\apcButton19, {
				arg vel, nn, chan, src;
				if (~countApc44 == 0, {
					~bar275SnowBall = Ndef(\bar275SnowBall, ~bar275SnowballToAll);
					~bar275SnowBall2 = Ndef(\bar275SnowBall2, ~bar275SnowballToAll_2);
					~bar275SnowBall3 = Ndef(\bar275SnowBall3, ~bar275SnowballToAll_3);
					~bar275SnowBall4 = Ndef(\bar275SnowBall4, ~bar275SnowballToAll_4);
					m.noteOn(0, 19, 01); //light on
					"on 19 button 44".postln;
					~countApc44 = 1;
				}, {
					~bar275SnowBall.release(1);
					~bar275SnowBall2.release(1);
					~bar275SnowBall3.release(1);
					~bar275SnowBall4.release(1);
					m.noteOn(0, 19, 0); //light off
					"off 19 button 44".postln;
					~countApc44= 0;
				});
			}, 19, srcID: ~apcID);

			//////////////////// bar 8 //////////////////// button 45
			MIDIdef.noteOn(\apcButton20, {
				arg vel, nn, chan, src;
				if (~countApc45 == 0, {
					~bar8Cue = Ndef(\bar8Cue, ~bar8PlayCue);
					Ndef(\bar8Cue).set(\bufnum, ~bufCueBar8);
					m.noteOn(0, 20, 01); //light on
					"on 20 button 45".postln;
					~countApc45 = 1;
				}, {
					~bar8PlayCue.release(1);
					m.noteOn(0, 20, 0); //light off
					"off 20 button 45".postln;
					~countApc45= 0;
				});
			}, 20, srcID: ~apcID);

			//////////////////// bar 46 //////////////////// button 46
			MIDIdef.noteOn(\apcButton21, {
				arg vel, nn, chan, src;
				if (~countApc46 == 0, {
					~bar46Cue = Ndef(\bar46Cue, ~bar46PlayCue);
					Ndef(\bar46Cue).set(\bufnum, ~bufCueBar46);
					m.noteOn(0, 21, 01); //light on
					"on 21 button 46".postln;
					~countApc46 = 1;
				}, {
					~bar46PlayCue.release(1);
					m.noteOn(0, 21, 0); //light off
					"off 21 button 46".postln;
					~countApc46= 0;
				});
			}, 21, srcID: ~apcID);

			//////////////////// bar 108 //////////////////// button 47
			MIDIdef.noteOn(\apcButton22, {
				arg vel, nn, chan, src;
				if (~countApc47 == 0, {
					~bar108Cue = Ndef(\bar108Cue, ~bar108PlayCue);
					Ndef(\bar108Cue).set(\bufnum, ~bufCueBar108);
					m.noteOn(0, 22, 01); //light on
					"on 22 button 47".postln;
					~countApc47 = 1;
				}, {
					~bar108PlayCue.release(1);
					m.noteOn(0, 22, 0); //light off
					"off 22 button 47".postln;
					~countApc47 = 0;
				});
			}, 22, srcID: ~apcID);

			//////////////////// bar 152 //////////////////// button 48
			MIDIdef.noteOn(\apcButton23, {
				arg vel, nn, chan, src;
				if (~countApc48 == 0, {
					~bar152Cue = Ndef(\bar152Cue, ~bar152PlayCue);
					Ndef(\bar152Cue).set(\bufnum, ~bufCueBar152);
					m.noteOn(0, 23, 01); //light on
					"on 23 button 48".postln;
					~countApc48 = 1;
				}, {
					~bar152PlayCue.release(1);
					m.noteOn(0, 23, 0); //light off
					"off 23 button 48".postln;
					~countApc48 = 0;
				});
			}, 23, srcID: ~apcID);

			//////////////////// bar 182 //////////////////// button 49
			MIDIdef.noteOn(\apcButton8, {
				arg vel, nn, chan, src;
				if (~countApc49 == 0, {
					~bar182Cue = Ndef(\bar182Cue, ~bar182PlayCue);
					Ndef(\bar182Cue).set(\bufnum, ~bufCueBar182);
					m.noteOn(0, 08, 01); //light on
					"on 8 button 49".postln;
					~countApc49 = 1;
				}, {
					~bar182PlayCue.release(1);
					m.noteOn(0, 08, 0); //light off
					"off 8 button 49".postln;
					~countApc49 = 0;
				});
			}, 08, srcID: ~apcID);

			//////////////////// bar 207 //////////////////// button 50
			MIDIdef.noteOn(\apcButton9, {
				arg vel, nn, chan, src;
				if (~countApc50 == 0, {
					~bar207Cue = Ndef(\bar207Cue, ~bar207PlayCue);
					Ndef(\bar207Cue).set(\bufnum, ~bufCueBar207);
					m.noteOn(0, 09, 01); //light on
					"on 9 button 50".postln;
					~countApc50 = 1;
				}, {
					~bar207PlayCue.release(1);
					m.noteOn(0, 09, 0); //light off
					"off 9 button 50".postln;
					~countApc50 = 0;
				});
			}, 09, srcID: ~apcID);

			//////////////////// bar 230 //////////////////// button 51
			MIDIdef.noteOn(\apcButton10, {
				arg vel, nn, chan, src;
				if (~countApc51 == 0, {
					~bar230Cue = Ndef(\bar230Cue, ~bar230PlayCue);
					Ndef(\bar230Cue).set(\bufnum, ~bufCueBar230);
					m.noteOn(0, 10, 01); //light on
					"on 10 button 51".postln;
					~countApc51 = 1;
				}, {
					~bar230PlayCue.release(1);
					m.noteOn(0, 10, 0); //light off
					"off 10 button 51".postln;
					~countApc51 = 0;
				});
			}, 10, srcID: ~apcID);

			//////////////////// bar 235 //////////////////// button 52
			MIDIdef.noteOn(\apcButton11, {
				arg vel, nn, chan, src;
				if (~countApc52 == 0, {
					~bar235Cue = Ndef(\bar235Cue, ~bar235PlayCue);
					Ndef(\bar235Cue).set(\bufnum, ~bufCueBar235);
					m.noteOn(0, 11, 01); //light on
					"on 11 button 52".postln;
					~countApc52 = 1;
				}, {
					~bar235PlayCue.release(1);
					m.noteOn(0, 11, 0); //light off
					"off 11 button 52".postln;
					~countApc52 = 0;
				});
			}, 11, srcID: ~apcID);

			//////////////////// bar 250 //////////////////// button 53
			MIDIdef.noteOn(\apcButton12, {
				arg vel, nn, chan, src;
				if (~countApc53 == 0, {
					~bar250Cue = Ndef(\bar250Cue, ~bar250PlayCue);
					Ndef(\bar250Cue).set(\bufnum, ~bufCueBar250);
					m.noteOn(0, 12, 01); //light on
					"on 12 button 53".postln;
					~countApc53 = 1;
				}, {
					~bar250PlayCue.release(1);
					m.noteOn(0, 12, 0); //light off
					"off 12 button 53".postln;
					~countApc53 = 0;
				});
			}, 12, srcID: ~apcID);

			//////////////////// bar 252 //////////////////// button 54
			MIDIdef.noteOn(\apcButton13, {
				arg vel, nn, chan, src;
				if (~countApc54 == 0, {
					~bar252Cue = Ndef(\bar252Cue, ~bar252PlayCue);
					Ndef(\bar252Cue).set(\bufnum, ~bufCueBar252);
					m.noteOn(0, 13, 01); //light on
					"on 13 button 54".postln;
					~countApc54 = 1;
				}, {
					~bar252PlayCue.release(1);
					m.noteOn(0, 13, 0); //light off
					"off 13 button 54".postln;
					~countApc54 = 0;
				});
			}, 13, srcID: ~apcID);

			//////////////////// bar 268 //////////////////// button 55
			MIDIdef.noteOn(\apcButton14, {
				arg vel, nn, chan, src;
				if (~countApc55 == 0, {
					~bar268Cue = Ndef(\bar268Cue, ~bar268PlayCue);
					Ndef(\bar268Cue).set(\bufnum, ~bufCueBar268);
					m.noteOn(0, 14, 01); //light on
					"on 14 button 55".postln;
					~countApc55 = 1;
				}, {
					~bar268PlayCue.release(1);
					m.noteOn(0, 14, 0); //light off
					"off 14 button 55".postln;
					~countApc55 = 0;
				});
			}, 14, srcID: ~apcID);

			//////////////////// amp 1, 2, 5, 6, 9 //////////////////// button 56
			MIDIdef.noteOn(\apcButton15, {
				arg vel, nn, chan, src;
				if (~countApc56 == 0, {
					~amp12569 = Ndef(\amp12569, ~sopAmp12569);
					m.noteOn(0, 15, 01); //light on
					"on 15 button 56".postln;
					~countApc56 = 1;
				}, {
					~amp12569.release(1);
					m.noteOn(0, 15, 0); //light off
					"off 15 button 56".postln;
					~countApc56 = 0;
				});
			}, 15, srcID: ~apcID);


			/****************************************** foot pedal can also control these ******************************************/
			//////////////////// foot controller B1 ////////////////////
			MIDIdef.noteOn(\apcB1, {
				arg vel, nn, chan, src;
				if (~countApcB1 == 0, {
					~bar9SpecSop = Ndef(\bar9SpecSop, ~bar9spec);
					~countApcB1= 1;
					m.noteOn(0, 82, 01); //light on
					"on 82, apc B1".postln;
				}, {
					~bar9SpecSop.release(2);
					~countApcB1 = 0;
					m.noteOn(0, 82, 0); //light on
					"off 82, apc B1".postln;
				});
			}, 82, srcID: ~apcID);

			//////////////////// foot controller B2 ////////////////////
			MIDIdef.noteOn(\apcB2, {
				arg vel, nn, chan, src;
				if (~countApcB2 == 0, {
					~bar184SpecSop = Ndef(\bar184SpecSop, ~bar184spec);
					~countApcB2= 1;
					m.noteOn(0, 83, 01); //light on
					"on 83, apc B2".postln;
				}, {
					~bar184SpecSop.release(2);
					~countApcB2 = 0;
					m.noteOn(0, 83, 0); //light on
					"off 83, apc B2".postln;
				});
			}, 83, srcID: ~apcID);

			//////////////////// foot controller B3 ////////////////////
			MIDIdef.noteOn(\apcB3, {
				arg vel, nn, chan, src;
				if (~countApcB3 == 0, {
					~bar188SpecSop = Ndef(\bar188SpecSop, ~bar188spec);
					~countApcB3= 1;
					m.noteOn(0, 84, 01); //light on
					"on 84, apc B3".postln;
				}, {
					~bar188SpecSop.release(2);
					~countApcB3 = 0;
					m.noteOn(0, 84, 0); //light on
					"off 84, apc B3".postln;
				});
			}, 84, srcID: ~apcID);

			//////////////////// foot controller B4 ////////////////////
			MIDIdef.noteOn(\apcB4, {
				arg vel, nn, chan, src;
				if (~countApcB4 == 0, {
					~bar250SpecSop = Ndef(\bar250SpecSop, ~bar250spec);
					~countApcB4 = 1;
					m.noteOn(0, 85, 01); //light on
					"on 85, apc B4".postln;
				}, {
					~bar250SpecSop.release(2);
					~countApcB4 = 0;
					m.noteOn(0, 85, 0); //light on
					"off 85, apc B4".postln;
				});
			}, 85, srcID: ~apcID);


			/****************************************** soprano amplification controls ******************************************/
			//////////////////// soprano amplify through speaker 1 //////////////////// button 57
			MIDIdef.noteOn(\apcButton0, {
				arg vel, nn, chan, src;
				if (~countApc57 == 0, {
					~sopThru1 = Ndef(\sopThru1, ~amplifySopThru1);
					m.noteOn(0, 0, 01); //light on
					"amplify soprano through speaker 1".postln;
					"on 0 button 57".postln;
					~countApc57 = 1;
				}, {
					~sopThru1.release(1);
					m.noteOn(0, 0, 0); //light off
					"off 0 button 57".postln;
					~countApc57= 0;
				});
			}, 0, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 2 //////////////////// button 58
			MIDIdef.noteOn(\apcButton1, {
				arg vel, nn, chan, src;
				if (~countApc58 == 0, {
					~sopThru2 = Ndef(\sopThru2, ~amplifySopThru2);
					m.noteOn(0, 1, 01); //light on
					"amplify soprano through speaker 2".postln;
					"on 1 button 58".postln;
					~countApc58 = 1;
				}, {
					~sopThru2.release(1);
					m.noteOn(0, 1, 0); //light off
					"off 1 button 58".postln;
					~countApc58= 0;
				});
			}, 1, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 3 //////////////////// button 59
			MIDIdef.noteOn(\apcButton2, {
				arg vel, nn, chan, src;
				if (~countApc59 == 0, {
					~sopThru3 = Ndef(\sopThru3, ~amplifySopThru3);
					m.noteOn(0, 2, 01); //light on
					"amplify soprano through speaker 3".postln;
					"on 2 button 59".postln;
					~countApc59 = 1;
				}, {
					~sopThru3.release(1);
					m.noteOn(0, 2, 0); //light off
					"off 2 button 59".postln;
					~countApc59= 0;
				});
			}, 2, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 4 //////////////////// button 60
			MIDIdef.noteOn(\apcButton3, {
				arg vel, nn, chan, src;
				if (~countApc60 == 0, {
					~sopThru4 = Ndef(\sopThru4, ~amplifySopThru4);
					m.noteOn(0, 3, 01); //light on
					"amplify soprano through speaker 4".postln;
					"on 3 button 60".postln;
					~countApc60 = 1;
				}, {
					~sopThru4.release(1);
					m.noteOn(0, 3, 0); //light off
					"off 3 button 60".postln;
					~countApc60= 0;
				});
			}, 3, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 5 //////////////////// button 61
			MIDIdef.noteOn(\apcButton4, {
				arg vel, nn, chan, src;
				if (~countApc61 == 0, {
					~sopThru5 = Ndef(\sopThru5, ~amplifySopThru5);
					m.noteOn(0, 4, 01); //light on
					"amplify soprano through speaker 5".postln;
					"on 4 button 61".postln;
					~countApc61 = 1;
				}, {
					~sopThru5.release(1);
					m.noteOn(0, 4, 0); //light off
					"off 4 button 61".postln;
					~countApc61= 0;
				});
			}, 4, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 6 //////////////////// button 62
			MIDIdef.noteOn(\apcButton5, {
				arg vel, nn, chan, src;
				if (~countApc62 == 0, {
					~sopThru6 = Ndef(\sopThru6, ~amplifySopThru6);
					m.noteOn(0, 5, 01); //light on
					"amplify soprano through speaker 6".postln;
					"on 5 button 62".postln;
					~countApc62 = 1;
				}, {
					~sopThru6.release(1);
					m.noteOn(0, 5, 0); //light off
					"off 5 button 62".postln;
					~countApc62= 0;
				});
			}, 5, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 7 //////////////////// button 63
			MIDIdef.noteOn(\apcButton6, {
				arg vel, nn, chan, src;
				if (~countApc63 == 0, {
					~sopThru7 = Ndef(\sopThru7, ~amplifySopThru7);
					m.noteOn(0, 6, 01); //light on
					"amplify soprano through speaker 7".postln;
					"on 6 button 63".postln;
					~countApc63 = 1;
				}, {
					~sopThru7.release(1);
					m.noteOn(0, 6, 0); //light off
					"off 6 button 63".postln;
					~countApc63= 0;
				});
			}, 6, srcID: ~apcID);

			//////////////////// soprano amplify through speaker 8 //////////////////// button 64
			MIDIdef.noteOn(\apcButton7, {
				arg vel, nn, chan, src;
				if (~countApc64 == 0, {
					~sopThru8 = Ndef(\sopThru8, ~amplifySopThru8);
					m.noteOn(0, 7, 01); //light on
					"amplify soprano through speaker 8".postln;
					"on 7 button 64".postln;
					~countApc64 = 1;
				}, {
					~sopThru8.release(1);
					m.noteOn(0, 7, 0); //light off
					"off 7 button 64".postln;
					~countApc64= 0;
				});
			}, 7, srcID: ~apcID);


			/****************************************** speaker test ******************************************/
			//////////////////// sweep sp 1 //////////////////// button 65
			MIDIdef.noteOn(\apcButton64, {
				arg vel, nn, chan, src;
				if (~countApc65 == 0, {
					~sweep1 = Ndef(\sweep1, ~sweep_sp1);
					~sweep1sub = Ndef(\sweep1sub, ~sweep_sp1sub);
					//Ndef(\sweep1).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep1).set(\bufnum, ~bufTestNoise);
					Ndef(\sweep1sub).set(\bufnum, ~bufTestSubNoise);
					m.noteOn(0, 64, 01); //light on
					"on 64 button 65 sweep speaker 1".postln;
					~countApc65 = 1;
				}, {
					~sweep1.release(1);
					~sweep1sub.release(1);
					m.noteOn(0, 64, 0); //light off
					"off 64 button 65".postln;
					~countApc65= 0;
				});
			}, 64, srcID: ~apcID);

			//////////////////// sweep sp 2 //////////////////// button 66
			MIDIdef.noteOn(\apcButton65, {
				arg vel, nn, chan, src;
				if (~countApc66 == 0, {
					~sweep2 = Ndef(\sweep2, ~sweep_sp2);
					~sweep2sub = Ndef(\sweep2sub, ~sweep_sp2sub);
					//Ndef(\sweep2).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep2).set(\bufnum, ~bufTestNoise);
					Ndef(\sweep2sub).set(\bufnum, ~bufTestSubNoise);
					m.noteOn(0, 65, 01); //light on
					"on 65 button 66 sweep speaker 2".postln;
					~countApc66 = 1;
				}, {
					~sweep2.release(1);
					~sweep2sub.release(1);
					m.noteOn(0, 65, 0); //light off
					"off 65 button 66".postln;
					~countApc66 = 0;
				});
			}, 65, srcID: ~apcID);

			//////////////////// sweep sp 3 //////////////////// button 67
			MIDIdef.noteOn(\apcButton66, {
				arg vel, nn, chan, src;
				if (~countApc67 == 0, {
					~sweep3 = Ndef(\sweep3, ~sweep_sp3);
					//Ndef(\sweep3).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep3).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 66, 01); //light on
					"on 66 button 67 sweep speaker 3".postln;
					~countApc67 = 1;
				}, {
					~sweep3.release(1);
					m.noteOn(0, 66, 0); //light off
					"off 66 button 67".postln;
					~countApc67 = 0;
				});
			}, 66, srcID: ~apcID);

			//////////////////// sweep sp 4 //////////////////// button 68
			MIDIdef.noteOn(\apcButton67, {
				arg vel, nn, chan, src;
				if (~countApc68 == 0, {
					~sweep4 = Ndef(\sweep4, ~sweep_sp4);
					//Ndef(\sweep4).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep4).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 67, 01); //light on
					"on 67 button 68 sweep speaker 4".postln;
					~countApc68 = 1;
				}, {
					~sweep4.release(1);
					m.noteOn(0, 67, 0); //light off
					"off 67 button 68".postln;
					~countApc68 = 0;
				});
			}, 67, srcID: ~apcID);

			//////////////////// sweep sp 5 //////////////////// button 69
			MIDIdef.noteOn(\apcButton68, {
				arg vel, nn, chan, src;
				if (~countApc69 == 0, {
					~sweep5 = Ndef(\sweep5, ~sweep_sp5);
					//Ndef(\sweep5).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep5).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 68, 01); //light on
					"on 68 button 69 sweep speaker 5".postln;
					~countApc69 = 1;
				}, {
					~sweep5.release(1);
					m.noteOn(0, 68, 0); //light off
					"off 68 button 69".postln;
					~countApc69 = 0;
				});
			}, 68, srcID: ~apcID);

			//////////////////// sweep sp 6 //////////////////// button 70
			MIDIdef.noteOn(\apcButton69, {
				arg vel, nn, chan, src;
				if (~countApc70 == 0, {
					~sweep6 = Ndef(\sweep6, ~sweep_sp6);
					//Ndef(\sweep6).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep6).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 69, 01); //light on
					"on 69 button 70 sweep speaker 6".postln;
					~countApc70 = 1;
				}, {
					~sweep6.release(1);
					m.noteOn(0, 69, 0); //light off
					"off 69 button 70".postln;
					~countApc70 = 0;
				});
			}, 69, srcID: ~apcID);

			//////////////////// sweep sp 7 //////////////////// button 71
			MIDIdef.noteOn(\apcButton70, {
				arg vel, nn, chan, src;
				if (~countApc71 == 0, {
					~sweep7 = Ndef(\sweep7, ~sweep_sp7);
					//Ndef(\sweep7).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep7).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 70, 01); //light on
					"on 70 button 71 sweep speaker 7".postln;
					~countApc71 = 1;
				}, {
					~sweep7.release(1);
					m.noteOn(0, 70, 0); //light off
					"off 70 button 71".postln;
					~countApc71 = 0;
				});
			}, 70, srcID: ~apcID);

			//////////////////// sweep sp 8 //////////////////// button 72
			MIDIdef.noteOn(\apcButton71, {
				arg vel, nn, chan, src;
				if (~countApc72 == 0, {
					~sweep8 = Ndef(\sweep8, ~sweep_sp8);
					//Ndef(\sweep8).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep8).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 71, 01); //light on
					"on 71 button 72 sweep speaker 8".postln;
					~countApc72 = 1;
				}, {
					~sweep8.release(1);
					m.noteOn(0, 71, 0); //light off
					"off 71 button 72".postln;
					~countApc72 = 0;
				});
			}, 71, srcID: ~apcID);

			//////////////////// sweep sp 9 //////////////////// button 73
			MIDIdef.noteOn(\apcButton98, {
				arg vel, nn, chan, src;
				if (~countApc73 == 0, {
					~sweep9 = Ndef(\sweep9, ~sweep_sp9);
					//Ndef(\sweep9).set(\bufnum, ~bufTestSweep);
					Ndef(\sweep9).set(\bufnum, ~bufTestNoise);
					m.noteOn(0, 89, 01); //light on
					"on 89 button 73 sweep speaker 9".postln;
					~countApc73 = 1;
				}, {
					~sweep9.release(1);
					m.noteOn(0, 89, 0); //light off
					"off 89 button 73".postln;
					~countApc73 = 0;
				});
			}, 89, srcID: ~apcID);



		};



		/* run mappings for controllers, and send on and off messages */
		//  go APC mapping
		~midiMapApc.();
		// go MPK mapping
		~midiMapMpk.(); // run mapping function for MPK mini
		// go foot pedal mapping
		~midiMapFoot.();

		"midiMap done".postln;

		"done!".postln;
	};
}.fork

)

//////////////////////////////////////// END ////////////////////////////////////////




