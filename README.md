# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

### Remarks for build

* get [wv2-0.4.2](https://sourceforge.net/projects/wvware/files/wv2/) on sourceforge.net
  * remove check for modern iconv in cmakelists.txt.

* get [libcharsetdetect](https://github.com/batterseapower/libcharsetdetect)

* change `AbstractOLEStorage` to `OLEStorage` in `thread_safe_ole_storage.h` 
* 
* change `AbstractOLEStreamReader` to `OLEStreamReader` in `thread_safe_ole_stream_reader.h`

* get [mimetic](http://www.codesink.org/mimetic_mime_library.html)
  * change in `mmfile.cxx`  from `if(m_beg > 0)` to `if(m_beg != NULL)`
  
* `2.1.0.8` from [TidyHuang/WV2](https://github.com/TidyHuang/WV2) compiles with unix make files but creates small library with no 3rd party dependencies. also error on arm. probably need to rerun automake or something.
