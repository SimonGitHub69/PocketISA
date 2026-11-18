B4A=true
Group=Default Group\Classi
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private md As MessageDigest
	Private bc As ByteConverter
End Sub

Public Sub Initialize
End Sub

Public Sub Hash(Testo As String) As String
	Dim data() As Byte = bc.StringToBytes(Testo, "UTF8")
	Dim digest() As Byte = md.GetMessageDigest(data, "MD5")
	Return bc.HexFromBytes(digest).ToLowerCase
End Sub
