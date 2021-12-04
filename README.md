![version](https://img.shields.io/badge/version-18%2B-EB8E5F)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-doctotext)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-doctotext/total)

# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

<img width="797" alt="ss" src="https://user-images.githubusercontent.com/1725068/144632527-14f2e26d-db2c-45d8-860e-a677092a8602.png">

### Abstract

the goal of this project is to support legacy Microsoft Word documents with the `.doc` file extension.

* [`wv`](https://sourceforge.net/projects/wvware/files/wv/) can load and parse Word 2000, 97, 95 and 6 file formats. 

* [`wvware`](http://wvware.sourceforge.net) is a document converter that uses `wv` to import `.doc` files. the outout format includes `.rtf`, `.txt`, `.tex`, `.pdf` or `.html`. see [unofficial mirror](https://github.com/remram44/wvware).

* [`abiword`](http://www.abisource.com) is a word processor that uses `wv` to import `.doc` files. it has a command line interface and server mode, similar to OpenOffice, that can be uses as a document converter. `wvware` deprecated its own suite of converters in favour of `abiword`.

* [`wv2`](https://sourceforge.net/projects/wvware/files/wv2/) is the successor to `wv`. it depends on `zlib`, `libgsf`, `libbz2`, `libxml2`, `libiconv` and `glib`, which in turns depends on `libffi`  and `libpcre`.

* [`doctotext`](http://silvercoders.com/en/products/doctotext/) is a document converter that uses `wv2` to import `.doc` files. additionally it uses [`libcharsetdetect`](https://github.com/batterseapower/libcharsetdetect), [`htmlcxx`](http://htmlcxx.sourceforge.net), `libmimetic`, `minizip` to support other input formats. the outout format is always plain text.
  
* [`pthread-win32`](https://github.com/GerHobbelt/pthread-win32) nuget might not work, need to compile from source. 
  
### Features

extract plain text from various file types:

### Syntax

```4d
status:=DocToText (document;options;attachments)
```

Parameter|Type|Description
------------|------|----
document|BLOB|
options|Object|see below
attachments|Array BLOB|
status|Object|

#### Options

Property|Type|Description
------------|------|----
xml | Text |`parse` (default) `fix` `strip` 
table | Text | `table` (default) `row` `col` 
url | Text | `underscored` (default) `text` `extended` 
list | Text |` * ` (default) or any string
verbose | Boolean |`false` (default)
fallback | Boolean |`false` (default)
format | Text | `.doc` (default) `.rtf` `.docx` `.pptx` `.xlsx` `.fodt` `.fods` `.fodp` `.fodg` `.odt` `.ods` `.odp` `.odg` `.ppt` `.xls` `.xlsb` `.pages` `.numbers` `.key` `.html` `.pdf` `.eml`
