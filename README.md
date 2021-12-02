# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

### Remarks for build

* get [wv2-0.4.2](https://sourceforge.net/projects/wvware/files/wv2/) on sourceforge.net
  * remove check for modern iconv in cmakelists.txt.

* get [libcharsetdetect](https://github.com/batterseapower/libcharsetdetect)

* get [htmlcxx](http://htmlcxx.sourceforge.net)

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
