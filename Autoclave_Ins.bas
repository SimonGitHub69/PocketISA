B4A=true
Group=Default Group\Carbon
ModulesStructureVersion=1
Type=Activity
Version=13.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: false
#End Region
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public xui As XUI
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private Label8 As Label
	Private EditText1 As EditText
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private Panel1 As Panel
	Private CodArt As String
	Private CodArtSer As String
	Private CodArtSer2 As String
	Private CodDip As String
	Private Col1Column As B4XTableColumn
	Private Col2Column As B4XTableColumn
	Private Col3Column As B4XTableColumn
	Private Col4Column As B4XTableColumn
	Private Col5Column As B4XTableColumn
	Private Col6Column As B4XTableColumn
	Private SelectedRows As B4XSet
	Private MultiSelection As Boolean = False
	Private SelectionColor As Int = 0xFF009DFF
	Public vTipoTab As Int ' Tipo tabella (1 = CliFor, 2 = Listino )
	Public vOperazione As String
	Private B4XTable1 As B4XTable
	Public vDataDocNew As String
	Private SwiftButton6 As SwiftButton
	Private SwiftButton7 As SwiftButton
	Private SwiftButton8 As SwiftButton
	Private SwiftButton9 As SwiftButton
	Private Label8 As Label
	Private DataList As List
	Private sqlstr As String
	Private SwiftButton3 As SwiftButton
	Private SwiftButton4 As SwiftButton
	Private SwiftButton10 As SwiftButton
	Private List_NomiOperatori As List
	Private List_CodOperatori As List
	Private CodDip1 As String
	Private CodDip2 As String
	Private CodDip3 As String 
	Private CodAutoclave As String
	Private NumTubo As Int
	Private btnDate As SwiftButton
	Private MD5_Componenti_old As String
	Private Md5_Componenti_new As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Label1.Initialize("")
	If FirstTime Then		
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
			SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
		Else
			MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
		End If
	End If
	ListaRigheAutoclavi(True)
	DateTime.DateFormat = "dd-MM-yyyy"
	Activity.RemoveAllViews
	Activity.LoadLayout("Autoclave_Ins")
	Sleep(0)
	CodAutoclave = Starter.Parametro2	
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	List_NomiOperatori.Initialize
	List_CodOperatori.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	EditText1.RequestFocus
	vTipoTab = 0
	Dim gradient As GradientDrawable
	Dim clrs(2) As Int
	clrs(0) = 0xFFD5D5D5
	clrs(1) = 0xFFB0ACAC
	gradient.Initialize("BL_TR",clrs)
	gradient.CornerRadius = 5dip
	CodDip1=Starter.CodDip1
	CodDip2=Starter.CodDip2
	CodDip3=Starter.CodDip3
	Dim List_CodOperatori As List
	List_CodOperatori.Initialize
	If(CodDip1<>Null) And (CodDip1<>"") Then
		List_CodOperatori.Add(CodDip1)
	End If
	If(CodDip2<>Null) And (CodDip2<>"") Then
		List_CodOperatori.Add(CodDip2)
	End If
	If(CodDip3<>Null) And (CodDip3<>"") Then
		List_CodOperatori.Add(CodDip3)
	End If
	CodDip=CodDip1
	Label4.text = Leggi_Dati_Operatore(CodDip1)
	Label7.text = Leggi_Dati_Operatore(CodDip2)
	Label8.text = Leggi_Dati_Operatore(CodDip3)
	Leggi_Dati_Tubo(CodAutoclave,Starter.NumTubo,Starter.UltimoProc)
	Label1.Text = Starter.Parametro2 & " Tubo: " & Starter.NumTubo	
	Leggi_Operatori(Starter.Parametro2)
	Starter.RegScheda=False
	If(Starter.UltimoProc=4000) Or (Starter.UltimoProc=8000) Then
		Swift_Button_State(SwiftButton8,False,-10dip,Colors.Gray,Colors.LightGray)
		Swift_Button_State(SwiftButton7,False,0,Colors.DarkGray,Colors.LightGray)
	Else
		Swift_Button_State(SwiftButton8,True,0,0,0)
	End If
	If(Starter.UltimoProc=9999) Then
		Swift_Button_State(SwiftButton8,False,-10dip,Colors.Gray,Colors.LightGray)
		Swift_Button_State(SwiftButton7,False,0,Colors.DarkGray,Colors.Gray)
		Swift_Button_State(SwiftButton1,False,-10dip,Colors.Gray,Colors.LightGray)
	End If
End Sub

Sub Leggi_Dati_Tubo(CodiceAutoclave As String, ntubo As Int, processo As Double) 
	Try
		Dim IdTesta As Int = 0 
		Dim CodOpe1 As String = ""
		Dim CodOpe2 As String = ""
		Dim CodOpe3 As String = ""
		Dim Cursor1 As Cursor
		Starter.NumTubo = ntubo
		Select	Starter.UltimoProc
			Case 4000
				Cursor1 = SQLDataAccess.ExecQuery2("SELECT ID,CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,STATO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND IFNULL(TRASMESSO,0)=0 AND PROCESSO BETWEEN 4000 AND 4999 AND IFNULL(DATAORA_FINE,'') ='' ORDER BY PROCESSO DESC LIMIT 1", _
					Array As String(CodiceAutoclave,ntubo))							
			Case 8000
				Cursor1 = SQLDataAccess.ExecQuery2("SELECT ID,CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,STATO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND IFNULL(TRASMESSO,0)=0 AND PROCESSO BETWEEN 8000 AND 8999 AND IFNULL(DATAORA_FINE,'') ='' ORDER BY PROCESSO DESC LIMIT 1", _
					Array As String(CodiceAutoclave,ntubo))							
			Case Else
				Cursor1 = SQLDataAccess.ExecQuery2("SELECT ID,CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,STATO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND IFNULL(TRASMESSO,0)=0 AND PROCESSO=? AND IFNULL(DATAORA_FINE,'') =''", _
					Array As String(CodiceAutoclave,ntubo,processo))								
		End Select		
		If Cursor1.RowCount > 0  Then
			Sleep(0)	
			Cursor1.Position = 0
			IdTesta = Cursor1.GetInt("ID")
			If(Starter.UltimoProc<3000) Then
				CodOpe1 = Cursor1.GetString("CODICEDIP1")
				CodOpe2 = Cursor1.GetString("CODICEDIP2")
				CodOpe3 = Cursor1.GetString("CODICEDIP3")
			Else
				CodOpe1 = Starter.CodDip1
				CodOpe2 = Starter.CodDip2
				CodOpe3 = Starter.CodDip3
			End If			
			Dim List_CodOperatori As List
			List_CodOperatori.Initialize
			If(CodOpe1<>Null) And (CodOpe1<>"") Then
				List_CodOperatori.Add(CodOpe1)
			End If
			If(CodOpe2<>Null) And (CodOpe2<>"") Then
				List_CodOperatori.Add(CodOpe2)
			End If
			If(CodOpe3<>Null) And (CodOpe3<>"") Then
				List_CodOperatori.Add(CodOpe3)
			End If
			If(Cursor1.GetString("NOTE")<>Null) Then
				Starter.Parametro4 = Cursor1.GetString("NOTE")
			Else
				Starter.Parametro4 = ""
			End If
			Starter.StatoSacco = "" ' Cursor1.GetString("STATO")
			
			Label4.Text = Leggi_Dati_Operatore(CodOpe1)
			Label7.Text = Leggi_Dati_Operatore(CodOpe2)
			Label8.Text = Leggi_Dati_Operatore(CodOpe3)
		Else
			CodOpe1 = Starter.CodDip1
			CodOpe2 = Starter.CodDip2
			CodOpe3 = Starter.CodDip3
			Dim List_CodOperatori As List
			List_CodOperatori.Initialize
			If(CodOpe1<>Null) And (CodOpe1<>"") Then
				List_CodOperatori.Add(CodOpe1)
			End If
			If(CodOpe2<>Null) And (CodOpe2<>"") Then
				List_CodOperatori.Add(CodOpe2)
			End If
			If(CodOpe3<>Null) And (CodOpe3<>"") Then
				List_CodOperatori.Add(CodOpe3)
			End If
			Starter.Parametro4 = ""
			Starter.StatoSacco = ""
		End If
		Cursor1.Close
			
		Wait For (Leggi_Dettaglio_Tubo(CodiceAutoclave, ntubo)) Complete (Result As String)
		MD5_Componenti_old = Result
		
		If(MD5_Componenti_old = Null) Then
			MD5_Componenti_old = ""
		End If
	
		If MD5_Componenti_old = "" Then
			Log("Nessun dettaglio trovato oppure errore")
		Else
			Log("Hash MD5 OLD tubo " & ntubo & " = " & MD5_Componenti_old)
		End If
	
	Catch
		Log(LastException)

	End Try
