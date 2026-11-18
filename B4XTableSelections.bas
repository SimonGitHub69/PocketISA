B4A=true
Group=Default Group\General
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'v1.04
Sub Class_Globals
	Public MODE_SINGLE_CELL_TEMP = 1, MODE_SINGLE_CELL_PERMANENT = 2, MODE_SINGLE_LINE_PERMANENT = 3 As Int
	Public MODE_MULTIPLE_CELLS = 4, MODE_MULTIPLE_LINES = 5 As Int
	Private LineMode, SingleMode As Boolean
	Private mCurrentMode As Int
	Public SelectedLines As B4XOrderedMap
	Public SelectionColor As Int
	Private mTable As B4XTable
	Private xui As XUI
	Public AutoRemoveInvisibleSelections As Boolean
	Public SelectedTextColor As Int = xui.Color_Black ' xui.Color_Magenta
	Public COLOR_NONE = -1, COLOR_DEFAULT = 0 As Int ' - 1 = NESSUN COLORE PERCIò LASCIA I COLORI, 0 = SOSTITUISCE CON I COLORI IMPOSTATI NELLA CLASSE
	Public mDefaultTextColor As Int
End Sub

Public Sub Initialize (Table As B4XTable)
	mTable = Table
	SelectionColor = xui.Color_Blue ' mTable.SelectionColors
	SelectedLines.Initialize
	mCurrentMode = MODE_SINGLE_LINE_PERMANENT  ' MODE_SINGLE_CELL_TEMP, MODE_MULTIPLE_LINES
	mDefaultTextColor = COLOR_NONE
End Sub

Public Sub CellClicked2 (ColumnId As String, RowId As Long)
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then Return
	Dim RemovedSelection As Boolean
	If SelectedLines.ContainsKey(RowId) Then
		If LineMode Then
			RemovedSelection = True
			SelectedLines.Remove(RowId)
		Else
			Dim SelectedCells As List = SelectedLines.Get(RowId)
			Dim i As Int = SelectedCells.IndexOf(ColumnId)
			If i > -1 Then
				RemovedSelection = True
				SelectedCells.RemoveAt(i)
				If SelectedCells.Size = 0 Then
					SelectedLines.Remove(RowId)
				End If
			End If
		End If
	End If
	If RemovedSelection = False Then
		If SingleMode Then SelectedLines.Clear
		If LineMode Then
			SelectedLines.Put(RowId, "")
		Else
			Dim SelectedCells As List
			If SelectedLines.ContainsKey(RowId) Then
				SelectedCells = SelectedLines.Get(RowId)
			Else
				Dim SelectedCells As List
				SelectedCells.Initialize
				SelectedLines.Put(RowId, SelectedCells)
			End If
			SelectedCells.Add(ColumnId)
		End If
	End If
    Refresh2(mDefaultTextColor)
End Sub

Public Sub CellClickedForced2 (ColumnId As String, RowId As Long, SelectedRowColor As Int)
	Refresh_RowColor(SelectedRowColor,RowId)
End Sub

Public Sub CellClickedForced (ColumnId As String, RowId As Long, SelectedRowColor As Int)
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then Return
	Dim RemovedSelection As Boolean
	If SelectedLines.ContainsKey(RowId) Then
		If LineMode Then
			RemovedSelection = True
			SelectedLines.Remove(RowId)
		Else
			Dim SelectedCells As List = SelectedLines.Get(RowId)
			Dim i As Int = SelectedCells.IndexOf(ColumnId)
			If i > -1 Then
				RemovedSelection = True
				SelectedCells.RemoveAt(i)
				If SelectedCells.Size = 0 Then
					SelectedLines.Remove(RowId)
				End If
			End If
		End If
	End If
	If RemovedSelection = False Then
		If SingleMode Then SelectedLines.Clear
		If LineMode Then
			SelectedLines.Put(RowId, "")
		Else
			Dim SelectedCells As List
			If SelectedLines.ContainsKey(RowId) Then
				SelectedCells = SelectedLines.Get(RowId)
			Else
				Dim SelectedCells As List
				SelectedCells.Initialize
				SelectedLines.Put(RowId, SelectedCells)
			End If
			SelectedCells.Add(ColumnId)
		End If
	End If
End Sub

