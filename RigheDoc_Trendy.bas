B4A=true
Group=Default Group\Trendy
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
	Public F_Barcode As Boolean = False
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
	Private Label10 As Label
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private DataList As List
	Private Phone As IME
	Public vTipoDocNew As String
'	Public vNumDocNew As Int
'	Public vEsercizioNew As Int
'	Public vDataDocNew As String
	Private vCodNegozio As String
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
	Private Label6 As Label
	Private Label7 As Label
	Private vCodNegozioArt As String
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
	Activity.LoadLayout("RigheDoc_Trendy")
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
	Button4.Enabled=True
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
		vCodNegozio = NewDocument.vCodNegozio
	Else
		vCodNegozio = ListaDoc.vCodNegozio
	End If	
	ListaRigheDoc(True, F_Barcode)
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
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
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

private Sub ListaRigheDoc(FirstTime As Boolean,F_StatoBarcode As Boolean)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	If(FirstTime) Then
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
		Dim categ1 As String
		Dim categ2 As String
		Dim categ3 As String
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
	End If
	Dim DataList As List
	DataList.Initialize
	If(NewDocument.vOperazione="NewDoc") Then
		sqlstr = "select RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.TipoRiga, RD.Sconto, '' as CodNegozio from " &  Main.PrefixSQL & "_RIGHEDOCUMENTI RD " _
		& "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '" & NewDocument.vNumDocNew  & "' AND RD.Esercizio = '" & NewDocument.vEsercizioNew & "'"			
	Else
		sqlstr = "select RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.TipoRiga, RD.Sconto, TD.CodNegozio, GA.DESCCAT1, GA.DESCCAT2, GA.DESCCAT3, RD.BARCODE from (" & Main.PrefixSQL _
		& "_RIGHEDOCUMENTI RD LEFT OUTER JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI As TD ON TD.TipoDoc=RD.TipoDoc And TD.Numerodoc=RD.Numerodoc And TD.Esercizio=RD.Esercizio) " _
		& "LEFT OUTER JOIN GS_ARTICOLI AS GA ON GA.BARCODE=RD.BARCODE WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' AND RD.Numerodoc = '" & ListaDoc.vNumerodoc _ 
		& "' AND RD.Esercizio = '" & ListaDoc.vEsercizio & "'"				
	End If
	Log(sqlstr)
	If(NewDocument.vOperazione="NewDoc") Then
		vCodNegozio = NewDocument.vCodNegozio
	Else
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rs.RowCount>0) Then
			Do While rs.NextRow
				Dim rowx(7) As Object
				If(rs.GetString("DESCCAT1").Length>=15) Then
					categ1 = rs.GetString("DESCCAT1").SubString2(0,14)
				Else
					categ1 = rs.GetString("DESCCAT1")
				End If
				If(rs.GetString("DESCCAT2").Length>=15) Then
					categ2 = rs.GetString("DESCCAT2").SubString2(0,14)
				Else
					categ2 = rs.GetString("DESCCAT2")
				End If
				If(rs.GetString("DESCCAT3").Length>=15) Then
					categ3 = rs.GetString("DESCCAT3").SubString2(0,14)
				Else
					categ3 = rs.GetString("DESCCAT3")
				End If
				rowx(0) = rs.GetInt("Idriga")
				rowx(1) = rs.Getstring("Codart")
				If(F_StatoBarcode) Then
				    rowx(2) = "                               Barcode -> " & rs.GetString("Barcode") & CRLF & rs.Getstring("Descrizione") & CRLF & categ1 & " - " & categ2					
				Else
					rowx(2) = rs.Getstring("Descrizione") & CRLF & categ1 & " - " & categ2 & " - " & categ3
				End If
				rowx(3) = rs.GetDouble("Qta")
				rowx(4) = rs.GetDouble("PrzUnit")				
				rowx(5) = rs.GetString("Sconto")
				rowx(6) = rs.GetString("TipoRiga")				
				DataList.Add(rowx)
			Loop		
		Else
			sqlstr = "SELECT IFNULL(CodNegozio,'') as CodNegozio FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE " _
			&  "TipoDoc = '" & ListaDoc.vTipoDoc & "' AND Numerodoc = '" & ListaDoc.vNumerodoc  & "' AND Esercizio = '" & ListaDoc.vEsercizio & "'"
			vCodNegozio = SQLDataAccess.ExecQuerySingleResult(sqlstr)		
		End If
		rs.Close
	End If
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

