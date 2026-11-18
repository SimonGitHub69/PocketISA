B4A=true
Group=Default Group\Kuore
ModulesStructureVersion=1
Type=Activity
Version=10.7
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private XUI As XUI
	Public SQLDataAccess As SQL
	Public vTipoTab As Int
	Public vCodice As String
	Public vDescrizione As String
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Public rp As RuntimePermissions
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private RowID_Riga As Long
	Dim IDriga As Int
	Private TabStrip1 As TabStrip
	Private ComboBoxTipoDoc As B4XComboBox
	' Private Panel1 As Panel
	Private btnDate As SwiftButton
	Private Base As B4XView
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private EditText1 As EditText
	Private SwiftButton1 As SwiftButton
	Private EditText2 As EditText	
	Private B4XImageView1 As B4XImageView
	Private B4XTable1 As B4XTable
	Private List_TipoDoc As List
	Private List_TipoDoc_Desc As List
	Private List_TipoDoc_TipoCliFor As List
	Private vBarcodeLetto As String
	Private sqlstr As String
	Private CodArt As String
	Private DesArt As String
	Private FlagCoppie As Int
	Private Partita As String
	Private SelectedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private Col1_Column As B4XTableColumn
	Private Col2_Column As B4XTableColumn
	Private Col3_Column As B4XTableColumn
	Private Col4_Column As B4XTableColumn
	Private Col5_Column As B4XTableColumn
	Private Col6_Column As B4XTableColumn
	Private Col7_Column As B4XTableColumn
	Private Col8_Column As B4XTableColumn
	Private DataList As List
	Private xlbl As B4XView
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Phone As IME
	Private vTipoDoc As String
	Private SwiftButton2 As SwiftButton
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private Label8 As Label
	Private Label9 As Label
	Private Label10 As Label
	Private Label11 As Label	
	Private Label12 As Label
	Private Label13 As Label
	Private NumListino As Int
	Private CodCliFor As String
	Private NumDoc As Int
	Private EsercizioDoc As Int
	Private DataDoc As String
	Private DataDocStr As String
	Private Prezzo As Double	
	Private CheckBox1 As CheckBox
	Private CheckBox2 As CheckBox
	Private Button6 As Button
	Private Button7 As Button
	Private EditText3 As EditText
	Private Panel2 As Panel
	Private Label14 As Label
	Private ScrollingLabel1 As ScrollingLabel
	Private B4XFloatTextField1 As B4XFloatTextField
	Private Label15 As Label
	Private EditText4 As EditText
	Private EditText5 As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Sleep(0)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Phone.Initialize("")
	vCodice = ""
	vDescrizione = ""
	Activity.LoadLayout("testedoc_kuore")
	'----------------------------------
	' Leggi parametridoc
	'----------------------------------
	TabStrip1.LoadLayout("page1_kuore", "Testata")
	SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	Leggi_ParametriDoc("")
	TabStrip1.LoadLayout("page2_kuore", "Dettaglio")	
	Dim Panel1 As Panel
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)
	Dim offset As Int = -3
	Dim numicons As Int = 5
	Dim icon_width As Int = 75dip
	Button1.Initialize("Button1") ' Apri
	Panel1.AddView(Button1, offset, 0, icon_width, 60dip)
	Button2.Initialize("Button2") ' nuovo
	Panel1.AddView(Button2, offset+(100%x / numicons), 0, icon_width, 60dip)
	Button3.Initialize("Button3")
	Panel1.AddView(Button3, offset+(100%x / numicons) * 2, 0, icon_width, 60dip)
	Button4.Initialize("Button4")
	Panel1.AddView(Button4, offset+(100%x / numicons) * 3, 0, icon_width, 60dip)
	Button5.Initialize("Button5")
	Panel1.AddView(Button5, offset+(100%x / numicons) * 4, 0, icon_width, 60dip)
	'Button6.Initialize("Button6")
	'Panel1.AddView(Button6, offset+(100%x / numicons) * 5, 0, icon_width, 60dip)
	Activity.AddView(Panel1, 0, 100%y - 60dip, 100%x, 70dip)
	CreateLabel(Button1, Chr(0xF0CB), "Modifica")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Elimina")
	CreateLabel(Button4, Chr(0xF0D0), "Cerca")
	CreateLabel(Button5, Chr(0xF0C7), "Salva")
	'--------------------------------
	Dim b As Boolean = False
	For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
		btn.visible = b
	Next
	Base = Activity
	Dialog.Initialize (Base)
	Label1.Text = ListaDoc.vTipoDoc & " n. " & ListaDoc.vNumerodoc & " del " & ListaDoc.vDataDoc & CRLF & ListaDoc.vRagSoc
	If(ListaDoc.vTipoOperazione="OpenDoc") Then
		Select ListaDoc.vTrasmesso
			Case 1
				Label1.Color=Colors.Red
			Case 2
				Label1.Color=Colors.Cyan
			Case Else
				Label1.Color=Colors.LightGray
		End Select
	Else
		Label1.Color=Colors.LightGray
	End If
	ListaRigheDoc(FirstTime)
	vBarcodeLetto = ""
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
	End If
	EditText2.InputType = EditText2.INPUT_TYPE_TEXT
	DateTime.DateFormat = "dd-MM-yyyy"
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	Button5.TextColor=Colors.Red
	Label7.Text = ""
	Label8.Text = ""
	Label13.Typeface = Typeface.DEFAULT_BOLD
	Label13.Width = 70dip
	Label13.TextSize = 12
	Label13.Text = "TOTALE"
	Label13.Top = B4XTable1.mBase.Top+B4XTable1.mBase.Height-51dip
	Label13.Left = 50%x+15dip
	Label13.Height = 20dip
	Label12.Typeface = Typeface.DEFAULT_BOLD	
	Label12.Left = 100%x-5dip-85dip
	Label12.Width = 85dip
	Label12.TextSize = 14
	Label12.Gravity = Gravity.RIGHT
	Label12.Padding = Array As Int(0dip,0dip,5dip,0dip)
	Label12.Top = B4XTable1.mBase.Top+B4XTable1.mBase.Height-51dip
	Label12.Height = 20dip
	Label7.Text = ""
