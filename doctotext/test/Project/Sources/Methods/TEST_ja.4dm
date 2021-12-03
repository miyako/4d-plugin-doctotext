//%attributes = {}
$file:=Folder:C1567(fk resources folder:K87:11).file("12-20_REST_WebService_w_4D1.doc")

$options:=New object:C1471("format";$file.extension)

ARRAY BLOB:C1222($attachments;0)
$status:=DocToText ($file.getContent();$options;$attachments)
If ($status.success)
	ALERT:C41($status.text)
Else 
	TRACE:C157
End if 