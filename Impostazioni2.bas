B4A=true
Group=Default Group\General
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Switch1 As Switch
	Private Switch2 As Switch
	Private Switch3 As Switch
	Private Switch4 As Switch
	Private lblTitolo As Label
	Private SwiftButton4 As SwiftButton
	Private Label15 As Label
	Private Label16 As Label
	Private Label17 As Label
	Private Label18 As Label
	Private Label19 As Label
	Private Label20 As Label
	Private Label21 As Label
	Private EditText14 As EditText
	Private EditText15 As EditText
	Private EditText16 As EditText
	Private pnlFooter As Panel
	Private btnFooterSalva As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	If(FirstTime) Then
		
	End If
	Activity.LoadLayout("Impostazioni2")

	' =========================
	' LABEL IN TESTA (FUORI SCROLL)
	' =========================
	lblTitolo.Initialize("")
	lblTitolo.Text = "IMPOSTAZIONI"
	lblTitolo.TextSize = 20
	lblTitolo.TextColor = Colors.White
	lblTitolo.Color = Colors.RGB(33, 150, 243)
	lblTitolo.Gravity = Gravity.CENTER
	Activity.AddView(lblTitolo, 0dip, 0dip, 100%x, 30dip)
	
	' =========================
	' LABEL INSERIMENTO SEQUENZIALE (SWITCH)
	' =========================
	Label15.Initialize("")
	Label15.Text = "Inserimento Sequenziale"
	Label15.TextSize = 13
	Label15.TextColor = Colors.Black
	Label15.Color = Colors.LightGray
	Label15.Gravity = Gravity.LEFT
	Label15.Gravity = Gravity.CENTER_VERTICAL
	Label15.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label15, 10dip, 8%y, 75%x, 30dip)	
	Switch1.SetLayout(72%x, 8%y, 80dip, 30dip)
	Switch1.Color=Colors.RGB(140,175,140)
		
	' =========================
	' LABEL Gestione Immagini (SWITCH)
	' =========================
	Label16.Initialize("")
	Label16.Text = "Gestione Immagini"
	Label16.TextSize = 13
	Label16.TextColor = Colors.Black
	Label16.Color = Colors.LightGray
	Label16.Gravity = Gravity.LEFT
	Label16.Gravity = Gravity.CENTER_VERTICAL
	Label16.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label16, 10dip, 15%y, 75%x, 30dip)
	Switch2.SetLayout(72%x, 15%y, 80dip, 30dip)
	Switch2.Color=Colors.RGB(140,175,140)
	
	' =========================
	' LABEL Quantità 1 (default)
	' =========================
	Label17.Initialize("")
	Label17.Text = "Quantità 1 (default)"
	Label17.TextSize = 13
	Label17.TextColor = Colors.Black
	Label17.Color = Colors.LightGray
	Label17.Gravity = Gravity.LEFT
	Label17.Gravity = Gravity.CENTER_VERTICAL
	Label17.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label17, 10dip, 22%y, 75%x, 30dip)
	Switch3.SetLayout(72%x, 22%y, 80dip, 30dip)
	Switch3.Color=Colors.RGB(140,175,140)
	
	' =========================
	' LABEL Quantità 1 (default)
	' =========================
	Label18.Initialize("")
	Label18.Text = "Modalità SPP"
	Label18.TextSize = 13
	Label18.TextColor = Colors.Black
	Label18.Color = Colors.LightGray
	Label18.Gravity = Gravity.LEFT
	Label18.Gravity = Gravity.CENTER_VERTICAL
	Label18.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label18, 10dip, 29%y, 75%x, 30dip)
	Switch4.SetLayout(72%x, 29%y, 80dip, 30dip)
	Switch4.Color=Colors.RGB(140,175,140)
		
	' =========================
	' LABEL Altezza Griglia Inserimento (dip)
	' =========================
	Label19.Initialize("")
	Label19.Text = "Altezza Griglia Inserimento (dip)"
	Label19.TextSize = 13
	Label19.TextColor = Colors.Black
	Label19.Color = Colors.LightGray
	Label19.Gravity = Gravity.LEFT
	Label19.Gravity = Gravity.CENTER_VERTICAL
	Label19.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label19, 10dip, 36%y, 75%x, 30dip)
	EditText14.Initialize("EditText14")
	EditText14.TextSize = 13
	EditText14.TextColor = Colors.Black    
	EditText14.Gravity = Bit.Or(Gravity.RIGHT, Gravity.BOTTOM)
	EditText14.Text = Main.AltRiga
	Activity.AddView(EditText14, 82%x, 33%y, 50dip, 50dip)
			
	' =========================
	' LABEL Larghezza Griglia Descrizione (dip)
	' =========================
	Label20.Initialize("")
	Label20.Text = "Larghezza Griglia Descrizione (dip)"
	Label20.TextSize = 13
	Label20.TextColor = Colors.Black
	Label20.Color = Colors.LightGray
	Label20.Gravity = Gravity.LEFT
	Label20.Gravity = Gravity.CENTER_VERTICAL
	Label20.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label20, 10dip, 43%y, 75%x, 30dip)
	EditText15.Initialize("EditText15")
	EditText15.TextSize = 13
	EditText15.TextColor = Colors.Black
	EditText15.Gravity = Bit.Or(Gravity.RIGHT, Gravity.BOTTOM)
	EditText15.Text = Main.LargDescRiga
	Activity.AddView(EditText15, 82%x, 40%y, 50dip, 50dip)
		
	' =========================
	' LABEL Path Immagini ../..
	' =========================
	Label21.Initialize("")
	Label21.Text = "Path Immagini ../.."
	Label21.TextSize = 13
	Label21.TextColor = Colors.Black
	Label21.Color = Colors.LightGray
	Label21.Gravity = Gravity.LEFT
	Label21.Gravity = Gravity.CENTER_VERTICAL
	Label21.Padding = Array As Int(5dip,0,0,0)
	Activity.AddView(Label21, 10dip, 50%y, 93%x, 30dip)
	EditText16.Initialize("EditText16")
	EditText16.TextSize = 13
	EditText16.TextColor = Colors.Black
	EditText16.Gravity = Bit.Or(Gravity.LEFT, Gravity.BOTTOM)
	EditText16.Text = Main.PathImages
	Activity.AddView(EditText16, 10dip, 55%y, 94%x, 50dip)
		
	If (Main.SwitchRepeatAdd = 1) Then
		Switch1.Checked = True
	Else
		Switch1.Checked = False
	End If
	If (Main.SwitchImages = 1) Then
		Switch2.Checked = True
	Else
		Switch2.Checked = False
	End If
	If (Main.SwitchQtaDefault = 1) Then
		Switch3.Checked = True
	Else
		Switch3.Checked = False
	End If
	If (Main.SwitchMode_SPP = 1) Then
		Switch4.Checked = True
	Else
		Switch4.Checked = False
	End If
	StileBottoneParametri