Public Sub CellClicked (ColumnId As String, RowId As Long, SelectedRowColor As Int)
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then Return
	Dim RemovedSelection As Boolean
	If SelectedLines.ContainsKey(RowId) Then
		If LineMode Then
			RemovedSelection = True
			SelectedLines.Remove(RowId)
		Else
			Dim SelectedCells As List = SelectedLines.Get(RowId)
			Dim i As Int = SelectedCells.IndexOf(ColumnId)
			If i > -1 Then
				RemovedSelection = True
				SelectedCells.RemoveAt(i)
				If SelectedCells.Size = 0 Then
					SelectedLines.Remove(RowId)
				End If
			End If
		End If
	End If
	If RemovedSelection = False Then
		If SingleMode Then SelectedLines.Clear
		If LineMode Then
			SelectedLines.Put(RowId, "")
		Else
			Dim SelectedCells As List
			If SelectedLines.ContainsKey(RowId) Then
				SelectedCells = SelectedLines.Get(RowId)
			Else
				Dim SelectedCells As List
				SelectedCells.Initialize
				SelectedLines.Put(RowId, SelectedCells)
			End If
			SelectedCells.Add(ColumnId)
		End If
	End If
	Refresh2(mDefaultTextColor)
End Sub

Public Sub Refresh_RowColor(SelectedRowColor As Int,RowIDRiga As Int)
	Try
 		Dim i As Int = RowIDRiga-1
		If (i < mTable.VisibleRowIds.Size ) Then
			Dim clr As Int
			If i Mod 2 = 0 Then clr = mTable.EvenRowColor Else clr = mTable.OddRowColor
			Dim RowID As Long = mTable.VisibleRowIds.Get(i)
			Dim RowSelected As Boolean = SelectedLines.ContainsKey(RowID)
			If RowSelected And LineMode = False Then
				Dim SelectedCells As List = SelectedLines.Get(RowID)
			End If
			For Each col As B4XTableColumn In mTable.VisibleColumns
				Dim p As B4XView = col.CellsLayouts.Get(i + 1)
				Dim lbl As B4XView = p.GetView(col.LabelIndex)
				If RowSelected And (LineMode Or SelectedCells.IndexOf(col.Id) > -1) Then  ' RowSelected
					p.Color = SelectedRowColor 'SelectionColor
					lbl.TextColor = SelectedTextColor
				Else
					Dim LetterRowColor As String = mTable.GetRow(RowID).GetValueAt(13)					
					If (LetterRowColor <> "") Then
						p.Color = ExtraUtility.Decodifica_Colore_Int(LetterRowColor)
						lbl.TextColor = mTable.TextColor
					Else
						p.Color = clr
						lbl.TextColor = mTable.TextColor
					End If					
				End If
			Next
		End If
		If AutoRemoveInvisibleSelections Then
			Dim RowsToRemove As List
			RowsToRemove.Initialize
			For Each RowID As Long In SelectedLines.Keys
				If mTable.VisibleRowIds.IndexOf(RowID) = -1 Then
					RowsToRemove.Add(RowID)
				End If
			Next
			For Each RowID As Long In RowsToRemove
				SelectedLines.Remove(RowID)
			Next
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Public Sub Refresh(columnColor As Int)
	Try
		If(columnColor>=0) Then
			For i = 0 To mTable.VisibleRowIds.Size - 1
				Dim clr As Int
				If i Mod 2 = 0 Then clr = mTable.EvenRowColor Else clr = mTable.OddRowColor
				Dim RowId As Long = mTable.VisibleRowIds.Get(i)
				Dim RowSelected As Boolean = SelectedLines.ContainsKey(RowId)
				If RowSelected And LineMode = False Then
					Dim SelectedCells As List = SelectedLines.Get(RowId)
				End If
				For Each col As B4XTableColumn In mTable.VisibleColumns
					Dim p As B4XView = col.CellsLayouts.Get(i + 1)
					Dim lbl As B4XView = p.GetView(col.LabelIndex)
					If RowSelected And (LineMode Or SelectedCells.IndexOf(col.Id) > -1) Then
						' legge il colore dalla colonna 13 della tabella (es. G, Y, R, ..ecc..)
						Dim SelectedRowColor As Int = ExtraUtility.Decodifica_Colore_Int("C")				
						p.Color = SelectedRowColor
						lbl.TextColor = SelectedTextColor
					Else
						Dim LetterRowColor As String 
						If (RowId > 0) And (columnColor>0) Then
							LetterRowColor = mTable.GetRow(RowId).GetValueAt(columnColor) ' es. 13 è la colonna che contiene la lettera del colore vedi Nesti
						Else
							If (RowId > 0) And (columnColor<0) Then
								LetterRowColor = "G"
							Else
								LetterRowColor = ""
							End If
						End If				
						' assegno il colore della colonna 13 (Green, Red, Yellow, Cyan)
						If (LetterRowColor <> "") Then
							p.Color = ExtraUtility.Decodifica_Colore_Int(LetterRowColor)
							lbl.TextColor = mTable.TextColor
						Else
							p.Color = clr
							lbl.TextColor = mTable.TextColor
						End If				
					End If
				Next
			Next
		End If
		If AutoRemoveInvisibleSelections Then
			Dim RowsToRemove As List
			RowsToRemove.Initialize
			For Each RowId As Long In SelectedLines.Keys
				If mTable.VisibleRowIds.IndexOf(RowId) = -1 Then
					RowsToRemove.Add(RowId)
				End If
			Next
			For Each RowId As Long In RowsToRemove
				SelectedLines.Remove(RowId)
			Next
		End If		
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try		
End Sub

