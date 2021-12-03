# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

### Abstact

the goal of this project is to support legacy Microsoft Word documents with the `.doc` file extension.

* import

`wv2`, the successor to `wv`, can load and parse Word 2000, 97, 95 and 6 file formats. it depends on `zlib`, `libgsf`, `libbz2`, `libxml2`, `libiconv` and `glib`, which in turns depends on `libffi`  and `libpcre`.

`doctotext` is a document converter that uses `wv2` to import `.doc` files. additionally it uses `libcharsetdetect`, `htmlcxx`, `libmimetic`, `minizip` to support other input formats. the outout format is always plain text.

### Dependencies

* [libwv2](https://sourceforge.net/projects/wvware/files/wv2/)
* [libcharsetdetect](https://github.com/batterseapower/libcharsetdetect)
* [htmlcxx](http://htmlcxx.sourceforge.net)
  
### Features

extract plain text from various file types:

* PARSER_AUTO
* PARSER_RTF
* PARSER_ODF_OOXML
* PARSER_XLS
* PARSER_DOC
* PARSER_PPT
* PARSER_HTML
* PARSER_IWORK
* PARSER_XLSB
* PARSER_PDF
* PARSER_TXT
* PARSER_EML
* PARSER_ODFXML
