(
s.options.numWireBufs = 1024*8;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*32;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 4;
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
s.boot;
~frames=1024;
)

Buffer.freeAll
(
~c1 = Buffer.readChannel(s,"/Users/amimid/Desktop/My Movie.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/amimid/Desktop/My Movie.wav",channels:1 );
)

////speaker setup

///cube

(
~a = VBAPSpeakerArray.new(3,
[[45, 35.264390.neg], [135, 35.264390.neg], [45.neg, 35.264390.neg], [135.neg, 35.264390.neg],[45,35.264390],[135,35.264390],[45.neg,35.264390],[135.neg,35.264390]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)


(
			{
var steps = 8;

~nVals = steps.collect { |i|
    i.linexp(0, steps-1, 0.18, 463).round
};
			~nVals.asInteger;
			}.value;
		)

(
SynthDef.new(\re, {
	var chain1rl,chain2rl,chain3rl,chain4rl,chain5rl,chain6rl,chain7rl,chain8rl;
	var chain1rr,chain2rr,chain3rr,chain4rr,chain5rr,chain6rr,chain7rr,chain8rr;
    var sig1rl,sig2rl,sig3rl,sig4rl,sig5rl,sig6rl,sig7rl,sig8rl;
	var sig1rr,sig2rr,sig3rr,sig4rr,sig5rr,sig6rr,sig7rr,sig8rr;
    var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8;
	var anglex1,angley1,anglez1,anglex2,angley2,anglez2,anglex3,angley3,anglez3,anglex4,angley4,anglez4;
	var anglex5,angley5,anglez5,anglex6,angley6,anglez6,anglex7,angley7,anglez7,anglex8,angley8,anglez8;
	var frames=~frames,silver=45,golden=45,g=((1+5.sqrt)/2),s=(1+2.sqrt);
	var in1,in2,chain1,chain2,spread=83;
	var az1,el1,az2,el2,az3,el3,az4,el4,az5,el5,az6,el6,az7,el7,az8,el8;
	var pan1,pan2,pan3,pan4,pan5,pan6,pan7,pan8;

     in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

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

	az1=LFNoise1.ar(3).range(pi,pi.neg);
	el1=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az2=LFNoise1.ar(3).range(pi,pi.neg);
	el2=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az3=LFNoise1.ar(3).range(pi,pi.neg);
	el3=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az4=LFNoise1.ar(3).range(pi,pi.neg);
	el4=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az5=LFNoise1.ar(3).range(pi,pi.neg);
	el5=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az6=LFNoise1.ar(3).range(pi,pi.neg);
	el6=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az7=LFNoise1.ar(3).range(pi,pi.neg);
	el7=LFNoise1.ar(3).range((pi/2),(pi/2).neg);
	az8=LFNoise1.ar(3).range(pi,pi.neg);
	el8=LFNoise1.ar(3).range((pi/2),(pi/2).neg);


	sph1=Spherical(1,az1,el1);
	sph2=Spherical(1,az2,el2);
	sph3=Spherical(1,az3,el3);
	sph4=Spherical(1,az4,el4);
	sph5=Spherical(1,az5,el5);
	sph6=Spherical(1,az6,el6);
	sph7=Spherical(1,az7,el7);
	sph8=Spherical(1,az8,el8);


anglex1=exp(Complex(0,1)*sph1.theta).real*exp(Complex(0,1)*sph1.phi).real;
angley1=exp(Complex(0,1)*sph1.theta).imag*exp(Complex(0,1)*sph1.phi).real;
anglez1=exp(Complex(0,1)*sph1.phi).imag;
anglex2=exp(Complex(0,1)*sph2.theta).real*exp(Complex(0,1)*sph2.phi).real;
angley2=exp(Complex(0,1)*sph2.theta).imag*exp(Complex(0,1)*sph2.phi).real;
anglez2=exp(Complex(0,1)*sph2.phi).imag;
anglex3=exp(Complex(0,1)*sph3.theta).real*exp(Complex(0,1)*sph3.phi).real;
angley3=exp(Complex(0,1)*sph3.theta).imag*exp(Complex(0,1)*sph3.phi).real;
anglez3=exp(Complex(0,1)*sph3.phi).imag;
anglex4=exp(Complex(0,1)*sph4.theta).real*exp(Complex(0,1)*sph4.phi).real;
angley4=exp(Complex(0,1)*sph4.theta).imag*exp(Complex(0,1)*sph4.phi).real;
anglez4=exp(Complex(0,1)*sph4.phi).imag;
anglex5=exp(Complex(0,1)*sph5.theta).real*exp(Complex(0,1)*sph5.phi).real;
angley5=exp(Complex(0,1)*sph5.theta).imag*exp(Complex(0,1)*sph5.phi).real;
anglez5=exp(Complex(0,1)*sph5.phi).imag;
anglex6=exp(Complex(0,1)*sph6.theta).real*exp(Complex(0,1)*sph6.phi).real;
angley6=exp(Complex(0,1)*sph6.theta).imag*exp(Complex(0,1)*sph6.phi).real;
anglez6=exp(Complex(0,1)*sph6.phi).imag;
anglex7=exp(Complex(0,1)*sph7.theta).real*exp(Complex(0,1)*sph7.phi).real;
angley7=exp(Complex(0,1)*sph7.theta).imag*exp(Complex(0,1)*sph7.phi).real;
anglez7=exp(Complex(0,1)*sph7.phi).imag;
anglex8=exp(Complex(0,1)*sph8.theta).real*exp(Complex(0,1)*sph8.phi).real;
angley8=exp(Complex(0,1)*sph8.theta).imag*exp(Complex(0,1)*sph8.phi).real;
anglez8=exp(Complex(0,1)*sph8.phi).imag;

	pan1=Cartesian(anglex1,angley1,anglez1);
	pan2=Cartesian(anglex2,angley2,anglez2);
	pan3=Cartesian(anglex3,angley3,anglez3);
	pan4=Cartesian(anglex4,angley4,anglez4);
	pan5=Cartesian(anglex5,angley5,anglez5);
	pan6=Cartesian(anglex6,angley6,anglez6);
	pan7=Cartesian(anglex7,angley7,anglez7);
	pan8=Cartesian(anglex8,angley8,anglez8);


Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rl),~b.bufnum,pan1.theta.raddeg,pan1.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig2rl),~b.bufnum,pan2.theta.raddeg,pan2.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig3rl),~b.bufnum,pan3.theta.raddeg,pan3.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig4rl),~b.bufnum,pan4.theta.raddeg,pan4.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig5rl),~b.bufnum,pan5.theta.raddeg,pan5.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig6rl),~b.bufnum,pan6.theta.raddeg,pan6.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig7rl),~b.bufnum,pan7.theta.raddeg,pan7.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig8rl),~b.bufnum,pan8.theta.raddeg,pan8.phi.raddeg,spread));

Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rr),~b.bufnum,pan1.theta.raddeg,pan1.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig2rr),~b.bufnum,pan2.theta.raddeg,pan2.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig3rr),~b.bufnum,pan3.theta.raddeg,pan3.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig4rr),~b.bufnum,pan4.theta.raddeg,pan4.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig5rr),~b.bufnum,pan5.theta.raddeg,pan5.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig6rr),~b.bufnum,pan6.theta.raddeg,pan6.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig7rr),~b.bufnum,pan7.theta.raddeg,pan7.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig8rr),~b.bufnum,pan8.theta.raddeg,pan8.phi.raddeg,spread));

}).add;
)




