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
	Dim blobColumns As Map
	Private SQLDataAccess As SQL
	Private SelectedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Private CheckedRows As B4XSet
	Public vCodArt As String
	Public vNRListino As Int
	Public vEsercizio As Int 
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private B4XTable1 As B4XTable
	'Private xui As XUI
	Private Label1 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	blobColumns.Initialize
	CheckedRows.Initialize
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("ListiniArticoli")
	Sleep(0)
	ListiniArt
End Sub

Sub Activity_Resume
	
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"CODART",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"NR.",Gravity.RIGHT)
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

private Sub ListiniArt
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 11
	B4XTable1.RowHeight = 40dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	B4XTable1.AddColumn("CODART", B4XTable1.COLUMN_TYPE_TEXT).Width=600 ' CODART
	B4XTable1.AddColumn("NR.", B4XTable1.COLUMN_TYPE_NUMBERS).Width=110 ' NRLISTINO
	Dim DataList As List
	DataList.Initialize
	Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT CODART, NRLISTINO FROM IS_LISTINIARTICOLI LIMIT 100")
	Do While rs.NextRow
		Dim rowx(2) As Object
		rowx(0) = rs.GetString("CODART")
		rowx(1) = rs.GetInt("NRLISTINO")
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
	Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(1) ' TIPODOC
	Dim Col2Value As Int = B4XTable1.GetRow(RowId).GetValueAt(2)    ' NUMERODOC
	vCodArt = Col1Value
	vNRListino = Col2Value
	Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		Return True
	Else
		Return False
	End If
End Sub

Sub Button1_Click ' Apri Documento
	Activity.Finish
	Select Case Main.Ditta
		Case "ZelariVi"
			StartActivity(RigheDoc_ZelariVi)
		Case "Trendy"
			StartActivity(RigheDoc_Trendy)
		Case "Kuore"
			StartActivity(RigheDoc_Trendy)		
		Case "Esseci"
			StartActivity(RigheDoc_Esseci)				
		Case "Nesti"
			StartActivity(RigheDoc_Esseci)
	End Select
End Sub

Sub Button2_Click ' Nuovo Documento
	StartActivity(NewDocument)	
End Sub

Sub Button3_Click ' Canc. Documento

End Sub