End Sub

Sub Leggi_Dettaglio_Tubo(CodiceAutoclave As String, ntubo As Int)As ResumableSub
	Try
		' 0) DB pronto?
		Sleep(0)
		If SQLDataAccess.IsInitialized = False Then
			Log("[ERR] SQLDataAccess non inizializzato")
			Return Null
		End If

		' 1) UI pronta?
		If B4XTable1.IsInitialized = False Then
			Log("[ERR] B4XTable1 non inizializzato (chiama Activity.LoadLayout prima)")
			Return Null
		End If

		' 2) Setup tabella UNA SOLA VOLTA
		If B4XTable1.Columns.Size = 0 Then
			B4XTable1.AddColumn("Pos", B4XTable1.COLUMN_TYPE_NUMBERS)
			B4XTable1.AddColumn("Cod. Articolo", B4XTable1.COLUMN_TYPE_TEXT)
			B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT)
		End If

		' 3) Opzioni tabella (niente mBase se non serve!)
		B4XTable1.MaximumRowsPerPage = 7
		B4XTable1.RowHeight = 30dip
		B4XTable1.SearchVisible = False
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.ClearDataView

		' 4) Dati
		Dim MD5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess, CodiceAutoclave, ntubo)
		Starter.MD5_Comp = MD5_Comp
		
		DataList.Initialize
		Dim c As Cursor = SQLDataAccess.ExecQuery2( _
            "SELECT POS, CODART, DESCART FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ? AND POS > 0 AND NUMTUBO = ?", _
            Array As String(MD5_Comp,Starter.NumTubo))

		For i = 0 To c.RowCount - 1
			c.Position = i
			Dim r() As Object = Array As Object( _
                c.GetInt("POS"), _
                c.GetString("CODART"), _
                c.GetString("DESCART"))
			DataList.Add(r)
		Next
		c.Close

		' 5) Bind dati
		B4XTable1.SetData(DataList)
		B4XTable1.UpdateTableCounters

		Dim MD5 As String
		MD5  = Componenti_MD5(B4XTable1,Starter.NumTubo)
		Return MD5

	Catch
		Log("[EX] " & LastException)
		' fallback: evita crash in UI
		Dim vuota As List : vuota.Initialize
		B4XTable1.SetData(vuota)
		B4XTable1.UpdateTableCounters
		Return Null
		
	End Try
End Sub

Sub Leggi_IdTesta_Caricamento (CodiceAutoclave As String, ntubo As Int) As Int
	Try
		Dim IdTesta As Int
		Dim Cursor3 As Cursor
		Cursor3 = SQLDataAccess.ExecQuery2("SELECT ID FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND " _
		& "IFNULL(DATAORA_FINE,'')='' ORDER BY PROCESSO ASC LIMIT 1", Array As String(CodiceAutoclave,ntubo))
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			IdTesta = Cursor3.GetInt("ID")
		Else
			IdTesta = 0
		End If
 		Cursor3.Close
		Return IdTesta
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Leggi_Dati_MD5_Registrazione_H(CodiceAutoclave As String, CodiceTubo As Int, UltimoProc As Int) As String
	Try
		Dim MD5_Comp As String
		Dim Cursor1 As Cursor
		Cursor1 = SQLDataAccess.ExecQuery2("SELECT MD5_COMP FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND PROCESSO = ? AND IFNULL(TRASMESSO,0)=0 AND IFNULL(DATAORA_FINE,'') =''", _
			Array As String(CodiceAutoclave,CodiceTubo,UltimoProc))
		If Cursor1.RowCount > 0 Then
			Cursor1.Position = 0
			MD5_Comp = Cursor1.GetInt("MD5_COMP")
		Else
			MD5_Comp = ""
		End If
		Cursor1.Close
		Return MD5_Comp
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Leggi_Dati_Registrazione_H(CodiceAutoclave As String, CodiceTubo As Int, UltimoProc As Int, Ciclo As Int) As Int
	Try
		Dim IdTesta As Int
		Dim Cursor1 As Cursor
		Cursor1 = SQLDataAccess.ExecQuery2("SELECT ID FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND PROCESSO = ? AND REPLICA = ? AND IFNULL(TRASMESSO,0)=0 " & _
		"And IFNULL(DATAORA_FINE,'') =''", Array As String(CodiceAutoclave,CodiceTubo,UltimoProc,Ciclo))
		If Cursor1.RowCount > 0 Then
			Cursor1.Position = 0
			IdTesta = Cursor1.GetInt("ID")
		Else
			IdTesta = 0
		End If
		Cursor1.Close
		Return IdTesta
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Swift_Button_State(SwiftButton As SwiftButton, State As Boolean, Gap As Int, Color As Int, BackColor As Int)
	If State = False Then
		SwiftButton.Enabled = False
		SwiftButton.mBase.Top = SwiftButton.mBase.Top + Gap
		Dim lbl As B4XView = SwiftButton.mBase.GetView(0)
		lbl.TextColor = Color
		lbl.Color = BackColor
	Else
		SwiftButton.Enabled = True
	End If
