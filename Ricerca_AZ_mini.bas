B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private SelectedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Private SelectedRows2 As B4XSet
	Private SelectionColor2 As Int = 0xFF009DFF
	Private MultiSelection2 As Boolean = False ' serve per gestire multiselezione
	Private SQLDataAccess As SQL
	Public vCodice As String
	Public vDescrizione As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private Button7 As Button
	Private Button8 As Button
	Private Button9 As Button
	Private Button10 As Button
	Private Button11 As Button
	Private Button12 As Button
	Private Button13 As Button
	Private Button14 As Button
	Private Button15 As Button
	Private Button16 As Button
	Private Button17 As Button
	Private Button18 As Button
	Private Button19 As Button
	Private Button20 As Button
	Private Button21 As Button
	Private Button22 As Button
	Private Button23 As Button
	Private Button24 As Button
	Private Button25 As Button
	Private Button26 As Button
	Private Button27 As Button
	Private B4XTable1 As B4XTable
	Private B4XTable2 As B4XTable
	Dim Codice As String
	Dim Descrizione As String
	Private Panel1 As Panel
	Private Panel2 As Panel
	Private Col1ColTb2 As B4XTableColumn
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("Ricerca_AZ_mini")
	Sleep(0)
	AdattaLayoutFullscreen
	B4XTable1.AddColumn("CODICE", B4XTable1.COLUMN_TYPE_TEXT).Width=150 ' CODICE
	B4XTable1.AddColumn("DESCRIZIONE", B4XTable1.COLUMN_TYPE_TEXT) ' DESCRIZIONE
	SetColumnAlignment(B4XTable1,"CODICE",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"DSCRIZIONE",Gravity.LEFT)
	Col1ColTb2 = B4XTable2.AddColumn("", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC
	Col1ColTb2.Width = 1
	'B4XTable2.AddColumn("COD.", B4XTable1.COLUMN_TYPE_TEXT).Width=150 ' CODICE
	B4XTable2.AddColumn("DESCRIZIONE VARIANTI", B4XTable1.COLUMN_TYPE_TEXT) ' DESCRIZIONE
	SetColumnAlignment(B4XTable2,"",Gravity.LEFT)
	SetColumnAlignment(B4XTable2,"DESCRIZIONE VARIANTI",Gravity.LEFT)
	Panel2.Visible=False
End Sub

Private Sub AdattaLayoutFullscreen
	Dim letterButtons As List
	letterButtons.Initialize
	letterButtons.AddAll(Array(Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8, Button9, Button10, _
		Button11, Button12, Button13, Button14, Button15, Button16, Button17, Button18, Button19, Button20, _
		Button21, Button22, Button23, Button24, Button25, Button26, Button27))
	ExtraUtility.AdattaRicercaAZFullscreen(Panel1, Panel2, B4XTable1, B4XTable2, letterButtons)
End Sub

private Sub Ricerca_Alfa(lettera As String)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.CurrentPage=1
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.Text=""
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 10
	B4XTable1.RowHeight = 40dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim DataList As List
	DataList.Initialize
	Select Main.Ditta
		Case "ZelariVi"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA = '1' AND CODICE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA = '1' AND CODICE LIKE '" & lettera & "%'")
			End If
			
		Case "Kuore"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE LIKE '" & lettera & "%'")
			End If

		Case "Florenzi"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE LIKE '" & lettera & "%'")
			End If
			
		Case "Trendy"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT BARCODE AS CODICE, DESCRIZIONE from GS_ARTICOLI WHERE DESCRIZIONE LIKE '" & lettera & "%'")
			End If
			
		Case "Esseci"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE DESCRIZIONE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE DESCRIZIONE LIKE '" & lettera & "%'")
			End If

		Case "Nesti"
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE DESCRIZIONE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE DESCRIZIONE LIKE '" & lettera & "%'")
			End If
		
		Case Else
			If (lettera="#") Then
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA = '1' AND CODICE BETWEEN '0' AND '9999999999999999'")
			Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA = '1' AND CODICE LIKE '" & lettera & "%'")
			End If
		
	End Select
	Do While rs.NextRow
		Dim rowx(2) As Object
		rowx(0) = rs.GetString("CODICE")
		rowx(1) = rs.getstring("DESCRIZIONE")
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
End Sub

Sub SetRowColor2(RowIndex As Int, Selected As Boolean)
	Dim clr As Int
	If Selected Then
		clr = SelectionColor2
	Else If RowIndex Mod 2 = 0 Then
		clr = B4XTable2.EvenRowColor
	Else
		clr = B4XTable2.OddRowColor
	End If
	For Each c As B4XTableColumn In B4XTable2.VisibleColumns
		Dim pnl2 As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
		pnl2.Color = clr
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

Sub B4XTable2_CellClicked (ColumnId As String, RowId As Long)
	If(MultiSelection2=False) Then
		SelectedRows2.Clear
		B4XTable2.Refresh
	End If
	' Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Dim Selected As Boolean
	If SelectedRows2.Contains(RowId) Then
		SelectedRows2.Remove(RowId)
		Selected = False
	Else
		SelectedRows2.Add(RowId)
		Selected = True
	End If
	Dim Index As Int = B4XTable2.VisibleRowIds.IndexOf(RowId)
	SetRowColor2(Index, Selected)
	Dim Col1Value As String = B4XTable2.GetRow(RowId).GetValueAt(0)    ' CODICE
	Dim Col2Value As String = B4XTable2.GetRow(RowId).GetValueAt(1)    ' DESCRIZIONE
	Log($"Number of rows selected: ${SelectedRows2.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
	Codice = Col1Value
	Descrizione = Col2Value
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
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
	Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(0)    ' CODICE
	Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' DESCRIZIONE
	Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
	Codice = Col1Value
	Descrizione = Col2Value
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		lbl.Padding = Array As Int (5dip, 0, 0, 0)
	Next
End Sub

Sub Button1_Click
	Ricerca_Alfa(Button1.Text)
End Sub
Sub Button2_Click
	Ricerca_Alfa(Button2.Text)
End Sub
Sub Button3_Click
	Ricerca_Alfa(Button3.Text)
End Sub
Sub Button4_Click
	Ricerca_Alfa(Button4.Text)
End Sub
Sub Button5_Click
	Ricerca_Alfa(Button5.Text)
End Sub
Sub Button6_Click
	Ricerca_Alfa(Button6.Text)
End Sub
Sub Button7_Click
	Ricerca_Alfa(Button7.Text)
End Sub
Sub Button8_Click
	Ricerca_Alfa(Button8.Text)
End Sub
Sub Button9_Click
	Ricerca_Alfa(Button9.Text)
End Sub
Sub Button10_Click
	Ricerca_Alfa(Button10.Text)
End Sub
Sub Button11_Click
	Ricerca_Alfa(Button11.Text)
End Sub
Sub Button12_Click
	Ricerca_Alfa(Button12.Text)
End Sub
Sub Button13_Click
	Ricerca_Alfa(Button13.Text)
End Sub
Sub Button14_Click
	Ricerca_Alfa(Button14.Text)
End Sub
Sub Button15_Click
	Ricerca_Alfa(Button15.Text)
End Sub
Sub Button16_Click
	Ricerca_Alfa(Button16.Text)
End Sub
Sub Button17_Click
	Ricerca_Alfa(Button17.Text)
End Sub
Sub Button18_Click
	Ricerca_Alfa(Button18.Text)
End Sub
Sub Button19_Click
	Ricerca_Alfa(Button19.Text)
End Sub
Sub Button20_Click
	Ricerca_Alfa(Button20.Text)
End Sub
Sub Button21_Click
	Ricerca_Alfa(Button21.Text)
End Sub
Sub Button22_Click
	Ricerca_Alfa(Button22.Text)
End Sub
Sub Button23_Click
	Ricerca_Alfa(Button23.Text)
End Sub
Sub Button24_Click
	Ricerca_Alfa(Button24.Text)
End Sub
Sub Button25_Click
	Ricerca_Alfa(Button25.Text)
End Sub
Sub Button26_Click
	Ricerca_Alfa(Button26.Text)
End Sub
Sub Button27_Click
	Ricerca_Alfa(Button27.Text)
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"CODICE",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"DSCRIZIONE",Gravity.LEFT)
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		For j = 0 To B4XTable1.Columns.size - 1
			Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
			ExtraUtility.SetSingleLine(i+1, column,True,"END")
		Next
	Next
End Sub

Sub B4XTable2_DataUpdated
	SetColumnAlignment(B4XTable2,"COD.",Gravity.LEFT)
	SetColumnAlignment(B4XTable2,"DESCRIZIONE",Gravity.LEFT)
	For i = 0 To B4XTable2.VisibleRowIds.Size - 1
		Dim RowId As Long = B4XTable2.VisibleRowIds.Get(i)
		SetRowColor2(i, SelectedRows2.Contains(RowId))
		Dim RowId As Long = B4XTable2.VisibleRowIds.Get(i)
	Next
	For i = 1 To Col1ColTb2.CellsLayouts.Size - 1
		Dim pnl As B4XView = Col1ColTb2.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.TextSize = 11
		lbl.Typeface = Typeface.DEFAULT_BOLD
		lbl.TextColor = Colors.RGB(9,0,104)
		lbl.Padding = Array As Int (5dip, 5dip, 5dip, 6dip)
	Next
End Sub

Sub B4XTable1_HeaderClicked (ColumnId As String)
	
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Select KeyCode
		Case KeyCodes.KEYCODE_BACK
			If (Panel2.Visible=True) Then
				Panel2.Visible=False
				Panel1.Visible=True
			Else
				Activity.Finish
			End If
			Return True
		Case KeyCodes.KEYCODE_HOME
			Return False
		Case Else
			Return False
	End Select
End Sub

Sub B4XTable1_CellLongClicked (ColumnId As String, RowId As Long)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	vCodice = Codice
	Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
	If(vCodice = vCodice_Pressed) Then
		Select Main.Ditta
			Case "ZelariVi"
				Panel1.Visible=False
				Panel2.Visible=True
				B4XTable2.CurrentPage=1
				B4XTable2.SearchField.HintText = "Cerca"
				B4XTable2.SearchField.Update
				B4XTable2.MaximumRowsPerPage = 15
				B4XTable2.RowHeight = 55dip
				B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
				SelectedRows2 = B4XCollections.CreateSet
				Dim DataList As List
				DataList.Initialize
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE, DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA = '0' AND CODICEPRIMARIO = '" & Codice & "'")
				Do While rs.NextRow
					Dim rowx(2) As Object
					rowx(0) = rs.GetString("CODICE")
					rowx(1) = rs.getstring("DESCRIZIONE")
					DataList.Add(rowx)
				Loop
				rs.Close
				B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
				B4XTable2.SetData(DataList)

			Case "Kuore"
				vCodice = Codice
				Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
				vDescrizione = Descrizione
				If(vCodice = vCodice_Pressed) Then
					Activity.Finish
				Else
					ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
				End If

			Case "Florenzi"
				vCodice = Codice
				Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
				vDescrizione = Descrizione
				If(vCodice = vCodice_Pressed) Then								
					CallSubDelayed3(RigheDoc_Florenzi, "Ricerca_AZ_Result", Codice, Descrizione)
					Activity.Finish					
				Else
					ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
				End If

			Case "Trendy"
				vCodice = Codice
				Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
				vDescrizione = Descrizione
				If(vCodice = vCodice_Pressed) Then
					Activity.Finish
				Else
					ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
				End If

			Case "Esseci"
				vCodice = Codice
				Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
				vDescrizione = Descrizione
				If(vCodice = vCodice_Pressed) Then
					Activity.Finish
				Else
					ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
				End If
				
			Case "Nesti"
				vCodice = Codice
				Dim vCodice_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
				vDescrizione = Descrizione
				If(vCodice = vCodice_Pressed) Then
					Activity.Finish
				Else
					ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
				End If
							
		End Select
	Else
		ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
	End If
End Sub

Sub B4XTable2_CellLongClicked (ColumnId As String, RowId As Long)
	vCodice = Codice
	Dim vCodice_Pressed As String = B4XTable2.GetRow(RowId).GetValueAt(0)
	vDescrizione = Descrizione
	If (vCodice.IndexOf("#")<>-1) Then
		If(vCodice = vCodice_Pressed) Then
			Activity.Finish
		Else
			ToastMessageShow("Premere a lungo sulla riga evidenziata!",False)
		End If
	End If
End Sub
