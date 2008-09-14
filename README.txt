= Apalo Toolkit

* http://apalo.netcorex.org (Project page)
* http://github.com/rubiojr/apalo (Code)
* http://rubiojr.lighthouseapp.com/projects/16913-apalo/overview (Bug tracker)

== DESCRIPTION:

Apache Logs Toolkit

== FEATURES

 * Analyzes apache log files (combined format and combined+vhost format)
   presenting useful reports
 * Modular, easily extended
 * Multiple output formats (stdout, pdf, html, ...) [TODO]
 * Multiple analyzers included (basic, ...) [TODO, only one ATM]

== PROBLEMS

* Early, buggy, mostly untested code
* Some of the code is pretty lame and slow (Especialy analyzers)

== SYNOPSIS:

* Library and tools to analyze Apache log files

== REQUIREMENTS:

* Installing from gem should pull all the requirementes
* Oniguruma Regexp Library is optional buy highly recommended. 
  It's waaaay faster than the current regexp engine in ruby1.8.
  Apalo performance is much better if oniguruma is present.


== LICENSE:

(The MIT License)

Copyright (c) 2008 Sergio Rubio <sergio@rubio.name>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
