B4A=true
Group=Default Group\General
ModulesStructureVersion=1
Type=Activity
Version=9.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public xui As XUI
	Public SQLDataAccess As SQL
	Public vCodice As String
	Public vDescrizione As String
	Public vTipoTab As Int ' Tipo tabella (1 = CliFor, 2 = Listino )
	Public vTipoDocNew As String
	Public vNumDocNew As Int
	Public vEsercizioNew As Int
	Public vNumRifDoc As String
	Public vDataDocNew As String
	Public vDataRifDoc As String
	Public vOperazione As String
	Public vRagSoc As String
	Public vValuta As String
	Public vCodCliFor As String
	Public vNumListino As Int
	Public vNumListinoNew As Int
	Public vDescListino As String
	Public vNoteDoc As String
	Public vCodNegozio As String
End Sub
Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private Label1 As Label
	Private Label2 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label7 As Label
	Private Label9 As Label
	Private Label6 As Label
	Private Label8 As Label
	Private Label9 As Label
	Private Label10 As Label
	Private Label11 As Label
	Private ComboBoxTipoDoc As B4XComboBox
	Private ListTipoDoc As List
	Private ListValute As List
   '	Private B4XTable1 As B4XTable
	Private Label3 As Label
	Private arr_TipoDoc() As String
	Private List_TipoDoc_Desc As List
	Private List_TipoDoc_TipoCliFor As List
	Private EditText1 As EditText
	Private Label10 As Label
	Private Label12 As Label
	Private Label11 As Label
	Private btnDate As SwiftButton
	Private btnDate2 As SwiftButton
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private SwiftButton3 As SwiftButton
	Private sqlstr As String
	Private ComboBoxValuta As B4XComboBox	
	Private Panel1 As Panel
	Private B4XTable1 As B4XTable
End Sub