End Sub

Sub Activity_Resume
	If(vCodice<>"") Then
		Select NewDocument.vTipoTab
			Case 1
				Label10.Text = vCodice
				Label11.Text = vDescrizione
			Case 2
				Label7.Text = vCodice
				Label8.Text = vDescrizione				
			Case Else
				Label10.Text = vCodice
				Label11.Text = vDescrizione
		End Select
	Else		
		vCodice = ""
		vDescrizione = ""
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub Leggi_ParametriDoc(TipoCF As String)
	Try 
		Dim ListDoc As List
		ListDoc.Initialize
		List_TipoDoc.Initialize
		List_TipoDoc_Desc.Initialize
		List_TipoDoc_TipoCliFor.Initialize
		ComboBoxTipoDoc.cmbBox.Clear
		ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE, DESCRIZIONE, TIPO, CLIFOR FROM IS_PARAMETRIDOC",Null,0)
		ComboBoxTipoDoc.cmbBox.Add("")
		List_TipoDoc.Add("")
		List_TipoDoc_Desc.Add("")
		List_TipoDoc_TipoCliFor.Add("")
		For Each arr_TipoDoc() As String In ListDoc
			ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(0) & " - " & arr_TipoDoc(1))
			List_TipoDoc.Add(arr_TipoDoc(1))
			List_TipoDoc_Desc.Add( arr_TipoDoc(2))
			List_TipoDoc_TipoCliFor.Add(arr_TipoDoc(3))
		Next
		ComboBoxTipoDoc.SelectedIndex=0
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub btnDate_Click
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
	If Result = XUI.DialogResponse_Positive Then
		btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
		' Dim DataDoc As Long
		' vDataDocNew = btnDate.xLBL.Text
		' DataDoc = DateTime.DateParse(vDataDocNew)
	End If
End Sub

Sub SwiftButton1_Click
	NewDocument.vTipoTab = 1	
	StartActivity(ListaTab)
End Sub

Sub SwiftButton2_Click
	NewDocument.vTipoTab = 2
	StartActivity(ListaTab)
End Sub

Private Sub TabStrip1_PageSelected (Position As Int)
	Dim b As Boolean 
	Select Position
		Case 0
			' Testata
			b = False
			For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
				btn.visible = b
			Next
			
		Case 1
			' Dettaglio		
			If(Label7.Text<>"") Then
				NumListino = Label7.Text
			Else
				NumListino = 0
			End If
			If(Label11.Text<>"") Then
				CodCliFor = Label10.Text
			Else
				CodCliFor = ""
			End If
			b = True
			For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
				btn.visible = b
			Next
			Dim vDataDocStr As String = btnDate.xLBL.Text
			DataDoc = DateTime.DateParse(vDataDocStr)
			EsercizioDoc = ExtraUtility.DateToFormat(DataDoc,"yyyy","it","")				
			Dim TipoDoc As String = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)		
			Dim Pos As Int = TipoDoc.IndexOf("-")
			If(TipoDoc.Length>0) Then
				vTipoDoc = TipoDoc.SubString2(0,Pos-1).trim			
			Else
				vTipoDoc = ""
			End If
			Label1.Text = "Doc. "  & vTipoDoc & " n. " & EditText1.Text & " del " & btnDate.xLBL.Text
			If(ListaDoc.vTipoOperazione="OpenDoc") Then
				Select ListaDoc.vTrasmesso
					Case 1 
						Label1.Color=Colors.Red
					Case 2
						Label1.Color=Colors.Cyan
					Case Else
						Label1.Color=Colors.LightGray
				End Select								
			Else
				Label1.Color=Colors.LightGray
			End If
			EditText1.RequestFocus
			If (TipoDoc="") Or (Label10.Text="") Or (NumListino=0) Then
				TabStrip1.ScrollTo(0,True)
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Inserimento errato controllare tipo documento, cliente e listino","ERRORE")
			End If						
	End Select
End Sub

Private Sub EditText2_EnterPressed	
	vBarcodeLetto = EditText2.Text.Trim
	Leggi_Info_Articolo(vBarcodeLetto,"INSERT")
	'------------------------------------------------------------------------------------
	Phone.HideKeyboard
	EditText2.RequestFocus
End Sub

