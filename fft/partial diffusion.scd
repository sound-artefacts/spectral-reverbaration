


(
(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*16;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 2;
//s.makeGui(w);
s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
//s.boot;
~frames=(1024*8);
///(44100/(1024*8))*(512*7) number of partials, bin width = sample rate/ fft size(frames)
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

		///VBAP for spatial setups
				(
//~a = VBAPSpeakerArray.new(3,
//				[[0, 90.neg],[0, 0],[90, 0],[180,0],[90.neg,0],[0,90]]);
//	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);
		/////////////osc polytope
	(
{
var sph1,sph2,az1=0,el1=0,az2=0,el2=0;
var azimuth,elevation,angle=0,silver_r=(1+2.sqrt),golden_r=((1+5.sqrt)/2);

	~az=[];~el=[];

	16.do{
azimuth=32.collect{
			az1 = (az1+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
		   el1 = (el1+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));
sph1=(Spherical(1,(az1+angle).wrap(pi.neg,pi),(el1+angle).wrap((pi/2).neg,(pi/2)))).theta.round(0.000000000001);
	};

elevation=32.collect{
				az2 = (az2+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el2 = (el2+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));
		sph2=(Spherical(1,(az2+angle).wrap(pi.neg,pi),(el2+angle).wrap((pi/2).neg,(pi/2)))).phi.round(0.000000000001);
	};

angle=(angle+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
~az=~az++azimuth;~el=~el++elevation;
		az1=0;el1=0;az2=0;el2=0;
	}
}.value;
);


//////////////audio file
(~b = Buffer.readChannel(s,,channels:0 ););

////psychoacoustic exponential bin distribution
		(
			{
var steps = 257;

~nVals = steps.collect { |i|
    i.linexp(0, steps-1, 0.18, 3584).round
};
			~nVals.asInteger;
			}.value;
		);

		///def
(
SynthDef.new(\re_dif, {

	arg az,el,stasis,pan_lfo;
    var in,n1=0,n2=1,chain,sig,chain_p,coo=0,modulator,panx,pany,panz;
	var frames=~frames,out,pos1,pos2,out1,out2,sph;
	var pan,p_amp=1,coordinate=0,angle,pan_az,pan_el;


				az=MouseX.kr(pi.neg,pi).lag(0.1);
				el=MouseY.kr((pi/2).neg,(pi/2)).lag(0.1);
    in = PlayBuf.ar(1, ~b.bufnum, BufRateScale.kr(~b.bufnum), loop: 1, doneAction:0);

chain = FFT(LocalBuf(frames), in);

256.do{
chain_p = chain.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[n1]+1, tobin: ~nVals.[n2], zeroothers: 1);


//sph1=Spherical(1,(~az1.[coordinate]+az).wrap(pi.neg,pi),(~el1.[coordinate]+el).wrap((pi/2).neg,(pi/2)));
//sph2=Spherical(1,(~az2.[coordinate]+az).wrap(pi.neg,pi),(~el2.[coordinate]+el).wrap((pi/2).neg,(pi/2)));

sph=Spherical(1,~az.[coo],~el.[coo]);
modulator=Spherical(1,az,el);

panx=((exp(Complex(0,1)*sph.theta).real*exp(Complex(0,1)*sph.phi).real)-(exp(Complex(0,1)*modulator.theta).real*exp(Complex(0,1)*modulator.phi).real));
pany=((exp(Complex(0,1)*sph.theta).imag*exp(Complex(0,1)*sph.phi).real)-(exp(Complex(0,1)*modulator.theta).imag*exp(Complex(0,1)*modulator.phi).real));
panz=((exp(Complex(0,1)*sph.phi).imag)-(exp(Complex(0,1)*modulator.phi).imag));

angle=Complex(panx,pany).theta;
					pan=Select.ar(stasis,[SinOsc.ar(pan_lfo,phase:angle,mul:p_amp),DC.ar(1)]);

					pos1=Select.ar(stasis,[K2A.ar(exp(Complex(0,1)*angle).real),DC.ar(1)]);
					pos2=Select.ar(stasis,[K2A.ar(exp(Complex(0,1)*angle).imag),DC.ar(1.neg)]);

sig=IFFT(chain_p);

out1=Out.ar(0,Pan2.ar(sig,pos1)*pan);
out2=Out.ar(0,Pan2.ar(sig,pos2)*pan);

					n1=n1+1; n2=n2+1; coo=coo+1;
						//out=VBAP.ar(4,sig,~b.bufnum,azimuth:sph.theta.raddeg,elevation:sph.phi.raddeg,spread:1);
						}

}).add;
);


120.wait;
		(
~synth=Synth.new(\re_dif,[\az,0,\el,pi/5,\stasis,0,\pan_lfo, 0.042105263157895]).register;
		);
	//	s.record(duration:(2*60)+59);

2.wait;
(
MIDIClient.init;
MIDIIn.connectAll;
		(
MIDIdef.cc(\midi_pot1,{ |val, num, chan, src|
		var az;
	az=val.linlin(0,127,pi.neg,pi).round(0.000001);
		az.postln;
		if(~synth.isPlaying,{~synth.set(\az,az)});
},26);
				);
	(
MIDIdef.cc(\midi_pot2,{ |val, num, chan, src|
		var el;
						el=val.linlin(0,127,(pi/2).neg,(pi/2)).round(0.000001);
		el.postln;
		if(~synth.isPlaying,{~synth.set(\el,el)});
},27);
	);
		(
MIDIdef.cc(\midi_pot3,{ |val, num, chan, src|
		var pan;
	pan=val.linlin(0,127,0.001,1).round(0.000001);
		pan.postln;
		if(~synth.isPlaying,{~synth.set(\pan_lfo,pan)});
},28);
	);
			(
MIDIdef.cc(\midi_switch1,{ |val, num, chan, src|
		var st;
					if(val>0,st=0,st=1);
		st.postln;
		if(~synth.isPlaying,{~synth.set(\stasis,st)});
},14);
	);

)
});
	Tdef(\drone).play;
}
)
)