End Sub

Sub Leggi_Dati_Registrazione_D(MD5_COMP As String, Pos As Int) As Int
	Try
		Dim Count As Int
		Dim Cursor1 As Cursor
		If(Pos=0) Then
			Cursor1 = SQLDataAccess.ExecQuery2("SELECT COUNT(*) AS NRECS FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ?", Array As String(MD5_COMP))
		Else
			Cursor1 = SQLDataAccess.ExecQuery2("SELECT COUNT(*) AS NRECS FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ? AND POS =?", Array As String(MD5_COMP,Pos))
		End If
		If Cursor1.RowCount > 0 Then
			Cursor1.Position = 0
			Count = Cursor1.GetInt("NRECS")
		Else
			Count = 0
		End If
		Cursor1.Close
		Return Count
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Leggi_Operatori(CodiceAutoclave As String) 
	Try
		Label4.Text = ""
		Label7.Text = ""
		Label8.Text = ""
		Starter.CodDip1 = ""
		Starter.CodDip2 = ""
		Starter.CodDip3 = ""
		Dim List_CodOperatori As List
		Dim List_NomiOperatori As List
		List_CodOperatori.Initialize
		List_NomiOperatori.Initialize		
		Dim c As Cursor = SQLDataAccess.ExecQuery2("SELECT CODDIP1,CODDIP2,CODDIP3 FROM GS_AUTOCLAVI WHERE CODICE = ?", Array As String(CodiceAutoclave))
		If(c.RowCount>0) Then
			For i = 1  To 3
				c.Position = 0
				Select Case i
					Case 1
						If(c.GetString("CODDIP1")<>Null) Then
							If(c.GetString("CODDIP1")<>"") Then
								Label4.Text = Leggi_Dati_Operatore(c.GetString("CODDIP1"))
								List_CodOperatori.Add(c.GetString("CODDIP1"))
								List_NomiOperatori.Add(Label4.Text)
								Starter.CodDip1 = c.GetString("CODDIP1")
							End If
						End If
					Case 2
						If(c.GetString("CODDIP2")<>Null) Then
							If (c.GetString("CODDIP2")<>"") Then
								Label7.Text = Leggi_Dati_Operatore(c.GetString("CODDIP2"))
								List_CodOperatori.Add(c.GetString("CODDIP2"))
								List_NomiOperatori.Add(Label7.Text)
								Starter.CodDip2 = c.GetString("CODDIP2")
							End If
						End If
					Case 3
						If(c.GetString("CODDIP3")<>Null) Then
							If(c.GetString("CODDIP3")<>"") Then
								Label8.Text = Leggi_Dati_Operatore(c.GetString("CODDIP3"))
								List_CodOperatori.Add(c.GetString("CODDIP3"))
								List_NomiOperatori.Add(Label8.Text)
								Starter.CodDip3 = c.GetString("CODDIP3")
							End If
						End If
				End Select			
			Next		
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_Dati_Operatore(CodOperatore As String) As String
	Try
		Dim nome As String
		nome = ""
		If(CodOperatore<>Null) Then
			Dim Cursor1 As Cursor
			Cursor1 = SQLDataAccess.ExecQuery2("SELECT NOME FROM GS_OPERATORI WHERE CODICE = ?", Array As String(CodOperatore))
			If Cursor1.RowCount > 0 Then
				Cursor1.Position = 0
				nome = Cursor1.GetString("NOME")
			Else
				nome = ""
			End If
			Cursor1.Close
		End If
		Return nome
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub ListaRigheAutoclavi(FirstTime As Boolean)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.MaximumRowsPerPage = 6
		B4XTable1.RowHeight=32dip
		B4XTable1.HeadersHeight=25dip
		B4XTable1.HeaderTextColor = Colors.Gray
		'B4XTable1.HeaderColor = xui.Color_Green
		'B4XTable1.HeaderTextColor = xui.Color_Red
		'B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(14)
		Col1Column = B4XTable1.AddColumn("P", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col1Column.Width=7%x
		Col2Column = B4XTable1.AddColumn("Articolo", B4XTable1.COLUMN_TYPE_TEXT)
		'Col2Column.Width=30%x
		Col2Column.Width=25%x
		Col3Column = B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT)
		'Col3Column.Width=62%x
		Col3Column.Width=65%x  		
		SelectedRows = B4XCollections.CreateSet
		If(FirstTime) Then
			DataList.Initialize
			B4XTable1.SetData(DataList)
			B4XTable1.Refresh
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Try
		Dim column As B4XTableColumn = tableName.GetColumn(columnID)
		If column.IsInitialized = False Then Return

		' Header
		If column.CellsLayouts.Size > 0 Then
			Dim pnlHead As B4XView = column.CellsLayouts.Get(0)

			If pnlHead.NumberOfViews > 0 Then
				Dim lblHead As Label = pnlHead.GetView(0)
				lblHead.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
			End If
		End If

		' Celle
		For i = 1 To column.CellsLayouts.Size - 1
			Dim pnl As B4XView = column.CellsLayouts.Get(i)

			If pnl.NumberOfViews > 0 Then
				Dim lbl As Label = pnl.GetView(0)
				lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
			End If
		Next

	Catch
		Log("SetColumnAlignment: " & LastException)
	End Try
End Sub

Sub Button4_Click
	Activity.Finish
End Sub

Sub AnotherDatePicker1_DateChanged (NewDate As Long)
	EditText1.Text = ExtraUtility.DateToFormat(NewDate,"yyyy","it","")
End Sub

Sub EditText1_TextChanged (Old As String, New As String)
	
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	
End Sub

