# User guide

This tool is designed to compose already prepared images and maybe any texts to collage.

You may need it if you have to make poster or collage, have ImageMagick installed, more familiar with terminal than with PowerPoint and don't want to write html.

### Installation:

Download binary version from `bin` on [Github](https://github.com/viviag/postermaker) and copy it to `~/.local/bin`.

Or if you have Haskell ecosystem on the computer and fear binary is out of date you can run
```
stack install
```

### Usage notes:

All parameters of image should be stored in two `.csv` files. (coords - left upper corner of image on the collage)
See examples: [images config](https://github.com/viviag/postermaker/blob/master/examples/images.csv), [texts config](https://github.com/viviag/postermaker/blob/master/examples/texts.csv)

Header is required. It is subject to change.

Texts are always on the foreground.

And if you want to change layout you can reorder fields in CSV files - first entry will be deepest.

See example generated with data from above:
![Result](https://github.com/viviag/postermaker/blob/master/examples/githask.png)

### Usage:

Everything is said in help message. To reproduce run
```
postermaker -h
```
If `--images` or `--texts` option is missing it will only miss images or texts.
```
Create poster or collage based on options and given mappings.
Coords and colors in mappings are formatted as x-y and r-g-b correspondingly.
Uses ImageMagick inside.

Usage: postermaker [-f|--format FORMAT] (-n|--name NAME) [-c|--color COLOR]
                   (-s|--size SIZE) [-i|--images IMAGES] [-t|--texts TEXTS]

Available options:
  -h,--help                Show this help text
  -f,--format FORMAT       Format in which to write output image. PNG by
                           default.
  -n,--name NAME           Name of resulting image.
  -c,--color COLOR         Background color in "(r,g,b)" format. White by
                           default.
  -s,--size SIZE           Image size in "(x,y)" format.
  -i,--images IMAGES       Path to images configuration file. ./images.csv by
                           default.
  -t,--texts TEXTS         Path to texts configuration file. ./texts.csv by
                           default.

```
