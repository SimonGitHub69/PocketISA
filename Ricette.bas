B4A=true
Group=Default Group\Carbon
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
	Public xui As XUI
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private pnlGrid As Panel
	Private NumRows As Int = 7
	Private NumCols As Int = 4
	Private CellWidth As Float
	Private CellHeight As Float
	Private GapWidth As Float
	Private txt_size As Int
	Private ttubo As String
	Private selezione_autoclave As String
	Private txt_title As Label
	Private LastIndex As Int = -1
	Private pnlContainer As Panel
	Private SelectedRows As B4XSet
	Private pnlGrid As Panel    ' quello che già usi per contenere i bottoni
	Private RowColor As Int = Colors.RGB(240, 240, 240)
	Private B4XTable1 As B4XTable
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Try
		'Do not forget to load the layout file created with the visual designer. For example:
		Activity.RemoveAllViews
		Sleep(0)
		If FirstTime Then
			ExtraUtility.CopyDBIfNeeded(Main.DBName)
			If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
				SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
			Else
				MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
			End If
		End If
		txt_title.Initialize("")
		pnlGrid.Initialize("")
		Activity.LoadLayout("Ricette")
		Activity.Color = Colors.LightGray
		Activity.AddView(pnlGrid, 0, 0, 100%x, 100%y)
		txt_title.Text="SELEZIONARE AUTOCLAVE"
		ListaRicette
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

private Sub ListaRicette
	'Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		Sleep(0)
		B4XTable1.Clear
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.RowHeight = 30dip
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=False
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Codice", B4XTable1.COLUMN_TYPE_TEXT) ' NOME TABELLA
		Col1_Column.Width = 35%x
		Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) ' NOME TABELLA
		Col2_Column.Width = 65%x
		Dim DataList As List
		DataList.Initialize
		Dim rs1 As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE,DESCRIZIONE FROM GS_RICETTE")
		Do While rs1.NextRow
			Dim rowx(2) As Object
			rowx(0) = rs1.GetString("CODICE")
			rowx(1) = rs1.GetString("DESCRIZIONE")
			DataList.Add(rowx)
			If DataList.Size Mod 5 = 0 Then Sleep(0)
		Loop
		rs1.Close
		' Disabilita / rende invisibile la selezione interna del B4XTable (nome proprietà dipende dalla versione)
		B4XTable1.SelectionColor = xui.Color_Transparent		
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.SetData(DataList)
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.SearchField.mBase.Height = 60dip
		B4XTable1.SearchField.mBase.Visible = True
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		For i = 1 To Col1_Column.CellsLayouts.Size - 1
			' colonna 1
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			lbl1.TextSize = 14
			'lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl1.TextColor = Colors.RGB(9,0,104)
			lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' colonna 2
			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			lbl2.TextSize = 14
			'lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl2.TextColor = Colors.RGB(9,0,104)
			lbl2.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		Select NewDocument.vTipoTab
			Case 3 ' Tabelle SQLite
				' Nessun Padding
			Case 4 ' Tabelle LIstaDoc
				' Nessun Padding
			Case Else
				lbl.Padding = Array As Int (5dip, 0, 0, 0)
		End Select
	Next
End Sub

Sub B4XTable1_DataUpdated
	Dim RowId As Long
	Dim column As B4XTableColumn

	SetColumnAlignment(B4XTable1,"Codice",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)

	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		RowId = B4XTable1.VisibleRowIds.Get(i)

		For j = 0 To B4XTable1.Columns.Size - 1
			column = B4XTable1.Columns.Get(j)
			ExtraUtility.SetSingleLine(i+1, column, True, "END")
		Next

		SetRowColor(i, SelectedRows.Contains(RowId))
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
		Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1)
		pnl.Color = clr
		If pnl.NumberOfViews > 0 Then
			pnl.GetView(0).Color = xui.Color_Transparent
		End If
	Next
End Sub


Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If MultiSelection = False Then SelectedRows.Clear

	If SelectedRows.Contains(RowId) Then
		SelectedRows.Remove(RowId)
	Else
		SelectedRows.Add(RowId)
	End If

	B4XTable1.Refresh
End Sub