(
Synth(\re);
//s.record(numChannels:8,duration:(8*60));
)


////////////////diffusion on array of pints
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

	8.do{
azimuth=8.collect{
			az1 = (az1+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
		   el1 = (el1+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

//	mag1=(mag1+(1-(1/1.6180339887499))).wrap(0,1);
sph1=(Spherical(mag1,(az1+angle).wrap(pi.neg,pi),(el1+angle).wrap((pi/2).neg,(pi/2)))).theta.round(0.000000000001);

	};

elevation=8.collect{
				az2 = (az2+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el2 = (el2+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

	//mag2=(mag2+(1-(1/1.6180339887499))).wrap(0,1);
		sph2=(Spherical(mag2,(az2+angle).wrap(pi.neg,pi),(el2+angle).wrap((pi/2).neg,(pi/2)))).phi.round(0.000000000001);

	};

magnitudex=	8.collect{
			az3 = (az3+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el3 = (el3+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

	//mag3=(mag3+(1-(1/1.6180339887499))).wrap(0,1);
	sph3=(Spherical(mag3,(az3+angle).wrap(pi.neg,pi),(el3+angle).wrap((pi/2).neg,(pi/2))));

	 mag_x=((Complex(cos((sph3.theta.round(0.000000000001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.000000000001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

				};

magnitudey=	8.collect{
			az4 = (az4+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
				el4 = (el4+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

	//mag4=(mag4+(1-(1/1.6180339887499))).wrap(0,1);
	sph4=(Spherical(mag4,(az4+angle).wrap(pi.neg,pi),(el4+angle).wrap((pi/2).neg,(pi/2))));

		 mag_y=((Complex(sin((sph4.theta.round(0.000000000001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.000000000001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		 (Complex(cos((sph4.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
				};


qx=	8.collect{
			az5 = (az5+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el5 = (el5+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

		//mag5=(mag5+(1-(1/1.6180339887499))).wrap(0,1);
	sph5=(Spherical(mag5,(az5+angle).wrap(pi.neg,pi),(el5+angle).wrap((pi/2).neg,(pi/2))));


mag_qx=((((Complex(cos(((sph5.theta.round(0.000000000001))*mq).wrap(pi.neg,pi)),
cos(((sph5.theta.round(0.000000000001))*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph5.phi.round(0.000000000001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph5.phi.round(0.000000000001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph5.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))),
cos((sph5.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);
				};


qy=	8.collect{
			az6 = (az6+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el6 = (el6+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

	//mag6=(mag6+(1-(1/1.6180339887499))).wrap(0,1);
	sph6=(Spherical(mag6,(az6+angle).wrap(pi.neg,pi),(el6+angle).wrap((pi/2).neg,(pi/2))));

 mag_qy=((((Complex(sin(((sph6.theta.round(0.000000000001))*mq).wrap(pi.neg,pi)),
sin(((sph6.theta.round(0.000000000001))*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph6.phi.round(0.000000000001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph6.phi.round(0.000000000001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph6.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))),
cos((sph6.phi.round(0.000000000001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);
				};


magnitudez=	8.collect{
			az7 = (az7+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
			el7 = (el7+(pi-(pi/silver_r))).wrap((pi/2).neg,(pi/2));

//mag7=(mag7+(1-(1/1.6180339887499))).wrap(0,1);
sph7=(Spherical(mag7,(az7+angle).wrap(pi.neg,pi),(el7+angle).wrap((pi/2).neg,(pi/2))));

//if(
//m_z.even,
mag_z=(Complex(sin((sph7.phi.round(0.000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph7.phi.round(0.000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
			//,
//mag_z=(Complex(sin((sph7.phi.round(0.000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph7.phi.round(0.000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho(2.sqrt)).pow(spread);
			//);
////z axis   ambi..  sin for odd numbers, cos for even
				};

angle=(angle+(2pi-(2pi/silver_r))).wrap(pi.neg,pi);
~az=~az++azimuth;~el=~el++elevation;
~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;
~qx=~qx++qx;~qy=~qy++qy;
		az1=0;el1=0;az2=0;el2=0;az3=0;el3=0;
		az4=0;el4=0;az5=0;el5=0;az6=0;el6=0;az7=0;el7=0;
	}
}.value;
)

(
			{
var steps =64;

~nVals = steps.collect { |i|
    i.linexp(0, steps-1, 0.18, 256).round
};
			~nVals.asInteger;
			}.value;
		)

(
SynthDef.new(\re, {
	var chain1rl, chain1rr;
    var sig1rl,sig1rr;
    var sph1,sph2;
	var anglex1,angley1,anglez1,anglex2,angley2,anglez2;
	var frames=~frames,silver=45,golden=45,g=((1+5.sqrt)/2),s=(1+2.sqrt);
	var in1,in2,chain1,chain2,spread=74;
	var az1,el1,az2,el2;
	var pan1,pan2,n=0;

     in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in2);


	64.do{

		chain1rl = chain1.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[n], tobin: ~nVals.[n], zeroothers: 1);

chain1rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[n], tobin: ~nVals.[n], zeroothers: 1);

	sig1rl=IFFT(chain1rl);
sig1rr=IFFT(chain1rr);

			az1=LFNoise1.ar(0.1).range(pi,pi.neg);
	el1=LFNoise1.ar(0.1).range((pi/2),(pi/2).neg);
	az2=LFNoise1.ar(0.1).range(pi,pi.neg);
	el2=LFNoise1.ar(0.1).range((pi/2),(pi/2).neg);

		sph1=Spherical(1,(~az.[n]+az1).wrap(pi.neg,pi),(~el.[n]+el1).wrap((pi/2).neg,(pi/2)));
		sph2=Spherical(1,(~az.[n]+az2).wrap(pi.neg,pi),(~el.[n]+el2).wrap((pi/2).neg,(pi/2)));

anglex1=exp(Complex(0,1)*sph1.theta).real*exp(Complex(0,1)*sph1.phi).real;
angley1=exp(Complex(0,1)*sph1.theta).imag*exp(Complex(0,1)*sph1.phi).real;
anglez1=exp(Complex(0,1)*sph1.phi).imag;
anglex2=exp(Complex(0,1)*sph2.theta).real*exp(Complex(0,1)*sph2.phi).real;
angley2=exp(Complex(0,1)*sph2.theta).imag*exp(Complex(0,1)*sph2.phi).real;
anglez2=exp(Complex(0,1)*sph2.phi).imag;

	pan1=Cartesian(anglex1,angley1,anglez1);
	pan2=Cartesian(anglex2,angley2,anglez2);

Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rl),~b.bufnum,pan1.theta.raddeg,pan1.phi.raddeg,spread));

Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rr),~b.bufnum,pan2.theta.raddeg,pan2.phi.raddeg,spread));

		n=n+1;
	};

}).add;
)




(
Synth(\re);
//s.record(numChannels:8,duration:(8*60));
)