B4A=true
Group=Default Group\Gefin
ModulesStructureVersion=1
Type=Activity
Version=11.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private SQLDataAccess As SQL
	Private SelectedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Public vCodice As String
	Public vDescrizione As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Public F_Barcode As Boolean = False
	Private Dialog As B4XDialog
	Private Base As B4XView
	Private B4XTable1 As B4XTable
	Private xui As XUI
	Private xlbl As B4XView
	Private sqlstr As String
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Panel2 As Panel
	Private IDriga As Int
	Private CodArt As String
	Private Descrizione As String
	Private Qta As Double
	Private RowID_Riga As Long
	Private Operazione As String
	Private xui As XUI
	Private Panel1 As Panel
	Private Label1 As Label
	Private Label9 As Label
	Private EditText1 As EditText
	Private EditText2 As EditText
	Private EditText3 As EditText
	Private EditText4 As EditText
	Private Label10 As Label
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private DataList As List
	Private Phone As IME
	Public vTipoDocNew As String
	Public vOperazione As String
	Public vRagSoc As String
	Public vNumListino As Int
	Public vTipoRiga As String
	Public vBarcodeLetto As String
	Private vUM As String
	Private Col1_Column As B4XTableColumn
	Private Col2_Column As B4XTableColumn
	Private Col3_Column As B4XTableColumn
	Private Col4_Column As B4XTableColumn
	Private Label11 As Label
	Private Label8 As Label
	Private formatter As B4XFormatter
	Private Label12 As Label
	Private Label13 As Label
	Private Button7 As Button
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Panel3 As Panel
	Private chk_Omaggio As CheckBox
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private Label14 As Label
	Private Label15 As Label
	Private Label16 As Label
	Private Label17 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.RemoveAllViews
	Activity.LoadLayout("RigheDoc_Gefin")
	Sleep(0)
	ExtraUtility.formato_europeo_2dec(formatter)
	Panel2.Visible=False
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
	CreateLabel(Button4, Chr(0xF0D0), "Extra")
	CreateLabel(Button5, Chr(0xF059), "Help")
	'--------------------------------
	Button4.Enabled=False
	Button5.Enabled=False
	Base = Activity
	Dialog.Initialize (Base)
	Label1.Text = ListaDoc.vTipoDoc & " n. " & ListaDoc.vNumerodoc & " del " & ListaDoc.vDataDoc & CRLF & ListaDoc.vRagSoc
	If (ListaDoc.vTrasmesso = 1) Then
		Label1.Color=Colors.Red
	Else
		Label1.Color=Colors.Cyan
	end  if
	vNumListino=0
	If(NewDocument.vOperazione="NewDoc") Then
		Label1.text = NewDocument.vTipoDocNew & " n. " & NewDocument.vNumDocNew &  " del " & NewDocument.vDataDocNew & Chr(10) & Chr(13) & NewDocument.vRagSoc & " - " & NewDocument.vNoteDoc
	End If
	ListaRigheDoc(True)
	Label13.Text = ""
	vBarcodeLetto = ""
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
	End If
	EditText2.InputType = EditText2.INPUT_TYPE_TEXT
End Sub

Sub Activity_Resume
	Sleep(0)
	If(Ricerca_AZ.vCodice<>"") Then
		EditText4.Text=Ricerca_AZ.vCodice
		Label9.Text=Ricerca_AZ.vDescrizione
		vUM = ""
		EditText2.RequestFocus
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"Partita",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.CENTER_HORIZONTAL)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
	Next
	For i = 1 To Col3_Column.CellsLayouts.Size - 1
		' Colonna 1
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 14
		lbl1.Typeface = Typeface.DEFAULT_BOLD
		lbl1.TextColor = Colors.Gray ' Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 3
		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 18
		lbl3.Typeface = Typeface.DEFAULT_BOLD
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 4
		Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 18
		lbl4.Typeface = Typeface.DEFAULT_BOLD
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
	Next
	
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Dim cs As CSBuilder
	cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(30).Append(Text1).Pop.Append(CRLF).Size(10).Append(Text2).Alignment("ALIGN_CENTER").PopAll
	xlbl = Label
	xlbl.Text = cs
	xlbl.TextColor = xui.Color_RGB(105, 105, 105)
	Return xlbl.Snapshot