Sub EditText1_EnterPressed
	Try
		Select Case Main.Ditta
			Case "Carbon"
				Dim Prefix As String = EditText1.Text.SubString2(0,4)
				Select Case Prefix
					Case "DIP-"
						CodDip = EditText1.Text.substring(4)
						Dim NomeDip As String = SQLDataAccess.ExecQuerySingleResult("SELECT NOME FROM GS_OPERATORI WHERE CODICE ='" & CodDip & "'")
						Label4.Text = NomeDip
						If List_NomiOperatori.IndexOf(NomeDip) = -1 Then
							List_NomiOperatori.Add(NomeDip)
							List_CodOperatori.Add(CodDip)							
						End If
						Dim n As Int = 0
						For Each label As String In List_NomiOperatori
							' ToastMessageShow(label,False)
							n = n + 1
							Select Case n
								Case 1
									Label4.Text = label
									Starter.CodDip1 = CodDip																	
								Case 2
									Label7.Text = label
									Starter.CodDip2= CodDip
								Case 3
									Label8.Text = label		
									Starter.CodDip3 = CodDip
							End Select
						Next
						n = 0
						For Each code As String In List_CodOperatori
							' ToastMessageShow(code,False)
							n = n + 1
							Select Case n
								Case 1
									Starter.CodDip1 = code
								Case 2
									Starter.CodDip2 = code
								Case 3
									Starter.CodDip3 = code
							End Select
						Next
						
					Case Else
						' caso di inserimento articolo
						Dim Pos As Int
						Pos = EditText1.Text.IndexOf("|")
						If (Pos=-1) Then
							Pos = EditText1.Text.IndexOf("$")
						End If	
						If(Pos=-1) Then						
							Pos =  EditText1.Text.IndexOf("/")
							If(Pos>0) Then
								Pos = EditText1.Text.Length
							End If
						End If
						If (Pos>0) And (Starter.CodDip1<>Null) And (Starter.CodDip1<>"") Then							
							CodArtSer = EditText1.Text.SubString2(0,Pos)
							Pos = CodArtSer.IndexOf("/")	
							If(Pos>0) Then
								CodArt = CodArtSer.SubString2(0,Pos)
								CodArtSer2 = CodArtSer.SubString2(Pos,Pos+6)
								Dim rs As ResultSet = SQLDataAccess.ExecQuery2( _
							    "SELECT DESCRIZIONE, CODCICLO1, CODCICLO2, CODCICLO3 " & _
							    "FROM GS_ARTICOLI WHERE CODICE = ?", Array As String(CodArt))
								If rs.NextRow Then
									Dim DescArt As String = rs.GetString("DESCRIZIONE")
									Label3.Text = DescArt
									Dim CodiciRicettaArt As String = ""
									Dim CodRicetta1 As String = rs.GetString("CODCICLO1")
									Dim CodRicetta2 As String = rs.GetString("CODCICLO2")
									Dim CodRicetta3 As String = rs.GetString("CODCICLO3")
									Dim F_RicettaErr As Boolean = False
									If(CodRicetta1<>Null) Then
										CodiciRicettaArt = CodRicetta1
										CodiciRicettaArt = CodiciRicettaArt.Trim
										If(CodRicetta1<>Starter.CodRicetta) And (CodRicetta1.trim<>"") Then
											F_RicettaErr = True
										End If																				
									End If		
									If(CodRicetta2<>Null) Then										
										CodiciRicettaArt = CodiciRicettaArt & " " & CodRicetta2
										CodiciRicettaArt = CodiciRicettaArt.Trim
										If(CodRicetta1<>Starter.CodRicetta) And (CodRicetta2.trim<>"") Then
											F_RicettaErr = True											
										End If
									End If
									If(CodRicetta3<>Null) Then
										CodiciRicettaArt = CodiciRicettaArt & " " & CodRicetta3
										CodiciRicettaArt = CodiciRicettaArt.Trim
										If(CodRicetta3<>Starter.CodRicetta) And (CodRicetta3.trim<>"") Then
											F_RicettaErr = True
										End If
									End If
									If(F_RicettaErr) Then
										ExtraUtility.Play_Sound("Error.wav")
										MsgboxAsync("CODICE RICETTA '" & Starter.CodRicetta & "' NON COMPATIBILE CON L'ARTICOLO " & CodiciRicettaArt ,"ERRORE RICETTA")
									End If
								Else
									Log("Articolo non trovato: " & CodArt)
								End If
								rs.Close
								InserisciRigaAutoclave(CodArtSer,DescArt,False)
							End If
						Else
							If(Starter.CodDip1=Null) Or (Starter.CodDip1="") Then
								ExtraUtility.Play_Sound("Error.wav")
								MsgboxAsync("INSERIRE PRIMA L'OPERATORE!","ERRORE")
							End If
						End If
						
				End Select
				EditText1.Text = ""
				EditText1.RequestFocus
				
		End Select
	Catch
		Log(LastException)
	End Try
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
	Try
		DateTime.DateFormat = "dd-MM-yyyy"
		Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
			vDataDocNew = btnDate.xLBL.Text
			'Dim DataDoc As Long
			'DataDoc = DateTime.DateParse(vDataDocNew)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Registra_Tubo_H(CodiceDip1 As String, CodiceDip2 As String, CodiceDip3 As String, CodiceAutoclave As String, NTubo As Int, Note As String, AcceptDuplicate As Boolean, UltimoProc As Int,Stato As String, MD5_Comp As String, Ciclo As Int) 
	Try
		Dim UltProcTuboPrec As Int
		Dim MD5_Comp_Prec As String
		Dim id_testata,id_testata_prec As Int
		id_testata = 0
		id_testata_prec = 0
		Dim DataOra_Inizio As String = ExtraUtility.Leggi_DataOraSQLite
		Dim UltProcTubo As Int = ExtraUtility.Leggi_Ultimo_proc_Tubo(SQLDataAccess, CodiceAutoclave, NTubo, UltimoProc)			
		If ((UltimoProc>=4000) And (UltimoProc<=4999)) Then
			UltProcTubo = UltProcTubo+1
			id_testata = Leggi_Dati_Registrazione_H(CodiceAutoclave,NTubo,UltProcTubo,Ciclo)
		Else
			If ((UltimoProc>=8000) And (UltimoProc<=8999)) Then
				UltProcTubo = UltProcTubo+1
				If(UltProcTubo>=10000) Then
					UltProcTubo=9999
				End If
				id_testata = Leggi_Dati_Registrazione_H(CodiceAutoclave,NTubo,UltProcTubo,Ciclo)				
			Else
				id_testata = Leggi_Dati_Registrazione_H(CodiceAutoclave,NTubo,UltimoProc,Ciclo)				
			End If
		End If	
		If(id_testata=0) Then
			If(UltimoProc=1000) Or (UltimoProc=2000) Then ' Inizio Caricamento
				Stato = "C"
			End If
			ExtraUtility.Aggiorna_Autoclave_UltProc(SQLDataAccess,CodiceAutoclave,Starter.UltimoProc,Starter.UltimoCiclo)
			If(Starter.RegScheda=True) Then ' Controllo Pressata e Controllo Ciclo
				If((UltimoProc>=4000) And (UltimoProc<=4999)) Or ((UltimoProc>=8000) And (UltimoProc<=8999)) Then
					SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_H (CODICEDIP1,CODICEDIP2,CODICEDIP3,DATAORA_INIZIO,CODAUTOCLAVE,NTUBO,NOTE,PROCESSO,STATO,MD5_Comp,REPLICA,UUID_CICLO) " & _
						"VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,DataOra_Inizio,CodiceAutoclave,NTubo,Note,UltProcTubo,Stato,Md5_Componenti_new,Ciclo,Starter.UUID_Ciclo))
						#if DEBUG
							Log("UltimoProc " & UltProcTubo & " Stato " & Stato)
						#End If
				End If
			Else
				If Not(((UltimoProc>=4000) And (UltimoProc<=4999)) Or ((UltimoProc>=8000) And (UltimoProc<=8999))) Then  ' diverso da controllo pressata e controllo ciclo
					#if DEBUG
						Log ("UltimoProc " & UltimoProc & " Stato " & Stato)
					#End If
					'----------------------------------------------------------------
					' VERIFICO SE ESISTE EVENTO PRECEDENTE ALTRIMENTI LO CREO
					'----------------------------------------------------------------
					UltProcTuboPrec = 0 
					Select Case UltProcTubo
						Case 2000
							UltProcTuboPrec = 1000											
					End Select
					If(UltProcTuboPrec>0) Then
						MD5_Comp_Prec = Leggi_Dati_MD5_Registrazione_H(CodiceAutoclave,NTubo,1000)
						If(MD5_Comp_Prec="") Then
							SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_H (CODICEDIP1,CODICEDIP2,CODICEDIP3,DATAORA_INIZIO,CODAUTOCLAVE,NTUBO,NOTE,PROCESSO,STATO,MD5_Comp,REPLICA,UUID_CICLO) " & _
								"VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", _
								Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,DataOra_Inizio,CodiceAutoclave,NTubo,Note,UltProcTuboPrec,Stato,Md5_Componenti_new,Ciclo,Starter.UUID_Ciclo))											
						End If
					End If
					'----------------------------------------------------------------
					' FINE SE ESISTE EVENTO PRECEDENTE ALTRIMENTI LO CREO
					'----------------------------------------------------------------
					If(UltProcTubo>0) Then
						SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_H (CODICEDIP1,CODICEDIP2,CODICEDIP3,DATAORA_INIZIO,CODAUTOCLAVE,NTUBO,NOTE,PROCESSO,STATO,MD5_Comp,REPLICA,UUID_CICLO) " _
						& "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", _
							Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,DataOra_Inizio,CodiceAutoclave,NTubo,Note,UltProcTubo,Stato,Md5_Componenti_new,Ciclo,Starter.UUID_Ciclo))					
						#if DEBUG
							Log("UltimoProc " & UltProcTubo & " Stato " & Stato)
						#End If
					End If					
				End If
			End If			
			' 2. Recupera l'ultimo ID generato
			Dim Cursor1 As Cursor = SQLDataAccess.ExecQuery("SELECT last_insert_rowid()")
			Cursor1.Position = 0
			id_testata = Cursor1.GetInt2(0)
			Cursor1.Close
		Else
			'----------------------------------------------------------------
			' VERIFICO SE ESISTE EVENTO PRECEDENTE ALTRIMENTI LO CREO
			'----------------------------------------------------------------
			UltProcTuboPrec = 0
			Select Case UltProcTubo
				Case 2000 ' Fine caricamento
					UltProcTuboPrec = 1000 ' Inizio caricamento
			End Select
			If(UltProcTuboPrec>0) Then				
				MD5_Comp_Prec = Leggi_Dati_MD5_Registrazione_H(CodiceAutoclave,NTubo,UltProcTuboPrec)
				If(MD5_Comp_Prec="") Then
					SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_H (CODICEDIP1,CODICEDIP2,CODICEDIP3,DATAORA_INIZIO,CODAUTOCLAVE,NTUBO,NOTE,PROCESSO,STATO,MD5_Comp,REPLICA,UUID_CICLO) " _
						& "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", _
						Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,DataOra_Inizio,CodiceAutoclave,NTubo,Note,UltProcTuboPrec,Stato,Md5_Componenti_new,Ciclo,Starter.UUID_Ciclo))											
				End If			
			End If
			'----------------------------------------------------------------
			' FINE SE ESISTE EVENTO PRECEDENTE ALTRIMENTI LO CREO
			'----------------------------------------------------------------			
			ExtraUtility.Aggiorna_Autoclave_UltProc(SQLDataAccess,CodiceAutoclave,UltimoProc,Starter.UltimoCiclo)
			If(Stato<>"") Then			
				SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVE_STORY_H SET CODICEDIP1=?,CODICEDIP2=?,CODICEDIP3=?,NOTE=?,STATO=?,MD5_COMP=? WHERE ID=?", _
					Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,Note,Stato,Md5_Componenti_new,id_testata))
			Else
				Dim UltStato As String 
				UltStato = ExtraUtility.Leggi_Ultimo_Stato_Tubo(SQLDataAccess, CodAutoclave,NTubo)
				If (UltStato="X") Then ' in caso di scollegamento
					Stato = "C"
					If(UltProcTubo>0) Then
						SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_H (CODICEDIP1,CODICEDIP2,CODICEDIP3,DATAORA_INIZIO,CODAUTOCLAVE,NTUBO,NOTE,PROCESSO,STATO,MD5_COMP,REPLICA,UUID_CICLO) " _
						& " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", _
						Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,DataOra_Inizio,CodiceAutoclave,NTubo,Note,UltProcTubo,Stato,Md5_Componenti_new,Ciclo,Starter.UUID_Ciclo))
						#if DEBUG
						Log("UltimoProc " & UltProcTubo & " Stato " & Stato)
						#End If					
					End If
					SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVE_STORY_H SET CODICEDIP1=?,CODICEDIP2=?,CODICEDIP3=?,NOTE=?,STATO=?,MD5_COMP=? WHERE ID=?", _
						Array As Object(CodiceDip1,CodiceDip2,CodiceDip3,Note,Stato,Md5_Componenti_new,id_testata))						
				End If				
			End If
		End If
		If(id_testata_prec>0) Then
			Return id_testata_prec
		Else
			Return id_testata
		End If
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Registra_Tubo_D(Pos As Int, CodArticolo As String, Descrizione As String, MD5_Comp As String, DataOra As String, NTubo As Int, AcceptDuplicate As Boolean)
	Try
		Dim Count As Int
		Count = Leggi_Dati_Registrazione_D(Md5_Componenti_new,Pos)
		If(Count=0) Then	
			SQLDataAccess.ExecNonQuery2("INSERT INTO GS_AUTOCLAVE_STORY_D (POS, CODART, DESCART, MD5_COMP, DATAORA, NUMTUBO, CODAUTOCLAVE, UUID_CICLO) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", _
				Array As Object(Pos, CodArticolo, Descrizione, MD5_Comp, DataOra, NTubo, Starter.Parametro2, Starter.UUID_Ciclo))
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub SwiftButton1_Click ' bottone di conferma finale
	Try
		If(Main.Ditta="Carbon") Then
			Dim DataOra_Agg As String = ExtraUtility.Leggi_DataOraSQLite
			Dim rowdata As Map
			Dim Id_Testata As Int
