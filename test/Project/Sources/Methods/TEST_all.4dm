//%attributes = {}
$files:=Folder:C1567(fk resources folder:K87:11).files(fk ignore invisible:K87:22)

For each ($file;$files)
	
	$options:=New object:C1471("format";$file.extension)
	
	ARRAY BLOB:C1222($attachments;0)
	$status:=DocToText ($file.platformPath;$options;$attachments)
	If ($status.success)
		  //ALERT($status.text)
	Else 
		TRACE:C157
	End if 
	
End for each 