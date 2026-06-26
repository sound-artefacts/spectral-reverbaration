/////////
c1 = +X
c2 = -X
c3 = +Y
c4 = -Y
c5 = +Z
c6 = -Z

W = ( +X + -X + +Y + -Y + +Z + -Z ) / 6
X = ( +X - -X ) / 2
Y = ( +Y - -Y ) / 2
Z = ( +Z - -Z ) / 2

/////

~c1 = Buffer.readChannel(s,"file.aiff",channels:0); // +X
~c2 = Buffer.readChannel(s,"file.aiff",channels:1); // -X
~c3 = Buffer.readChannel(s,"file.aiff",channels:2); // +Y
~c4 = Buffer.readChannel(s,"file.aiff",channels:3); // -Y
~c5 = Buffer.readChannel(s,"file.aiff",channels:4); // +Z
~c6 = Buffer.readChannel(s,"file.aiff",channels:5); // -Z

(
{
	var xp, xn, yp, yn, zp, zn;
	var W,X,Y,Z;

	xp = PlayBuf.ar(1, ~c1, BufRateScale.kr(~c1));
	xn = PlayBuf.ar(1, ~c2, BufRateScale.kr(~c2));
	yp = PlayBuf.ar(1, ~c3, BufRateScale.kr(~c3));
	yn = PlayBuf.ar(1, ~c4, BufRateScale.kr(~c4));
	zp = PlayBuf.ar(1, ~c5, BufRateScale.kr(~c5));
	zn = PlayBuf.ar(1, ~c6, BufRateScale.kr(~c6));

	W = (xp + xn + yp + yn + zp + zn) / 6;
	X = (xp - xn) / 2;
	Y = (yp - yn) / 2;
	Z = (zp - zn) / 2;

	Out.ar(0,[W,X,Y,Z]);
}.play;
)