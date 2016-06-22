# Challenge Description

[Dithering](https://en.wikipedia.org/wiki/Dither) is the intentional use of
noise to reduce the error of compression. If you start with a color image
and want to reduce it to two colors (black and white) the naive approach is
to threshold the image. However, the results are usually terrible.

* [Color Solids](http://i.imgur.com/kjWn2Q1.png)
* [Thresholded Solids](http://i.imgur.com/RDOMCfg.png)

One of the most popular dithering algorithms is
[Floyd-Steinberg](https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering).
When a pixel is thresholded, the error (difference) between the original value
and the converted value is carried forward into nearby pixels.

* [Floyd-Steinberg Solids](http://i.imgur.com/w9DFOKS.png)

There are other approaches, such as
[Ordered Dithering](https://en.wikipedia.org/wiki/Ordered_dithering) with a
Bayer Matrix.

* [Bayer solids](http://i.imgur.com/mLKUyfn.png)

## Input Description

Your program will take a color or grayscale image as its input. You may choose
your input method appropriate to your language of choice. If you want to do it
yourself, I suggest picking a [Netpbm](https://en.wikipedia.org/wiki/Netpbm)
format, which is easy to read.

## Output Description

Output a two-color (e.g. Black and White) dithered image in your choice of
format. Again, you could output a Netpbm image which is easy to write.

## Notes

* [Here](http://www.tannerhelland.com/4660/dithering-eleven-algorithms-source-code/)
  is a good resource for dithering algorithms.
