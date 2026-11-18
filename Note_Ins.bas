B4A=true
Group=Default Group\Carbon
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
	Public Const CLR_HEADER As Int = 0xFFEFEFEF
	Public Const CLR_EVEN   As Int = 0xFFFFFFFF
	Public Const CLR_ODD    As Int = 0xFFF6F7F9
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private xui As XUI
	Private Label1 As Label
	Private EditText1 As EditText
	Private ime As IME
	Private btnScoppio As Button
	Private btnPerdita As Button
	Private btnAltro As Button
	Private CLV1 As CustomListView
	Private btnOK As Button
	Private Panel1 As Panel
	Private btnSave As Button
	Private SwiftButton5 As SwiftButton ' occhio di controllo
End Sub

' ====== Librerie da spuntare ======
' - XUI Views (per xui)
' - CustomListView
' - SQL (se usi la parte DB)

Sub Activity_Create(FirstTime As Boolean)
	Dim DescStatoSacco As String = ""
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
			SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
		Else
			MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
		End If
	End If
	' Do not forget to load the layout file created with the visual designer. For example:		
	Activity.LoadLayout("Note_Ins")
	Sleep(0)
	If (Starter.UltimoProc<=3000) Then
		btnPerdita.Enabled = False
		btnScoppio.Enabled = False
		btnAltro.Enabled = False
		btnOK.Enabled = False
		Panel1.Visible = False		
	Else
		If(Starter.UltimoProc=9999) Then ' fine ciclo			
			btnPerdita.Enabled = False
			btnScoppio.Enabled = False
			btnAltro.Enabled = False
			btnOK.Enabled = False
			Panel1.Visible = False
			btnSave.Enabled = False
		Else
			btnPerdita.Enabled = True
			btnScoppio.Enabled = True
			btnAltro.Enabled = True
			btnOK.Enabled = True
			EditText1.Enabled = True
			EditText1.Visible = True
			Panel1.Visible = True
		End If
	End If
	EditText1.Text=""
	If (Starter.StatoSacco<>Null) Then
		If(Starter.StatoSacco<>"") Then 
			Select Starter.StatoSacco
				Case "S"
					DescStatoSacco = "Scoppiato"
					btnScoppio.TextColor=Colors.Red
				Case "P"
					DescStatoSacco = "Perdita"
					btnPerdita.TextColor=Colors.Magenta
				Case "A"
					DescStatoSacco = "Altro"
					btnAltro.TextColor=Colors.Yellow	
				Case "K"
					DescStatoSacco = "OK"
					btnOK.TextColor=Colors.Green
				Case "X"
					DescStatoSacco = "Scollegato"
					btnOK.TextColor=Colors.black
					btnPerdita.Enabled = False
					btnScoppio.Enabled = False
					btnAltro.Enabled = False
					btnOK.Enabled = False
					Panel1.Visible = False
					btnSave.Enabled = False
				Case Else
					DescStatoSacco = "ERR"
			End Select
			Label1.Text = "TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & DescStatoSacco
		Else
			Label1.Text = Starter.Parametro2 & " - TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & Starter.StatoSacco
		End If
	End If
	ime.Initialize("")
	CLV1.Clear
	Load_processi_FromDB(Starter.Parametro2,Starter.NumTubo,Starter.MD5_Comp)
	EditText1.RequestFocus
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Activity_Resume

End Sub

' =====================
'   CARICAMENTO DA DB
' =====================
Private Sub Load_processi_FromDB(codautoclave As String, ntubo As Int, MD5_Comp As  String)
	Try
		CLV1.Clear
		CLV1.Add(CreateRowPanel(True, Array As String("Processo","Ora","S","Note")), "")
		' Esempio query: adatta a tua tabella
		Dim q As String = "SELECT PROCESSO, substr(DATAORA_INIZIO, 12, 8) AS ORA, STATO, IFNULL(NOTE,'') AS NOTE FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND MD5_Comp = ? AND IFNULL(TRASMESSO,0)=0 ORDER BY DATAORA_INIZIO, PROCESSO"
        Dim c As Cursor 
		c = SQLDataAccess.ExecQuery2(q, Array As String(codautoclave,ntubo,MD5_Comp))
        For i = 0 To c.RowCount - 1
            c.Position = i
           ' Dim pos As String = i+1
            Dim cod As String = Leggi_array_Processi(c.GetInt("PROCESSO"))
            Dim des As String = c.GetString("ORA")
			Dim stato As String = c.GetString("STATO")
			If(stato = Null) Then
				stato = ""
			Else
				If(stato = "K") Then
					stato = "ok"
				End If
				If(stato = "C") Then
					stato = ""
				End If
			End If			
			Dim note As String = c.GetString("NOTE")
			If(note = Null) Then
				note = ""
			End If
            Dim p As B4XView = CreateRowPanel(False, Array As String(cod, des,stato, note))
            p.Color = IIf(i Mod 2 = 0, CLR_EVEN, CLR_ODD)
			If(cod = "Ctr. Press.") And (stato="") Then
				' niente
			Else
				If(cod = "Ctr. Ciclo") And (stato="") Then
					' niente
				Else
					CLV1.Add(p, Array As String(cod, des, stato, note))
				End If
			End If            	
        Next
        c.Close
    Catch
        Log(LastException)
        ToastMessageShow("Errore caricamento dati.", False)
    End Try
End Sub

