


(
(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*8;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 2;
//s.makeGui(w);
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
s.boot;
~frames=1024;
);


//
(
s.waitForBoot{
MIDIClient.init;
MIDIIn.connectAll;
s.freqscope;
s.scope;
//s.makeWindow;
s.meter;
	Tdef(\drone, {
	Buffer.freeAll;

(
~r1 = Buffer.readChannel(s,"/Users/amimid/Desktop/1.wav",channels:0 );
~r2 = Buffer.readChannel(s,"/Users/amimid/Desktop/2.wav",channels:0 );
//~i3 = Buffer.readChannel(s,,channels:1 );
		);

		(
			{
var steps = 8;

~nVals = steps.collect { |i|
    i.linexp(0, steps-1, 0.18, 463).round
};
			~nVals.asInteger;
			}.value;
		);

(
SynthDef.new(\re_im, {

	arg amp1=1,amp2=1,amp3=1,amp4=1,amp5=1,amp6=1,amp7=1,amp8=1,
				amp1a=1,amp2a=1,amp3a=1,amp4a=1,amp5a=1,amp6a=1,amp7a=1,
				amp8a=1,amp1aa=1,amp2aa=1,amp3aa=1,amp4aa=1,amp5aa=1,amp6aa=1,amp7aa=1,amp8aa=1,az,el,azimuth,elevation;

	var chain1rl,chain2rl,chain3rl,chain4rl,chain5rl,chain6rl,chain7rl,chain8rl;
	var chain1rr,chain2rr,chain3rr,chain4rr,chain5rr,chain6rr,chain7rr,chain8rr;
	var chain1il,chain2il,chain3il,chain4il,chain5il,chain6il,chain7il,chain8il;
    var sig1rl,sig2rl,sig3rl,sig4rl,sig5rl,sig6rl,sig7rl,sig8rl;
	var sig1rr,sig2rr,sig3rr,sig4rr,sig5rr,sig6rr,sig7rr,sig8rr;
    var sig1il,sig2il,sig3il,sig4il,sig5il,sig6il,sig7il,sig8il;
	var sph, anglex,angley,anglez,in1,in2,in3,in4,n=0,chain1,chain2;
	var frames=~frames,silver=45,golden=45,l=1,r=1.neg,g=((1+5.sqrt)/2),s=(1+2.sqrt);


    in1 = PlayBuf.ar(1, ~r1.bufnum, BufRateScale.kr(~r1.bufnum), loop: 0, doneAction:0);
	in2 = PlayBuf.ar(1, ~r2.bufnum, BufRateScale.kr(~r2.bufnum), loop: 1, doneAction:0);

	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in2);

chain1rl = chain1.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2rl = chain1.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);

chain1rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);


sig1rl=IFFT(chain1rl);sig2rl=IFFT(chain2rl);sig3rl=IFFT(chain3rl);sig4rl=IFFT(chain4rl);
sig5rl=IFFT(chain5rl);sig6rl=IFFT(chain6rl);sig7rl=IFFT(chain7rl);sig8rl=IFFT(chain8rl);

sig1rr=IFFT(chain1rr);sig2rr=IFFT(chain2rr);sig3rr=IFFT(chain3rr);sig4rr=IFFT(chain4rr);
sig5rr=IFFT(chain5rr);sig6rr=IFFT(chain6rr);sig7rr=IFFT(chain7rr);sig8rr=IFFT(chain8rr);


Out.ar(0,Pan2.ar(sig1rl,1,amp1));
Out.ar(0,Pan2.ar(sig2rl,1,amp2));
Out.ar(0,Pan2.ar(sig3rl,1,amp3));
Out.ar(0,Pan2.ar(sig4rl,1,amp4));
Out.ar(0,Pan2.ar(sig5rl,1,amp5));
Out.ar(0,Pan2.ar(sig6rl,1,amp6));
Out.ar(0,Pan2.ar(sig7rl,1,amp7));
Out.ar(0,Pan2.ar(sig8rl,1,amp8));

Out.ar(0,Pan2.ar(sig1rr,1.neg,amp1a));
Out.ar(0,Pan2.ar(sig2rr,1.neg,amp2a));
Out.ar(0,Pan2.ar(sig3rr,1.neg,amp3a));
Out.ar(0,Pan2.ar(sig4rr,1.neg,amp4a));
Out.ar(0,Pan2.ar(sig5rr,1.neg,amp5a));
Out.ar(0,Pan2.ar(sig6rr,1.neg,amp6a));
Out.ar(0,Pan2.ar(sig7rr,1.neg,amp7a));
Out.ar(0,Pan2.ar(sig8rr,1.neg,amp8a));


}).add;
);


5.wait;
		(
~synth=Synth.new(\re_im,[\amp1,0.33,\amp2,0.5,\amp3,0.2,\amp4,0.1,\amp5,1,\amp6,0.6,\amp7,0.3,\amp8,0.4,
			\amp1a,1,\amp2a,0.333,\amp3a,1,\amp4a,0.7,\amp5a,0.1,\amp6a,0.8,\amp7a,1,\amp8a,0.7]).register;//s.record
		)
	//	~synth=Synth.new(\re_im);



(
MIDIClient.init;
MIDIIn.connectAll;
		(
			(
MIDIdef.cc(\midi_slider1,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp1, th)});
},25);
			);

											(
MIDIdef.cc(\midi_slider2,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp2, th)});
},26);
	);

														(
MIDIdef.cc(\midi_slider3,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp3, th)});

},27);
	);
(
MIDIdef.cc(\midi_slider4,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp4, th)});

},28);
	);

				(
MIDIdef.cc(\midi_slider5,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp5, th)});

},29);
			);
					(
MIDIdef.cc(\midi_slider6,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp6, th)});

},30);
			);
				(
MIDIdef.cc(\midi_slider7,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp7, th)});
},31);
	);

(
MIDIdef.cc(\midi_slider8,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp8, th)});

},32);
	);

);

(
			(
MIDIdef.cc(\midi_slider18,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp1a, th)});
},74);
			);

											(
MIDIdef.cc(\midi_slider19,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp2a, th)});
},75);
	);

														(
MIDIdef.cc(\midi_slider20,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp3a, th)});

},76);
	);
(
MIDIdef.cc(\midi_slider21,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp4a, th)});
},77);
	);

				(
MIDIdef.cc(\midi_slider22,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp5a, th)});
},78);
			);
					(
MIDIdef.cc(\midi_slider23,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp6a, th)});
},79);
			);
					(
MIDIdef.cc(\midi_slider24,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp7a, th)});
},80);
	);

(
MIDIdef.cc(\midi_slider25,{ |val, num, chan, src|
		var th;
	th=val.linlin(0,127,0.0001,1).round(0.0001);
		th.postln;
if(~synth.isPlaying,{~synth.set(\amp8a, th)});
},81);
				);

			)


)
});
	Tdef(\drone).play;
}
)
)
s.record(numchannels:2,duration:(4*60));