'			If(CodAutoclave<>"") Then
'				SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE=?",Array As String (CodAutoclave))
'			End If
			CodDip1 = ""
			CodDip2 = ""
			CodDip3 = ""
			If(B4XTable1.Size>0) Then
				DateTime.DateFormat = "dd-MM-yyyy HH:MM:SS"
				Dim n As Int = 0
				For Each code As String In List_CodOperatori
					' ToastMessageShow(label,False)
					n = n + 1
					Select Case n
						Case 1
							CodDip1 = code
						Case 2
							CodDip2 = code
						Case 3
							CodDip3 = code
					End Select
				Next		
				'----------------------------------------
				' Registrazione Tubo H
				'----------------------------------------	
				Md5_Componenti_new  = Componenti_MD5(B4XTable1, Starter.NumTubo)
				#if DEBUG
					Log("Hash NEW MD5 tubo " & Starter.NumTubo & " = " & Md5_Componenti_new)					
				#End If			
				If(MD5_Componenti_old<>Md5_Componenti_new) Then
					'-----------------------------------------------------------
					' INIZIO Aggiornamento dettaglio componenti Registra_Tubo_D
					'-----------------------------------------------------------					
					Dim Md5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,Starter.NumTubo)
					SQLDataAccess.BeginTransaction
					If(Md5_Comp<>"") And (Starter.UltimoProc<=2000) Then ' in caso di caricamento viene canecllato e inserito...
						SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ?", Array As Object(Md5_Comp))
					End If'
					Dim DataOra As String = ExtraUtility.Leggi_DataOraSQLite
					For i = 0 To B4XTable1.VisibleRowIds.Size - 1
						Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
						Dim r As Map = B4XTable1.GetRow(RowId)
						If (r.Get("P")<>Null) Then
							Registra_Tubo_D(r.Get("P"),r.Get("Articolo"),r.Get("Descrizione"), Md5_Componenti_new, DataOra, Starter.NumTubo, False)
						End If
					Next
					If(Starter.StatoSacco="") And (B4XTable1.VisibleRowIds.Size>0) Then
						Starter.StatoSacco = "C"
						Id_Testata = Registra_Tubo_H(CodDip1, CodDip2, CodDip3, CodAutoclave, Starter.NumTubo, Starter.Parametro4, False, Starter.UltimoProc, Starter.StatoSacco,Md5_Componenti_new,Starter.UltimoCiclo)
					End If						
					'-------------------------------------------
					' FINE Aggiornamento dettaglio componenti
					'-------------------------------------------
					SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET CODDIP1=?, CODDIP2=?, CODDIP3=?, DATAORA_AGG=? WHERE CODICE=?", _
					Array As Object(CodDip1,CodDip2,CodDip3,DataOra_Agg,Starter.Parametro2))		
					SQLDataAccess.TransactionSuccessful
					SQLDataAccess.EndTransaction
				Else					
					Id_Testata = Registra_Tubo_H(CodDip1, CodDip2, CodDip3, CodAutoclave, Starter.NumTubo, Starter.Parametro4, False, Starter.UltimoProc, Starter.StatoSacco,Md5_Componenti_new,Starter.UltimoCiclo)
					Dim Md5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,Starter.NumTubo)
					SQLDataAccess.BeginTransaction
					SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET CODDIP1=?, CODDIP2=?, CODDIP3=?, DATAORA_AGG=? WHERE CODICE=?", _
					Array As Object(CodDip1,CodDip2,CodDip3,DataOra_Agg,Starter.Parametro2))		
					SQLDataAccess.TransactionSuccessful
					SQLDataAccess.EndTransaction
				End If
				DataList.Clear
				B4XTable1.SetData(DataList)
				B4XTable1.Refresh
				Label3.Text=""
				Label4.Text=""
				Label8.Text=""
				Label7.Text=""
				ToastMessageShow("Operazione salvataggio conclusa!",False)
				Activity.Finish
			Else				
				Dim Md5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,Starter.NumTubo)
				SQLDataAccess.BeginTransaction
				If(Md5_Comp<>"") Then
					SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ?", Array As Object(Md5_Comp))
				End If'
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				ExtraUtility.Play_Sound("Error.wav")
				Msgbox2Async("Nessun componente inserito?", "ATTENZIONE", "CONFERMO", "RIPROVA", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Md5_Componenti_new = ExtraUtility.MD5_stringa(Starter.Parametro2 & "|" & NumTubo)
					If (Md5_Componenti_new<>"")	Then ' in caso di caricamento viene canecllato e inserito...
						SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP = ?", Array As Object(Md5_Componenti_new))
					End If'
					Id_Testata = Registra_Tubo_H(Starter.CodDip1,Starter.CodDip2,Starter.CodDip3,Starter.Parametro2,Starter.NumTubo,"",True,Starter.UltimoProc,"E",Md5_Componenti_new,Starter.UltimoCiclo)
					Dim DataOra As String = ExtraUtility.Leggi_DataOraSQLite		
					Registra_Tubo_D(0,"","", Md5_Componenti_new, DataOra, Starter.NumTubo, False)					
					Activity.Finish
					Starter.StatoSacco=""
				End If
			End If
			' Sleep(0)			
		End If
	Catch
		MsgboxAsync("Errore: " & LastException.Message,"ERRORE Registrazione") 'no changes will be made
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Try
		If KeyCode = KeyCodes.KEYCODE_BACK Then
			Activity.Finish
			' CallSubDelayed(ListaDoc, "ListaDocChkNew")
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub SwiftButton5_Click ' apre le note
	Try
		Dim Count As Int
		Dim MD5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,Starter.NumTubo)
		Count = Leggi_Dati_Registrazione_D(MD5_Comp,0)
		If(Count>0) Then
			Starter.StatoSacco = ""
			StartActivity("Note_Ins")
		Else
			ExtraUtility.Play_Sound("Error.wav")
			Msgbox2Async("Nessun componente inserito?", "ATTENZIONE", "VEDI NOTE", "RIPROVA", "", Null, False)
			Wait For MsgBox_Result (Result As Int)
			If Result = DialogResponse.POSITIVE Then
				Starter.StatoSacco = "" 				
				StartActivity("Note_Ins")
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub B4XTable1_DataUpdated
	Try
		Dim RowId As Long

		' allineamento colonne
		SetColumnAlignment(B4XTable1, "P", Gravity.CENTER)
		SetColumnAlignment(B4XTable1, "Articolo", Gravity.CENTER)
		SetColumnAlignment(B4XTable1, "Descrizione", Gravity.CENTER)

		' gestione righe visibili
		For i = 0 To B4XTable1.VisibleRowIds.Size - 1
			RowId = B4XTable1.VisibleRowIds.Get(i)

			SetRowColor(i, SelectedRows.Contains(RowId))

			For j = 0 To B4XTable1.Columns.Size - 1
				Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
				ExtraUtility.SetSingleLine(i + 1, column, True, "END")
			Next
		Next

		' ==========================
		' COLONNA P
		' ==========================
		For i = 1 To Col1Column.CellsLayouts.Size - 1
			Dim pnl As B4XView = Col1Column.CellsLayouts.Get(i)
			If pnl.NumberOfViews > 0 Then
				Dim lbl As Label = pnl.GetView(0)
				lbl.TextColor = Colors.Gray
				lbl.TextSize = 12
				lbl.Gravity = Gravity.CENTER
				lbl.Typeface = Typeface.DEFAULT_BOLD
				lbl.Padding = Array As Int(5dip, 5dip, 5dip, 5dip)
			End If
		Next

		' ==========================
		' COLONNA ARTICOLO
		' ==========================
		For i = 1 To Col2Column.CellsLayouts.Size - 1
			Dim pnl As B4XView = Col2Column.CellsLayouts.Get(i)
			If pnl.NumberOfViews > 0 Then
				Dim lbl As Label = pnl.GetView(0)
				lbl.TextColor = Colors.Black
				lbl.TextSize = 10
				lbl.Gravity = Gravity.LEFT
				lbl.Typeface = Typeface.DEFAULT_BOLD
				lbl.SingleLine = False
				lbl.Padding = Array As Int(5dip, 2dip, 5dip, 2dip)
			End If
		Next

		' ==========================
		' COLONNA DESCRIZIONE
		' ==========================
		For i = 1 To Col3Column.CellsLayouts.Size - 1
			Dim pnl As B4XView = Col3Column.CellsLayouts.Get(i)
			If pnl.NumberOfViews > 0 Then
				Dim lbl As Label = pnl.GetView(0)
				lbl.TextColor = Colors.Blue
				lbl.TextSize = 10
				lbl.Gravity = Gravity.LEFT
				lbl.Typeface = Typeface.DEFAULT_BOLD
				lbl.Padding = Array As Int(5dip, 2dip, 5dip, 2dip)
			End If
		Next

	Catch
		Log(LastException)
	End Try
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean)
	Try
		Dim clr As Int
		If Selected Then
			clr = SelectionColor
		Else If RowIndex Mod 2 = 0 Then
			clr = B4XTable1.EvenRowColor
		Else
			clr = B4XTable1.OddRowColor
		End If
		For Each c As B4XTableColumn In B4XTable1.VisibleColumns
			Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
			pnl.Color = clr
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Try
		If(MultiSelection=False) Then
			SelectedRows.Clear
			B4XTable1.Refresh
		End If
		' Log($"Number of rows selected: ${SelectedRows.Size}"$)
		If SelectedRows.Contains(RowId) Then
			SelectedRows.Remove(RowId)
		Else
			SelectedRows.Add(RowId)
		End If
		'Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Log($"Row selected: ${RowId}"$)
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub DrawButton(btn As SwiftButton, Color1 As Int, Color2 As Int)
	Dim dr As GradientDrawable
	dr.Initialize("TOP_BOTTOM", Array As Int(Color1, Color2))
	dr.CornerRadius = 10dip