End Sub

private Sub ListaRigheDoc(FirstTime As Boolean)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	If(FirstTime) Then
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 10
		B4XTable1.RowHeight = 40dip
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		Col1_Column = B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS)				' c0
		Col1_Column.Width=120 ' n
		Col2_Column = B4XTable1.AddColumn("CodArt", B4XTable1.COLUMN_TYPE_TEXT)				' c1
		Col2_Column.Width=-1 ' CODART
		Col3_Column = B4XTable1.AddColumn("Partita", B4XTable1.COLUMN_TYPE_TEXT) 			' c2 Descrizione
		Col3_Column.Width =0
		Col4_Column =  B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_NUMBERS)			' c4
		Col4_Column.Width=140 ' NUMBERS	
		ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
	End If
	Dim DataList As List
	DataList.Initialize
	If(NewDocument.vOperazione="NewDoc") Then
		sqlstr = "select RD.Idriga, RD.Codart, RD.Barcode, RD.Descrizione, RD.Qta  from " &  Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " _
		& "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '" & NewDocument.vNumDocNew  & "' AND RD.Esercizio = '" & NewDocument.vEsercizioNew & "'"			
	Else
		sqlstr = "select RD.Idriga, RD.Codart, RD.Barcode, RD.Descrizione, RD.Qta from " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD LEFT OUTER JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT As TD " _
		& "ON TD.TipoDoc=RD.TipoDoc And TD.Numerodoc=RD.Numerodoc And TD.Esercizio=RD.Esercizio WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' AND RD.Numerodoc = '" _
		& ListaDoc.vNumerodoc & "' AND RD.Esercizio = '" & ListaDoc.vEsercizio & "'"				
	End If
	Log(sqlstr)
	If(NewDocument.vOperazione="NewDoc") Then
		' niente
	Else
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rs.RowCount>0) Then
			Do While rs.NextRow
				Dim rowx(4) As Object
				rowx(0) = rs.GetInt("Idriga")
				rowx(1) = rs.Getstring("Codart")
				rowx(2) = rs.Getstring("Barcode") 
				rowx(3) = rs.GetDouble("Qta")
				DataList.Add(rowx)
			Loop
		End If
		rs.Close
	End If
	' B4XTable1.SetData(DataList)
	Wait for(B4XTable1.SetData(DataList)) Complete (Unused As Boolean)	
	B4XTable1.UpdateTableCounters
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.Refresh
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	Dim total As Double = 0
	Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
	Dim totalriga As Double
	Do While rs.NextRow
		totalriga = rs.GetString("c3")
		total = total + totalriga
	Loop
	rs.Close
	Label11.Text = NumberFormat2(total,0,0,0,False)
	'------------------------------------------------------------------------------------
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

Sub DeleteRow (tbl As B4XTable, RowId As Long)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	'Dim RowData As Map = tbl.GetRow(RowId)
	Dim sql As String = ""
	SQLDataAccess.BeginTransaction
	sql = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc _
	& "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga = " & IDriga 
	Log(sql)
	SQLDataAccess.ExecNonQuery(sql)
	sql = "UPDATE " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT SET Idriga = Idriga-1 WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" _
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
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	Dim total As Double = 0
	Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
	Dim totalriga As Double
	Do While rs.NextRow
		totalriga = rs.GetString("c3")
		total = total + totalriga
	Loop
	rs.Close
	Label11.Text = NumberFormat2(total,0,0,0,False)
	'-------------------------------------------------------------------------------------
	tbl.Refresh
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If(Panel2.Visible=False) Then
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
		Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' Codart
		Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' Descrizione
		Dim Col4Value As Double = B4XTable1.GetRow(RowId).GetValueAt(3)    ' Qta
		'	Dim Col5Value As Double = B4XTable1.GetRow(RowId).GetValueAt(4)    ' Prz. Unitario
		Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Log($"Row selected: ${RowId}"$)
		Log($"Value of row selected: ${Col1Value}"$)
		RowID_Riga = RowId
		IDriga = Col1Value
		CodArt = Col2Value
		Descrizione=Col3Value
		Qta=Col4Value
	End If
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then		
		Activity.Finish
		CallSubDelayed(ListaDoc, "ListaDocChkNew")
		' CallSubDelayed(ListaDoc, "ListaDocChk")
		Return True
	Else
		Return False
	End If
