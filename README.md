Fontex
------

Fontex is a tool that extracts fonts from CSS [@font-face](http://www.w3schools.com/cssref/css3_pr_font-face_rule.asp) rules. Fonts are extracted into files named after their attributes and written to the current directory.

    Usage: $ fontex file.css
       or: $ fontex http://example.com/fonts.css [html-headers]
       or: $ fontex http://example.com [html-headers]

Fontex is written in Ruby and is known to work on the version shown below:

    ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-linux]

It can be given either a local path to a CSS file or a URL. If given a URL, it can be to a CSS file
or to a HTML web page that loads CSS files. In the latter case, Fontex will crawl all such CSS files.

When given a URL, it can be proceded by HTML headers in the form name=value and space-separated if
more than one are to be given. For example:

    $ fontex http:/www.example.com referer=http:/www.example.com

Fontex uses the [open_uri_redirections](https://rubygems.org/gems/open_uri_redirections) gem to support redirections from HTTP to HTTPS. You need to install this gem before starting Fontex. You can, however, use Fontex without it, albeit without its ability to follow such redirections. To do this, comment out the `require 'open_uri_redirections'` statement in the `fontex` source code.

### API usage

To use Fontex inside another Ruby program, `require` to gain a `decode` method:

    require 'fontex'
    decode(dir,args)

which will decode fonts specified by the `args` array and write them to `dir`. The args array should contain arguments as described above. For an example of this use, see the tests described below.

### Tests

Some RSpec tests are provided in the `spec` directory. To run them:

    $ cd spec
    $ rspec fontex_spec.rb

To facilitate testing, a small number of embedded fonts are supplied in the `spec/css` directory purely for the purpose of testing Fontex. These have been obtained from publicly accessible web-sites for the sole purpose of testing. They are not supplied for use on other web-sites without being licensed.

### Sample viewer

A small static web site can display fonts decoded by Fontex. In its current state it takes all its parameters from variables set within the file and, in this default state, it displays the fonts used by the abovementioned rspec tests. To build the webserver, which exercises Fontex to produce font files:

    $ cd sample
    $ ./build

This builds a static site (in a subdirectory called `site`) that can be launched with a basic web werver like WEBRick:

    $ ruby -run -e httpd site -p 8000

### Issues

Fontex relies heavily on regular expressions and these can be quite brittle. Passing an HTML page containing lots of CSS can present difficulties to the Regex engine, causing Fontex to run for a very long time or appear to hang. Should this happen, manually extract the required CSS URLs and run against those directly.

The regular expressions work for all sites and content exercised by the tests. There are probably sites out there that won't work.

Any improvements to the regular expressions to mitigate these problems would be very welcome. See *Contributing*, below.

### Disclaimer

Fontex was written in a few hours to scratch an itch. It isn't polished or presented in such a way that is intended to be useful to anyone else. That said, if you do find it useful, great. Just don't expect anything wonderful!

### License

Fontex, with the exception of the fonts in the test suite, is published under the MIT Licence. Please read the LICENCE file.

### Contributing

Any contributions are welcome. Should you wish to do so, please fork the repo, make changes and include a new rspec test. Then, once all tests pass, issue a pull request.

---
