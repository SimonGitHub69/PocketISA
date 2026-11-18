B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

'Public Sub GestisciBarcode(Code As String, TypeCode As String)
'	Log("ScanLogic -> Code: " & Code)
'	Log("ScanLogic -> Type: " & TypeCode)
'End Sub

Public Sub DeviceConstructeur As String
	Dim Ref As Reflector
	Return Ref.GetStaticField("android.os.Build", "MANUFACTURER")
End Sub

Public Sub DeviceModele As String
	Dim Ref As Reflector
	Return Ref.GetStaticField("android.os.Build", "MODEL")
End Sub

Public Sub GestisciBarcode(Code As String, TypeCode As String)
	Log("Elaboro: " & Code)

	CallSubDelayed3(Main, "AfficheCAB", Code, TypeCode)
End Sub
