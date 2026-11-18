B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.8
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
	Private Dialog As B4XDialog
	Private Base As B4XView
	Private B4XTable1 As B4XTable
	Private xui As XUI
	Dim xlbl As B4XView
	Dim sqlstr As String
	Private Button1 As Button
	Private Button2 As Button	
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Panel2 As Panel
	Dim IDriga As Int
	Dim CodArt As String
	Dim Descrizione As String
	Dim Qta As Double
	Private RowID_Riga As Long
	Dim Operazione As String 
	Private xui As XUI
	Private Panel1 As Panel
	Private Label1 As Label
	Private Label9 As Label
	Private EditText1 As EditText
	Private EditText2 As EditText	
	Private EditText3 As EditText
	Private EditText4 As EditText
	Private EditText5 As EditText
	Private Label10 As Label
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private DataList As List
	Private Phone As IME
	Public vTipoDocNew As String
	Public vNumDocNew As Int
	Public vEsercizioNew As Int
	Public vDataDocNew As String
	Public vOperazione As String
	Public vRagSoc As String
	Public vNumListino As Int
	Public vTipoRiga As String
	Public vBarcodeLetto As String
	Private vUM As String	
	Private Col3_Column As B4XTableColumn
	Private Col4_Column As B4XTableColumn
	Private Col5_Column As B4XTableColumn
	Private Col6_Column As B4XTableColumn
	Private Col7_Column As B4XTableColumn
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
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:	
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("RigheDoc_Esseci")
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
	If(NewDocument.vOperazione="NewDoc") Then									
		Label1.text = NewDocument.vTipoDocNew & " n. " & NewDocument.vNumDocNew &  " del " & NewDocument.vDataDocNew & Chr(10) & Chr(13) & NewDocument.vRagSoc
		vNumListino = NewDocument.vNumListinoNew
	Else
		vNumListino = DB_SQLite.Leggi_NRListinoTesteDoc(SQLDataAccess,ListaDoc.vTipoDoc,ListaDoc.vNumerodoc,ListaDoc.vEsercizio)
	End If	
	ListaRigheDoc
	Label13.Text = vNumListino
	vBarcodeLetto = ""
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
	End If	
	EditText2.InputType = EditText2.INPUT_TYPE_TEXT
	If (Choose_Menu.vTipoCliFor="F") Then
		Label5.Visible=True
		EditText5.Visible=True
	Else
		Label5.Visible=False
		EditText5.Visible=False
	End If
	
End Sub

Sub Activity_Resume
	Sleep(0)
	If(Ricerca_AZ.vCodice<>"") Then
		EditText4.Text=Ricerca_AZ.vCodice
		Label9.Text=Ricerca_AZ.vDescrizione
		Dim PrezzoCorr As Double = 0
		vUM = DB_SQLite.Leggi_UM_Articolo(SQLDataAccess,Choose_Menu.vTipoCliFor,EditText4.Text)
		PrezzoCorr = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
		EditText1.Text = PrezzoCorr
		EditText2.RequestFocus
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"PrzUnit",Gravity.RIGHT)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
	'	For j = 0 To B4XTable1.Columns.size - 1
	'		Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
	'       ExtraUtility.SetSingleLine( i + 1 , column,True,"END")			
	'	Next
	Next
	For i = 1 To Col3_Column.CellsLayouts.Size - 1
		' Colonna 3
		Dim pnl1 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 11
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 4
		Dim pnl2 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 13
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
		' Colonna 5
		Dim pnl3 As B4XView = Col5_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 13
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
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