End Sub

'Sub AutoClose (TimedDialog As CustomLayoutDialog, UpdateLabel As Label, Disable() As Boolean)
'	UpdateLabel.Text = 9
'	Do While UpdateLabel.Text > 0
'		Sleep(1000)
'		'the timer was disabled
'		If Disable(0) = True Then Return
'		UpdateLabel.Text = NumberFormat(UpdateLabel.Text - 1, 0, 0)
'	Loop
'	TimedDialog.CloseDialog(DialogResponse.CANCEL)
'End Sub

Sub Button3_Click ' Delete Record
	If SelectedRows.Contains(RowID_Riga) Then
		Dim sf As Object = xui.Msgbox2Async("Elimino la riga?", "CANCELLAZIONE RIGA", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			DeleteRow(B4XTable1, RowID_Riga)
		End If
	Else
		Dim sf As Object = xui.Msgbox2Async("Selezionare la riga da eliminare","ATTENZIONE","OK","","",Null)
	End If
End Sub

Sub Button2_Click ' New Record (Riga)
	Operazione="Add"
'	vBarcodeLetto = ""
	vUM = ""
	EditText4.Enabled=True
	EditText4.RequestFocus
	Panel2.Visible=True
	Panel1.SendToBack
	B4XTable1.ClearDataView
	Dim cdw As ColorDrawable
	cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
	Panel2.Background = cdw
	Label10.Text="#" & (B4XTable1.Size+1)
	Label9.Text=""
	Label6.Text=""
	Label7.Text=""
	Label14.Text=""
	Label15.Text=""
	Label16.Text=""
	EditText1.Text=""
	EditText2.Text=""
	EditText3.Text=""
	EditText4.Text=""
	If(NewDocument.vOperazione="NewDoc") Then
		If(NewDocument.vTipoDocNew="INV") Then
			chk_Omaggio.Visible=False
			EditText3.Visible=False
			Label4.Visible=False
			EditText1.Visible=False
			Label3.Visible=False
		End If
	Else
		If(ListaDoc.vTipoDoc="INV") Then
			chk_Omaggio.Visible = False
			EditText3.Visible=False
'			Label4.Visible=False			
			EditText1.Visible=False
			Label3.Visible=False
		End If
	End If
End Sub

Sub Button1_Click ' Modifica riga
	'Panel1.Width = 100%x
'	'Panel1.Height = 100%y
	Try
		If (ListaDoc.vTrasmesso=1) Then
			SwiftButton1.mBase.Color = Colors.Transparent
			SwiftButton2.xLBL.TextColor = Colors.Gray
			SwiftButton1.Enabled = False
			SwiftButton1.xLBL.Text = ""
			EditText1.Enabled = False
			EditText2.Enabled = False
			EditText3.Enabled = False
			EditText4.Enabled = False
			Button7.Enabled = False
		Else
			SwiftButton1.Enabled = True
		End If
		Operazione="Modify"
		If (IDriga <> 0) Then
			EditText4.Text=""
			Panel2.Visible=True
			Panel1.SendToBack
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
			Panel2.Background = cdw			
			Label10.Text="#" & IDriga
			EditText2.Text=Qta
			' Legge tutti i dati del record
			If(NewDocument.vOperazione="NewDoc") Then
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Barcode, RD.Descrizione, RD.Qta FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " _
				& "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '"	& NewDocument.vNumDocNew  & "' AND " _
				& "RD.Esercizio = '" & NewDocument.vEsercizioNew & "' AND RD.Idriga = '" & IDriga & "'"
			Else
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Barcode, RD.Descrizione, RD.Qta FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " _
				& "WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' AND RD.Numerodoc = '" & ListaDoc.vNumerodoc  & "' AND RD.Esercizio = '" _
				& ListaDoc.vEsercizio & "' AND RD.Idriga = '" & IDriga & "'"				
			End If
			Log(sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Label10.Text = "#" & rs.GetInt("Idriga")
				EditText2.Text = rs.GetInt("Qta")
				EditText4.Text = rs.GetString("Barcode")				
			Loop
			rs.close
			EditText4.Enabled=False
			EditText2.RequestFocus
			EditText2.SelectAll
		Else
			ToastMessageShow("Selezionare la riga da modificare!",False)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button7_Click
	StartActivity(Ricerca_AZ)
End Sub

Sub SwiftButton1_Click()
	' OK
	RegistraRiga(EditText4.Text)
End Sub

Sub RegistraRiga(BarcodeCopy As String)
	' OK
	Dim vQta As String
	vQta = EditText2.text
	If (BarcodeCopy <> "") And (IsNumber(vQta)) Then
		Select Operazione
			Case "Add" ' aggiungi riga
				Dim Pos As Int = B4XTable1.Size+1
				Dim Note As String = ""
				B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?)"$ , Array As Object(Pos,"", BarcodeCopy.trim, EditText2.text))
				Dim sql As String = "INSERT INTO GS_RIGHEDOCUMENTI_LT (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
				sql = sql & "Descrizione,Sconto,PrzUnit,Note,UM,Barcode) VALUES "
				If(NewDocument.vOperazione="NewDoc") Then
					sql = sql & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
				Else
					sql = sql & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
				End If
				sql = sql & Main.Utente & "','" & BarcodeCopy.Trim & "','" & EditText2.text & "','" & Label9.Text & "','" & EditText3.Text & "','" _
				& Label6.text & "','" & Note & "','" & vUM & "','" & BarcodeCopy & "')"
				SQLDataAccess.ExecNonQuery(sql)
				B4XTable1.ClearDataView
				' Sleep(0)
				Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
				column1.InternalSortMode="DESC"
				'-------------------------------------------------------------------------------------
				' serve per fare la somma delle colonne
				'-------------------------------------------------------------------------------------
				Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
				Dim total As Double = 0
				Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
				Dim totalriga As Double
				Do While rs.NextRow
					totalriga = rs.GetString("c3")
					total = total + totalriga
				Loop
				rs.Close
				Label11.Text = NumberFormat2(total,0,0,0,False)
				'-------------------------------------------------------------------------------------
				B4XTable1.Refresh
				
			Case "Modify"					
				If(NewDocument.vOperazione="NewDoc") Then
					B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ? WHERE rowid = ?", Array (IDriga,"",EditText4.text, EditText2.Text, RowID_Riga))
					Dim sql As String
					sql = "UPDATE GS_RIGHEDOCUMENTI_LT SET Barcode = ?, DESCRIZIONE = ?, QTA = ? WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
					SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text,"",EditText2.Text, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
				Else
					B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ? WHERE rowid = ?", Array (IDriga,"",EditText4.text, EditText2.Text, RowID_Riga))
					Dim sql As String
					sql = "UPDATE GS_RIGHEDOCUMENTI_LT SET Codart = ?, Descrizione = ?, Qta = ? WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
					SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text,"", EditText2.Text, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
				End If
				'-------------------------------------------------------------------------------------
				' serve per fare la somma delle colonne
				'-------------------------------------------------------------------------------------
				Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
				Dim total As Double = 0
				Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
				Dim totalriga As Double
				Do While rs.NextRow
					totalriga = rs.GetString("c3")
					total = total + totalriga
				Loop
				rs.Close
				Label11.Text = NumberFormat2(total,0,0,0,False)
				'-------------------------------------------------------------------------------------
				' B4XTable1.ClearDataView
				B4XTable1.Refresh
				
		End Select
		Panel2.Visible=False
		Phone.HideKeyboard
		If (Main.SwitchRepeatAdd=1) And (Operazione="Add") Then
			Panel2.Visible=True
			Panel1.SendToBack
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
			Panel2.Background = cdw
			Label10.Text="#" & (B4XTable1.Size+1)
			Label9.Text=""
			Label7.Text=""
			Label6.Text=""
			Label14.Text=""
			Label15.Text=""
			Label16.Text=""
			EditText1.Text=""
			EditText2.Text=""
			EditText3.Text=""
			EditText4.Text=""
			EditText4.RequestFocus
			Panel2.Visible=True
		End If
		If (vQta=0) Then
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Quantità a zero, modificare la riga in caso di errore!","ATTENZIONE")
		End If
	Else
		ExtraUtility.Play_Sound("error.wav")
		MsgboxAsync("Inserimento errato controllare PARTITA e QUANTITA'","ERRORE")
	End If
End Sub


Sub SwiftButton2_Click
	' Annulla
	Panel2.Visible=False
	Sleep(0)
	Dim Phone As IME
	Phone.HideKeyboard
End Sub

Sub EditText4_EnterPressed ' barcode
	Dim vBarcodeLettoNum As Int = 0
	EditText4.Text=EditText4.Text.ToUpperCase
	vBarcodeLetto = EditText4.Text
	sqlstr = "SELECT TipoDoc,Numerodoc,Esercizio,Idriga FROM GS_RIGHEDOCUMENTI_LT WHERE Barcode = ? AND TipoDoc='INV'"
	Dim rs1 As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String (vBarcodeLettoNum))
	If(rs1.RowCount=0) Then
		Wait For (Check_Partita(vBarcodeLetto)) Complete (Success As Boolean)
		If(Success) Then
			If(EditText2.Text<>"") Then				
				RegistraRiga(vBarcodeLetto)
			Else
				EditText2.RequestFocus
			End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("Codice PARTITA non valido!",True)
		End If
	Else
		Do While rs1.NextRow
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Articolo già presente in inventario documento " & rs1.GetString("TipoDoc") & " n. "  & rs1.Getstring("Numerodoc") _
			& "/" & rs1.Getstring("Esercizio") & " riga: " &  rs1.GetString("Idriga") & ".","CONTROLLO")
		Loop
	End If
	rs1.Close