Sub Leggi_Info_Articolo(Barcode As String, Operazione As String)	
	CodArt = ""
	DesArt = ""
	Partita = ""
	Label5.Text = ""
	FlagCoppie = 0
	Prezzo = 0
	Dim sqlstr1 As String = "SELECT CODART,DESCRIZIONE,VERDIBA,PESOORO,CARATI,VERDIBA,PARTITA,FLAGCOPPIE from IS_ANAGRAFICAARTICOLI WHERE PARTITA = '" & Barcode & "'"
	Dim rs1 As ResultSet = SQLDataAccess.ExecQuery(sqlstr1)
	If (rs1.RowCount>0) Then
		Do While rs1.NextRow
			CodArt = rs1.GetString("CODART")
			DesArt = rs1.GetString("DESCRIZIONE")
			Partita = rs1.GetString("PARTITA")
			FlagCoppie = rs1.GetInt("FLAGCOPPIE")
			Label5.Text = "V.D. " & rs1.GetString("VERDIBA") & Chr(13) & Chr(10) & rs1.GetString("PARTITA") & Chr(13) & Chr(10) & "Peso " & rs1.Getstring("PESOORO") & Chr(13) & Chr(10) & "Ct " & rs1.Getstring("CARATI")
		Loop		
	End If
	rs1.Close
	If(CodArt="") Then
		sqlstr1= "SELECT CODART,DESCRIZIONE,VERDIBA,PESOORO,CARATI,VERDIBA,PARTITA,FLAGCOPPIE from IS_ANAGRAFICAARTICOLI WHERE CODART = '" & Barcode & "'"
		Dim rs1 As ResultSet = SQLDataAccess.ExecQuery(sqlstr1)
		If (rs1.RowCount>0) Then
			If (rs1.RowCount>0) Then
				Do While rs1.NextRow
					CodArt = rs1.GetString("CODART")
					DesArt = rs1.GetString("DESCRIZIONE")
					Partita = rs1.GetString("PARTITA")
					FlagCoppie = rs1.GetInt("FLAGCOPPIE")
					Label5.Text = "V.D. " & rs1.GetString("VERDIBA") & Chr(13) & Chr(10) & rs1.GetString("PARTITA") & Chr(13) & Chr(10) & "Peso " & rs1.Getstring("PESOORO") & Chr(13) & Chr(10) & "Ct " & rs1.Getstring("CARATI")
				Loop		
			End If						
		Else
			CodArt = Barcode
			DesArt = ""
		End If
		rs1.Close
	End If
	If(CodArt<>"") Then
		Dim sqlstr2 As String = "SELECT PREZZOEURO FROM IS_LISTINIARTICOLI WHERE CODART = '" & CodArt & "' AND NRLISTINO = '" & NumListino & "'"
		Dim rs2 As ResultSet = SQLDataAccess.ExecQuery(sqlstr2)
		If (rs2.RowCount>0) Then
			Do While rs2.NextRow
				Prezzo = rs2.GetDouble("PREZZOEURO")
			Loop
		End If
		rs2.close
		Dim FileName As String = CodArt & ".jpg"
		Dim DirExt1 As String = Main.PathImages
		Dim DirExt2 As String = ""
		Dim fn As String = ExtraUtility.GetFolderFileName(DirExt1,"/")
		DirExt2 = DirExt1.Replace(fn & "/","")
		If(DirExt1=DirExt2) Then
			DirExt2 = DirExt1.Replace(fn,"")
		End If
		If File.Exists(DirExt2,fn) = False  Then
			MsgboxAsync("Percorso immagini non trovato!" & CRLF & DirExt1,"ATTENZIONE")
		Else
			If File.Exists(DirExt1,FileName)  Then
				B4XImageView1.Load(DirExt1,FileName)
			Else
				FileName = "NOIMAGE.jpg"
				If File.Exists(DirExt1, FileName)  Then
					ExtraUtility.Play_Sound("Sound1.wav")
					B4XImageView1.Load(DirExt1,FileName)
				Else
					MsgboxAsync("Immagine 'NOIMAGE.jpg' non trovata!" & CRLF & DirExt1,"ATTENZIONE")
				End If
			End If
			Label3.Text = CodArt
			Label4.Text = DesArt
		End If	
	End If
	EditText2.Text=""
	If(Operazione="INSERT") And (CodArt<>"") Then
		If(vBarcodeLetto.Length>0) Then
			btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
			Dim DataDocum As Long
			Dim vDataDocStr As String = btnDate.xLBL.Text
			DataDocum = DateTime.DateParse(vDataDocStr)
			Dim EsercizioDoc As Int = ExtraUtility.DateToFormat(DataDocum,"yyyy","it","")
			If(CheckBox1.Checked) Then
				Dim AcceptDuplicate As Boolean = False
			Else
				Dim AcceptDuplicate As Boolean = True
			End If
			If(CheckBox2.Checked) And (FlagCoppie=1) Then
				Dim Qta As Double = 0.5
				Prezzo = Round(Prezzo /2)
			Else
				Dim Qta As Double = 1
			End If
			If(DesArt<>"") Then
				InserisciRigaDettaglio(Partita,CodArt,DesArt,Qta,Prezzo,vTipoDoc,NumDoc,EsercizioDoc,"NewDoc",AcceptDuplicate)
			Else
				ExtraUtility.Play_Sound("error.wav")
				ToastMessageShow("CODICE NON TROVATO!",False)
			End If
		End If
		Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
	Else
		If(Operazione="INSERT") Then
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("CODICE ERRATO!",False)
		End If
	End If
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		lbl.Padding= Array As Int (0, 0, 10, 0)
	Next
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"n.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Partita",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"C. Art.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"N",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"C",Gravity.CENTER_HORIZONTAL)
	' SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
	Next
	For i = 1 To Col6_Column.CellsLayouts.Size - 1
		' Colonna 1 n
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 12
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 2 Partita
		Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 12
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 3 Cod. Art
		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 12
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 4 Note
		Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 28
		lbl4.Typeface = Typeface.DEFAULT
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 5 Descrizione
		Dim pnl5 As B4XView = Col5_Column.CellsLayouts.Get(i)
		Dim lbl5 As Label = pnl5.GetView(0)
		lbl5.TextSize = 12
		lbl5.Typeface = Typeface.DEFAULT
		lbl5.TextColor = Colors.RGB(9,0,104)
		lbl5.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 6 Qta
		Dim pnl6 As B4XView = Col6_Column.CellsLayouts.Get(i)
		Dim lbl6 As Label = pnl6.GetView(0)
		lbl6.TextSize = 14
		lbl6.Typeface = Typeface.DEFAULT
		lbl6.TextColor = Colors.RGB(9,0,104)
		lbl6.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 7 Prezzo
		Dim pnl7 As B4XView = Col7_Column.CellsLayouts.Get(i)
		Dim lbl7 As Label = pnl7.GetView(0)
		lbl7.TextSize = 13 ' 13
		lbl7.Typeface = Typeface.DEFAULT
		lbl7.TextColor = Colors.RGB(9,0,104)
		lbl7.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
		' Colonna 8 Canc
		Dim pnl8 As B4XView = Col8_Column.CellsLayouts.Get(i)
		Dim lbl8 As Label = pnl8.GetView(0)
		lbl8.TextSize = 13 ' 13
		lbl8.Typeface = Typeface.DEFAULT
		lbl8.TextColor = Colors.RGB(255,0,0)
		lbl8.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
	Next
	Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean)
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
End Sub