private Sub ListaRigheDoc
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.HintColor = Colors.Green
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 10
	B4XTable1.RowHeight = 40dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS).Width=85 ' n
	B4XTable1.AddColumn("CodArt", B4XTable1.COLUMN_TYPE_TEXT).Width=1 ' CODART
	' B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT).Width=380 ' DESCRIZIONE
	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) ' Descrizione
	Col3_Column.Width = 380	
	Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_NUMBERS)
	Col4_Column.Width=100 ' NUMBERS	
	Dim Col5_Column As B4XTableColumn = B4XTable1.AddColumn("Prezzo", B4XTable1.COLUMN_TYPE_NUMBERS)
	Col5_Column.Width=140 '140 NUMBERS
	Dim Col6_Column As B4XTableColumn = B4XTable1.AddColumn("Sconto", B4XTable1.COLUMN_TYPE_TEXT)
	Col6_Column.Width=1 ' TEXT	
	Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("TipoRiga", B4XTable1.COLUMN_TYPE_TEXT)
	Col7_Column.Width=1 ' TEXT	
	ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
	ExtraUtility.CreateCustomFormat2dec(Col5_Column,B4XTable1)
	DataList.Initialize
	If(NewDocument.vOperazione="NewDoc") Then
		sqlstr = "select Idriga, Codart, Descrizione, Qta, PrzUnit, TipoRiga, Sconto from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & vTipoDocNew
		sqlstr = sqlstr & "' AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "select Idriga, Codart, Descrizione, Qta, PrzUnit, TipoRiga, Sconto from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & ListaDoc.vTipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & ListaDoc.vNumerodoc  & "' AND Esercizio = '" & ListaDoc.vEsercizio & "'"
	End If
	Log(sqlstr)
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(7) As Object
		rowx(0) = rs.GetInt("Idriga")
		rowx(1) = rs.Getstring("Codart")
		rowx(2) = rs.Getstring("Descrizione")
		rowx(3) = rs.GetDouble("Qta")
		rowx(4) = rs.GetDouble("PrzUnit")				
		rowx(5) = rs.GetString("Sconto")
		rowx(6) = rs.GetString("TipoRiga")
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	Dim total As Double = 0
	Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))	
	Dim totalriga As Double
	Do While rs.NextRow	
		totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
		total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"), rs.GetString("c6"))
	Loop
	rs.Close
	Label11.Text = formatter.Format(total)
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
	sql = "DELETE FROM IS_RIGHEDOCUMENTI WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc _
	& "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga = " & IDriga 
	Log(sql)
	SQLDataAccess.ExecNonQuery(sql)
	sql = "UPDATE IS_RIGHEDOCUMENTI SET Idriga = Idriga-1 WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" _
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
		totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
		total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),rs.GetString("c6"))
	Loop
	rs.Close
	Label11.Text = formatter.Format(total)
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
	chk_Omaggio.Checked = False
	Panel2.Visible=True
	Panel1.SendToBack
	B4XTable1.ClearDataView
	Dim cdw As ColorDrawable
	cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
	Panel2.Background = cdw
	Label10.Text="#" & (B4XTable1.Size+1)
	Label9.Text=""
	EditText1.Text=""
	EditText2.Text=""
	EditText3.Text=""
	EditText4.Text=""
	EditText5.Text=""
	If (Choose_Menu.vTipoCliFor="F") Then
		Label5.Visible = True
		EditText5.Visible = True
	Else
		Label5.Visible = False
		EditText5.Visible = False
	End If
	If(NewDocument.vOperazione="NewDoc") Then
		If(NewDocument.vTipoDocNew="INV") Then
			chk_Omaggio.Visible=False
			EditText3.Visible=False
			Label4.Visible=False
			EditText1.Visible=False
			Label3.Visible=False			
		End If
		If (ListaDoc.vTrasmesso = 1) Then
			Label5.Visible=False
			EditText5.Visible=False			
		End If
	Else
		If(ListaDoc.vTipoDoc="INV") Then	
			chk_Omaggio.Visible = False
			EditText3.Visible=False
'			Label4.Visible=False			
			EditText1.Visible=False
			Label3.Visible=False
		End If
		If (ListaDoc.vTrasmesso = 1) Then
			Label5.Visible=False
			EditText5.Visible=False
		End If
	End If
	EditText4.RequestFocus
End Sub

Sub Button1_Click ' Modifica riga
	'Panel1.Width = 100%x