Sub Button4_Click ' Extra (setta barcode si/no)
	F_Barcode=Not(F_Barcode)
	ListaRigheDoc(False, F_Barcode)
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
	EditText4.RequestFocus
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
			chk_Omaggio.Enabled = False
			Button7.Enabled = False		
		Else
			SwiftButton1.Enabled = True
		End If
		Operazione="Modify" 
		If (CodArt <> "") Then
			EditText4.Text=""
			Panel2.Visible=True	
			Panel1.SendToBack
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
			Panel2.Background = cdw
			Label9.Text=Descrizione
			Label10.Text="#" & IDriga
			EditText2.Text=Qta
 		    ' Legge tutti i dati del record 
			If(NewDocument.vOperazione="NewDoc") Then
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.Sconto, RD.Magazzino, RD.VARIAMISURE, RD.TipoRiga, RD.UM, " _
				& "IFNULL(RD.DesCat1,'') AS DesCat1, IFNULL(RD.DesCat2,'') AS DesCat2, IFNULL(RD.DesCat3,'') AS DesCat3, RD.ArticoloAQta, GA.CODNEGOZIO FROM " & Main.PrefixSQL _
				& "_RIGHEDOCUMENTI RD LEFT OUTER JOIN GS_ARTICOLI GA ON GA.BARCODE=RD.Barcode " _
				& "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '"	& NewDocument.vNumDocNew  & "' AND " _
				& "RD.Esercizio = '" & NewDocument.vEsercizioNew & "' AND RD.Idriga = '" & IDriga & "'"
			Else
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.Sconto, RD.Magazzino, RD.VARIAMISURE, RD.TipoRiga, RD.UM, " _
				& "IFNULL(RD.DesCat1,'') AS DesCat1, IFNULL(RD.DesCat2,'') AS DesCat2, IFNULL(RD.DesCat3,'') AS DesCat3, RD.ArticoloAQta, GA.CODNEGOZIO FROM " & Main.PrefixSQL _
				& "_RIGHEDOCUMENTI RD LEFT OUTER JOIN GS_ARTICOLI As GA ON GA.BARCODE=RD.BARCODE " _
				& "WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' AND RD.Numerodoc = '" & ListaDoc.vNumerodoc  & "' AND RD.Esercizio = '" _
				& ListaDoc.vEsercizio & "' AND RD.Idriga = '" & IDriga & "'"				
			End If
			Log(sqlstr)				
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Label10.Text = "#" & rs.GetInt("Idriga")
				Label9.Text = rs.GetString("Descrizione")
				EditText2.Text = rs.GetInt("Qta")
				Label6.text = rs.GetDouble("PrzUnit")
				Label7.Text = rs.GetString("DesCat1") & " - " & rs.GetString("DesCat2") & " - " & rs.GetString("DesCat3")
				EditText3.Text = rs.GetString("Sconto")
				vBarcodeLetto = rs.GetString("VARIAMISURE")
				Label4.Text = rs.GetInt("ArticoloAQta")
				vCodNegozioArt = rs.GetString("CODNEGOZIO")
				Label14.Text = rs.GetString("DesCat1")
				Label15.Text = rs.GetString("DesCat2")				
				Label17.Text = rs.GetString("DesCat3")
				Label16.Text = rs.GetString("Codart")
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
					'Label4.Visible=False
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
	vCodArt = Label16.Text
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
			ValSconto = ExtraUtility.Calc_Valore_Scontato(Label6.TEXT,EditText3.Text,"N")
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
					Dim Categ1 As String = ""
					Dim Categ2 As String = ""
					Dim Categ3 As String = ""
					Dim DescArtCat1Cat2 As String
					If(Label14.text.Length>=15) Then
						Categ1 = Label14.text.SubString2(0,14)
					Else
						Categ1 = Label14.Text
					End If
					If(Label15.text.Length>=15) Then
						Categ2 = Label15.text.SubString2(0,14)
					Else
						Categ2 = Label15.text
					End If
					If(Label17.text.Length>=15) Then
						Categ3 = Label17.text.SubString2(0,14)
					Else
						Categ3 = Label17.text
					End If
					If(Main.DBName="Trendy.db") Then
						DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2 & " - " & Categ3
					Else
						DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2 
					End If
					B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?)"$ , Array As Object(Pos, Label16.text, DescArtCat1Cat2, EditText2.text, Label6.text, EditText3.text,vTipoRiga))
					Dim sql As String = "INSERT INTO GS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
					sql = sql & "Descrizione,Sconto,PrzUnit,TipoRiga,Magazzino,DataConsegna,Note,RifIdTesta,VariaMisure,UM,Barcode,ArticoloAQta,DesCat1,DesCat2,DesCat3) VALUES "
					If(NewDocument.vOperazione="NewDoc") Then 
						sql = sql & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
					Else
						sql = sql & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
					End If
					sql = sql & Main.Utente & "','" & Label16.text.Trim & "','" & EditText2.text & "','" & Label9.Text & "','" & EditText3.Text & "','" _
					& Label6.text & "','" & vTipoRiga & "','','" & DataConsegna & "','" & Note & "'," & RifIdTesta & ",'" & vBarcodeLetto & "','" _
					& vUM & "','" & vBarcodeLetto & "','" & Label4.Text & "','" & Label14.Text & "','" & Label15.Text & "','" & Label17.Text & "')"
					SQLDataAccess.ExecNonQuery(sql)
					B4XTable1.ClearDataView
					Sleep(0)
					Dim pag As Int
					pag = B4XTable1.mCurrentCount/B4XTable1.RowsPerPage
					'Log("pagina " & pag)				
					Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
					column1.InternalSortMode="DESC"
					'Log ("Sort " & column1.InternalSortMode)
					'If column1.InternalSortMode <> "DESC" Then
						' column.InternalSortMode= "DESC"
					'	B4XTable1.CurrentPage = pag + 1
					'Else
						' column.InternalSortMode= "ASC"
					'	B4XTable1.CurrentPage = 1
					'End If
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
					
				Case "Modify"			
					If(Label14.text.Length>=15) Then
						Categ1 = Label14.text.SubString2(0,14)
					Else
						Categ1 = Label14.Text
					End If
					If(Label15.text.Length>=15) Then
						Categ2 = Label15.text.SubString2(0,14)
					Else
						Categ2 = Label15.text
					End If
					If(Label17.text.Length>=15) Then
						Categ3 = Label17.text.SubString2(0,14)
					Else
						Categ3 = Label17.text
					End If
					DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2
					If(NewDocument.vOperazione="NewDoc") Then
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,Label16.text,DescArtCat1Cat2,EditText2.text,Label6.Text, EditText3.Text,vTipoRiga, RowID_Riga))
						Dim sql As String
						sql = "UPDATE GS_RIGHEDOCUMENTI SET CODART = ?, DESCRIZIONE = ?, QTA = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?, DesCat1 = ?, DesCat2 = ?, DesCat3 = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (Label16.text, Label9.Text, EditText2.Text, Label6.text, EditText3.text, vTipoRiga, vUM, Label14.Text, Label15.text, Label17.Text, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
					Else
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,Label16.text,DescArtCat1Cat2,EditText2.text,Label6.Text, EditText3.Text, vTipoRiga, RowID_Riga))
						Dim sql As String
						sql = "UPDATE GS_RIGHEDOCUMENTI SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?, DesCat1 = ?, DesCat2 = ?, DesCat3 = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (Label16.text, Label9.Text, EditText2.Text, Label6.text, EditText3.text, vTipoRiga, vUM, Label14.Text, Label15.text, Label17.text, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
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
				EditText2.Text = ""
				EditText3.Text=""
				EditText4.Text=""
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