Sub InserisciRigaDettaglio(PartitaArt As String, CodArticolo As String, Descr As String, Qta As Double, Listino As Double, TipoDoc As String, NumeroDoc As Int, AnnoDoc As Int,Operazione As String,AcceptDuplicate As Boolean)	
	Dim Pos As Int = B4XTable1.Size+1
	Dim Note As String
	Dim nrecs As Int=0
	If(AcceptDuplicate=False) Then
		nrecs = B4XTable1.sql1.ExecQuerySingleResult2($"select count(*) FROM data WHERE c1=?"$,Array As String(PartitaArt))
	End If
	If(nrecs=0) Or (AcceptDuplicate) Then
		B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?)"$ , Array As Object(Pos, PartitaArt, CodArticolo, Note, Descr, Qta, Listino, ""))
		B4XTable1.ClearDataView
		B4XTable1.Refresh
		B4XTable1.UpdateTableCounters
		Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
		column1.InternalSortMode="DESC"
		B4XTable1.SearchField.mBase.Visible=False
	Else
		ToastMessageShow("CODICE GIA' PRESENTE!",False)
		ExtraUtility.Play_Sound("Sound3.wav")		
	End If	
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Try
		If(MultiSelection=False) Then
			SelectedRows.Clear
			B4XTable1.Refresh
		End If
		' Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Dim Selected As Boolean
		If SelectedRows.Contains(RowId) Then
			SelectedRows.Remove(RowId)
			Selected = False
		Else
			SelectedRows.Add(RowId)
			Selected = True
		End If
		Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId)
		SetRowColor(Index, Selected)
		Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(0)    ' N.
		Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' Partita
		Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' C. Art
		Dim Col4Value As String = B4XTable1.GetRow(RowId).GetValueAt(3)    ' Note
		Dim Col5Value As String = B4XTable1.GetRow(RowId).GetValueAt(4)    ' Descrizione
		Dim Col6Value As Double = B4XTable1.GetRow(RowId).GetValueAt(5)    ' Qta
		Dim Col7Value As Double = B4XTable1.GetRow(RowId).GetValueAt(6)    ' Prz. Unitario
		Dim Col8Value As String = B4XTable1.GetRow(RowId).GetValueAt(7)    ' Cancella
		Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Log($"Row selected: ${RowId}"$)
		Log($"Value of row selected: ${Col1Value}"$)
		RowID_Riga = RowId
		IDriga = Col1Value
		Leggi_Info_Articolo(Col2Value,"READ")
		' B4XTable1.SearchField.mBase.Visible=False
		Dim Note As String = ""
		Dim Qta As Double 
		Dim PrezzoArt As Double = Col7Value
		If(DesArt="") Then
			Label4.text=Col5Value
			Label5.Text = "PARTITA NON TROVATA"
		End If
		If(Col4Value<>"") Then
			Note=Col4Value.SubString(2)
		Else
			Note=""
		End If
		If (Col6Value>0) Then
			Qta = Col6Value
		Else
			Qta = 1
		End If
		EditText3.Text = Qta
		EditText4.Text = PrezzoArt
		Label6.Text=Note
		If(Panel2.Visible) Then
			B4XFloatTextField1.Text=Note
			EditText3.Text=Col6Value
		End If 	
	'	Descrizione=Col3Value
	'	Qta=Col4Value
	Catch
		Log(LastException)
	End Try
End Sub

