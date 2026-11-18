B4A=true
Group=Default Group\General
ModulesStructureVersion=1
Type=Activity
Version=11
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	Dim Panel1 As Panel
	Dim Canvas1 As Canvas
	Dim SD As SignatureData 'This object holds the data required for SignatureCapture
	Private Label1 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("Signature")
	Canvas1.Initialize(Panel1)	
	SD.Initialize
	SD.Canvas = Canvas1
	SD.Panel = Panel1
	SD.SignatureColor = Colors.Black
	SD.SignatureWidth = 5dip 'Stroke width
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub
Sub Panel1_Touch (Action As Int, X As Float, Y As Float)
	SignatureCapture.Panel_Touch(SD, x, y, Action)
End Sub
Sub btnSave_Click
	'SignatureCapture.Save(SD, File.DirRootExternal, "sign.png")
	'ToastMessageShow("Firma salvata : " & File.Combine(File.DirRootExternal, "sign.png"), False)
	ToastMessageShow("Firma salvata!", False)
	'The Next line will load the image And set it As the Activity background.
	'Activity.SetBackgroundImage(LoadBitmap(File.DirRootExternal, "sign.png"))
	Activity.finish
End Sub
Sub btnClear_Click
	SignatureCapture.Clear(SD)
End Sub