Public Sub Refresh2(Flag_Color As Int)
	For i = 0 To mTable.VisibleRowIds.Size - 1
		Dim clr As Int
		If i Mod 2 = 0 Then clr = mTable.EvenRowColor Else clr = mTable.OddRowColor
		Dim RowId As Long = mTable.VisibleRowIds.Get(i)
		Dim RowSelected As Boolean = SelectedLines.ContainsKey(RowId)
		If RowSelected And LineMode = False Then
			Dim SelectedCells As List = SelectedLines.Get(RowId)
		End If
		For Each Col As B4XTableColumn In mTable.VisibleColumns
			Dim p As B4XView = Col.CellsLayouts.Get(i + 1)
			Dim lbl As B4XView = p.GetView(Col.LabelIndex)
			If RowSelected And (LineMode Or SelectedCells.IndexOf(Col.Id) > -1) Then
				p.Color = SelectionColor
				Select Flag_Color
					Case -1
						' niente non varia il colore
					Case Else
						lbl.TextColor = SelectedTextColor
				End Select
			Else
				p.Color = clr
				Select Flag_Color
					Case 0
						lbl.TextColor = mTable.TextColor
					Case -1
						' niente non varia il colore
					Case Else
						lbl.TextColor = Flag_Color
				End Select
			End If
		Next
	Next
	If AutoRemoveInvisibleSelections Then
		Dim RowsToRemove As List
		RowsToRemove.Initialize
		For Each RowId As Long In SelectedLines.Keys
			If mTable.VisibleRowIds.IndexOf(RowId) = -1 Then
				RowsToRemove.Add(RowId)
			End If
		Next
		For Each RowId As Long In RowsToRemove
			SelectedLines.Remove(RowId)
		Next
	End If
End Sub


Public Sub getMode As Int
	Return mCurrentMode
End Sub

Public Sub setMode (m As Int)
	mCurrentMode = m
	SelectedLines.Clear
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then
		mTable.SelectionColor = SelectionColor
		mTable.HighlightSearchResults = True
	Else
		mTable.SelectionColor = xui.Color_Transparent ' xui.Color_Green
		mTable.HighlightSearchResults = False
	End If
	Select mCurrentMode
		Case MODE_SINGLE_CELL_PERMANENT
			SingleMode = True
			LineMode = False
		Case MODE_SINGLE_LINE_PERMANENT
			SingleMode = True
			LineMode = True
		Case MODE_MULTIPLE_CELLS
			SingleMode = False
			LineMode = False
		Case MODE_MULTIPLE_LINES
			SingleMode = False
			LineMode = True
	End Select
	' Refresh
End Sub

Public Sub Clear
	SelectedLines.Clear
	Refresh2(mDefaultTextColor)
End Sub

'Returns true if it least one item is selected.
Public Sub getIsSelected As Boolean
	Return SelectedLines.Size > 0
End Sub

'Gets the first selected row id.
Public Sub FirstSelectedRowId As Long
	If SelectedLines.Size > 0 Then
		Return SelectedLines.Keys.Get(0)
	Else
		Return 0
	End If
End Sub

'Gets the first selected column id. Only relevant in MODE_SINGLE_CELL_PERMANENT and MODE_MULTIPLE_CELLS modes.
Public Sub FirstSelectedColumnId As String
	If SelectedLines.Size > 0 Then
		Dim l As List = SelectedLines.Values.Get(0)
		Return l.Get(0)
	Else
		Return ""
	End If
End Sub
