



(
{
    var w, x, y, z, p;

	w=(InFeedback.ar(3)+InFeedback.ar(4)++InFeedback.ar(5))/2.sqrt;

	x=InFeedback.ar(3);

	y=InFeedback.ar(4);

	z=InFeedback.ar(5);

    // B-format decode to stereo with speakers at different distances
    BFDecode1.ar1(w, x, y, z, [0.degrad, 90.degrad], 0,4 );

}.scope(2);
)


//manual
///weights can be cartesian
(
{
    var w, x, y, z;
    var left, right;

    #w, x, y, z = SoundIn.ar([0,1,2,3]);

    left  = w + 0.5*x + 0.5*y + 0.2*z;
    right = w + 0.5*x - 0.5*y + 0.2*z;

    [left, right] * 0.5
}.play;
)