End Sub

Sub EditText2_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		EditText2.InputType = EditText2.INPUT_TYPE_TEXT
	Else
		Phone.ShowKeyboard(EditText2)
		EditText2.InputType = EditText2.INPUT_TYPE_DECIMAL_NUMBERS
	End If
End Sub

Sub EditText4_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		If(EditText4.Text <> "")  Then
			EditText2.RequestFocus
			Phone.ShowKeyboard(EditText2)
		Else
			' caso errore riamngo sul codice
			EditText4.RequestFocus
		End If
	End If
End Sub

Sub EditText2_TextChanged (Old As String, New As String)
	If (New.Length>5) Then
		ExtraUtility.Play_Sound("error.wav")
		EditText2.Text = ""
		ToastMessageShow("LA QUANTITA' INSERITA E' ERRATA!",True)
		EditText2.RequestFocus
	Else
		If(New.Length=5) Then
			Dim QtaPelli As Long = New
			If(QtaPelli>=10000) Then
				ExtraUtility.Play_Sound("error.wav")
				Dim sf As Object = xui.Msgbox2Async("Quantità maggiore di 10.000 pezzi?","CONTROLLO", "OK", "", "NO", Null)
				Wait For (sf) Msgbox_Result (Result As Int)
				If Result = xui.DialogResponse_Negative Then
					EditText2.RequestFocus
				End If
			End If
		End If
	End If
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	If HasFocus=True Then
		If (EditText1.Text="0.0") Then
			EditText1.Text = ""
		End If
	End If
