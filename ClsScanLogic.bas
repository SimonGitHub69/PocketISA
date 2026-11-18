B4A=true
Group=Default Group\GS_General
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
B4A=True
ModulesStructureVersion=1
Type=Class
Version=13.4
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Public Sub GestisciBarcode(Code As Object, TypeCode As Object)
	Dim sCode As String = "" & Code
	Dim sType As String = "" & TypeCode

	Log("ClsScanLogic -> Code: " & sCode)
	Log("ClsScanLogic -> Type: " & sType)

	CallSubDelayed3(RigheDoc_Florenzi, "AfficheCAB", sCode, sType)
	CallSubDelayed3(ServiceScan, "GestisciBarcode", sCode, sType)
End Sub

Public Sub DeviceConstructeur As String
	Dim Ref As Reflector
	Return Ref.GetStaticField("android.os.Build", "MANUFACTURER")
End Sub

Public Sub DeviceModele As String
	Dim Ref As Reflector
	Return Ref.GetStaticField("android.os.Build", "MODEL")
End Sub
