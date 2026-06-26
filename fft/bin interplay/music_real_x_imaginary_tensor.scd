


(
(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*4;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 2;
//s.makeGui(w);
s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
//s.boot;
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
~r1 = Buffer.readChannel(s,,channels:0 );
~r2 = Buffer.readChannel(s,,channels:1 );
~i3 = Buffer.readChannel(s,,channels:0 );
~i4 = Buffer.readChannel(s,,channels:1 );
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

		////// tensor locations
(
~az=[45.degrad,135.degrad,45.neg.degrad,135.neg.degrad,45.degrad,135.degrad,45.neg.degrad,135.neg.degrad];
~el=[35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad];
);

(
SynthDef.new(\re_im, {

	arg az=0,el=1,re=0,i=0,pan=0.2;
	var amp1=1,amp2=1,amp3=1,amp4=1,amp5=1,amp6=1,amp7=1,amp8=1,amp1a=1,amp2a=1,amp3a=1,amp4a=1,amp5a=1,amp6a=1,amp7a=1,amp8a=1;
    var in1,in2,in3,in4,chain1,chain2,chain3,chain4,n=0;
	var chain1rl,chain2rl,chain3rl,chain4rl,chain5rl,chain6rl,chain7rl,chain8rl;
	var chain1rr,chain2rr,chain3rr,chain4rr,chain5rr,chain6rr,chain7rr,chain8rr;
	var chain1il,chain2il,chain3il,chain4il,chain5il,chain6il,chain7il,chain8il;
	var chain1ir,chain2ir,chain3ir,chain4ir,chain5ir,chain6ir,chain7ir,chain8ir;
    var sig1rl,sig2rl,sig3rl,sig4rl,sig5rl,sig6rl,sig7rl,sig8rl;
	var sig1rr,sig2rr,sig3rr,sig4rr,sig5rr,sig6rr,sig7rr,sig8rr;
    var sig1il,sig2il,sig3il,sig4il,sig5il,sig6il,sig7il,sig8il;
	var sig1ir,sig2ir,sig3ir,sig4ir,sig5ir,sig6ir,sig7ir,sig8ir;
	var frames=~frames,sig1,sig2,silver=45,golden=45,l=1,r=1.neg,g=((1+5.sqrt)/2),s=(1+2.sqrt);
	var loc1,loc2,loc3,loc4,loc5,loc6,loc7,loc8,tensor,index_i,index_re;

				az=MouseX.kr(pi.neg,pi);
				el=MouseY.kr((pi/2).neg,(pi/2));

    in1 = PlayBuf.ar(1, ~r1.bufnum, BufRateScale.kr(~r1.bufnum), loop: 1, doneAction:0);
	in2 = PlayBuf.ar(1, ~r2.bufnum, BufRateScale.kr(~r2.bufnum), loop: 1, doneAction:0);
	//in1 = SoundIn.ar(0);
	//in2 = SoundIn.ar(1);
    in3 = PlayBuf.ar(1, ~i3.bufnum, BufRateScale.kr(~i3.bufnum), loop: 1, doneAction:0)*0.3;
	in4 = PlayBuf.ar(1, ~i4.bufnum, BufRateScale.kr(~i4.bufnum), loop: 1, doneAction:0)*0.3;
	//in3 = SoundIn.ar(0);
	//in4 = SoundIn.ar(1);
	chain1 = FFT(LocalBuf(frames), in1);	chain3 = FFT(LocalBuf(frames), in3);
	chain2 = FFT(LocalBuf(frames), in2);	chain4 = FFT(LocalBuf(frames), in4);

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


chain1il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8il = chain3.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);


chain1ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8ir = chain4.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);


//l=exp(Complex(0,1)*silver.degrad).real.round(0.0001).abs;
//r=exp(Complex(0,1)*silver.degrad).imag.round(0.0001).abs.neg;

	//	silver=(silver+(360-(360/s))).wrap(0,360).round(0.0001);
	//	golden=(golden+(360-(360/g))).wrap(180.neg,180).round(0.0001);

sig1rl=IFFT(chain1rl);sig2rl=IFFT(chain2rl);sig3rl=IFFT(chain3rl);sig4rl=IFFT(chain4rl);
sig5rl=IFFT(chain5rl);sig6rl=IFFT(chain6rl);sig7rl=IFFT(chain7rl);sig8rl=IFFT(chain8rl);

sig1rr=IFFT(chain1rr);sig2rr=IFFT(chain2rr);sig3rr=IFFT(chain3rr);sig4rr=IFFT(chain4rr);
sig5rr=IFFT(chain5rr);sig6rr=IFFT(chain6rr);sig7rr=IFFT(chain7rr);sig8rr=IFFT(chain8rr);

sig1il=IFFT(chain1il);sig2il=IFFT(chain2il);sig3il=IFFT(chain3il);sig4il=IFFT(chain4il);
sig5il=IFFT(chain5il);sig6il=IFFT(chain6il);sig7il=IFFT(chain7il);sig8il=IFFT(chain8il);

sig1ir=IFFT(chain1ir);sig2ir=IFFT(chain2ir);sig3ir=IFFT(chain3ir);sig4ir=IFFT(chain4ir);
sig5ir=IFFT(chain5ir);sig6ir=IFFT(chain6ir);sig7ir=IFFT(chain7ir);sig8ir=IFFT(chain8ir);


loc1=Spherical(1,~az.[0],~el.[0]);loc2=Spherical(1,~az.[1],~el.[1]);loc3=Spherical(1,~az.[2],~el.[2]);loc4=Spherical(1,~az.[3],~el.[3]);
loc5=Spherical(1,~az.[4],~el.[4]);loc6=Spherical(1,~az.[5],~el.[5]);loc7=Spherical(1,~az.[6],~el.[6]);loc8=Spherical(1,~az.[7],~el.[7]);

tensor=Spherical(1,az,el);
index_re=re; index_i=i;

amp1=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc1.theta).real*exp(Complex(0,1)*loc1.phi).real)-
							(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp2=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc2.theta).real*exp(Complex(0,1)*loc2.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp3=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc3.theta).real*exp(Complex(0,1)*loc3.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp4=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc4.theta).real*exp(Complex(0,1)*loc4.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp5=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc5.theta).real*exp(Complex(0,1)*loc5.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp6=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc6.theta).real*exp(Complex(0,1)*loc6.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp7=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc7.theta).real*exp(Complex(0,1)*loc7.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp8=Select.ar(index_re,[
K2A.ar(
((exp(Complex(0,1)*loc8.theta).real*exp(Complex(0,1)*loc8.phi).real)-
						(exp(Complex(0,1)*tensor.theta).real*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp1a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc1.theta).imag*exp(Complex(0,1)*loc1.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp2a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc2.theta).imag*exp(Complex(0,1)*loc2.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp3a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc3.theta).imag*exp(Complex(0,1)*loc3.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp4a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc4.theta).imag*exp(Complex(0,1)*loc4.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp5a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc5.theta).imag*exp(Complex(0,1)*loc5.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp6a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc6.theta).imag*exp(Complex(0,1)*loc6.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp7a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc7.theta).imag*exp(Complex(0,1)*loc7.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);
amp8a=Select.ar(index_i,[
K2A.ar(
((exp(Complex(0,1)*loc8.theta).imag*exp(Complex(0,1)*loc8.phi).real)-
						(exp(Complex(0,1)*tensor.theta).imag*exp(Complex(0,1)*tensor.phi).real))),DC.ar(1)]);



Out.ar(0,Pan2.ar(sig1rl,l,amp1));Out.ar(0,Pan2.ar(sig2rl,l,amp2));Out.ar(0,Pan2.ar(sig3rl,l,amp3));Out.ar(0,Pan2.ar(sig4rl,l,amp4));
Out.ar(0,Pan2.ar(sig5rl,l,amp5));Out.ar(0,Pan2.ar(sig6rl,l,amp6));Out.ar(0,Pan2.ar(sig7rl,l,amp7));Out.ar(0,Pan2.ar(sig8rl,l,amp8));
Out.ar(0,Pan2.ar(sig1rr,r,amp1));Out.ar(0,Pan2.ar(sig2rr,r,amp2));Out.ar(0,Pan2.ar(sig3rr,r,amp3));Out.ar(0,Pan2.ar(sig4rr,r,amp4));
Out.ar(0,Pan2.ar(sig5rr,r,amp5));Out.ar(0,Pan2.ar(sig6rr,r,amp6));Out.ar(0,Pan2.ar(sig7rr,r,amp7));Out.ar(0,Pan2.ar(sig8rr,r,amp8));

Out.ar(0,Pan2.ar(sig1il,l,amp1a));Out.ar(0,Pan2.ar(sig2il,l,amp2a));Out.ar(0,Pan2.ar(sig3il,l,amp3a));Out.ar(0,Pan2.ar(sig4rl,l,amp4a));
Out.ar(0,Pan2.ar(sig5il,l,amp5a));Out.ar(0,Pan2.ar(sig6il,l,amp6a));Out.ar(0,Pan2.ar(sig7il,l,amp7a));Out.ar(0,Pan2.ar(sig8il,l,amp8a));
Out.ar(0,Pan2.ar(sig1ir,r,amp1a));Out.ar(0,Pan2.ar(sig2ir,r,amp2a));Out.ar(0,Pan2.ar(sig3ir,r,amp3a));Out.ar(0,Pan2.ar(sig4ir,r,amp4a));
Out.ar(0,Pan2.ar(sig5ir,r,amp5a));Out.ar(0,Pan2.ar(sig6ir,r,amp6a));Out.ar(0,Pan2.ar(sig7ir,r,amp7a));Out.ar(0,Pan2.ar(sig8ir,r,amp8a));

}).add;
);


5.wait;
~synth=Synth.new(\re_im,[\az,pi,\el,(pi/2),\re,0,\i,0,]).register;//s.record
	//	~synth=Synth.new(\re_im);
2.wait;
(
MIDIClient.init;
MIDIIn.connectAll;
		(
MIDIdef.cc(\midi_pot1,{ |val, num, chan, src|
		var a1;

	a1=val.linlin(0,127,pi.neg,pi).round(0.000001);
		a1.postln;
		if(~synth.isPlaying,{~synth.set(\az,a1)});
},26);
				);
	(
MIDIdef.cc(\midi_pot2,{ |val, num, chan, src|
		var a2;
		a2=val.linlin(0,127,(pi/2).neg,(pi/2)).round(0.000001);
		a2.postln;
		if(~synth.isPlaying,{~synth.set(\el,a2)});
},27);
	);

		(
MIDIdef.cc(\midi_switch1,{ |val, num, chan, src|
		var b;
					if(val>0,b=1,b=0);
		b.postln;
		if(~synth.isPlaying,{~synth.set(\re,b)});
},14);
	);
	(
MIDIdef.cc(\midi_switch2,{ |val, num, chan, src|
		 var b;
					if(val>0,b=1,b=0);
		b.postln;
		if(~synth.isPlaying,{~synth.set(\i,b)});
},15);
	);

				(
MIDIdef.cc(\midi_switch7,{ |val, num, chan, src|
		var p;
				if(val>0,p=1);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},20);
	);
	(
MIDIdef.cc(\midi_switch8,{ |val, num, chan, src|
		 var p;
				if(val>0,p=1/2);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},21);
	);
			(
MIDIdef.cc(\midi_switch9,{ |val, num, chan, src|
		var p, n=2, a=1;
					if(val>0,p=1/3);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},22);
	);

	(
MIDIdef.cc(\midi_switch10,{ |val, num, chan, src|
         var p, n=3, a=1;
				if(val>0,p=1/4);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},23);
	);
		(
MIDIdef.cc(\midi_switch11,{ |val, num, chan, src|
		var p, n=4, a=1;
				if(val>0,p=1/5);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},24);
	);
					(
MIDIdef.cc(\midi_switch12,{ |val, num, chan, src|
		var p, n=5, a=1;
					if(val>0,p=1/6);
		p.postln;
		if(~synth.isPlaying,{~synth.set(\pan,p)});
},25);
	);



)
});
	Tdef(\drone).play;
}
)
)
s.record(numchannels:2,duration:(4*60));


