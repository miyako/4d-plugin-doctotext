If (Form event code:C388=On Selection Change:K2:29)
	
	Form:C1466.text:=""
	OBJECT SET RGB COLORS:C628(*;"Input";Foreground color:K23:1;Background color none:K23:10)
	
	C_OBJECT:C1216($file)
	
	$file:=Form:C1466.file
	
	If ($file#Null:C1517)
		
		$options:=New object:C1471("format";$file.file.extension;"fallback";True:C214)
		
		ARRAY BLOB:C1222($attachments;0)
		$status:=DocToText ($file.file.getContent();$options;$attachments)
		
		If ($status.success)
			Form:C1466.text:=$status.text
			OBJECT SET RGB COLORS:C628(*;"Input";Foreground color:K23:1;Background color:K23:2)
		End if 
	End if 
	
End if 