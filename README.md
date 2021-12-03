# 4d-plugin-doctotext
4D implementation of [DocToText](http://silvercoders.com/en/products/doctotext/).

### Abstact

the goal of this project is to support legacy Microsoft Word documents with the `.doc` file extension.

* [`wv`](https://sourceforge.net/projects/wvware/files/wv/) can load and parse Word 2000, 97, 95 and 6 file formats. 

* [`wvware`](http://wvware.sourceforge.net) is a document converter that uses `wv` to import `.doc` files. the outout format includes `.rtf`, `.txt`, `.tex`, `.pdf` or `.html`. see [unofficial mirror](https://github.com/remram44/wvware).

* [`abiword`](http://www.abisource.com) is a word processor that uses `wv` to import `.doc` files. it has a command line interface and server mode, similar to OpenOffice, that can be uses as a document converter. `wvware` deprecated its own suite of converters in favour of `abiword`.

* [`wv2`](https://sourceforge.net/projects/wvware/files/wv2/) is the successor to `wv`. it depends on `zlib`, `libgsf`, `libbz2`, `libxml2`, `libiconv` and `glib`, which in turns depends on `libffi`  and `libpcre`.

* [`doctotext`](http://silvercoders.com/en/products/doctotext/) is a document converter that uses `wv2` to import `.doc` files. additionally it uses [`libcharsetdetect`](https://github.com/batterseapower/libcharsetdetect), [`htmlcxx`](http://htmlcxx.sourceforge.net), `libmimetic`, `minizip` to support other input formats. the outout format is always plain text.
  
### Features

extract plain text from various file types:

### Syntax

```4d
status:=DocToText (path;options;attachments)
```
<div class="grid">
  <div class="syntax-th cell cell--2">Parameter</div>
  <div class="syntax-th cell cell--2">Type</div>
  <div class="syntax-th cell cell--8">Description</div>
  <div class="syntax-td cell cell--2">path</div>
  <div class="syntax-td cell cell--2">TEXT</div>
  <div class="syntax-td cell cell--8">platform path</div>        
  <div class="syntax-td cell cell--2">options</div>
  <div class="syntax-td cell cell--2">OBJECT</div>
  <div class="syntax-td cell cell--8"></div>      
  <div class="syntax-td cell cell--2">attachments</div>
  <div class="syntax-td cell cell--2">ARRAY BLOB</div>
  <div class="syntax-td cell cell--8"></div>        
  <div class="syntax-td cell cell--2">status</div>
  <div class="syntax-td cell cell--2">OBJECT</div>
  <div class="syntax-td cell cell--8"></div>          
</div>

#### Options

Property|Type|Description
------------|------|----
xml | Text | `fix` `strip` `parse` (default)
table | Text | `row` `col` `table` (default)
url | Text | `text` `extended` `underscored` (default)
list | Text | any string or ` * ` (default)
verbose | Boolean |
format | Text | `.doc` (default) `.rtf` `.docx` `.pptx` `.xlsx` `.fodt` `.fods` `.fodp` `.fodg` `.odt` `.ods` `.odp` `.odg` `.ppt` `.xls` `.xlsb` `.pages` `.numbers` `.key` `.html` `.pdf` `.eml`