Sub ListaRigheDoc(FirstTime As Boolean)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try	
		B4XTable1.SearchField.mBase.Visible=False
		B4XTable1.MaximumRowsPerPage = 5
		B4XTable1.RowHeight = 30dip
		SelectedRows = B4XCollections.CreateSet
		'If(FirstTime) Then
			
			Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS)	 		' n.
			Col1_Column.Width = 35dip

			Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("Partita", B4XTable1.COLUMN_TYPE_TEXT) 		' B. Code
			Col2_Column.Width = 55dip

			Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("C. Art.", B4XTable1.COLUMN_TYPE_TEXT)	 		' C. Art.
			Col3_Column.Width = 55dip

			Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_TEXT) 				' Note
			Col4_Column.Width = 20dip
			
			Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione
			Col5_Column.Width = 85dip

			Dim Col6_Column As B4XTableColumn =  B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_TEXT)				' Qta
			Col6_Column.Width=35dip ' NUMBERS

			Dim Col7_Column As B4XTableColumn =  B4XTable1.AddColumn("Prezzo", B4XTable1.COLUMN_TYPE_NUMBERS)		' Prezzo
			Col7_Column.Width=55dip ' NUMBERS
			
			Dim Col8_Column As B4XTableColumn =  B4XTable1.AddColumn("C", B4XTable1.COLUMN_TYPE_TEXT) 				' Canc x Cancellare
			Col8_Column.Width = 16dip
						
			ExtraUtility.CreateCustomFormat(Col7_Column, B4XTable1)
			B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
			B4XTable1.Refresh
			
		'End If
			
		Dim DataList As List
		DataList.Initialize			
		If(ListaDoc.vTipoOperazione="NewDoc") Then
			sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.TipoRiga, RD.Sconto from " &  Main.PrefixSQL & "_RIGHEDOCUMENTI RD " _
			& "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '" & NewDocument.vNumDocNew  & "' AND RD.Esercizio = '" & NewDocument.vEsercizioNew & "'"			
			Log(sqlstr)'
		Else
			sqlstr = "SELECT TL.DESCRIZIONE AS DESCLISTINO, AC.DSCCONTO1,TD.Datadoc, TD.CodiceUnico, Td.MezzoOrecchino, TD.Numerodoc, TD.Note AS NoteTestata, TD.CodClifor, TD.NrListino, RD.Idriga, " _
			& "RD.Partita, RD.Codart, RD.Note, RD.Descrizione,RD.Qta, RD.PrzUnit, ifnull(RD.Canc,'') as Canc from ((IS_RIGHEDOCUMENTI RD LEFT OUTER JOIN IS_TESTEDOCUMENTI As TD ON TD.TipoDoc=RD.TipoDoc And " _
			& "TD.Numerodoc=RD.Numerodoc And TD.Esercizio=RD.Esercizio) LEFT OUTER JOIN IS_ANAGRAFICACF As AC ON AC.CodClifor=TD.CodClifor) LEFT OUTER JOIN IS_TABLISTINI As TL " _
			& "ON TL.NrListino=TD.NrListino WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' And RD.Numerodoc = '" & ListaDoc.vNumerodoc & "' And RD.Esercizio ='" & ListaDoc.vEsercizio & "'"		
			Log(sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If(rs.RowCount>0) Then
				Dim k As Int = 0
				Do While rs.NextRow
					If(k=0) Then
						' **** LEGGI TESTATA ****
						Sleep(0)
						Dim idx As Int = ExtraUtility.LeggiIndexComboBox(ComboBoxTipoDoc,ListaDoc.vTipoDoc)
						If(rs.GetInt("CodiceUnico")=1) Then
							CheckBox1.Checked=True
						Else
							CheckBox1.Checked=False
						End If
						If(rs.GetInt("MezzoOrecchino")=1) Then
							CheckBox2.Checked=True
						Else
							CheckBox2.Checked=False
						End If
						ComboBoxTipoDoc.SelectedIndex=idx		
						ComboBoxTipoDoc.cmbBox.Enabled=False					
						btnDate.xLBL.Text=rs.GetString("Datadoc")
						EditText1.Text=rs.GetInt("Numerodoc")	
						EditText5.Text=rs.GetString("NoteTestata")
						Label10.Text=rs.getstring("CodClifor")
						Label7.Text=rs.Getint("NrListino")		
						Label8.Text=rs.GetString("DESCLISTINO")			
						Label11.Text=rs.GetString("DSCCONTO1")
						SwiftButton1.Enabled=False
						SwiftButton2.Enabled=False
						btnDate.Enabled=False
					End If
					k = K + 1						
					Dim rowx(8) As Object
					rowx(0) = rs.GetInt("Idriga")
					rowx(1) = rs.Getstring("Partita")
					rowx(2) = rs.Getstring("Codart")
					rowx(3) = rs.GetString("Note")
					rowx(4) = rs.GetString("Descrizione")
					rowx(5) = rs.GetDouble("Qta")
					rowx(6) = rs.GetDouble("PrzUnit")
					rowx(7) = rs.GetString("Canc")
					DataList.Add(rowx)
				Loop
			End If
			rs.Close
		End If
		B4XTable1.SetData(DataList)
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.UpdateTableCounters
		Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
	Catch
		Log(LastException)
	End Try
End Sub

Sub SommaColonnaTotale(fattore1 As String) As Double
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Try
		Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
		Dim total As Double = 0
		Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
		Dim totalriga As Double
		Do While rs.NextRow
			totalriga = Round(rs.GetString(fattore1))
			total = total + totalriga
		Loop
		rs.Close
		Return total
		'------------------------------------------------------------------------------------
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub SommaTotale(fattore1 As String, fattore2 As String) As Double
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Try
		Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
		Dim total As Double = 0
		Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
		Dim totalriga As Double
		Do While rs.NextRow
			totalriga = Round(rs.GetString(fattore1) * rs.GetString(fattore2))
			total = total + totalriga
		Loop
		rs.Close
		Return total
		'------------------------------------------------------------------------------------
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Dim cs As CSBuilder
	cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(30).Append(Text1).Pop.Append(CRLF).Size(10).Append(Text2).Alignment("ALIGN_CENTER").PopAll
	xlbl = Label
	xlbl.Text = cs
	xlbl.TextColor = XUI.Color_RGB(105, 105, 105)
	Return xlbl.Snapshot
End Sub

Sub Button3_Click ' Delete Record
	If SelectedRows.Contains(RowID_Riga) Then
		Dim sf As Object = XUI.Msgbox2Async("Elimino la riga?", "CANCELLAZIONE RIGA", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = XUI.DialogResponse_Positive Then		
			Dim c7_value As String
			c7_value = B4XTable1.sql1.ExecQuerySingleResult2("SELECT c7 FROM data WHERE RowId = ?",Array As String(RowID_Riga))
			If(c7_value = "A") Then									
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c7='' WHERE RowId = ?", Array (RowID_Riga))	 	' update record from Table
			Else
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c7='A' WHERE RowId = ?", Array (RowID_Riga))	 	' update record from Table
			End If
			B4XTable1.Refresh
			'Wait For (DeleteRow(B4XTable1, RowID_Riga)) Complete (Success As Boolean)			
			'If (Success) Then
			'	Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
			'End If
		End If
		' B4XTable1.SearchField.mBase.Visible=False
	Else
		Dim sf As Object = XUI.Msgbox2Async("Selezionare la riga da eliminare","ATTENZIONE","OK","","",Null)
	End If
End Sub

Sub Button4_Click
	' Cerca
	If(B4XTable1.SearchField.mBase.Visible=True) Then
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=False
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
	Else
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=True
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.SearchField.RequestFocusAndShowKeyboard
	End If
End Sub

Sub Button5_Click
	' Salva il documento
	Button5.TextColor=ExtraUtility.Color_DarkGreen
	Sleep(0)
	Msgbox2Async("Vuoi registrare il documento?", "Pocket ISA", "SI", "NO", "", Null, False)
	Wait For MsgBox_Result (ResultDial As Int)
	If ResultDial = DialogResponse.POSITIVE Then	
		Dim NrListino As Int = Label7.text
		Dim NoteTestata As String = EditText5.Text
		Dim CodiceUnico As Int = 0
		Dim MezzoOrecchino As Int = 0
		If(CheckBox1.Checked) Then
			CodiceUnico=1
		End If
		If (CheckBox2.Checked) Then
			MezzoOrecchino=1
		End If
		If(ListaDoc.vTipoOperazione="OpenDoc") Then
			ProgressDialogShow2("Salvatggio in corso..",False)
			Sleep(100)
			Wait For(RegistraDocumento(ListaDoc.vTipoDoc, ListaDoc.vNumerodoc, ListaDoc.vEsercizio, ListaDoc.vDataDoc, ListaDoc.vCodCliFor,NrListino,NoteTestata,CodiceUnico,MezzoOrecchino)) complete (Result As Boolean)
			If(Result) Then
				StartActivity(ListaDoc)
				Activity.Finish
			End If			
			ProgressDialogHide
		Else
			ProgressDialogShow2("Salvatggio in corso..",False)
			Sleep(100)
			Wait For(RegistraDocumento(vTipoDoc, NumDoc, EsercizioDoc, DataDocStr, CodCliFor,NrListino,NoteTestata,CodiceUnico,MezzoOrecchino)) complete (Result As Boolean)
			If(Result) Then
				'CallSubDelayed(ListaDoc,"ListaDocChkNew")				
				StartActivity(ListaDoc)
				Activity.Finish
			End If
			ProgressDialogHide
		End If		
	Else
		Button5.TextColor=Colors.Red
	End If
End Sub

Sub RegistraDocumento(TipoDoc As String, NumeroDoc As Int, AnnoDoc As  Int, DataDocum As String, CodiceCliFor As String, NrListino As Int, NoteTestata As String, CodiceUnico As Int, MezzoOrecchino As Int) As ResumableSub
	Try
		Dim rowdata As Map
		Dim  sqlstr As String
		Dim c0_value As Long = 0
		Dim c1_value As String
		Dim c7_value As String
		Dim nrecs As Long
		Dim f_stop As Int = 0
		' Ripristina tutte le righe		
		B4XTable1.CreateDataView($"c0 >0 AND c7='A'"$)
		nrecs = B4XTable1.Size
		B4XTable1.ClearDataView
		If(nrecs>0) Then				
			Msgbox2Async("Rilevate " & nrecs & " righe da cancellare procedo?", "ATTENZIONE!", "SI", "NO", "INDIETRO", Null, False)
			Wait For MsgBox_Result (Result As Int)
			If Result = DialogResponse.NEGATIVE Then
				f_stop = 2
			End If
			If Result = DialogResponse.CANCEL Then
				f_stop = 1
			End If
		End If
		If (f_stop<=1) Then
			B4XTable1.CreateDataView($"c0 >0"$)
			B4XTable1.Refresh
			If(ListaDoc.vTipoOperazione<>"NewDoc") Then
				DataDocStr = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
				sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumeroDoc & "'"
				SQLDataAccess.ExecNonQuery(sqlstr)
				sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumeroDoc & "'"
				SQLDataAccess.ExecNonQuery(sqlstr)
			End If
			sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,NrListino,Note,CodiceUnico,MezzoOrecchino) VALUES "
			sqlstr = sqlstr & "('" & TipoDoc & "','" & NumeroDoc & "','" & AnnoDoc & "','" & Main.Utente & "','" & CodiceCliFor  & "','" _
			& DataDocum & "','" & NrListino & "','" & NoteTestata & "','" & CodiceUnico & "','" & MezzoOrecchino &"')"
			SQLDataAccess.ExecNonQuery(sqlstr)
			For i=0 To B4XTable1.Size
				rowdata = B4XTable1.GetRow(i)
				If rowdata.Size>0 Then
					' rowdata.GetValueAt(1)
					RowID_Riga =  rowdata.Getvalueat(0) ' rowdata.GetValueAt(0)				
					c7_value =  rowdata.Getvalueat(7)				
					c1_value =  rowdata.Getvalueat(1)
					If ((c7_value<>"A") And (f_stop=0)) Or (f_stop=1)  Then
						c0_value = c0_value+1
						sqlstr  = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Partita,Qta,Descrizione,PrzUnit,CodCliFor,Note) VALUES " _
						 & "('" & TipoDoc & "','" & NumeroDoc & "','" & AnnoDoc & "','" & c0_value & "','" & Main.Utente & "','" & rowdata.Get("C. Art.") & "','" & rowdata.Get("Partita") _
						 & "','" & rowdata.get("Qta") & "','" & rowdata.Get("Descrizione") & "','" & rowdata.Get("Prezzo") &  "','" & CodiceCliFor & "','" & rowdata.Get("N") &"')"
						Log(sqlstr)
						SQLDataAccess.ExecNonQuery(sqlstr)
					Else
						Log("CANCELLATO " & c1_value & " POS " & RowID_Riga)
					End If	
				End If
			Next
			ProgressDialogHide
			Return True
		Else
			ProgressDialogHide
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

