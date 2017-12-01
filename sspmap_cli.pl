#!/usr/bin/perl
# vim: syntax=perl

use strict;
use warnings;

use Image::Magick;
use Getopt::Long;

my $scale = 1;
GetOptions ('scale=i' => \$scale);

if ($scale < 1 or $scale > 5) {
    die "Scale $scale not supported: must be in [1,5]";
}

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
    [0,0,0],         # pilgrimage entrance
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
    if ($1 < 0 or $1 > $#COLORS) {
        warn "Unknown color $1";
        next;
    }
    $img->SetPixel(x => $2, y => $3, color => $COLORS[$1]);
}

if ($scale > 1) {
    my $size = 160 * $scale;
    $img->Resize(width => $size, height => $size, filter => 'Point');
}

$img->Write('png:-');
exit;
