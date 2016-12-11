# ICU Demo

This is a simple program demonstrating how to build and statically link [ICU](http://site.icu-project.org/).

To build, simply run `make`. This should work on macOS and Linux. There is also a `Dockerfile` provided, if you want to do the build in a Linux container.

The resulting `demo` program produces the following output:

```
Original:  Das Kind überquerte die Straße.
Uppercase: DAS KIND ÜBERQUERTE DIE STRASSE.
```

This demo is released into the public domain. ICU is distributed by the Unicode Consortium under its own [license](http://www.unicode.org/copyright.html#License).
