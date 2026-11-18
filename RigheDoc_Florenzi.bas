B4A=true
Group=Default Group\Florenzi
ModulesStructureVersion=1
Type=Activity
Version=13.4
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
	Private EditText2 As EditText
	Private EditText4 As EditText
	Private Label10 As Label
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
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
	Private Col5_Column As B4XTableColumn
	Private Label11 As Label
	Private Label8 As Label
	Private formatter As B4XFormatter
	Private Button7 As Button
	Private Label2 As Label
	Private Panel3 As Panel
	Private Label5 As Label
	Private Label6 As Label
	Private Label5 As Label
	' Scanner 
	Private ScanHelp As ClsScanHelper
	Private LblModele As Label
	Private LblCodebarre As Label
	Private TxtTempsSpot As EditText
	Private TxtForFocus As EditText
	Private TxtTpsMaxCab As EditText
	Private LblSymbologie As Label
	Private ImgLecteur As ImageView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("RigheDoc_Florenzi")
	'----------------------------------------------------------
'Dim jo1 As JavaObject = EditText2
'jo1.RunMethod("setOnKeyListener", Array(Me, "EditText_Key"))

'Dim jo2 As JavaObject = EditText4
'jo2.RunMethod("setOnKeyListener", Array(Me, "EditText_Key"))
	'---------------------------------------------------------
	' Scanner
	'---------------------------------------------------------
	Starter.UsaIntentScanner = (Main.Ditta.Trim.ToUpperCase = "FLORENZI")
	StartService(Starter)
	If Starter.UsaIntentScanner Then
		ScanHelp.Initialize(Activity, LblCodebarre, LblSymbologie, TxtForFocus, ImgLecteur)
		Log("ScanHelp inizializzato")
	Else
		Log("Scanner non previsto per questa ditta")
	End If
	'---------------------------------------------------------
	ExtraUtility.formato_europeo_2dec(formatter)
	Panel2.Visible=False
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)
	Phone.Initialize("")
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
	'--------------------------------------
	' RegisterBarcodeReceiver
	'--------------------------------------
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
		Label1.text = NewDocument.vTipoDocNew & " n. " & NewDocument.vNumDocNew &  " del " & NewDocument.vDataDocNew & " - "  & NewDocument.vNoteDoc
	End If
	Sleep(0)
	ListaRigheDoc(True, F_Barcode)
	vBarcodeLetto = ""
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
	End If
	EditText2.InputType = EditText2.INPUT_TYPE_TEXT
	If(Panel1.Visible=True) Then
		Panel2.Top = B4XTable1.mBase.Top+2dip
	End If
End Sub

Sub Activity_Resume
	If Starter.UsaIntentScanner Then
		If Starter.PropPda.IsInitialized And ScanHelp.IsInitialized Then
			ScanHelp.CaricaImmagineScanner(Starter.PropPda)
		End If
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If Starter.UsaIntentScanner And ScanHelp.IsInitialized Then
		Try
			ScanHelp.SupprimeFocus
		Catch
			Log(LastException)
		End Try
	End If
End Sub

Sub EditText_Key(ViewTag As Object, KeyCode As Int, Event As Object) As Boolean
	Log("KEYCODE PREMUTO: " & KeyCode)

	' intercetta tutti i possibili ENTER
	If KeyCode = 66 Or KeyCode = 160 Or KeyCode = 23 Or KeyCode = 61 Then
        
		If Panel2.Visible Then
            
			' se sei sul barcode
'			If EditText4.IsFocused Then
'				p_EditText4_EnterPressed
'				Return True
'			End If
'            
			' se sei sulla quantità → conferma
'			If EditText2.IsFocused Then
'				SwiftButton1_Click   ' oppure SwiftButton10_Click
'				Return True
'			End If
            
			' fallback
			SwiftButton1_Click
			Return True
		End If
	End If

	Return False
End Sub

