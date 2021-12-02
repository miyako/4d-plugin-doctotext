# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

### Remarks for build

* get [wv2-0.4.2](https://sourceforge.net/projects/wvware/files/wv2/) on sourceforge.net
  * remove check for modern iconv in cmakelists.txt.

* get [libcharsetdetect](https://github.com/batterseapower/libcharsetdetect)

* `2.1.0.8` from [TidyHuang/WV2](https://github.com/TidyHuang/WV2) compiles with unix make files but creates small library with no 3rd party dependencies.
