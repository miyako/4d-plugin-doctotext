![version](https://img.shields.io/badge/version-18%2B-EB8E5F)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-doctotext)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-doctotext/total)

### Dependencies and Licensing

* the source code of this plugin developed using the [4D Plug-in SDK](https://github.com/4d/4D-Plugin-SDK) is licensed under the MIT license.
* see [SILVERCODERS](https://silvercoders.com/en/products/doctotext/) for the licensing of **DocToText** (GPLv2 or commercial).
* the licensing of the binary product of this plugin is subject to the licensing of all its dependencies.

# 4d-plugin-doctotext

4D implementation of [DocToText](https://silvercoders.com/en/products/doctotext/). The plugin has one command, [DocToText](#doctotext), that takes the content of a document as a `Blob` and returns an `Object` with the plain text, the hyperlinks found in the document, its metadata (author, dates, page and word counts) and, for e-mail messages, the attachments as an `ARRAY BLOB`. The parsing runs in-process in the DocToText C++ library and its dependencies (`wv2` for legacy Word files, `htmlcxx`, `mimetic`, `libcharsetdetect`, `minizip`, `libxml2`). No external converter or Office installation is used.

<img width="797" alt="ss" src="https://user-images.githubusercontent.com/1725068/144632527-14f2e26d-db2c-45d8-860e-a677092a8602.png">

Command | Returns | Purpose
---|---|---
[DocToText](#doctotext) | `Object` | Extract plain text, links, metadata and e-mail attachments from a document

**Platforms:** macOS (universal: Apple silicon and Intel), Windows (64-bit)

[Releases](https://github.com/miyako/4d-plugin-doctotext/releases)

---

## Requirements & platform notes

* **macOS**: the build targets macOS 11.5 or later. Some prebuilt arm64 library objects (`htmlcxx`, `mimetic`) were compiled for macOS 12.0, so on Apple silicon assume macOS 12 or later.
* **Windows**: 64-bit 4D only.
* **The document is a `Blob`, not a path.** Read the file into a blob first, for example with `$file.getContent()`. The test method `TEST_all` in this repository still passes `$file.platformPath`, which does not match the current command.
* **The format is not detected by default.** Without `format` in the options, the document is parsed as a Word 97–2003 `.doc`. Set `format` to the file extension, or set `fallback` to `True` so that DocToText detects the format from the content when the selected parser fails.
* **All three parameters are mandatory.** Pass an `Object` (it can be empty) as the second parameter and an `ARRAY BLOB` variable as the third, even when you don't expect attachments.
* **Failure is reported in the result, not as a 4D error.** Check `success` before you read `text`.
* **Thread-safe.** The command is declared thread-safe and can be called from a preemptive process.

---

## DocToText

### Syntax

```4d
status:=DocToText(document; options; attachments)
```

Parameter | Type | Description
---|---|---
`document` | `Blob` | Content of the document to convert
`options` | `Object` | Parsing options, see [Options](#options). Can be an empty object
`attachments` | `ARRAY BLOB` | Receives the attachments of an e-mail message. Replaced on every call
Result | `Object` | Status object, see [Result object](#result-object)

### Description

`DocToText` parses the blob with the parser selected by `options.format` and returns the plain text as `Text`.

The command always returns an object. When the blob is empty, or when the parser fails, `success` is `False` and there is no `text`. Metadata is read in a separate pass, so `meta` can be present even when `success` is `False`.

Only the e-mail parser (`.eml`) produces attachments. The command replaces the content of the array you pass, whatever it held before; after the call the array holds only the attachments of this document.

**Array indexing:** the first attachment is stored in element **0** of the array, the second in element 1, and so on, and the `data` property of each attachment holds its element number. For a message with one attachment, `Size of array` returns `0` and the blob is in `$attachments{0}`. Always read an attachment with `$attachments{$attachment.data}`, as in the e-mail example below.

### Options

Property | Type | Description
---|---|---
`format` | `Text` | Parser to use, given as a file extension with the leading dot, see the table below. Default, and for any value not in the table: `.doc`
`fallback` | `Boolean` | `True`: if the selected parser fails, DocToText detects the format from the content and tries again. Default `False`
`xml` | `Text` | How malformed XML is handled in XML-based formats: `parse` (default, strict), `fix` (try to repair it), `strip` (drop the markup, keep the text)
`table` | `Text` | Table layout in the text: `table` (default: cells separated by tabs, one line per row), `row` (all cells on one line, separated by spaces), `col` (one cell per line)
`url` | `Text` | How a hyperlink appears in the text: `underscored` (default: `_link_text_`, spaces replaced by `_`), `text` (link text only), `extended` (`<url>link text`)
`list` | `Text` | Prefix written before each list item. Default `" * "`
`verbose` | `Boolean` | `True`: the library writes diagnostic messages to the standard error stream of the 4D application, which 4D code can't read. Default `False`

`format` is compared exactly: use lower case and include the dot. A 4D `File` object's `extension` property already has that form (`".docx"`).

`format` | Parser
---|---
`.doc` | Word 97–2003, and earlier Word versions read by `wv2`
`.docx` `.xlsx` `.pptx` `.odt` `.ods` `.odp` `.odg` | Office Open XML and OpenDocument (zip-based)
`.fodt` `.fods` `.fodp` `.fodg` | Flat OpenDocument XML
`.rtf` | Rich Text Format
`.xls` | Excel 97–2003
`.xlsb` | Excel binary workbook
`.ppt` | PowerPoint 97–2003
`.pages` `.numbers` `.key` | Apple iWork (zip-based)
`.html` | HTML
`.pdf` | PDF (text layer only, no OCR)
`.eml` | E-mail message (MIME), with attachments

There is no `format` value for plain text files (`.txt`). With `fallback` set to `True`, the content detection may still select the text parser.

**`table` = `col`** only works in builds made after 1.3.0. In 1.3.0 and earlier, `col` was ignored and the default `table` layout was used.

### Result object

Property | Type | Description
---|---|---
`success` | `Boolean` | `True` if the text was extracted
`text` | `Text` | The plain text. Only when `success` is `True`
`links` | `Collection` | Hyperlinks found in the document, see below. Only when `success` is `True` (can be empty)
`attachments` | `Collection` | Attachments of an e-mail message, see below. Only when `success` is `True` (empty for other formats)
`meta` | `Object` | Document metadata, see below. Only when metadata could be read
`error` | `Text` | Message of an unexpected exception raised while parsing. Only in builds made after 1.3.0; earlier versions returned no result in that case

Each element of `links`:

Property | Type | Description
---|---|---
`url` | `Text` | Target of the link
`text` | `Text` | Link text
`position` | `Number` | Position of the link in `text`, as the length of the text before it. Inferred from the library: counted in UTF-8 bytes, so it differs from a 4D character position when the preceding text has non-ASCII characters

Each element of `attachments`:

Property | Type | Description
---|---|---
`name` | `Text` | File name of the attachment, as given in the message
`data` | `Number` | Element number of the attachment's blob in the `attachments` array
`fields` | `Object` | MIME header fields of the part as text, such as `Content-Type`, `Content-Disposition`, `Content-Description`, `Content-ID`

`meta` object:

Property | Type | Description
---|---|---
`author` | `Text` | Author
`lastModifiedBy` | `Text` | Last author
`creationDate` | `Text` | Creation date as `YYYY-MM-DD HH:MM:SS`, or `""` if unknown
`lastModificationDate` | `Text` | Last modification date, same format
`pageCount` | `Number` | Number of pages
`wordCount` | `Number` | Number of words
`authorType`, `lastModifiedByType`, `lastModificationDateType`, `pageCountType`, `wordCountType` | `Number` | How the matching value was obtained: `0` not available, `1` read from the document, `2` estimated

There is no `creationDateType`; test `creationDate` for `""` instead.

### Example

From the plugin's own test form (`test/Project/Sources/Forms/TEST/ObjectMethods/lb.files.4dm`):

```4d
If (Form event code:C388=On Selection Change:K2:29)
	
	Form:C1466.text:=""
	OBJECT SET RGB COLORS:C628(*; "Input"; Foreground color:K23:1; Background color none:K23:10)
	
	C_OBJECT:C1216($file)
	
	$file:=Form:C1466.file
	
	If ($file#Null:C1517)
		
		$options:=New object:C1471("format"; $file.file.extension; "fallback"; True:C214)
		
		ARRAY BLOB:C1222($attachments; 0)
		var $blob : Blob
		$blob:=$file.file.getContent()
		$status:=DocToText($blob; $options; $attachments)
		
		If ($status.success)
			Form:C1466.text:=$status.text
			OBJECT SET RGB COLORS:C628(*; "Input"; Foreground color:K23:1; Background color:K23:2)
		End if 
	End if 
	
End if
```

From the plugin's own test method (`test/Project/Sources/Methods/TEST_ja.4dm`), a Japanese Word 97 document:

```4d
$file:=Folder:C1567(fk resources folder:K87:11).file("12-20_REST_WebService_w_4D1.doc")

$options:=New object:C1471("format";$file.extension)

ARRAY BLOB:C1222($attachments;0)
$status:=DocToText ($file.getContent();$options;$attachments)
If ($status.success)
	ALERT:C41($status.text)
Else 
	TRACE:C157
End if
```

A spreadsheet, one cell per line, links as plain text:

```4d
var $file : 4D.File
var $options; $status; $link : Object

$file:=Folder(fk resources folder).file("report.xlsx")
$options:=New object("format"; ".xlsx"; "table"; "col"; "url"; "text")

ARRAY BLOB($attachments; 0)
$status:=DocToText($file.getContent(); $options; $attachments)

If ($status.success)
	For each ($link; $status.links)
		// $link.url, $link.text, $link.position
	End for each 
End if
```

An e-mail message with attachments:

```4d
var $file : 4D.File
var $status; $attachment : Object

$file:=Folder(fk resources folder).file("message.eml")

ARRAY BLOB($attachments; 0)
$status:=DocToText($file.getContent(); New object("format"; ".eml"); $attachments)

If ($status.success)
	For each ($attachment; $status.attachments)
		// the blob is at the element number given by "data" (the first attachment is element 0)
		BLOB TO DOCUMENT(Folder(fk desktop folder).file($attachment.name).platformPath; $attachments{$attachment.data})
	End for each 
End if
```

The attachment `name` comes from the message itself: check it before you use it as a file name.

---

## Error handling & troubleshooting

* **`success` is `False` for a valid document**: `format` is missing or wrong, so the default `.doc` parser was used. Pass the extension with the dot (`".docx"`, not `"docx"` or `".DOCX"`), or add `"fallback"; True`.
* **`text` is empty although `success` is `True`**: the document has no extractable text, for example a scanned PDF without a text layer. It also happens when the extracted text is not valid UTF-8: the whole value is then returned as `""`. In builds made after 1.3.0 this is also the case on Windows, where invalid bytes used to become U+FFFD.
* **`error` is present**: the library raised an exception; `success` is `False` and the message comes from the library.
* **One attachment but `Size of array` is `0`**: attachments start at element 0. Use the `data` property as the index.
* **The attachments array was emptied**: the third parameter is replaced on every call, even for formats that have no attachments.
* **`meta` is missing**: the library could not read metadata for this format or document.
* **A link `position` doesn't match `Position`**: `position` is a byte offset in the UTF-8 text (inferred), not a character position.

---

## Quick reference

```4d
ARRAY BLOB($attachments; 0)
$status:=DocToText($file.getContent(); New object("format"; $file.extension; "fallback"; True); $attachments)
If ($status.success)
	$text:=$status.text  // plain text
	$links:=$status.links  // [{url; text; position}]
	$meta:=$status.meta  // {author; creationDate; pageCount; ...}
	// e-mail: $attachments{$status.attachments[0].data}
End if
```

---

## Background

the goal of this project is to support legacy Microsoft Word documents with the `.doc` file extension.

* [`wv`](https://sourceforge.net/projects/wvware/files/wv/) can load and parse Word 2000, 97, 95 and 6 file formats. 

* [`wvware`](http://wvware.sourceforge.net) is a document converter that uses `wv` to import `.doc` files. the outout format includes `.rtf`, `.txt`, `.tex`, `.pdf` or `.html`. see [unofficial mirror](https://github.com/remram44/wvware).

* [`abiword`](http://www.abisource.com) is a word processor that uses `wv` to import `.doc` files. it has a command line interface and server mode, similar to OpenOffice, that can be uses as a document converter. `wvware` deprecated its own suite of converters in favour of `abiword`.

* [`wv2`](https://sourceforge.net/projects/wvware/files/wv2/) is the successor to `wv`. it depends on `zlib`, `libgsf`, `libbz2`, `libxml2`, `libiconv` and `glib`, which in turns depends on `libffi`  and `libpcre`.

* [`doctotext`](http://silvercoders.com/en/products/doctotext/) is a document converter that uses `wv2` to import `.doc` files. additionally it uses [`libcharsetdetect`](https://github.com/batterseapower/libcharsetdetect), [`htmlcxx`](http://htmlcxx.sourceforge.net), `libmimetic`, `minizip` to support other input formats. the outout format is always plain text.
  
* [`pthread-win32`](https://github.com/GerHobbelt/pthread-win32) nuget might not work, need to compile from source. 
