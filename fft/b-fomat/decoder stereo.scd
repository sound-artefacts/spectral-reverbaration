


(
(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*4;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 2;
//s.makeGui(w);
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
s.boot;
~frames=2048;
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
~f1 = Buffer.readChannel(s,,channels:0 );
~f2 = Buffer.readChannel(s,,channels:0 );
~f3 = Buffer.readChannel(s,,channels:0 );
~f4 = Buffer.readChannel(s,,channels:0 );
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
SynthDef.new(\re_de, {

	arg amp=1,az=0,el=0;
	var sph,anglex,angley,anglez,in1,in2,in3,in4;
	var sig1,sig2,sig3,phasex,phasey,phasez,frames=~frames;
	var chain1,chain2,chain3,chainx,chainy,chainz;


    in1 = PlayBuf.ar(1, ~f1.bufnum, BufRateScale.kr(~f1.bufnum), loop: 0, doneAction:0);
	in2 = PlayBuf.ar(1, ~f2.bufnum, BufRateScale.kr(~f2.bufnum), loop: 0, doneAction:0);
    in3 = PlayBuf.ar(1, ~f3.bufnum, BufRateScale.kr(~f3.bufnum), loop: 0, doneAction:0);
    in4 = PlayBuf.ar(1, ~f4.bufnum, BufRateScale.kr(~f4.bufnum), loop: 0, doneAction:0);


sph=Spherical.ar(1,az,el);

anglex=(exp(Complex(0,1)*sph.theta).real*exp(Complex(0,1)*sph.phi).real).round(0.00001);
angley=(exp(Complex(0,1)*sph.theta).imag*exp(Complex(0,1)*sph.phi).real).round(0.00001);
anglez=(exp(Complex(0,1)*sph.phi).imag).round(0.00001);

phasex=Complex(0,anglex).theta;
phasey=Complex(0,angley).theta;
phasez=Complex(0,anglez).theta;

 chain1 = FFT(LocalBuf(frames), in1);
 chain2 = FFT(LocalBuf(frames), in2);
 chain3 = FFT(LocalBuf(frames), in3);

 chainx = PV_PhaseShift(chain1,phasex);
 chainy = PV_PhaseShift(chain2,phasey);
 chainz = PV_PhaseShift(chain3,phasez);


sig1=in4-in1;
sig2=in4-in2;
sig3=in4-in3;

Out.ar(0,Pan2.ar(sig1,anglex,amp));
Out.ar(0,Pan2.ar(sig2,angley,amp));
Out.ar(0,Pan2.ar(sig3,anglez,amp));




}).add;
);


5.wait;
		~synth=Synth.new(\re_de,[\amp,1,\az,0,\el,pi/4]).register;//s.record
	//	~synth=Synth.new(\re_im);
2.wait;


)
});
	Tdef(\drone).play;
}
)
)
s.record(numchannels:2,duration:(4*60));