'	'Panel1.Height = 100%y
	Try
		If (ListaDoc.vTrasmesso=1) Then
			'SwiftButton1.disabledColor = Colors.Gray
			'SwiftButton1.disabledColor = Colors.Transparent
			'SwiftButton2.disabledColor = Colors.Gray
			'SwiftButton1.SetColors(Colors.Blue,Colors.Magenta)
			SwiftButton1.mBase.Color = Colors.Transparent	
			SwiftButton2.xLBL.TextColor = Colors.Gray
			SwiftButton1.Enabled = False
			SwiftButton1.xLBL.Text = ""
			EditText1.Enabled = False
			EditText2.Enabled = False
			EditText3.Enabled = False
			EditText4.Enabled = False
			chk_Omaggio.Enabled = False
			Button7.Enabled = False		
		Else
			SwiftButton1.Enabled = True
		End If
		Label5.Visible=False
		EditText5.Visible=False
		Operazione="Modify" 
		If (CodArt <> "") Then
			Panel2.Visible=True	
			Panel1.SendToBack
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
			Panel2.Background = cdw
			EditText5.Text=""
			EditText4.Text=CodArt
			Label9.Text=Descrizione
			Label10.Text="#" & IDriga
			EditText2.Text=Qta
 		    ' Legge tutti i dati del record 
			If(NewDocument.vOperazione="NewDoc") Then
				sqlstr = "SELECT Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto, Magazzino, VARIAMISURE, TipoRiga, UM "
				sqlstr = sqlstr & " FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & NewDocument.vTipoDocNew & "' AND Numerodoc = '"
				sqlstr = sqlstr & NewDocument.vNumDocNew  & "' AND Esercizio = '" & NewDocument.vEsercizioNew & "' AND Idriga = '" & IDriga & "'"
			Else
				sqlstr = "SELECT Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto, Magazzino, VARIAMISURE, TipoRiga, UM "
				sqlstr = sqlstr & " FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & ListaDoc.vTipoDoc & "' AND Numerodoc = '"
				sqlstr = sqlstr & ListaDoc.vNumerodoc  & "' AND Esercizio = '" & ListaDoc.vEsercizio & "' AND Idriga = '" & IDriga & "'"				
			End If
			Log(sqlstr)				
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Label10.Text = "#" & rs.GetInt("Idriga")
				EditText4.Text = rs.GetString("Codart")
				Label9.Text = rs.GetString("Descrizione")
				EditText2.Text = rs.GetInt("Qta")
				EditText1.Text = rs.GetDouble("PrzUnit")
				EditText3.Text = rs.GetString("Sconto")
				vBarcodeLetto = rs.GetString("VARIAMISURE")
				vUM = rs.GetString("UM")
				vTipoRiga = rs.GetString("TipoRiga")
			Loop
			rs.close
			If (vTipoRiga ="O") Then
				chk_Omaggio.Checked = True
			Else
				chk_Omaggio.Checked = False
			End If
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
					Label4.Visible=False
					EditText1.Visible=False
					Label3.Visible=False
				End If
			End If
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
	Dim vCodArt As String
	vCodArt = EditText4.Text
	Dim vQta As String
	If (chk_Omaggio.Checked) Then
		vTipoRiga = "O"
	Else
		vTipoRiga = "N"
	End If
	vQta = EditText2.text	
	If (ExtraUtility.Check_Sconto_Syntax(EditText3.Text)) Then
		Dim ValSconto As Double = 0
		If (EditText3.Text.Trim <> "") Then
			ValSconto = ExtraUtility.Calc_Valore_Scontato(EditText1.Text,EditText3.Text,"N")
			If (ValSconto=0) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Verificare la stringa dello sconto!","ATTENZIONE")
			End If
			If (ValSconto<0) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Lo sconto applicato supera il 100%.","ATTENZIONE")
			End If			
		End If
		If (vCodArt <> "") And (IsNumber(vQta)) Then		
			Select Operazione
				Case "Add" ' aggiungi riga			
		'			rowx(0) = rs.GetInt("Idriga")
		'			rowx(1) = rs.Getstring("Codart")
		'			rowx(2) = rs.Getstring("Descrizione")
					Dim Pos As Int = B4XTable1.Size+1			
					Dim DataConsegna As String
					DataConsegna = ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy","it","")
					Dim Note As String = ""
					Dim RifIdTesta As Int = 0				
					B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?)"$ , Array As Object(Pos, EditText4.Text, Label9.Text, EditText2.text, EditText1.text, EditText3.text,vTipoRiga))
					Dim sql As String = "INSERT INTO IS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
					sql = sql & "Descrizione,Sconto,PrzUnit,TipoRiga,Magazzino,DataConsegna,Note,RifIdTesta,VariaMisure,UM) VALUES "
					If(NewDocument.vOperazione="NewDoc") Then 
						sql = sql & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
					Else
						sql = sql & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
					End If
					sql = sql & Main.Utente & "','" & EditText4.text.Trim & "','" & EditText2.text & "','" & Label9.Text & "','" & EditText3.Text & "','"
					sql = sql & EditText1.Text & "','" & vTipoRiga & "','','" & DataConsegna & "','" & Note & "'," & RifIdTesta & ",'" & vBarcodeLetto & "','" & vUM & "')"
					SQLDataAccess.ExecNonQuery(sql)
					B4XTable1.ClearDataView
					Sleep(0)
					Dim pag As Int
					pag = B4XTable1.mCurrentCount/B4XTable1.RowsPerPage
					'Log("pagina " & pag)				
					Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
					'Log ("Sort " & column1.InternalSortMode)
					If column1.InternalSortMode <> "DESC" Then
						' column.InternalSortMode= "DESC"
						B4XTable1.CurrentPage = pag + 1
					Else
						' column.InternalSortMode= "ASC"
						B4XTable1.CurrentPage = 1
					End If
					'-------------------------------------------------------------------------------------
					' serve per fare la somma delle colonne
					'-------------------------------------------------------------------------------------
					Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
					Dim total As Double = 0
					Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
					Dim totalriga As Double
					Do While rs.NextRow
						totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto
						total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),rs.GetString("c6"))
					Loop
					rs.Close
					Label11.Text = formatter.Format(total)
					'-------------------------------------------------------------------------------------
					' B4XTable1.ClearDataView
					B4XTable1.Refresh	
					
				Case "Modify"		
					If(NewDocument.vOperazione="NewDoc") Then
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,EditText4.text,Label9.Text,EditText2.text,EditText1.Text, EditText3.Text,vTipoRiga, RowID_Riga))
						Dim sql As String
						sql = "UPDATE IS_RIGHEDOCUMENTI SET CODART = ?, DESCRIZIONE = ?, QTA = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text, Label9.Text, EditText2.Text, EditText1.text, EditText3.text, vTipoRiga, vUM, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
					Else
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,EditText4.text,Label9.Text,EditText2.text,EditText1.Text, EditText3.Text, vTipoRiga, RowID_Riga))
						Dim sql As String
						sql = "UPDATE IS_RIGHEDOCUMENTI SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text, Label9.Text, EditText2.Text, EditText1.text, EditText3.text, vTipoRiga, vUM, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
					End If		
					'-------------------------------------------------------------------------------------
					' serve per fare la somma delle colonne
					'-------------------------------------------------------------------------------------
					Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
					Dim total As Double = 0
					Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
					Dim totalriga As Double
					Do While rs.NextRow
						totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
						total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),rs.GetString("c6"))
					Loop
					rs.Close
					Label11.Text = formatter.Format(total)
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
				EditText1.Text=""
				EditText2.Text = ""
				EditText3.Text=""
				EditText4.Text=""
				EditText5.Text=""
				EditText4.RequestFocus
				Panel2.Visible=True
			End If		
			If (Main.SwitchQtaDefault=1) And (vQta = 0) Then				
				EditText2.Text = "1"
				vQta = 1
			End If				
			If (vQta = 0) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Quantità a zero, modificare la riga in caso di errore!","ATTENZIONE")
			End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Inserimento errato controllare articolo e quantità","ERRORE")
		End If
	Else
		ExtraUtility.Play_Sound("error.wav")
		MsgboxAsync("Utilizzare solo valori numerici ed il carattere '+' per sconti composti o il punto come decimale!","ERRORE SCONTO")
	End If