Sub Button1_Click
	Try
		' Modifica
		Sleep(0)
		If(ListaDoc.vTipoOperazione="NewDoc") Then
			Button7.Enabled=True
			Button5.Enabled=True
		Else
			If (ListaDoc.vTrasmesso = 1) Then
				Button7.Enabled=False
				Button5.Enabled=False
			Else
				Button7.Enabled=True
				Button5.Enabled=True
			End If
		End If
		Dim Col2Value As String = B4XTable1.GetRow(RowID_Riga).GetValueAt(1)    ' Partita		
		Dim Col4Value As String = B4XTable1.GetRow(RowID_Riga).GetValueAt(3)    ' Note
		Dim Col6Value As Double = B4XTable1.GetRow(RowID_Riga).GetValueAt(5)    ' Qta
		Dim Col7Value As Double = B4XTable1.GetRow(RowID_Riga).GetValueAt(6)    ' Prezzo
		Leggi_Info_Articolo(Col2Value,"READ")
		Dim Note As String = ""
		Dim Qta As Double = 0
		Dim PrezzoArt As Double = Col7Value
		If(Col4Value<>"") Then
			Note=Col4Value.SubString(2)
		Else
			Note=""
		End If
		If (Col6Value>0) Then
			Qta = Col6Value
		Else
			Qta = 1
		End If
		EditText3.Text = Qta
		EditText4.Text = PrezzoArt
		Label6.Text=Note
		B4XFloatTextField1.Text=Note
		Panel2.Visible=True
		B4XFloatTextField1.RequestFocusAndShowKeyboard
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button2_Click
	' Nuovo
	B4XTable1.SearchField.Text = ""
	B4XTable1.SearchField.mBase.Enabled=False
	EditText2.RequestFocus	
	Phone.HideKeyboard	