/*(///location arrays

diffusion polytope
(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=9,m_y=9,m_z=9,qx,qy,mq=m_x-1;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=0,az5=0,el5=0,az6=0,el6=0,az7=0,el7=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez,angle=0,n=12;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=1,ply=1,plz=1;
var ellipsis=[1,1,1],spread=1,silver_r=(1+2.sqrt);
var mag1=1,mag2=1,mag3=1,mag4=1,mag5=1,mag6=1,mag7=1;
	~az=[];~el=[];~magx=[];~magy=[];~magz=[];~qx=[];~qy=[];

//	spread = if(m_z < 1) { 1 / m_z } { m_z };

	16.do{
azimuth=32.collect{
			az1 = (az1+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
		   el1 = (el1+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

//	mag1=(mag1+(1-(1/1.6180339887499))).wrap(0,1);
sph1=(Spherical(mag1,(az1+angle).wrap(pi.neg,pi),(el1+angle).wrap((pi/2).neg,(pi/2)))).theta.round(0.000000000001);

	};

elevation=32.collect{
				az2 = (az2+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el2 = (el2+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

	//mag2=(mag2+(1-(1/1.6180339887499))).wrap(0,1);
		sph2=(Spherical(mag2,(az2+angle).wrap(pi.neg,pi),(el2+angle).wrap((pi/2).neg,(pi/2)))).phi.round(0.000000000001);

	};

angle=(angle+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
~az=~az++azimuth;~el=~el++elevation;
		az1=0;el1=0;az2=0;el2=0;
	}
}.value;
)
	///tetrahedron
(
~az=[45.degrad,135.neg.degrad,45.neg.degrad,135.degrad];
~el=[35.264390.neg.degrad,35.264390.neg.degrad,35.264390.degrad,35.264390.degrad];
);
//////cube
(
~az=[45.degrad,135.degrad,45.neg.degrad,135.neg.degrad,45.degrad,135.degrad,45.neg.degrad,135.neg.degrad];
~el=[35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad];
)

/////octahedron

(
~az=[0.degrad,0.degrad,90.degrad,180.degrad,90.neg.degrad,0.degrad];
~el=[90.neg.degrad,0.degrad,0.degrad,0.degrad,0.degrad,90.degrad];
)

//////icosahedron
(
~az=[90.degrad,90.neg.degrad,0.degrad,180.degrad,58.28.degrad,121.72.degrad,121.72.neg.degrad,58.neg.degrad,90.degrad,90.neg.degrad,0.degrad,180.degrad];
~el=[58.28.neg.degrad,58.28.neg.degrad,31.72.neg.degrad,31.72.neg.degrad,0.degrad,0.degrad,0.degrad,0.degrad,58.28.degrad,58.28.degrad,31.72.degrad,31.72.degrad];
)

/////dodecahedron

(
~az=[45.degrad,135.neg.degrad,135.degrad,45.neg.degrad,90.degrad,90.neg.degrad,0.degrad,180.degrad,45.degrad,135.neg.degrad,135.degrad,45.neg.degrad,90.degrad,
	90.neg.degrad,69.09.degrad,110.91.degrad,110.91.neg.degrad,69.09.neg.degrad,0.degrad,180.degrad];

~el=[35.26.neg.degrad,35.26.neg.degrad,35.26.neg.degrad,35.26.neg.degrad,69.09.neg.degrad,69.09.neg.degrad,20.91.neg.degrad,20.91.neg.degrad,
	35.26.degrad,35.26.degrad,35.26.degrad,35.26.degrad,69.09.degrad,69.09.degrad,0.degrad,0.degrad,0.degrad,0.degrad,20.91.degrad,20.91.degrad]
)

/////Rhombic dodecahedron//// hull

(
~az=[0.degrad,45.degrad,135.neg.degrad,135.degrad,45.neg.degrad,0.degrad,180.degrad,90.degrad,90.neg.degrad,0.degrad,
	45.degrad,135.neg.degrad,135.degrad,45.neg.degrad];
~el=[90.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,35.264390.neg.degrad,0.degrad
	,0.degrad,0.degrad,0.degrad,90.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad,35.264390.degrad];
)

/////cuboctahedron//// core

(
~az=[0.degrad,90.degrad,180.degrad,90.neg.degrad,45.degrad,135.degrad,45.neg.degrad,135.neg.degrad,
	0.degrad,90.degrad,180.degrad,90.neg.degrad];
~el=[45.neg.degrad,45.neg.degrad,45.neg.degrad,45.neg.degrad,0.degrad,0.degrad,0.degrad,0.degrad,
	45.degrad,45.degrad,45.degrad,45.degrad];
)


///////////////Rhombic Triacontahedron//// hull
(
~az=[0.degrad,0.degrad,72.degrad,144.degrad,144.neg.degrad,72.neg.degrad,36.degrad,108.degrad,180.degrad,108.neg.degrad,36.neg.degrad,
	0.degrad,72.degrad,144.degrad,144.neg.degrad,72.neg.degrad,36.degrad,108.degrad,180.degrad,108.neg.degrad,36.neg.degrad,
	0.degrad,72.degrad,144.degrad,144.neg.degrad,72.neg.degrad,36.degrad,108.degrad,180.degrad,108.neg.degrad,36.neg.degrad,0.degrad];

~el=[90.neg.degrad,52.6.neg.degrad,52.6.neg.degrad,52.6.neg.degrad,52.6.neg.degrad,52.6.neg.degrad,26.6.neg.degrad,26.6.neg.degrad,26.6.neg.degrad,26.6.neg.degrad,26.6.neg.degrad,10.8.neg.degrad,10.8.neg.degrad,10.8.neg.degrad,10.8.neg.degrad,10.8.neg.degrad,52.6.degrad,52.6.degrad,52.6.degrad,52.6.degrad,52.6.degrad,26.6.degrad,26.6.degrad,26.6.degrad,26.6.degrad,26.6.degrad,10.8.degrad,10.8.degrad,10.8.degrad,10.8.degrad,10.8.degrad,90.degrad];

)

///////icosidodecahedron//// core
(
~az=[18.degrad,90.degrad,162.degrad,126.neg.degrad,54.neg.degrad,54.degrad,126.degrad,162.neg.degrad,90.neg.degrad,18.neg.degrad,
	0.degrad,36.degrad,72.degrad,108.degrad,144.degrad,180.degrad,144.neg.degrad,108.neg.degrad,72.neg.degrad,36.neg.degrad,
	54.degrad,126.degrad,162.neg.degrad,90.neg.degrad,18.neg.degrad,18.degrad,90.degrad,162.degrad,126.neg.degrad,54.neg.degrad];

~el=[58.283.degrad,58.283.degrad,58.283.degrad,58.283.degrad,58.283.degrad,58.283.neg.degrad,58.283.neg.degrad,58.283.neg.degrad,58.283.neg.degrad,58.283.neg.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,0.degrad,
37.717.degrad,37.717.degrad,37.717.degrad,37.717.degrad,37.717.degrad,37.717.neg.degrad,37.717.neg.degrad,37.717.neg.degrad,37.717.neg.degrad,37.717.neg.degrad];

)
)*/