End Sub

Sub Activity_Resume
	StileBottoneParametri
End Sub

' Freccia blu grande, come su Clienti e Listini (terzo slot, in basso a destra).
Private Sub StileBottoneParametri
	Try
		Dim margin As Int = 6dip
		Dim gap As Int = 6dip
		Dim barH As Int = 58dip
		Dim topBtn As Int = 100%y - barH
		If topBtn < 0 Then topBtn = 0

		If pnlFooter.IsInitialized = False Then
			pnlFooter.Initialize("")
			Activity.AddView(pnlFooter, 0, topBtn, 100%x, barH)
			btnFooterSalva.Initialize("btnFooterSalva")
			pnlFooter.AddView(btnFooterSalva, 0, 0, 10dip, 10dip)
		End If

		pnlFooter.SetLayout(0, topBtn, 100%x, barH)
		pnlFooter.Color = Colors.White
		pnlFooter.Visible = True

		Dim slotW As Int = (pnlFooter.Width - margin * 2 - gap * 2) / 3
		If slotW < 40dip Then slotW = 40dip
		btnFooterSalva.SetLayout(margin + (slotW + gap) * 2, 4dip, slotW, barH - 8dip)
		btnFooterSalva.Typeface = Typeface.FONTAWESOME
		btnFooterSalva.Text = Chr(0xF061)
		btnFooterSalva.TextSize = 26
		btnFooterSalva.TextColor = Colors.White
		btnFooterSalva.Color = Colors.RGB(25, 118, 210)
		btnFooterSalva.Gravity = Gravity.CENTER
		btnFooterSalva.Enabled = True
		btnFooterSalva.Visible = True
		pnlFooter.BringToFront

		If SwiftButton4.IsInitialized Then
			If SwiftButton4.mBase.IsInitialized Then SwiftButton4.mBase.Visible = False
		End If
	Catch
		Log("StileBottoneParametri: " & LastException)
	End Try
End Sub

Sub btnFooterSalva_Click
	Activity.Finish
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Switch1_CheckedChange(Checked As Boolean)
	If(Checked) Then
		Main.SwitchRepeatAdd = 1
	Else
		Main.SwitchRepeatAdd = 0
	End If
End Sub

Sub Switch2_CheckedChange(Checked As Boolean)
	If(Checked) Then
		Main.SwitchImages = 1
	Else
		Main.SwitchImages = 0
	End If
End Sub

Sub Switch3_CheckedChange(Checked As Boolean)
	If(Checked) Then
		Main.SwitchQtaDefault = 1
	Else
		Main.SwitchQtaDefault = 0
	End If
End Sub

Sub Switch4_CheckedChange(Checked As Boolean)
	If(Checked) Then
		Main.SwitchMode_SPP = 1
	Else
		Main.SwitchMode_SPP = 0
	End If
End Sub

Private Sub SwiftButton4_Click
	Activity.Finish
End Sub

Sub EditText14_TextChanged (Old As String, New As String)
	Main.AltRiga = New
	#IF DEBUG
		Log("Altezza grid: " & New)
	#End If
End Sub

Sub EditText15_TextChanged(Old As String, New As String)
	Main.LargDescRiga = New
	#IF DEBUG
		Log("Larghezza desc. grid: " & New)
	#End If
End Sub

Sub EditText16_TextChanged(Old As String, New As String)
	Main.PathImages = New
	#IF DEBUG
		Log("Path Immagini: " & New)
	#End If
End Sub