End Sub

Private Sub SwiftButton6_Click
	Try
'		Dim lbl3_Top As Int = Label3.Top
'		Label3.Top=lbl3_Top+3dip
'		Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)
'		Sleep(50)
'		Label3.Top=lbl3_Top
'		Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)	
		Msgbox2Async("Vuoi eseguire il cambio operatori eliminando i suddetti?", "CAMBIO TURNO", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Label4.Text=""
			Label7.Text=""
			Label8.Text=""
			List_NomiOperatori.Clear
			List_CodOperatori.Clear
		End If
	Catch
		Log(LastException)
	End Try	
End Sub

Private Sub SwiftButton8_Click
	Try
		Dim Count As Int
		' Dim IDTesta As Int = Leggi_IdTesta_Caricamento(Starter.Parametro2,Starter.NumTubo)
		Dim md5_comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,Starter.NumTubo)
		Count = Leggi_Dati_Registrazione_D(md5_comp,0)
		If(Count>0) Or (SelectedRows.Size>0)  Then
			If(SelectedRows.Size>0) Then
				Dim RowId As Int = SelectedRows.AsList.get(0)
				Dim sf As Object = xui.Msgbox2Async("Elimino il componente selezionato?", "CANCELLAZIONE", "OK", "", "NO", Null)
				Wait For (sf) Msgbox_Result (Result As Int)
				If Result = xui.DialogResponse_Positive Then
					Dim md5_comp As String
					md5_comp = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2, Starter.NumTubo)			
					wait for (DeleteRow(B4XTable1, md5_comp, RowId, Starter.UltimoProc)) complete (Success As Boolean)
					If (Success) Then
						SelectedRows.Clear						
						Dim NumRighe As Int = B4XTable1.Size						
						If(NumRighe=0) Then								