End Sub

Sub SwiftButton2_Click
	' Annulla
	Panel2.Visible=False
	Sleep(0)
	Dim Phone As IME
	Phone.HideKeyboard
End Sub

Sub EditText4_EnterPressed
	' 8056455939510	
	vBarcodeLetto = EditText4.Text
	Select Main.Ditta
		Case "ZelariVi"
			sqlstr = "select CODICE,DESCRIZIONE,UMV,UMA,UM from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA='0' AND BARCODE like '" & EditText4.Text.Trim & "%'"
		Case "Esseci"
			If (Choose_Menu.vTipoCliFor="F") Then
				' il valore della giacenza viene visulizzato solo per i documenti di acquisto
				sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI " _
					& "AA LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
			Else
				sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
			End If
			
		Case "Nesti"
			If (Choose_Menu.vTipoCliFor="F") Then
				' il valore della giacenza viene visulizzato solo per i documenti di acquisto
				sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI " _
					& "AA LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
			Else
				sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
			End If
			
		'sqlstr = "select CODICE,DESCRIZIONE,UMV,UMA,UM from IS_ANAGRAFICAARTICOLI WHERE CODICE = '" & EditText4.Text.Trim & "'"
	End Select
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	If (rs.RowCount>0) Then
		Do While rs.NextRow
			If (Choose_Menu.vTipoCliFor="F") Then
				EditText5.text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)
			End If				
			Label9.Text = rs.GetString("DESCRIZIONE")
			EditText4.Text = rs.GetString("CODICE")		
			EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
			If (Choose_Menu.vTipoCliFor="C") Then
				vUM = rs.GetString("UMV")
			Else
				vUM = rs.GetString("UMA")
			End If
		Loop		
		rs.close
	Else
		Select Main.Ditta
			Case "Esseci"
				If (Choose_Menu.vTipoCliFor="F") Then
					sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM (IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& " ON AA.CODICE=BC.ARTICOLO) LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"				
				Else
					sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"
				End If
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				'Dim Giacenza As Double = 0
				If (rs.RowCount>0) Then
					Do While rs.NextRow
						If (Choose_Menu.vTipoCliFor="F") Then
							EditText5.text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)
						End If
						Label9.Text = rs.GetString("DESCRIZIONE")
						EditText4.Text = rs.GetString("ARTICOLO")
						EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
						If (Choose_Menu.vTipoCliFor="C") Then
							vUM = rs.GetString("UMV")
						Else
							vUM = rs.GetString("UMA")
						End If
					Loop
					rs.close
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText4.Text = ""
					EditText5.Text = ""
				End If
			Case "Nesti"
				If (Choose_Menu.vTipoCliFor="F") Then
					sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM (IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& " ON AA.CODICE=BC.ARTICOLO) LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"				
				Else
					sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"
				End If
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				'Dim Giacenza As Double = 0
				If (rs.RowCount>0) Then
					Do While rs.NextRow
						If (Choose_Menu.vTipoCliFor="F") Then
							EditText5.text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)
						End If
						Label9.Text = rs.GetString("DESCRIZIONE")
						EditText4.Text = rs.GetString("ARTICOLO")												
						EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
						If (Choose_Menu.vTipoCliFor="C") Then
							vUM = rs.GetString("UMV")
						Else
							vUM = rs.GetString("UMA")
						End If						
					Loop	
					rs.close				
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText4.Text = ""
					EditText5.Text = ""
				End If
			Case Else
				ExtraUtility.Play_Sound("error.wav")
				Label9.Text = "*** CODICE ERRATO ***"
				EditText4.Text = ""
				EditText5.Text = ""
		End Select
	End If
	If (EditText4.Text <> "") Then
		' trova il listino minimo
		Dim PrezzoCorr As Double = 0 
		PrezzoCorr = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
		EditText1.Text = PrezzoCorr
		Phone.ShowKeyboard(EditText2)
		EditText2.RequestFocus		
		' trova il listino corrente
	End If