#Region "Gestion scanner DATALOGIC"
Public Sub AfficheCAB(Code As String, TypeCode As String)
	If Starter.UsaIntentScanner = False Then Return
	If ScanHelp.IsInitialized = False Then Return
	' Log("Main.AfficheCAB: " & Code & " - " & TypeCode)
	ScanHelp.AfficheCAB(Code, TypeCode)
	' Log("codice " & Code)
	EditText4.Text = Code
	Label5.TEXT = Code
	p_EditText4_EnterPressed
End Sub
#End Region

#Region "Eventi TextEdit"
Private Sub TxtTpsMaxCab_FocusChanged (HasFocus As Boolean)
    If Starter.UsaIntentScanner = False Then Return
    If ScanHelp.IsInitialized = False Then Return
    If Not(HasFocus) Then ScanHelp.SupprimeFocus
End Sub

Private Sub TxtTpsMaxCab_EnterPressed
	If Starter.UsaIntentScanner = False Then Return
	If ScanHelp.IsInitialized = False Then Return
	ScanHelp.SupprimeFocus
End Sub

Private Sub TxtTempsSpot_FocusChanged (HasFocus As Boolean)
	If Starter.UsaIntentScanner = False Then Return
	If ScanHelp.IsInitialized = False Then Return
	If Not(HasFocus) Then ScanHelp.SupprimeFocus
End Sub

Private Sub TxtTempsSpot_EnterPressed
	If Starter.UsaIntentScanner = False Then Return
	If ScanHelp.IsInitialized = False Then Return
	ScanHelp.SupprimeFocus
End Sub
#End Region

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"CodArt",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		If SelectedRows.IsInitialized Then
			SetRowColor(i, SelectedRows.Contains(RowId))
		Else
			SetRowColor(i, False)
		End If
	Next
	Dim max1 As Int = Col1_Column.CellsLayouts.Size
	Dim max2 As Int = Col2_Column.CellsLayouts.Size
	Dim max3 As Int = Col3_Column.CellsLayouts.Size
	Dim max4 As Int = Col4_Column.CellsLayouts.Size
	Dim maxLoop As Int = Min(max1, Min(max2, Min(max3, max4))) - 1
	For i = 1 To maxLoop
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 11 ' n.
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)

		Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 11 ' codart
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int(5dip, 0dip, 0dip, 0dip)

		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 11 ' descrizione
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int(5dip, 0dip, 0dip, 0dip)

		Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 13 ' qta
		lbl4.Typeface = Typeface.DEFAULT_BOLD
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int(0dip, 0dip, 5dip, 0dip)
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

