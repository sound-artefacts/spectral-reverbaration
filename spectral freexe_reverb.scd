(
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*32;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 4;
//s.makeGui(w);
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
~fftsize = 64*32;
///bin width= samplerate/fft size (frames) ,  44100/1024
//center freq= bin index * bin width
///fft size= power of two
///bin frequency= (index*sample rate)/ fft size
/// bin number  eg
///(44100/1024)*463
);

s.waitForBoot{
~r = Buffer.readChannel(s,"/Users/amimid/Documents/cosmography/untitled folder/marine.wav", channels:[0]); ////signal buffer

/////panning and reverb room
(
~azimuth=[45.degrad,135.neg.degrad,45.neg.degrad,135.degrad];
~elevation=[35.264390.neg.degrad,35.264390.neg.degrad,35.264390.degrad,35.264390.degrad];
);

/////vbap
(
~vbap = VBAPSpeakerArray .new(3,
[[~azimuth.[0],~elevation.[0]], [~azimuth.[1],~elevation.[1]], [~azimuth.[2],~elevation.[2]], [~azimuth.[3],~elevation.[3]]]);
~vbap_buf = Buffer.loadCollection(s, ~vbap.getSetsAndMatrices);
);

/////fft bin exponential diffusion compensation
//(44100/2048)*900
(
~bins=180;
{
var steps = ~bins;
~nVals = steps.collect { |i|
i.linexp(0, steps-1, 0.18, 900).round};
~nVals.asInteger;}.value;
);

(
SynthDef.new(\verb, {
arg spread,room=1,mix=0;
var chaindry,chainwet;
var frames=~fftsize, polytope, sig, in, chain, chain1,bins,reverfb,env,gate,dry,decay,chain11;
var g=((1+5.sqrt)/2),s=(1+2.sqrt),az=0,el=0,n=0,verb,material_m,material_p,threshold,chainn;

bins=~bins;
 in = PlayBuf.ar(1, ~r.bufnum, BufRateScale.kr(~r.bufnum), loop: 0, doneAction:0);
chaindry = FFT(LocalBuf(frames), in);
chainwet =  FFT(LocalBuf(frames), in);

~bins.do{

az = (az+(2pi-(2pi/s))).wrap(pi.neg,pi);
el = (el+(pi-(pi/s))).wrap(0.5pi.neg,0.5pi);
polytope=Spherical(1,az,el);

material_p=Complex(1,polytope.x).theta*4;          ////reflection materiality
material_m=polytope.rho;
threshold=(polytope.rho*room)*mix;           /////trigger reflection threshold

chain11 = chaindry.pvcollect(frames,
{|mag, phase, index| [mag, phase]; }, frombin: ~nVals.[n], tobin: ~nVals.[n], zeroothers: 1);

dry=IFFT(chain11);                                ///dry signal
gate=(Amplitude.kr(dry,mul:n.reciprocal*10000)-threshold);           ///trigger for spectral freeze and reverb decay envelope
decay=(polytope.rho*room.linlin(0,1,1,0))*mix;
env=Decay2.kr(gate,0.01, decay) * mix;


chain1 = PV_Freeze(chainwet.pvcollect(frames,
{|mag, phase, index| [mag, phase]; }, frombin: ~nVals.[n], tobin: ~nVals.[n], zeroothers: 1),gate);

verb=IFFT(chain1);      ///spectral freeze on reflection

		sig=(verb*mix)+(dry*mix.linlin(0,1,1,0));

		Out.ar(0,Pan2.ar(sig,polytope.x,spread));
//Out.ar(0,VBAP.ar(4,sig*0.01,~vbap_buf.bufnum,polytope.theta.raddeg,polytope.phi.raddeg,spread));

n=n+1;
}
}).add;
)}
)

	(
~synth=Synth.new(\verb,[\spread,0.05,\room,20,\mix,1]);
//s.record(numChannels:4,duration:(1*60)+60)
)

	~synth.set(\room,0.000000000001,\mix,1);