'							Dim sf As Object = xui.Msgbox2Async("Scollego dalla tubazione il sacco?", "ELIMINAZIONE SACCO", "OK", "", "NO", Null)
'							Wait For (sf) Msgbox_Result (Result As Int)
'							If Result = xui.DialogResponse_Positive Then
'								Dim MD5_Comp As String = Leggi_MD5_Caricamento(Starter.Parametro2,Starter.NumTubo)								
''								SQLDataAccess.BeginTransaction
''								If(MD5_Comp<>"") Then
''									SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_STORY_D WHERE IDTESTA = ?", Array As Object(MD5_Comp))
''								End If'
''								SQLDataAccess.TransactionSuccessful
''								SQLDataAccess.EndTransaction
'								SelectedRows.Clear
'								Md5_Componenti_new = ExtraUtility.MD5_stringa("|" & NumTubo)
'								IDTesta = Registra_Tubo_H(Starter.CodDip1, Starter.CodDip2, Starter.CodDip3, Starter.Parametro2, Starter.NumTubo, "Scollegato", False, Starter.UltimoProc, "X", Md5_Componenti_new)
'								Activity.Finish
'							End If							
						End If						
					End If
				End If
			End If
		Else
			ExtraUtility.Play_Sound("Error.wav")
			ToastMessageShow("Nessun componente inserito!",True)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub DeleteRow (tbl As B4XTable, md5_comp As String, RowId As Long, UltimoProc As Int)  As ResumableSub
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		' Dim RowData As Map = tbl.GetRow(RowId)
		Dim sql As String = ""
		SQLDataAccess.BeginTransaction
		If(RowId=0) Then
			Dim DataOra_Agg As String = ExtraUtility.Leggi_DataOraSQLite
			If(UltimoProc>=1000) And (UltimoProc<=2000) Then ' in caso di caricamento cancello i componenti letti
				sql = "DELETE FROM GS_AUTOCLAVE_STORY_D WHERE MD5_COMP=?"
				SQLDataAccess.ExecNonQuery2(sql, Array (md5_comp))
			End If
			#if debug
				Log(sql & " MD5_comp = " & md5_comp)	
			#End If
			' cancello i riferimenti dei dipendenti
			Dim NewProcesso As Int = Starter.UltimoProc + 1000
			SQLDataAccess.ExecNonQuery2( _
				"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, DATAORA_INIZIO, PROCESSO, REPLICA,NOTE,STATO) " & _
		        "SELECT  CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, ?, ?, ?,'Scollegato','X' FROM GS_AUTOCLAVE_STORY_H " & _
		        "WHERE CODAUTOCLAVE = ? AND NTUBO = ? AND PROCESSO = ? ORDER BY DATAORA_INIZIO DESC LIMIT 1", Array As Object(DataOra_Agg,NewProcesso,0,CodAutoclave,Starter.NumTubo,Starter.UltimoProc))
			SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET DATAORA_AGG=? WHERE CODICE=?", Array As Object(DataOra_Agg,Starter.Parametro2))		
			'tbl.sql1.ExecNonQuery("DELETE FROM data")	 											' deletes record from Table			
		Else
			'sql = "DELETE FROM GS_AUTOCLAVE_STORY_D WHERE IDTESTA=? AND POS=?"
			'SQLDataAccess.ExecNonQuery2(sql, Array (IDTesta,RowId))
			#if debug
				Log(sql & " md5_comp = " & md5_comp & " POS = " & RowId)
			#End If
			tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE RowId = ?", Array As Object (RowId))	 			' deletes record from Table
			RinumeraRighe_tbl(tbl)
		End If		
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		Dim page As Int = tbl.CurrentPage
		Dim FirstIndex As Int = tbl.FirstRowIndex
		tbl.ClearDataView 'Updates the rows count.
		tbl.UpdateTableCounters
		If FirstIndex + 1 >= tbl.mCurrentCount Then
			page = page - 1
		End If
		tbl.CurrentPage = page
		tbl.Refresh
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub RinumeraRighe_tbl(tbl As B4XTable) ' tabella virtuale
	Dim rs As ResultSet = tbl.sql1.ExecQuery("SELECT rowid FROM data ORDER BY c0")
	Dim i As Int = 1
	Do While rs.NextRow
		Dim rid As Long = rs.GetLong("rowid")
		tbl.sql1.ExecNonQuery2("UPDATE data SET c0 = ? WHERE rowid = ?", Array(i, rid))
		i = i + 1
	Loop
	rs.Close