Private Sub ListaRigheDoc(FirstTime As Boolean, F_StatoBarcode As Boolean)
	If FirstTime Then
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.RowHeight = 40dip
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.MaximumRowsPerPage = 10
		SelectedRows = B4XCollections.CreateSet

		Col1_Column = B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col1_Column.Width = 10%x

		Col2_Column = B4XTable1.AddColumn("CodArt", B4XTable1.COLUMN_TYPE_TEXT)
		Col2_Column.Width = 25%x

		Col3_Column = B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT)
		Col3_Column.Width = 50%x

		Col4_Column = B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col4_Column.Width = 13%x

		Col5_Column = B4XTable1.AddColumn("Prezzo", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col5_Column.Width = 1%x
		
	End If

	Dim DataList As List
	DataList.Initialize

	If NewDocument.vOperazione = "NewDoc" Then
		sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit " & _
                 "FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " & _
                 "WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' " & _
                 "AND RD.Numerodoc = '" & NewDocument.vNumDocNew & "' " & _
                 "AND RD.Esercizio = '" & NewDocument.vEsercizioNew & "' "  & _
				 "ORDER BY RD.Idriga DESC"
	Else
		sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.BARCODE " & _
                 "FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " & _
                 "WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' " & _
                 "AND RD.Numerodoc = '" & ListaDoc.vNumerodoc & "' " & _
                 "AND RD.Esercizio = '" & ListaDoc.vEsercizio & "' " & _
				 "ORDER BY RD.Idriga DESC"				 
	End If

	' Log("INIZIO QUERY")
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	' Log("QUERY FATTA")

	Do While rs.NextRow
		Dim rowx(5) As Object
		rowx(0) = rs.GetInt("Idriga")
		rowx(1) = rs.GetString("Codart")
		rowx(2) = rs.GetString("Descrizione")
		rowx(3) = rs.GetDouble("Qta")
		rowx(4) = rs.GetDouble("PrzUnit")
		DataList.Add(rowx)
	Loop
	rs.Close
	
	' Log("PRIMA SETDATA")
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	' Log("DOPO SETDATA")

	Dim o() As Object = B4XTable1.BuildQuery(False)
	Dim total As Double = 0
	Dim rsTot As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))

	Do While rsTot.NextRow
		total = total + rsTot.GetDouble("c3")   ' totale quantità
		' total = total + (rsTot.GetDouble("c3") * rsTot.GetDouble("c4"))   ' totale importo
	Loop
	rsTot.Close

	Label11.Text = NumberFormat2(total, 0, 0, 0, False)
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
	
	
	' cancella dalla tabella locale B4X
	tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array(RowId))

	' 🔥 rinumerazione corretta
	Dim rs As ResultSet = tbl.sql1.ExecQuery("SELECT rowid FROM data ORDER BY c0")
	Dim i As Int = 1
	Do While rs.NextRow
		Dim rid As Long = rs.GetLong("rowid")
		tbl.sql1.ExecNonQuery2("UPDATE data SET c0 = ? WHERE rowid = ?", Array(i, rid))
		i = i + 1
	Loop
	rs.Close
	'refresh
	'tbl.Refresh

	'tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array (RowId))	 			' deletes record from Table
	'tbl.sql1.ExecNonQuery2("UPDATE data SET c0=c0-1 WHERE RowId >= ?", Array (RowId))	 	' update record from Table
		
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
		Dim Col5Value As Double = B4XTable1.GetRow(RowId).GetValueAt(4)    ' Prz. Unitario
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
    If KeyCode = KeyCodes.KEYCODE_ENTER Then
        p_EditText4_EnterPressed
        Return True
    End If
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		CallSubDelayed(ListaDoc, "ListaDocChkNew")
		Return True
	Else
		Return False
	End If
