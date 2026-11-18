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
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private B4XTable1 As B4XTable
	Private Button1 As Button
	Private Button2 As Button
	Dim Codice As String
	Dim Descrizione As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(File.DirInternal, Main.DBName, False)
	End If
	Activity.LoadLayout("ListaTab")		
	Select NewDocument.vTipoTab
		Case 1
		    CliForTab			
		Case 2
			ListinoTab
	End Select
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"Ragione Sociale",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
	Next
End Sub

'Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
'	Dim sf As Object = xui.Msgbox2Async("Delete row?", "Title", "Yes", "Cancel", "No", Null)
'	Wait For (sf) Msgbox_Result (Result As Int)
'	If Result = xui.DialogResponse_Positive Then
'		DeleteRow(B4XTable1, RowId)
'	End If
'End Sub

private Sub CliForTab
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 12
	B4XTable1.RowHeight = 22dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	B4XTable1.AddColumn("Codice", B4XTable1.COLUMN_TYPE_TEXT).Width=140 ' CODICE
	B4XTable1.AddColumn("Ragione Sociale", B4XTable1.COLUMN_TYPE_TEXT).Width=300 ' DSCCONTO1
	B4XTable1.AddColumn("Localita", B4XTable1.COLUMN_TYPE_TEXT) ' LOCALITA	
	Dim DataList As List
	DataList.Initialize
	Dim rs As ResultSet = SQLDataAccess.ExecQuery("select CODCLIFOR, DSCCONTO1, LOCALITA from IS_ANAGRAFICACF")
	Do While rs.NextRow
		Dim rowx(3) As Object
		rowx(0) = rs.GetString("CODCLIFOR")
		rowx(1) = rs.getstring("DSCCONTO1")
		rowx(2) = rs.getstring("LOCALITA")
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
End Sub

private Sub ListinoTab
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 12
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_TEXT).Width=100 ' NRLISTINO
	B4XTable1.AddColumn("Descrizione Listino", B4XTable1.COLUMN_TYPE_TEXT) ' DESCRIZIONE
	Dim DataList As List
	DataList.Initialize
	Dim rs As ResultSet = SQLDataAccess.ExecQuery("select NRLISTINO, DESCRIZIONE from IS_TABLISTINI")
	Do While rs.NextRow
		Dim rowx(2) As Object
		rowx(0) = rs.GetString("NRLISTINO")
		rowx(1) = rs.getstring("DESCRIZIONE")
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
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
	Select NewDocument.vTipoTab
		Case 1	' CodCliFor
			Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(0)    ' CODICE
			Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' RAGIONESOCIALE
			Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' LOCALITA
			
		Case 2  ' Listino
			Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(0)    ' NRLISTINO
			Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' DESCRIZIONE
	End Select
	Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
	Codice = Col1Value
	Descrizione = Col2Value
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		Return True
	Else
		Return False
	End If
End Sub

Sub Button2_Click ' Annulla
	Activity.Finish
	NewDocument.vCodice = ""
	NewDocument.vDescrizione = ""
End Sub

Sub Button1_Click ' Assegna
	NewDocument.vCodice = Codice
	NewDocument.vDescrizione = Descrizione
	Activity.Finish
End Sub

