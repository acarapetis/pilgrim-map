#!/usr/bin/perl

use strict;
use warnings;

use Image::Magick;

my @COLORS = map {[ map { $_ / 256 } @$_ ]} (
    [10,137,244],    # trampoline / dark blue
    [180,177,17],    # swamp / olive
    [163,237,253],   # cross / light blue
    [0,0,0],
    [0,0,0],
    [253,169,3],     # bridge / orange
    [223,58,58],     # shrapnel / red
    [0,0,0],
    [150,223,17],    # shrubbery / green
    [154,100,220],   # castle / purple
    [111,131,147],   # bedrock / grey
);

binmode STDOUT;

my $img = Image::Magick->new(size=>'160x160');
$img->ReadImage('canvas:white');

my $data;
{
    undef local $/;
    $data = <>;
}

while ($data =~ /\cF.(\d+),(\d+),(\d+),-?\d+,-?\d+/g) {
    my $x = $2 // next;
    my $y = $3 // next;
    my $c = $1 // next;
    $img->SetPixel(x => $x, y => $y, color => $COLORS[$c]);
}

$img->Write('png:-');
exit;
