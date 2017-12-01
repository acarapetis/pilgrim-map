# pilgrim-map
Simple map renderer for starseed pilgrim saves.

This is the CLI script version, requires ImageMagick for Perl 5.

CGI version is hosted at http://a.carapetis.com/pilgrim/


### Usage
Reads save file from STDIN or file given as argument, writes PNG map to STDOUT.

    ./sspmap_cli.pl <sample.save >map.png

### Options
There is currently one option: you can scale up the image (by a clean integer factor). For example, to scale up from 160x160 to 640x640:

    ./sspmap_cli.pl --scale 4 sample.sav > map.png