End Sub

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
	Panel2.Visible=True
	Panel1.SendToBack
	Dim cdw As ColorDrawable
	cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
	Panel2.Background = cdw
	Label10.Text="#" & (B4XTable1.Size+1)
	Label9.Text=""
	Label6.Text=""
	Label5.Text = ""
	EditText2.Text=""
	EditText4.Text=""
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
			EditText2.Enabled = False
			EditText4.Enabled = False
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
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.Sconto, RD.UM FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " _
				& "LEFT OUTER JOIN GS_ARTICOLI GA ON GA.BARCODE=RD.Barcode WHERE RD.TipoDoc = '" & NewDocument.vTipoDocNew & "' AND RD.Numerodoc = '" _
				& NewDocument.vNumDocNew  & "' AND RD.Esercizio = '" & NewDocument.vEsercizioNew & "' AND RD.Idriga = '" & IDriga & "'"
			Else
				sqlstr = "SELECT RD.Idriga, RD.Codart, RD.Descrizione, RD.Qta, RD.PrzUnit, RD.Sconto, RD.UM FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT RD " _
				& "LEFT OUTER JOIN GS_ARTICOLI As GA ON GA.BARCODE=RD.BARCODE WHERE RD.TipoDoc = '" & ListaDoc.vTipoDoc & "' AND RD.Numerodoc = '" _
				& ListaDoc.vNumerodoc  & "' AND RD.Esercizio = '" & ListaDoc.vEsercizio & "' AND RD.Idriga = '" & IDriga & "'"				
			End If
			Log(sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Label10.Text = "#" & rs.GetInt("Idriga")
				Label9.Text = rs.GetString("Descrizione")
				EditText2.Text = rs.GetInt("Qta")
				Label6.text = ""
				vBarcodeLetto = rs.GetString("Codart")
				Label5.Text = rs.GetString("Codart")
			Loop				
			rs.close
		Else
			ToastMessageShow("Selezionare la riga da modificare!",False)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button7_Click
	ApriRicercaAZ
End Sub

Sub ApriRicercaAZ
	StartActivity(Ricerca_AZ_mini)
	Wait For Ricerca_AZ_Result (zCodice As String, zDescrizione As String)
	vBarcodeLetto = zCodice
	Label9.Text = zDescrizione
	Label5.Text = zCodice
	Label6.Text = ""
End Sub

Sub SwiftButton1_Click
	vBarcodeLetto=vBarcodeLetto.Trim
	If vBarcodeLetto<>"" Then
		RegistraRiga(Label5.Text.Trim,vBarcodeLetto)
		Label5.Text = ""
	End If
End Sub

Sub EditText2_Key(ViewTag As Object, KeyCode As Int, Event As Object) As Boolean
	Log("KEYCODE: " & KeyCode)
	If KeyCode = 66 Or KeyCode = 160 Or KeyCode = 23 Or KeyCode = 61 Then
		If Panel2.Visible Then
			SwiftButton1_Click
			Return True
		End If
	End If
	Return False
End Sub

Sub RegistraRiga(CodArtCopy As String, BarcodeCopy As String)
	Dim vCodArt As String
	Dim vDescArt As String
	Dim vQta As String
	Dim vSconto As String
	Dim vPrzUnit As String
	Dim vUMX As String 
	
	vCodArt = CodArtCopy.Trim
	vQta = EditText2.Text.Trim	
	vDescArt = Label9.Text.Trim
	vSconto = ""
	vPrzUnit = ""
	vUMX = ""
	
	If (vCodArt <> "") And (IsNumber(vQta)) Then
		
		Select Operazione
			
			Case "Add"
				Dim Pos As Int = B4XTable1.Size + 1
				Dim Note As String = ""
				Dim RifIdTesta As Int = 0
				
				' B4XTable locale
				B4XTable1.sql1.ExecNonQuery2( _
					"INSERT INTO data VALUES(?,?,?,?,?)", _
					Array As Object(Pos, vCodArt, vDescArt, vQta, vPrzUnit))

				Dim sql As String
				sql = "INSERT INTO GS_RIGHEDOCUMENTI_LT (TipoDoc,Numerodoc,Esercizio,Idtesta,Idriga,UtenteModifica,Codart,Qta,Descrizione,Sconto,PrzUnit,Note,UM,Barcode) " & _
				      "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

				If NewDocument.vOperazione = "NewDoc" Then
					SQLDataAccess.ExecNonQuery2(sql, Array As Object( _
			        NewDocument.vTipoDocNew, _
			        NewDocument.vNumDocNew, _
			        NewDocument.vEsercizioNew, _
			        RifIdTesta, _
			        Pos, _
			        Main.Utente, _
			        vCodArt, _
			        vQta, _
			        vDescArt, _
			        vSconto, _
			        vPrzUnit, _
			        Note, _
			        vUMX, _
			        BarcodeCopy))
				Else
					SQLDataAccess.ExecNonQuery2(sql, Array As Object( _
			        ListaDoc.vTipoDoc, _
			        ListaDoc.vNumerodoc, _
			        ListaDoc.vEsercizio, _
			        RifIdTesta, _
			        Pos, _
			        Main.Utente, _
			        vCodArt, _
			        vQta, _
			        vDescArt, _
			        vSconto, _
			        vPrzUnit, _
			        Note, _
			        vUMX, _
			        BarcodeCopy))
				End If
				Log(sql)
				
			Case "Modify"			
				B4XTable1.sql1.ExecNonQuery2( _
    				"UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ? WHERE rowid = ?", _
    				Array As Object(IDriga, vCodArt, vDescArt, vQta, vPrzUnit, RowID_Riga))
				
				Dim sql As String
				sql = "UPDATE GS_RIGHEDOCUMENTI_LT SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, UM = ?"
				sql = sql & " WHERE TipoDoc = ? AND Esercizio = ? AND Numerodoc = ? AND Idriga = ?"
				
				If NewDocument.vOperazione = "NewDoc" Then
					SQLDataAccess.ExecNonQuery2(sql, Array As Object( _
						vCodArt, vDescArt, vQta, vPrzUnit, vSconto, vUMX, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
				Else
					SQLDataAccess.ExecNonQuery2(sql, Array As Object( _
						vCodArt, vDescArt, vQta, vPrzUnit, vSconto, vUMX, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
				End If
		End Select
		
		Panel2.Visible = False
		Phone.HideKeyboard
		ListaRigheDoc(False, F_Barcode)
		
		If (Main.SwitchRepeatAdd = 1) And (Operazione = "Add") Then
			Panel2.Visible = True
			Panel1.SendToBack
			
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3, Colors.Black)
			Panel2.Background = cdw
			
			Label10.Text = "#" & (B4XTable1.Size + 1)
			Label9.Text = ""
			Label6.Text = ""
			EditText2.Text = ""
			EditText4.Text = ""
			EditText4.RequestFocus
		End If		
		If (Main.SwitchQtaDefault = 1) And (vQta = 0) Then
			EditText2.Text = "1"
		End If
		
		If (vQta = 0) Then
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Quantità a zero, modificare la riga in caso di errore!", "ATTENZIONE")
		End If
		
	Else
		ExtraUtility.Play_Sound("error.wav")
		MsgboxAsync("Inserimento errato controllare articolo e quantità", "ERRORE")
	End If
End Sub

Sub SwiftButton2_Click
	' Annulla
	Panel2.Visible=False
	Sleep(0)
	Phone.HideKeyboard
End Sub

Sub EditText4_EnterPressed
	p_EditText4_EnterPressed
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
	If (EditText2.Text.Length > 5) Then
		' qtà maggiore di		
	End If
End Sub

Sub p_EditText4_EnterPressed
	EditText4.Text = EditText4.Text.Replace(Chr(32), "").Trim
	vBarcodeLetto = EditText4.Text.ToUpperCase
	
	If vBarcodeLetto = "" Then Return
	
	' salsto il controllo se l'articolo fosse già presente in altro docuemnto
	If False Then
		sqlstr = "SELECT TipoDoc, Numerodoc, Esercizio, Idriga, Descrizione " & _
				 "FROM GS_RIGHEDOCUMENTI_LT " & _
				 "WHERE Barcode = ? AND TipoDoc = 'INV'"
		
		Dim rs1 As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String(vBarcodeLetto))
		
		If rs1.NextRow Then
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Articolo già presente in inventario documento " & _
						rs1.GetString("TipoDoc") & " n. " & _
						rs1.GetString("Numerodoc") & "/" & _
						rs1.GetString("Esercizio") & " riga: " & _
						rs1.GetString("Idriga") & ". " & _
						rs1.GetString("Descrizione"), _
						"CONTROLLO -> " & vBarcodeLetto)
			rs1.Close
			Return
		End If	
		rs1.Close
	End If
	Dim param As String
	If (vBarcodeLetto.Length = 13) Then
		' caso doi EAN12 lehhe con LIKE	
		param = vBarcodeLetto.SubString2(0	,12) & "%"
		sqlstr = "SELECT CODART, BARCODE, DESCRIZIONE,MAGAZZINO FROM GS_ARTICOLI WHERE BARCODE LIKE ?"
	Else
		sqlstr = "SELECT CODART, BARCODE, DESCRIZIONE,MAGAZZINO FROM GS_ARTICOLI WHERE BARCODE = ?"
		param = vBarcodeLetto
	End If
	Dim rs2 As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String(param))
	Log(sqlstr)
	
	If rs2.NextRow Then
		Label9.Text = rs2.GetString("DESCRIZIONE")
		Label5.Text = rs2.GetString("CODART")
		Label6.Text = rs2.GetString("MAGAZZINO").SubString2(0,1)
		rs2.Close		
		If (Main.SwitchQtaDefault = 1) And (EditText2.Text = "") Then
			EditText2.Text = "1"
			EditText2.SelectAll
		End If		
		EditText4.Text = ""
		EditText2.RequestFocus
		EditText2.SelectAll
	Else
		rs2.Close
		ExtraUtility.Play_Sound("error.wav")
		Label9.Text = "*** CODICE ERRATO ***"
		Label6.Text = ""
		EditText4.Text = ""
		EditText4.RequestFocus
	End If
End Sub