End Sub

Sub RinumeraRighe_sql(MD5_Comp As String,  ntubo As Int) ' tabella sql
	Dim c As Cursor = SQLDataAccess.ExecQuery( _
        "SELECT rowid FROM GS_AUTOCLAVE_STORY_D ORDER BY POS WHERE MD5_Comp = ? AND NUMTUBO = ?")
	SQLDataAccess.BeginTransaction
	Try
		For i = 0 To c.RowCount - 1
			c.Position = i
			SQLDataAccess.ExecNonQuery2( _
                "UPDATE GS_AUTOCLAVE_STORY_D SET POS = ? WHERE POS = ? AND MD5_Comp = ? AND NUMTUBO = ?", _
                Array As Object(i + 1, c.GetLong("POS"),MD5_Comp,ntubo))
		Next
		SQLDataAccess.TransactionSuccessful
	Catch
		Log(LastException)
	End Try
	SQLDataAccess.EndTransaction
	c.Close
End Sub

Sub InserisciRigaAutoclave(CodArticolo As String, Descarticolo As String, AcceptDuplicate As Boolean)
	Try	
		Dim maxPos As Int
		If(B4XTable1.mCurrentCount=0) Then
			maxPos = 0
		Else
			maxPos = B4XTable1.sql1.ExecQuerySingleResult("SELECT max(c0) FROM data")
		End If
		Dim nrecs As Int = 0
		If(AcceptDuplicate=False) And (maxPos>0) Then
			nrecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT COUNT(*) FROM data WHERE c1=?"$,Array As String(CodArticolo))
		End If
		If(nrecs=0) Or (AcceptDuplicate) Then
			maxPos = maxPos + 1
			Dim tbl As B4XTable = B4XTable1
			tbl.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?)"$, Array As Object (maxPos, CodArticolo, Descarticolo))
			B4XTable1.ClearDataView
			B4XTable1.Refresh
			B4XTable1.UpdateTableCounters
			Dim column1 As B4XTableColumn = B4XTable1.GetColumn("P")
			column1.InternalSortMode="DESC"
			B4XTable1.SearchField.mBase.Visible=False
		Else
			ExtraUtility.Play_Sound("Error.wav")
			ToastMessageShow("CODICE GIA' INSERITO!",True)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub SwiftButton3_Click
	Panel1.Visible=False	
End Sub

Private Sub SwiftButton10_Click
	Panel1.Visible=False
End Sub

Sub Activity_Resume

End Sub

Private Sub SwiftButton2_Click
	
End Sub

Private Sub SwiftButton7_Click
	Try
		Msgbox2Async("Vuoi eliminare i componenti inseriti?", "ELIMINA", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Dim lst As List
			lst.Initialize
			B4XTable1.SetData(lst)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Componenti_MD5(tbl As B4XTable, ntubo As Int) As String
	Try
		Dim md5 As Cls_MD5
		Dim lst As List
		md5.Initialize
		lst.Initialize
		For i = 0 To tbl.VisibleRowIds.Size - 1
			Dim RowId As Long = tbl.VisibleRowIds.Get(i)
			Dim r As Map = tbl.GetRow(RowId)
			If r.Get("Articolo") <> Null Then
				lst.Add(r.Get("Articolo"))
			End If
		Next
		lst.Sort(True) 'ordine crescente
		Dim sb As StringBuilder
		sb.Initialize
		For Each art As String In lst
			sb.Append(art).Append("|")
		Next
		sb.Append(ntubo)
		Return md5.Hash(sb.ToString)
	Catch
		Log(LastException)
	End Try
End Sub