End Sub

Sub Check_Partita(Partita As String) As ResumableSub
	' Controllo se il codice partita è corretto
	Try
		If(Partita.Length>14) Then
			Dim PartitaStr As String = Partita.SubString2(2,8)
			If(IsNumber(PartitaStr)) Then
				Dim PartitaNum As Long = 0
				PartitaNum = PartitaStr
				Dim vPos1 As Int = Partita.IndexOf("$")		
				Dim vPos2 As Int = Partita.IndexOf2("N",3)
				Dim QtaPelli As Long = 0
				If(vPos2=13) Then
					QtaPelli = Partita.SubString(vPos2+1)
				End If
				If(vPos1=8) And (vPos2=13) And (PartitaNum>200000) And (QtaPelli>0) Then
					If(QtaPelli>=10000) Then
						ExtraUtility.Play_Sound("error.wav")
						Dim sf As Object = xui.Msgbox2Async("Quantità maggiore di 10.000 pezzi?","CONTROLLO", "OK", "", "NO", Null)
						Wait For (sf) Msgbox_Result (Result As Int)
						If Result = xui.DialogResponse_Positive Then
							Return True
						Else
							Return False
						End If
					Else
						Return True
					End If
				Else
					Return False
				End If	
			Else
				Return False
			End If
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub
