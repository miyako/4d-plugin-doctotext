If (Form event code:C388=On Load:K2:1)
	
	$files:=Folder:C1567(fk resources folder:K87:11).files(fk ignore invisible:K87:22)
	
	Form:C1466.files:=New collection:C1472
	
	For each ($file;$files)
		
		GET DOCUMENT ICON:C700($file.platformPath;$icon)
		Form:C1466.files.push(New object:C1471(\
			"icon";$icon;\
			"file";$file))
		
	End for each 
	
End if 