' =========================================
'   COSTRUZIONE RIGA (Header o Riga Dati)
' =========================================
Private Sub CreateRowPanel(IsHeader As Boolean, values() As String) As B4XView
    ' Layout riga: 48dip di altezza
    Dim p As B4XView = xui.CreatePanel("")
    p.SetLayoutAnimated(0, 0, 0, 100%x, 20dip)
    p.Color = IIf(IsHeader, CLR_HEADER, Colors.Transparent)

    ' Colonne (percentuali)
    Dim colW() As Float = Array As Float(0.25, 0.22, 0.10, 0.43)   ' 14% - 26% - 30% - 30%
    Dim x As Int = 0
    For i = 0 To 3 ' Min(values.Length - 1, 2)
        Dim w As Int = Round(100%x * colW(i))
        Dim L As Label
        L.Initialize("")
        L.Text = values(i)
        L.TextSize = IIf(IsHeader, 16, 15)
        L.TextColor = Colors.Black
        L.Gravity = Bit.Or(Gravity.LEFT, IIf(i=3, Gravity.LEFT, Gravity.CENTER)) ' descrizione allineata a sinistra
        L.Typeface = IIf(IsHeader, Typeface.DEFAULT_BOLD, Typeface.DEFAULT)
        p.AddView(L, x + 8dip, 0, w - 16dip, p.Height)
        x = x + w
    Next

    ' separatore inferiore (righe più definite)
    If IsHeader = False Then
        Dim line As Panel
        line.Initialize("")
        line.Color = 0xFFDDDDDD
        p.AddView(line, 0, p.Height - 1dip, p.Width, 1dip) 
    End If

    Return p
End Sub

Sub btnSave_Click
	' ToastMessageShow("Note salvate!", False)
	' The next line will load the image and set it as the activity background.	
	If(Starter.StatoSacco = "A") And (EditText1.Text.Trim="") Then ' Note
		ExtraUtility.Play_Sound("error.wav")
		MsgboxAsync("Nessuna nota è stata inserita.","ERRORE INSERIMENTO")
	Else
		If(Starter.StatoSacco <> "") Then
			Starter.RegScheda = True
			Starter.Parametro4 = EditText1.Text
			ime.HideKeyboard
			Activity.finish
		Else
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Nessun evento è stato selezionato.","ERRORE INSERIMENTO")
		End If
	End If
End Sub

Sub btnClear_Click
	Activity.Finish
End Sub

Sub Leggi_array_Processi(index As Int) As String
	Try
		Dim npos As Int
		npos = index / 1000
		Dim arr_Processi() As String = Array As String("", "Iniz. Caric.","Fine Caric." ,"Iniz. Press.", "Ctr. Press.", "Int. Press.","Fine Press.","Iniz. Ciclo","Ctr. Ciclo","Int. Ciclo","Fine Ciclo")
		Return arr_Processi(npos)
	Catch
		Return 0
		Log(LastException)
	End Try
End Sub

Private Sub btnOK_Click
	Starter.StatoSacco = "K"	' ok
	EditText1.Text = ""
	Label1.Text = "TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & ChangeColor_Stato("K")
End Sub

Private Sub btnPerdita_Click
	Starter.StatoSacco = "P"	' perdita sacco
	EditText1.Text = ""
	Label1.Text = "TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & ChangeColor_Stato("P")
End Sub

Private Sub btnScoppio_Click
	Starter.StatoSacco = "S"	' scoppio sacco
	EditText1.Text = ""
	Label1.Text = "TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & ChangeColor_Stato("S")
End Sub

Private Sub btnAltro_Click
	Starter.StatoSacco = "A"	' altro
	EditText1.Text = ""
	Label1.Text = "TUBO: " & Starter.NumTubo & " - " & Leggi_array_Processi(Starter.UltimoProc) & " - " & ChangeColor_Stato("A")
End Sub

Private Sub ChangeColor_Stato(stato As String) As String
	Dim DescStatoSacco As String
	Select Case stato
		Case "S"			
			DescStatoSacco = "Scoppio"
			btnScoppio.TextColor=Colors.Red
			btnPerdita.TextColor=Colors.Black
			btnAltro.TextColor=Colors.Black
			btnOK.TextColor=Colors.Black
		Case "P"
			DescStatoSacco = "Perdita"
			btnScoppio.TextColor=Colors.black
			btnPerdita.TextColor=Colors.Yellow
			btnAltro.TextColor=Colors.Black
			btnOK.TextColor=Colors.Black
		Case "A"
			DescStatoSacco = "Altro"
			btnScoppio.TextColor=Colors.Black
			btnPerdita.TextColor=Colors.Black
			btnAltro.TextColor=Colors.White
			btnOK.TextColor=Colors.Black
		Case "K"
			DescStatoSacco = "OK"
			btnScoppio.TextColor=Colors.Black
			btnPerdita.TextColor=Colors.Black
			btnAltro.TextColor=Colors.Black
			btnOK.TextColor=Colors.Green
		Case "X"
			DescStatoSacco = "Scollegato"
			btnScoppio.TextColor=Colors.Black
			btnPerdita.TextColor=Colors.Black
			btnAltro.TextColor=Colors.Black
			btnOK.TextColor=Colors.black
	End Select
	Return DescStatoSacco
End Sub

Private Sub Leggi_Ultimo_proc_Tubo(CodAutoclave As String, nTubo As Int, UltProc As Int) As Double
	Try
		Dim UltProcTubo As Double
		Dim Cursor3 As Cursor
		Select Case UltProc
			Case 4000
				Cursor3 = SQLDataAccess.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO BETWEEN 4000 AND 4999 ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo))
			Case 8000
				Cursor3 = SQLDataAccess.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO BETWEEN 8000 AND 8999 ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo))				
			Case Else
				Cursor3 = SQLDataAccess.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO = ? ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo,UltProc))
		End Select				
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			UltProcTubo = Cursor3.GetDouble("PROCESSO")
		Else
			UltProcTubo = UltProc
		End If
		Cursor3.Close
		Return UltProcTubo
	Catch
		Log(LastException)
		Return 0
	End Try
	
End Sub