End Sub

Private Sub EditText2_FocusChanged (HasFocus As Boolean)
	If (HasFocus) Then
		Phone.HideKeyboard
		Sleep(0)		
		'B4XTable1.SearchField.Text=""
		'B4XTable1.SearchField.mBase.Visible=False		
	End If
End Sub

Private Sub HandleBackKey
	Try
		If(ListaDoc.vTipoOperazione="OpenDoc") Then
			Msgbox2Async("Vuoi annullare le modifiche al documento?", "Pocket ISA", "SI", "NO", "", Null, False)
		Else
			' vTipoOperazione="NewDoc"
			Msgbox2Async("Vuoi annullare il documento inserito?", "Pocket ISA", "SI", "NO", "", Null, False)
		End If
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.positive Then	
			' in caso di nuovo documento viene distrutto ListaDoc e ricreato con StartActivity	
			If(ListaDoc.vTipoOperazione="NewDoc") Then
				StartActivity(ListaDoc)	
			End If
			Activity.Finish
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long )As ResumableSub
	Try 
		Sleep(0) 'this is required as the table layout is not immediately created.'
		'Dim RowData As Map = tbl.GetRow(RowId)
		Dim sql As String = ""
		SQLDataAccess.BeginTransaction
		sql = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc _
		& "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga = " & IDriga 
		Log(sql)
		SQLDataAccess.ExecNonQuery(sql)
		sql = "UPDATE " & Main.PrefixSQL & "_RIGHEDOCUMENTI SET Idriga = Idriga-1 WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" _
		& ListaDoc.vTipoDoc & "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga > 1 And Idriga > " & IDriga
		Log(sql)
		SQLDataAccess.ExecNonQuery(sql)
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array (RowId))	 			' deletes record from Table
		tbl.sql1.ExecNonQuery2("UPDATE data SET c0=c0-1 WHERE RowId >= ?", Array (RowId))	 	' update record from Table
		Dim page As Int = tbl.CurrentPage
		Dim FirstIndex As Int = tbl.FirstRowIndex	
		tbl.ClearDataView 'Updates the rows count.
		tbl.UpdateTableCounters
		If FirstIndex + 1 >= tbl.mCurrentCount Then
			page = page - 1
		End If
		tbl.CurrentPage = page
		' tbl.ClearDataView
		tbl.Refresh
		Return True
	Catch
		Return False
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Try
		Select KeyCode
			Case KeyCodes.KEYCODE_BACK
				HandleBackKey
				Return True
			Case KeyCodes.KEYCODE_HOME
				Return False
			Case Else
				Return False
		End Select
	Catch
		Return False
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub RegistraRiga(BarcodeCopy As String, Operazione As String)
	' OK
	Dim vCodArt As String
	vCodArt = BarcodeCopy
	Dim vQta As String
	vQta = EditText2.text
	' Dim ValSconto As Double = 0
	If (vCodArt <> "") And (IsNumber(vQta)) Then
		Select Operazione
			Case "Add" ' aggiungi riga
				Dim Pos As Int = B4XTable1.Size+1
				Dim Note As String = ""
				Dim RifIdTesta As Int = 0
				'B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?)"$ , Array As Object(Pos, BarcodeCopy.trim, DescArtCat1Cat2, EditText2.text, Label6.text, EditText3.text,vTipoRiga))
				sqlstr = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,CodCliFor,UtenteModifica,DataDoc) VALUES "				
				sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
				sqlstr = sqlstr & "Descrizione,Sconto,PrzUnit,TipoRiga,Magazzino,DataConsegna,Note,RifIdTesta,VariaMisure,UM,Barcode,ArticoloAQta,DesCat1,DesCat2) VALUES "
				If(NewDocument.vOperazione="NewDoc") Then
					sqlstr = sqlstr & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
				Else
					sqlstr = sqlstr & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
				End If
				'sqlstr = sqlstr & Main.Utente & "','" & BarcodeCopy.Trim & "','" & EditText2.text & "','" & Label9.Text & "','" & EditText3.Text & "','" _
			'	& Label6.text & "','" & vTipoRiga & "','','" & DataConsegna & "','" & Note & "'," & RifIdTesta & ",'" & BarcodeCopy & "','" _
			'	& vUM & "','" & BarcodeCopy & "','" & Label4.Text & "','" & Label14.Text & "','" & Label15.Text & "')"
				SQLDataAccess.ExecNonQuery(sqlstr)
				B4XTable1.ClearDataView
				' Sleep(0)
				Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
				column1.InternalSortMode="DESC"
				Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
				' B4XTable1.ClearDataView
				B4XTable1.Refresh
				
			Case "Modify"
				Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
				B4XTable1.Refresh
				
		End Select
	Else
		ExtraUtility.Play_Sound("error.wav")
		MsgboxAsync("Inserimento errato controllare articolo e quantità","ERRORE")
	End If
