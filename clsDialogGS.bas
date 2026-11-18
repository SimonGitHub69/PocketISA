B4A=true
Group=Default Group\Classi
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mParent As B4XView
	Private pnlOverlay As B4XView
	Private Risposta As Int
	Private Chiuso As Boolean
End Sub

Public Sub Initialize(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub ShowYesNo(Msg As String) As ResumableSub
	
	Risposta = xui.DialogResponse_Cancel
	Chiuso = False
	
	pnlOverlay = xui.CreatePanel("")
	pnlOverlay.Color = xui.Color_ARGB(170, 0, 0, 0)
	mParent.AddView(pnlOverlay, 0, 0, mParent.Width, mParent.Height)
	
	Dim box As B4XView = xui.CreatePanel("")
	box.Color = Colors.White
	box.SetColorAndBorder( Colors.White, 2dip, Colors.LightGray, 20dip)
	pnlOverlay.AddView(box, 10dip, 18%y, mParent.Width - 20dip, 280dip)
	
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = Msg
	lbl.TextSize = 28
	lbl.TextColor = Colors.Black
	lbl.Gravity = Gravity.CENTER
	box.AddView(lbl, 10dip, 20dip, box.Width - 20dip, 140dip)
	
	Dim btnSi As Label
	btnSi.Initialize("btnSiGS")
	btnSi.Text = "SI"
	btnSi.TextSize = 22
	btnSi.TextColor = Colors.White
	btnSi.Gravity = Gravity.CENTER
	btnSi.Color = xui.Color_RGB(33,150,243)
	box.AddView(btnSi, 35dip, 190dip, 140dip, 55dip)
	
	Dim btnNo As Label
	btnNo.Initialize("btnNoGS")
	btnNo.Text = "NO"
	btnNo.TextSize = 22
	btnNo.TextColor = Colors.White
	btnNo.Gravity = Gravity.CENTER
	btnNo.Color = xui.Color_RGB(150,150,150)
	box.AddView(btnNo, box.Width - 175dip, 190dip, 140dip, 55dip)
	
	Do While Chiuso = False
		Sleep(50)
	Loop
	
	Return Risposta
	
End Sub

Private Sub btnSiGS_Click
	Risposta = xui.DialogResponse_Positive
	Chiudi
End Sub

Private Sub btnNoGS_Click
	Risposta = xui.DialogResponse_Negative
	Chiudi
End Sub

Private Sub Chiudi
	Chiuso = True
	If pnlOverlay.IsInitialized Then pnlOverlay.RemoveViewFromParent
End Sub