End Sub

Sub EditText2_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		EditText2.InputType = EditText2.INPUT_TYPE_TEXT
		If (EditText2.Text.Length>5) Then
			EditText4.Text = EditText2.Text
			EditText4_EnterPressed
			EditText2.Text = ""
			EditText2.RequestFocus
		End If
	Else
		If (Main.SwitchQtaDefault=1) And (EditText2.Text="") Then
			EditText2.Text = "1"	
			EditText2.SelectAll
		End If
		EditText2.InputType = EditText2.INPUT_TYPE_DECIMAL_NUMBERS
	End If
End Sub

Sub EditText4_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		If(EditText4.Text <> "")  Then
			EditText2.RequestFocus
			Phone.ShowKeyboard(EditText2)
		Else			
			If(Label9.Text = "*** CODICE ERRATO ***") Then
				' caso errore riamngo sul codice
				EditText4.RequestFocus
			End If
		End If
	End If
End Sub

Sub EditText2_TextChanged (Old As String, New As String)
	If (New.Length>5) Then
		ExtraUtility.Play_Sound("error.wav")
		EditText2.Text = ""
		ToastMessageShow("LA QUANTITA' INSERITA E' ERRATA!",True)
		EditText2.RequestFocus
	End If
End Sub

Sub EditText2_EnterPressed
	If (EditText2.Text.Length <= 5) Then
		EditText1.RequestFocus
	End If	
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	If HasFocus=True Then
		If (EditText1.Text="0.0") Then
			EditText1.Text = ""
		End If
	End If
End Sub

Sub EditText1_EnterPressed
	If (EditText1.text >= 99999 ) Then
		EditText1.Text = ""
		EditText1.RequestFocus		
		ExtraUtility.Play_Sound("error.wav")
		ToastMessageShow("VERIFICARE IL PREZZO INSERITO!",True)
	Else
		EditText3.RequestFocus
	End If	
End Sub