Sub Activity_Create(FirstTime As Boolean)
	btnDate2.Initialize("","")	
	ListaDoc.vTrasmesso=0
	'Do not forget to load the layout file created with the visual designer. For example:
	If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then		
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	Else
		MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
	End If
	' LoadLayout PRIMA di qualsiasi Sleep: altrimenti Activity_Resume parte con Label non create
	DateTime.DateFormat = "dd-MM-yyyy"
	Select Choose_Menu.vOperazioneMenu
		Case "Picking"
			Activity.LoadLayout("Picking")
	
		Case "Carico Ordine Fornitore"
			Activity.LoadLayout("Picking")
			
		Case Else
			Select Main.Ditta
				Case "Kuore"
					Activity.LoadLayout("testedoc_kuore")
			
				Case Else
					If (Main.Ditta <> "") Then
						Activity.LoadLayout("NewDocument_" & Main.Ditta)
					Else
						Activity.LoadLayout("NewDocument_ZelariVi")
					End If
					'---------- Label10 -------------
					Dim cd As ColorDrawable
					Dim MyBorder = Colors.Black As Int
					cd.Initialize2(Colors.LightGray,1dip,2dip,MyBorder)
					Label10.Text=""
					Label10.background=cd
					'---------- Label11 -------------
					cd.Initialize2(Colors.LightGray,1dip,2dip,MyBorder)
					Label11.Text=""
					Label11.background=cd
					'--------------------------------
					Select Case Main.Ditta
						Case "Florenzi"
							' niente
						Case "Trendy"
							' niente
						Case "Carbon"
							' niente
						Case "Gefin"
							' niente
						Case Else
							Leggi_Valute
					End Select
					'--------------------------------
					
			End Select

	End Select
	Sleep(0)
	Base = Activity
	Dialog.Initialize (Base)
	'--------------------------------------------------
	If( Main.Ditta<>"Kuore") Then
		DateTemplate.Initialize
		DateTemplate.MinYear = 2016
		DateTemplate.MaxYear = 2099
		btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
		vDataDocNew = btnDate.xLBL.Text
		Dim DataDoc As Long
		DataDoc = DateTime.DateParse(vDataDocNew)
		vEsercizioNew = ExtraUtility.DateToFormat(DataDoc,"yyyy","it","")
	End If
	'--------------------------------------------------
	Select Case Main.Ditta
		Case "Gefin"
			EditText1.Text=""
			Label1.Text="TESTATA DOCUMENTO "
			Label2.Text="Tipo Documento"
			Label4.Text="Data Doc."
			Label5.Text="Note"
			Label6.Text="Negozio"
			Label8.Text="Valuta"
			Label12.Text="Listino"
			Leggi_ParametriDoc("")
			
		Case "Florenzi"
			EditText1.Text=""
			Label1.Text="TESTATA DOCUMENTO "
			Label2.Text="Tipo Documento"
			Label4.Text="Data Doc."
			Label5.Text="Note"
			Label6.Text="Cliente"
			Label8.Text="Valuta"
			Label12.Text="Listino"
			Leggi_ParametriDoc("")
		
		Case "Trendy"
			EditText1.Text=""
			Label1.Text="TESTATA DOCUMENTO "
			Label2.Text="Tipo Documento"
			Label4.Text="Data Doc."
			Label5.Text="Note"
			Label6.Text="Negozio"
			Label8.Text="Valuta"
			Label12.Text="Listino"
			Leggi_ParametriDoc("")
			
		Case "ZelariVi"
			EditText1.Text=vEsercizioNew
			Label1.Text="TESTATA DOCUMENTO "
			Label2.Text="Tipo"
			Label4.Text="Data Doc."
			Label5.Text="Esercizio"
			Label6.Text="Cliente/Fornitore"
			Label8.Text="Valuta"
			Label12.Text="List."
			Leggi_ParametriDoc("")	
				
		Case "Esseci"			
			Select Case Choose_Menu.vTipoCliFor
				Case "F"
					Label12.Text="Listino Acquisto"
					Label1.Text="DOCUMENTO ACQUISTO"
					Label6.Text="Fornitore"				
					Dim stringa As String = DB_SQLite.Leggi_NRListinoAcquisto(SQLDataAccess)
					Dim arr_Listno() As String
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = False
					Leggi_ParametriDoc("F")
					
				Case "C"
					Label12.Text="Listino Vendita"
					Label1.Text="DOCUMENTO VENDITA"
					Label6.Text="Cliente"
					Dim stringa As String = DB_SQLite.Leggi_NRListinoVendita(SQLDataAccess)
					Dim arr_Listno() As String					
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = True
					Leggi_ParametriDoc("C")
					
				Case "X"
					Label12.Text="Listino Acquisto"
					Label1.Text="INVENTARIO"
					Label6.Text="Fornitore"
					Dim stringa As String = DB_SQLite.Leggi_NRListinoAcquisto(SQLDataAccess)
					Dim arr_Listno() As String
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = False
					Leggi_ParametriDoc("X")					
					ComboBoxTipoDoc.cmbBox.SelectedIndex = 1			
					ComboBoxTipoDoc.cmbBox.Enabled=False
					Label3.Text = List_TipoDoc_Desc.Get(1)
					Label10.Text="F     1"
					Label7.Text = DB_SQLite.Leggi_AnagraficaCF(SQLDataAccess,Label10.Text,"DSCCONTO1")					
					
			End Select
			Label2.Text="Tipo"
			Label4.Text="Data Documento"
			Label5.Text="Num. Riferimento"
			Label8.Text="Valuta"
			ListaDoc.vTrasmesso=0
			
		Case "Nesti"
			Select Case Choose_Menu.vTipoCliFor
				Case "F"
					Label12.Text="Listino Acquisto"
					Label1.Text="DOCUMENTO ACQUISTO"
					Label6.Text="Fornitore"
					Dim stringa As String = DB_SQLite.Leggi_NRListinoAcquisto(SQLDataAccess)
					Dim arr_Listno() As String
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = False
					Leggi_ParametriDoc("F")
					
				Case "C"
					Label12.Text="Listino Vendita"
					Label1.Text="DOCUMENTO VENDITA"
					Label6.Text="Cliente"
					Dim stringa As String = DB_SQLite.Leggi_NRListinoVendita(SQLDataAccess)
					Dim arr_Listno() As String
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = True
					Leggi_ParametriDoc("C")
					
				Case "X"
					Label12.Text="Listino Acquisto"
					Label1.Text="INVENTARIO"
					Label6.Text="Fornitore"
					Dim stringa As String = DB_SQLite.Leggi_NRListinoAcquisto(SQLDataAccess)
					Dim arr_Listno() As String
					arr_Listno = Regex.Split("§",stringa)
					Label11.Text = arr_Listno(0)
					Label9.Text  = arr_Listno(1)
					SwiftButton3.Enabled = False
					Leggi_ParametriDoc("X")
					ComboBoxTipoDoc.cmbBox.SelectedIndex = 1
					ComboBoxTipoDoc.cmbBox.Enabled=False
					Label3.Text = List_TipoDoc_Desc.Get(1)
					Label10.Text="F     1"
					Label7.Text = DB_SQLite.Leggi_AnagraficaCF(SQLDataAccess,Label10.Text,"DSCCONTO1")
					
			End Select
			Label2.Text="Tipo"
			Label4.Text="Data Documento"
			Label5.Text="Num. Riferimento"
			Label8.Text="Valuta"
			ListaDoc.vTrasmesso=0
	End Select
	' Se torniamo da ListaTab con una selezione, non azzerare vTipoTab qui
	ApplicaSelezioneDaLista
End Sub

' Applica codice/descrizione scelti in ListaTab (Clienti/Listino). Safe se layout non pronto.
Private Sub ApplicaSelezioneDaLista
	Try
		If vCodice = "" Then
			If vTipoTab <> 1 And vTipoTab <> 2 Then vTipoTab = 0
			Return
		End If
		Select vTipoTab
			Case 1 ' CodCliFor
				If Label10.IsInitialized = False Or Label7.IsInitialized = False Then Return
				Label10.Text = vCodice
				Label7.Text = vDescrizione
			Case 2 ' Listino
				If Label11.IsInitialized = False Or Label9.IsInitialized = False Then Return
				Label11.Text = vCodice
				Label9.Text = vDescrizione
			Case Else
				Return
		End Select
		vCodice = ""
		vDescrizione = ""
		vTipoTab = 0
	Catch
		Log("ApplicaSelezioneDaLista: " & LastException)
	End Try
End Sub

Sub Activity_Resume
	ApplicaSelezioneDaLista
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub Leggi_ParametriDoc(TipoCF As String)
	ListTipoDoc.Initialize
	List_TipoDoc_Desc.Initialize
	List_TipoDoc_TipoCliFor.Initialize
	Label3.Text = ""
	ComboBoxTipoDoc.cmbBox.Clear
	Select Case Main.Ditta
	Case "Florenzi"
			ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE, TIPODOC, DESCRIZIONE, TIPOCLIFOR FROM GS_TABPARAMETRIDOC",Null,0)
	Case "Trendy"
			ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE, TIPODOC, DESCRIZIONE, TIPOCLIFOR FROM GS_TABPARAMETRIDOC",Null,0)
	Case "Gefin"
			ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE, CODICE AS TIPODOC, DESCRIZIONE, TIPOCLIFOR FROM GS_PARAMETRIDOC",Null,0)
	Case Else
		Select Case TipoCF
			Case "F"
				ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='" & TipoCF & "' AND TipoDoc<>'INV'",Null,0)
			Case "C"
				ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='" & TipoCF & "'",Null,0)
			Case "X"
				ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='F' AND TipoDoc='INV'",Null,0)
			Case Else
				ListTipoDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC",Null,0)
		End Select
	End Select
	ComboBoxTipoDoc.cmbBox.Add("")
	List_TipoDoc_Desc.Add("")
	List_TipoDoc_TipoCliFor.Add("")
	For Each arr_TipoDoc() As String In ListTipoDoc
		ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(1))
		List_TipoDoc_Desc.Add( arr_TipoDoc(2))
		List_TipoDoc_TipoCliFor.Add(arr_TipoDoc(3))
	Next
	ComboBoxTipoDoc.SelectedIndex=0
End Sub

Private Sub Leggi_Valute
	ListValute.Initialize
	ComboBoxValuta.cmbBox.Clear
	Dim arr_Valute() As String
	ListValute = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, Divisa  FROM IS_TABCAMBI",Null,0)
	ComboBoxValuta.cmbBox.Add("")
	For Each arr_Valute() As String In ListValute
		ComboBoxValuta.cmbBox.Add(arr_Valute(1))
	Next
	ComboBoxValuta.SelectedIndex=0
End Sub

Sub Button4_Click
	Activity.Finish
End Sub

Sub Button3_Click
	
End Sub

Sub ComboBoxTipoDoc_SelectedIndexChanged (Index As Int)
	Label3.Text = List_TipoDoc_Desc.Get(Index)	
	Choose_Menu.vTipoCliFor = List_TipoDoc_TipoCliFor.Get(Index)
End Sub

Sub AnotherDatePicker1_DateChanged (NewDate As Long)
	EditText1.Text = ExtraUtility.DateToFormat(NewDate,"yyyy","it","")
End Sub

Sub EditText1_TextChanged (Old As String, New As String)
	
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	
End Sub

Sub Button1_Click
	vTipoTab = 1
	StartActivity(ListaTab)
End Sub

Sub Button2_Click
	vTipoTab = 2
	StartActivity(ListaTab)
End Sub

Sub btnDate_Click
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
		Dim DataDoc As Long
		vDataDocNew = btnDate.xLBL.Text
		DataDoc = DateTime.DateParse(vDataDocNew)
		Select Case Main.Ditta
			Case "ZelariVi"
				vEsercizioNew = ExtraUtility.DateToFormat(DataDoc,"yyyy","it","")
				EditText1.Text=vEsercizioNew
			Case Else
				EditText1.Text=""
		End Select		
	End If
End Sub

Sub btnDate2_Click
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		btnDate2.xLBL.Text = DateTime.Date(DateTemplate.Date)
		vDataRifDoc = btnDate2.xLBL.Text
	End If
End Sub

Sub SwiftButton1_Click ' bottone di conferma finale	
	Try		
		Dim F_Errore As Boolean = False
		Dim vCodValuta As String = ""
		vTipoDocNew = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)
		vDataDocNew = btnDate.xLBL.Text
		Select Case Main.Ditta
			Case "ZelariVi"
				' vDataRifDoc = Null	
				vValuta = ComboBoxValuta.cmbBox.GetItem(ComboBoxValuta.cmbBox.SelectedIndex)	
				vCodNegozio = ""
			Case "Florenzi"
				' vDataRifDoc = Null
				vValuta = ""
				vCodNegozio = Label10.Text
			Case "Trendy"
				' vDataRifDoc = Null
				vValuta = ""
				vCodNegozio = Label10.Text
			Case "Gefin"
				' vDataRifDoc = Null
				vValuta = ""
				vCodNegozio = ""
			Case Else
				vDataRifDoc =btnDate2.xLBL.Text
				vValuta = ComboBoxValuta.cmbBox.GetItem(ComboBoxValuta.cmbBox.SelectedIndex)
				vCodNegozio = ""
		End Select
		vRagSoc = Label7.Text
		vCodCliFor = Label10.Text
		If IsNumber(Label11.Text) Then
			vNumListinoNew = Label11.Text
		Else
			vNumListinoNew = 0		
		End If	
		vOperazione ="NewDoc"
		Select Case Main.Ditta
		Case "Gefin"
				If (vTipoDocNew = "") Then
					MsgboxAsync("Tipo documento non inserito!","ERRORE INSERIMENTO")
					F_Errore = True
				End If
				
		Case "Florenzi"
				If (vRagSoc.Trim = "") Or (vCodCliFor.Trim = "") Then
					MsgboxAsync("Cliente/Fornitore non inserito!","ERRORE INSERIMENTO")
					F_Errore = True
				End If
				If (vTipoDocNew = "") Then
					MsgboxAsync("Tipo documento non inserito!","ERRORE INSERIMENTO")
					F_Errore = True
				End If
				
		Case "Trendy"
			If (vRagSoc.Trim = "") Or (vCodCliFor.Trim = "") Then
				MsgboxAsync("Cliente/Fornitore non inserito!","ERRORE INSERIMENTO")
				F_Errore = True
			End If
			If (vTipoDocNew = "") Then
				MsgboxAsync("Tipo documento non inserito!","ERRORE INSERIMENTO")
				F_Errore = True
			End If

		Case Else
			If (vNumListinoNew = 0) Then
				MsgboxAsync("Listino non inserito!","ERRORE INSERIMENTO")
				F_Errore = True
			End If
			If (vRagSoc.Trim = "") Or (vCodCliFor.Trim = "") Then
				MsgboxAsync("Cliente/Fornitore non inserito!","ERRORE INSERIMENTO")
				F_Errore = True
			End If
			If (vTipoDocNew = "") Then
				MsgboxAsync("Tipo documento non inserito!","ERRORE INSERIMENTO")
				F_Errore = True
			End If
		
		End Select
		If (F_Errore = False) Then
			Sleep(0)
			Dim vNumDocNew As Int
			Select Main.Ditta
				Case "Florenzi"
					sqlstr = "SELECT max(numerodoc) as maxnumdoc FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT where tipodoc='"
					sqlstr = sqlstr & vTipoDocNew & "' and esercizio = '" & vEsercizioNew & "'"
				Case "Gefin"
					sqlstr = "SELECT max(numerodoc) as maxnumdoc FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT where tipodoc='"
					sqlstr = sqlstr & vTipoDocNew & "' and esercizio = '" & vEsercizioNew & "'"					
				Case Else
					sqlstr = "SELECT max(numerodoc) as maxnumdoc FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI where tipodoc='"
					sqlstr = sqlstr & vTipoDocNew & "' and esercizio = '" & vEsercizioNew & "'"					
			End Select
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If(rs.RowCount>0) Then
				Do While rs.NextRow
					vNumDocNew =  rs.GetInt("maxnumdoc")+1
				Loop
			Else
				vNumDocNew = 1
			End If
			rs.close
			Select Case Main.Ditta
				Case "Trendy"
					vCodValuta = 1
				Case "Florenzi"
					vCodValuta = 1
				Case "Gefin"
					vCodValuta = 1
				Case Else
					sqlstr = "SELECT CODICE FROM IS_TABCAMBI WHERE DIVISA ='" & vValuta & "'"
					Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
					If(rs.RowCount>0) Then
						Do While rs.NextRow
							vCodValuta =  rs.GetInt("CODICE")
						Loop
					Else
						vCodValuta = 1
					End If
					rs.close
			End Select							
			Select Case Main.Ditta
				Case "Kuore"
					vNumRifDoc=""
					vNoteDoc=EditText1.Text
				Case "Trendy"
					vNumRifDoc=""
					vNoteDoc=EditText1.Text		
				Case "Florenzi"
					vNumRifDoc=""
					vNoteDoc=EditText1.Text
				Case "Gefin"
					vNumRifDoc=""
					vNoteDoc=EditText1.Text
				Case "ZelariVi"				
					vNumRifDoc=""
					vNoteDoc=""
				Case "Esseci"
					vNumRifDoc=EditText1.Text					
					vNoteDoc=""
				Case Else
					vNumRifDoc=EditText1.Text
					vNoteDoc=""
			End Select
			' Log(sqlstr & CRLF & vNumDocNew)
			' ListaDoc.B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?)"$ , Array As Object("", vTipoDocNew, vNumDocNew, vDataDocNew, vCodCliFor, vRagSoc))		
			Select Case Main.Ditta
				Case "Gefin"
					sqlstr  = "INSERT INTO " &  Main.PrefixSQL & "_TESTEDOCUMENTI_LT (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,NrListino,DataDoc,Note) VALUES " _
					& "('" & vTipoDocNew & "','" & vNumDocNew & "','" & vEsercizioNew & "','" & Main.Utente & "','" & Label10.Text & "','" & vNumListinoNew  & "','" _
					& vDataDocNew & "','" & vNoteDoc & "')"
										
				Case "Florenzi"
					sqlstr  = "INSERT INTO " &  Main.PrefixSQL & "_TESTEDOCUMENTI_LT (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,NrListino,DataDoc,Note) VALUES " _
					& "('" & vTipoDocNew & "','" & vNumDocNew & "','" & vEsercizioNew & "','" & Main.Utente & "','" & Label10.Text & "','" & vNumListinoNew  & "','" _
					& vDataDocNew & "','" & vNoteDoc & "')"
					
				Case "Trendy"				
					sqlstr  = "INSERT INTO " &  Main.PrefixSQL & "_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,NrListino,DataDoc," _
					& "Valuta,NumRifDoc,DataRifDoc,Note,CodNegozio) VALUES " _
					& "('" & vTipoDocNew & "','" & vNumDocNew & "','" & vEsercizioNew & "','" & Main.Utente & "','" _
					& Label10.Text  & "','" & vNumListinoNew  &"','" & vDataDocNew & "','" & vCodValuta & "','" & vNumRifDoc &"','" _
					& vDataRifDoc & "','" & vNoteDoc & "','" & vCodNegozio & "')"
					
				Case Else
					sqlstr  = "INSERT INTO " &  Main.PrefixSQL & "_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,NrListino,DataDoc," _
					& "Valuta,NumRifDoc,DataRifDoc,Note) VALUES " _
					& "('" & vTipoDocNew & "','" & vNumDocNew & "','" & vEsercizioNew & "','" & Main.Utente & "','" _
					& Label10.Text  & "','" & vNumListinoNew  &"','" & vDataDocNew & "','" & vCodValuta & "','" & vNumRifDoc &"','" & vDataRifDoc & "','" & vNoteDoc & "')"												
			End Select					
			Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)	
			Activity.Finish
			' CallSubDelayed(ListaDoc, "ListaDocChkNew")		
			Select Case Main.Ditta
				Case "ZelariVi"
					StartActivity(RigheDoc_ZelariVi)
				Case "Florenzi"
					StartActivity(RigheDoc_Florenzi)
				Case "Trendy"
					StartActivity(RigheDoc_Trendy)
				Case "Gefin"
					StartActivity(RigheDoc_Gefin)
				Case "Esseci"
					StartActivity(RigheDoc_Esseci)
				Case "Nesti"
					StartActivity(RigheDoc_Esseci)
				Case "Kuore"
					StartActivity(RigheDoc_Trendy)
			End Select
		Else
			ExtraUtility.Play_Sound("error.wav")
	End If
	Catch
		MsgboxAsync("Errore: " & LastException.Message,"ERRORE " & Main.PrefixSQL & "_TESTEDOCUMENTI") 'no changes will be made
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		' CallSubDelayed(ListaDoc, "ListaDocChkNew")
		Return True
	Else
		Return False
	End If
End Sub

Sub SwiftButton2_Click
	vTipoTab = 1
	StartActivity(ListaTab)
End Sub

Sub SwiftButton3_Click
	vTipoTab = 2
	StartActivity(ListaTab)
End Sub