End Sub

Private Sub ComboBoxTipoDoc_SelectedIndexChanged (Index As Int)
	Dim TipoDoc As String = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)
	Dim Pos As Int = TipoDoc.IndexOf("-")
	TipoDoc = TipoDoc.SubString2(0,Pos-1).Trim
	If(TipoDoc.Length>0) Then
		vTipoDoc = TipoDoc.SubString2(0,Pos-1).trim
	Else
		vTipoDoc = ""
	End If
	DataDocStr = btnDate.xLBL.Text
	'Dim DataDocum As Int = DateTime.DateParse(DataDocStr)
	EsercizioDoc =  ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
	NumDoc = ExtraUtility.Leggi_MaxNumDoc(SQLDataAccess,TipoDoc,EsercizioDoc)
	EditText1.Text = NumDoc
End Sub

Private Sub Button7_Click	
	Dim Note As String = ""
	If(B4XFloatTextField1.text.Length>0) Then
		Note = "* " & B4XFloatTextField1.Text
	End If	
	Dim Qta As Double = EditText3.Text
	Dim PrezzoArt As Double = EditText4.Text
	B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c3 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (Note, Qta, PrezzoArt, RowID_Riga))
	Dim sql As String
	sql = "UPDATE GS_RIGHEDOCUMENTI SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?, DesCat1 = ?, DesCat2 = ?"
	sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
	'SQLDataAccess.ExecNonQuery2(sql, Array As String (BarcodeCopy.trim,Label9.Text, EditText2.Text, Label6.text, EditText3.text, vTipoRiga, vUM, Label14.Text, Label15.text, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
	B4XTable1.Refresh
	Phone.HideKeyboard
	Panel2.Visible=False
	' B4XTable1.SearchField.Text=""
	' B4XTable1.SearchField.mBase.Visible=False
	Label12.Text = ExtraUtility.NumberFormat_ITA(SommaColonnaTotale("c6"),1,0)
	Sleep(0)
	EditText2.RequestFocus
End Sub

Private Sub Button6_Click
	Panel2.Visible=False
	' B4XTable1.SearchField.Text=""
	' B4XTable1.SearchField.mBase.Visible=False
	Sleep(0)
	EditText2.RequestFocus
End Sub