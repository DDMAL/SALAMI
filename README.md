SALAMI resources
================

This repository contains some helpful auxilliary files related to the [SALAMI project](http://ddmal.music.mcgill.ca/salami).

Contents include:

* A Ruby script that parses the annotations and generates separate lowercase, uppercase and function labels from each annotation: *get_sections_sept_2012.rb*
* A Ruby script that runs the above command on all the SALAMI annotations: *parse_annotations_shell.rb*
* A Matlab function to load parsed annotations: *annotation_getfile.m*
* A Python script that downloads mp3s of all the publically available music annotated by SALAMI (i.e., all the music taken from the Internet Archive): *SALAMI_download.py*

All files (unless otherwise specified—e.g., see *SALAMI_download.py*) are released under the MIT License, outlined below.


The MIT License (MIT)
---------------------

Copyright (c) 2013 DDMAL

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.