Sub RegistraRiga(BarcodeCopy As String)
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
				Dim DataConsegna As String
				DataConsegna = ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy","it","")
				Dim Note As String = ""
				Dim RifIdTesta As Int = 0
				Dim Categ1 As String = ""
				Dim Categ2 As String = ""
				Dim Categ3 As String = ""
				Dim DescArtCat1Cat2 As String
				If(Label14.text.Length>=15) Then
					Categ1 = Label14.text.SubString2(0,14)
				Else
					Categ1 = Label14.Text
				End If
				If(Label15.text.Length>=15) Then
					Categ2 = Label15.text.SubString2(0,14)
				Else
					Categ2 = Label15.text
				End If
				If(Label17.text.Length>=15) Then
					Categ3 = Label17.text.SubString2(0,14)
				Else
					Categ3 = Label17.text
				End If
				If(Main.DBName="Trendy.db") Then
					DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2 & " - " & Categ3
				Else
					DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2
				End If
				B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?)"$ , Array As Object(Pos, BarcodeCopy.trim, DescArtCat1Cat2, EditText2.text, Label6.text, EditText3.text,vTipoRiga))
				Dim sql As String = "INSERT INTO GS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
				sql = sql & "Descrizione,Sconto,PrzUnit,TipoRiga,Magazzino,DataConsegna,Note,RifIdTesta,VariaMisure,UM,Barcode,ArticoloAQta,DesCat1,DesCat2,DesCat3) VALUES "
				If(NewDocument.vOperazione="NewDoc") Then
					sql = sql & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
				Else
					sql = sql & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
				End If
				sql = sql & Main.Utente & "','" & BarcodeCopy.Trim & "','" & EditText2.text & "','" & Label9.Text & "','" & EditText3.Text & "','" _
				& Label6.text & "','" & vTipoRiga & "','','" & DataConsegna & "','" & Note & "'," & RifIdTesta & ",'" & BarcodeCopy & "','" _
				& vUM & "','" & BarcodeCopy & "','" & Label4.Text & "','" & Label14.Text & "','" & Label15.Text & "','" & Label17.Text & "')"
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
				' B4XTable1.ClearDataView
				B4XTable1.Refresh
				
			Case "Modify"
				If(Label14.text.Length>=15) Then
					Categ1 = Label14.text.SubString2(0,14)
				Else
					Categ1 = Label14.Text
				End If
				If(Label15.text.Length>=15) Then
					Categ2 = Label15.text.SubString2(0,14)
				Else
					Categ2 = Label15.text
				End If
				DescArtCat1Cat2 = Label9.Text & CRLF & Categ1 & " - " & Categ2
				If(NewDocument.vOperazione="NewDoc") Then
					B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,BarcodeCopy,DescArtCat1Cat2,EditText2.text,Label6.Text, EditText3.Text,vTipoRiga, RowID_Riga))
					Dim sql As String
					sql = "UPDATE GS_RIGHEDOCUMENTI SET CODART = ?, DESCRIZIONE = ?, QTA = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?, DesCat1 = ?, DesCat2 = ?"
					sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
					SQLDataAccess.ExecNonQuery2(sql, Array As String (BarcodeCopy.trim, Label9.Text, EditText2.Text, Label6.text, EditText3.text, vTipoRiga, vUM, Label14.Text, Label15.text, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
				Else
					B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?", Array (IDriga,BarcodeCopy,DescArtCat1Cat2,EditText2.text,Label6.Text, EditText3.Text, vTipoRiga, RowID_Riga))
					Dim sql As String
					sql = "UPDATE GS_RIGHEDOCUMENTI SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, TipoRiga = ?, UM = ?, DesCat1 = ?, DesCat2 = ?"
					sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
					SQLDataAccess.ExecNonQuery2(sql, Array As String (BarcodeCopy.trim,Label9.Text, EditText2.Text, Label6.text, EditText3.text, vTipoRiga, vUM, Label14.Text, Label15.text, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
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
			EditText2.Text = ""
			EditText3.Text=""
			EditText4.Text=""
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
	Dim vDesNegozio As String = ""
	Dim vStatoArt As String = ""	
	EditText4.Text = EditText4.text.Replace(Chr(32),"").Trim	
	Dim F_RegistraAuto As Boolean
	If(Label16.Text<>"") Then
		F_RegistraAuto = True
	Else
		F_RegistraAuto = False
	End If
	vBarcodeLetto = EditText4.Text.ToUpperCase
	If (IsNumber(vBarcodeLetto)) Then
		vBarcodeLettoNum = vBarcodeLetto		
	End If
	If(F_RegistraAuto) Then
		RegistraRiga(Label16.Text)
	End If
	sqlstr = "SELECT TipoDoc,Numerodoc,Esercizio,Idriga,Descrizione,DesCat1,DesCat2,DesCat3 FROM GS_RIGHEDOCUMENTI WHERE Barcode = ? AND TipoDoc='INV' AND ifnull(ArticoloAQta,0)=0" 
	Dim rs1 As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String (vBarcodeLettoNum))	
	If(rs1.RowCount=0) Then
		sqlstr = "SELECT BARCODE,DESCRIZIONE,PREZZOLISTINO,DESCCAT1,DESCCAT2,DESCCAT3,ARTICOLOAQTA,ifnull(CODNEGOZIO,'') AS CODNEGOZIO,ifnull(STATO,'') AS STATO FROM GS_ARTICOLI WHERE BARCODE = ?"
		Log(sqlstr)
		Dim rs2 As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String(vBarcodeLettoNum))
		If (rs2.RowCount>0) Then
			Do While rs2.NextRow	
				Label9.Text = rs2.GetString("DESCRIZIONE")
				If(Main.DBName="Trendy.db") Then
					Label7.Text = rs2.GetString("DESCCAT1") & " - " & rs2.GetString("DESCCAT2") & " - " & rs2.GetString("DESCCAT3")
				Else
					Label7.Text = rs2.GetString("DESCCAT1") & " - " & rs2.GetString("DESCCAT2")
				End If
				Label6.Text = rs2.GetDouble("PREZZOLISTINO")				
				Label4.Text = rs2.GetInt("ARTICOLOAQTA")
				Label16.Text = rs2.GetString("BARCODE").Trim
				Label14.Text = rs2.GetString("DESCCAT1")
				Label15.Text = rs2.GetString("DESCCAT2")
				Label17.Text = rs2.GetString("DESCCAT3")
				vCodNegozioArt = rs2.GetString("CODNEGOZIO")
				vStatoArt = rs2.GetString("STATO")				
			Loop		
			rs2.close
			If (Main.SwitchQtaDefault=1) And (EditText2.Text="") Then
				EditText2.Text = "1"
				EditText2.SelectAll
			End If	
			Dim F_Continua As Boolean = False
			Select Case vStatoArt
				Case "DIS"
					F_Continua = True
				Case "VEN"
					F_Continua = False
					ExtraUtility.Play_Sound("error.wav")
					MsgboxAsync("Questo articolo risulta VENDUTO!","CONTROLLO")
				Case "VIS"
					F_Continua = False
					ExtraUtility.Play_Sound("error.wav")
					MsgboxAsync("Questo articolo risulta in VISIONE!","CONTROLLO")
				Case Else
					F_Continua = False				
					ExtraUtility.Play_Sound("error.wav")
					MsgboxAsync("Questo articolo non risulta DISPONIBILE -> " & vStatoArt & " !","CONTROLLO")
			End Select
			If (vCodNegozio<>vCodNegozioArt) And (vCodNegozioArt<>"") And (F_Continua) And (Main.DBName<>"Trendy.db") Then				
				ExtraUtility.Play_Sound("error.wav")
				Select Case vCodNegozioArt
					Case "MO"
						vDesNegozio = "MONTALE"
					Case "PT"
						vDesNegozio = "PISTOIA"
					Case "QU"
						vDesNegozio = "QUARRATA"					
				End Select
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Negozio articolo errato!" & CRLF & "Negozio: " & vCodNegozioArt & " - " & vDesNegozio& ".","CONTROLLO")
				If (F_Continua) Then
					Label16.Text = vBarcodeLetto
					EditText4.Text = ""
				End If
			Else
				If (F_Continua) Then
					Label16.Text = vBarcodeLetto
					EditText4.Text = ""					
				End If
			End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			Label9.Text = "*** CODICE ERRATO ***"
			Label6.Text = ""
			Label7.Text = ""
			Label14.Text = ""
			Label15.Text = ""
			Label4.Text = ""
			EditText4.Text = ""
			Label16.Text = ""
			vCodNegozioArt = ""
		End If
	Else
		Do While rs1.NextRow
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Articolo già presente in inventario documento " & rs1.GetString("TipoDoc") & " n. "  & rs1.Getstring("Numerodoc") _
			& "/" & rs1.Getstring("Esercizio") & " riga: " &  rs1.GetString("Idriga") & "."  & CRLF & rs1.GetString("DesCat1") & " - " _
			& rs1.GetString("DesCat2") & " - " & rs1.GetString("DesCat3") & CRLF & rs1.GetString("Descrizione"),"CONTROLLO -> " & vBarcodeLetto)
		Loop
	End If
	rs1.Close
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

