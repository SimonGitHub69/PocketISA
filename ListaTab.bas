B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private XUI As XUI	
	Private SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Dialog As B4XDialog
	Private B4XTable1 As B4XTable
	Private Codice As String
	Private Descrizione As String
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private SwiftButton3 As SwiftButton
	Private FooterBarH As Int
	Private pnlGap1 As Panel
	Private pnlGap2 As Panel
	Private pnlFooter As Panel
	Private btnTabElimina As Button
	Private btnTabAzzera As Button
	Private btnTabSalva As Button
	Private ShowElimina As Boolean
	Private ShowAzzera As Boolean
	Private ShowSalva As Boolean
	Private SelectedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Private Col1Value As String
	Private Col2Value As String
	Private Col3Value As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("ListaTab")
	Sleep(0)
	Dialog.Initialize(Activity)
	Select NewDocument.vTipoTab
		Case 1
			ShowElimina = False
			ShowAzzera = False
			ShowSalva = True
		    CliForTab(Choose_Menu.vTipoCliFor)	
		Case 2
			ShowElimina = False
			ShowAzzera = False
			ShowSalva = True
			ListinoTab
		Case 3		
			' Lista tabelle: Elimina, Azzera, Salva
			ShowElimina = True
			ShowAzzera = True
			ShowSalva = True
			ListaTabSqlite				
		Case 4
			ShowElimina = False
			ShowAzzera = False
			ShowSalva = True
			ListaDocTab(TesteDoc_Kuore_Spunta.vTipoDoc)	
		Case Else
			ShowElimina = False
			ShowAzzera = False
			ShowSalva = False
	End Select	
End Sub

' Solo il bottone blu di conferma (Clienti/Listino/Documenti).
Private Sub PreparaFrecciaConferma As ResumableSub
	Try
		ShowElimina = False
		ShowAzzera = False
		ShowSalva = True
		FooterBarH = 58dip
		Wait For (StileBottoniListaTabelle) Complete (ok As Boolean)
		If pnlFooter.IsInitialized Then pnlFooter.BringToFront
	Catch
		Log("PreparaFrecciaConferma: " & LastException)
	End Try
	Return True
End Sub

Sub Activity_Resume
	If pnlFooter.IsInitialized Then pnlFooter.BringToFront
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub B4XTable1_DataUpdated
	Select NewDocument.vTipoTab
		Case 1
			SetColumnAlignment(B4XTable1,"Codice",Gravity.LEFT)
			SetColumnAlignment(B4XTable1,"Ragione Sociale",Gravity.LEFT)
			SetColumnAlignment(B4XTable1,"Localita",Gravity.LEFT)
			
		Case 2
			SetColumnAlignment(B4XTable1,"N",Gravity.LEFT)
			SetColumnAlignment(B4XTable1,"Descrizione Listino",Gravity.LEFT)
			
		Case 3 ' Tabelle SQLite
			SetColumnAlignment(B4XTable1,"Nome Tabella",Gravity.LEFT)
			SetColumnAlignment(B4XTable1,"Records",Gravity.RIGHT)
		
		Case 4
			SetColumnAlignment(B4XTable1,"Tipo Doc.",Gravity.CENTER_HORIZONTAL)
			SetColumnAlignment(B4XTable1,"Num. Doc.",Gravity.CENTER_HORIZONTAL)
			SetColumnAlignment(B4XTable1,"Data Doc.",Gravity.CENTER_HORIZONTAL)
										
	End Select
	Dim RowId As Long
	Dim column As B4XTableColumn
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		RowId = B4XTable1.VisibleRowIds.Get(i)
		For j = 0 To B4XTable1.Columns.size - 1
			column = B4XTable1.Columns.Get(j)
			ExtraUtility.SetSingleLine(i+1, column,True,"END")
		Next
		SetRowColor(i, SelectedRows.Contains(RowId))
	Next
End Sub

private Sub CliForTab(TipoCliFor As String)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.Clear
		SelectedRows = B4XCollections.CreateSet
		Wait For (PreparaFrecciaConferma) Complete (okF As Boolean)

		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.Update
		B4XTable1.SelectionColor = XUI.Color_Transparent

		Dim tableTop As Int = B4XTable1.mBase.Top
		Dim footerTop As Int = 100%y - FooterBarH
		Dim tableH As Int = Max(220dip, footerTop - tableTop - 4dip)
		B4XTable1.mBase.Height = tableH

		Dim DataList As List
		DataList.Initialize
		Dim rs As ResultSet
		Select Case Main.Ditta
			Case "Florenzi"
				rs = SQLDataAccess.ExecQuery("select CODICE AS CODCLIFOR, RAGSOC AS DSCCONTO1, LOCALITA from GS_ANAGRAFICACF")
			Case "Trendy"
				rs = SQLDataAccess.ExecQuery("select CODICE AS CODCLIFOR, RAGSOC AS DSCCONTO1, LOCALITA from GS_ANAGRAFICACF")
			Case "Kuore"
				rs = SQLDataAccess.ExecQuery("select CODCLIFOR, DSCCONTO1, LOCALITA from IS_ANAGRAFICACF WHERE TIPOCLIFOR='" & TipoCliFor & "'")
			Case Else
				If (TipoCliFor ="X") Then
					rs = SQLDataAccess.ExecQuery("select CODCLIFOR, DSCCONTO1, LOCALITA from IS_ANAGRAFICACF WHERE TIPOCONTO='F'")
				Else
					rs = SQLDataAccess.ExecQuery("select CODCLIFOR, DSCCONTO1, LOCALITA from IS_ANAGRAFICACF WHERE TIPOCONTO='" & TipoCliFor & "'")
				End If
		End Select
		Do While rs.NextRow
			Dim rowx(3) As Object
			rowx(0) = SafeStr(rs.GetString("CODCLIFOR"))
			rowx(1) = SafeStr(rs.GetString("DSCCONTO1"))
			rowx(2) = SafeStr(rs.GetString("LOCALITA"))
			DataList.Add(rowx)
		Loop
		rs.Close

		Dim rowH As Int = 28dip
		Dim chrome As Int = 80dip ' search + header + navigazione
		Dim rowsPerPage As Int = Max(1, (tableH - chrome) / rowH)
		B4XTable1.RowHeight = rowH
		B4XTable1.MaximumRowsPerPage = rowsPerPage
		B4XTable1.BuildLayoutsCache(rowsPerPage)

		Dim Col1_Column As B4XTableColumn = B4XTable1.AddColumn("Codice", B4XTable1.COLUMN_TYPE_TEXT)
		Col1_Column.Width = 22%x
		Dim Col2_Column As B4XTableColumn = B4XTable1.AddColumn("Ragione Sociale", B4XTable1.COLUMN_TYPE_TEXT)
		Col2_Column.Width = 54%x
		Dim Col3_Column As B4XTableColumn = B4XTable1.AddColumn("Localita", B4XTable1.COLUMN_TYPE_TEXT)
		Col3_Column.Width = 24%x

		B4XTable1.SetData(DataList)

		' Padding come Lista Tabelle: testo staccato dal bordo
		Dim padLeft As Int = 12dip
		For i = 0 To Col1_Column.CellsLayouts.Size - 1
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			If i = 0 Then
				lbl1.TextSize = 12
				lbl1.Typeface = Typeface.DEFAULT_BOLD
			Else
				lbl1.TextSize = 12
				lbl1.Typeface = Typeface.DEFAULT
			End If
			lbl1.TextColor = Colors.RGB(20, 20, 20)
			lbl1.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl1.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl1.SingleLine = True
			lbl1.Ellipsize = "END"

			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			If i = 0 Then
				lbl2.TextSize = 12
				lbl2.Typeface = Typeface.DEFAULT_BOLD
			Else
				lbl2.TextSize = 13
				lbl2.Typeface = Typeface.DEFAULT
			End If
			lbl2.TextColor = Colors.RGB(20, 20, 20)
			lbl2.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl2.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl2.SingleLine = True
			lbl2.Ellipsize = "END"

			Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
			Dim lbl3 As Label = pnl3.GetView(0)
			If i = 0 Then
				lbl3.TextSize = 12
				lbl3.Typeface = Typeface.DEFAULT_BOLD
			Else
				lbl3.TextSize = 13
				lbl3.Typeface = Typeface.DEFAULT
			End If
			lbl3.TextColor = Colors.RGB(20, 20, 20)
			lbl3.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl3.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl3.SingleLine = True
			lbl3.Ellipsize = "END"
		Next

		Wait For (PreparaFrecciaConferma) Complete (okF2 As Boolean)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SafeStr(v As Object) As String
	If v = Null Then Return ""
	Return "" & v
End Sub

private Sub ListaDocTab(TipoDoc As String)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	B4XTable1.Clear
	B4XTable1.SearchField.HintText = "Cerca"
	B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 11
	B4XTable1.RowHeight = 40dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Tipo Doc.", B4XTable1.COLUMN_TYPE_TEXT) ' Tipo Doc
	Col1_Column.Width = 100dip
	Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("Num. Doc.", B4XTable1.COLUMN_TYPE_NUMBERS) ' Num Doc.
	Col2_Column.Width = 136dip
	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Data Doc.", B4XTable1.COLUMN_TYPE_TEXT) ' Num Doc.
	Col3_Column.Width = 120dip
	Dim DataList As List
	DataList.Initialize
	Dim rs As ResultSet
	Select Case Main.Ditta
		Case "Kuore"
			If(TipoDoc<>"") Then
				rs = SQLDataAccess.ExecQuery2("SELECT TIPODOC,NUMERODOC,DATADOC FROM IS_RIGHEDOCPARTITE WHERE TIPODOC=? AND FLAG_VISPALM=1 GROUP BY NUMERODOC,TIPODOC,DATADOC", Array As String(TipoDoc)) 
			Else
				rs = SQLDataAccess.ExecQuery("SELECT TIPODOC,NUMERODOC,DATADOC FROM IS_RIGHEDOCPARTITE WHERE FLAG_VISPALM=1 GROUP BY NUMERODOC,TIPODOC,DATADOC")
			End If
	End Select
	Do While rs.NextRow
		Dim rowx(3) As Object
		rowx(0) = rs.GetString("TIPODOC")
		rowx(1) = rs.GetInt("NUMERODOC")
		rowx(2) = rs.getstring("DATADOC")
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
	For i = 1 To Col1_Column.CellsLayouts.Size - 1
		' colonna 1
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 14
		'lbl.Typeface = Typeface.DEFAULT_BOLD
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (0, 0, 0, 0)
		' colonna 2
		Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)		
		lbl2.TextSize = 14
		' lbl2.Typeface = Typeface.DEFAULT_BOLD
		lbl2.TextColor = Colors.RGB(9,0,104)
		'lbl2.Padding = Array As Int (0, 0, 50, 0)
		lbl2.Padding = Array As Int (0, 0, 0, 0)
		' colonna 3
		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 14
		'lbl.Typeface = Typeface.DEFAULT_BOLD
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (0, 0, 0, 0)
	Next
End Sub

' Stessa barra di Impostazioni: Elimina | Azzera | Salva.
Private Sub StileBottoniListaTabelle As ResumableSub
	Try
		NascondiSwiftLista

		Dim margin As Int = 6dip
		Dim gap As Int = 6dip
		Dim barH As Int = 58dip
		Dim topBtn As Int = 100%y - barH
		If topBtn < 0 Then topBtn = 0
		FooterBarH = barH

		If pnlFooter.IsInitialized = False Then
			pnlFooter.Initialize("")
			Activity.AddView(pnlFooter, 0, topBtn, 100%x, barH)
			btnTabElimina.Initialize("btnTabElimina")
			btnTabAzzera.Initialize("btnTabAzzera")
			btnTabSalva.Initialize("btnTabSalva")
			pnlFooter.AddView(btnTabElimina, 0, 0, 10dip, 10dip)
			pnlFooter.AddView(btnTabAzzera, 0, 0, 10dip, 10dip)
			pnlFooter.AddView(btnTabSalva, 0, 0, 10dip, 10dip)
			PreparaBottoneLista(btnTabElimina, "Elimina", Colors.RGB(69, 90, 100))
			PreparaBottoneLista(btnTabAzzera, "Azzera", Colors.RGB(69, 90, 100))
			PreparaBottoneLista(btnTabSalva, "Salva", Colors.RGB(25, 118, 210))
		End If

		pnlFooter.SetLayout(0, topBtn, 100%x, barH)
		pnlFooter.Color = Colors.White
		pnlFooter.Visible = True

		Dim slotW As Int = (pnlFooter.Width - margin * 2 - gap * 2) / 3
		If slotW < 40dip Then slotW = 40dip
		Dim bh As Int = barH - 8dip
		btnTabElimina.SetLayout(margin, 4dip, slotW, bh)
		btnTabAzzera.SetLayout(margin + slotW + gap, 4dip, slotW, bh)
		btnTabSalva.SetLayout(margin + (slotW + gap) * 2, 4dip, slotW, bh)
		btnTabElimina.Visible = ShowElimina
		btnTabAzzera.Visible = ShowAzzera
		btnTabSalva.Visible = ShowSalva
		' Clienti, Fornitori e Listini: freccia grande al posto di Salva
		If NewDocument.vTipoTab = 1 Or NewDocument.vTipoTab = 2 Then
			btnTabSalva.Typeface = Typeface.FONTAWESOME
			btnTabSalva.Text = Chr(0xF061)
			btnTabSalva.TextSize = 34
		Else
			btnTabSalva.Typeface = Typeface.DEFAULT_BOLD
			btnTabSalva.Text = "Salva"
			btnTabSalva.TextSize = 15
		End If
		btnTabSalva.TextColor = Colors.White
		btnTabSalva.Gravity = Gravity.CENTER
		pnlFooter.BringToFront
		NascondiGapBottoni
	Catch
		Log("StileBottoniListaTabelle: " & LastException)
	End Try
	Return True
End Sub

Private Sub PreparaBottoneLista (btn As Button, testo As String, colore As Int)
	btn.Text = testo
	btn.TextSize = 15
	btn.TextColor = Colors.White
	btn.Color = colore
	btn.Gravity = Gravity.CENTER
	btn.Enabled = True
End Sub

Private Sub NascondiSwiftLista
	Try
		If SwiftButton1.IsInitialized Then
			If SwiftButton1.mBase.IsInitialized Then SwiftButton1.mBase.Visible = False
		End If
		If SwiftButton2.IsInitialized Then
			If SwiftButton2.mBase.IsInitialized Then SwiftButton2.mBase.Visible = False
		End If
		If SwiftButton3.IsInitialized Then
			If SwiftButton3.mBase.IsInitialized Then SwiftButton3.mBase.Visible = False
		End If
	Catch
		Log("NascondiSwiftLista: " & LastException)
	End Try
End Sub

Sub btnTabElimina_Click
	CallSubDelayed(Me, "SwiftButton2_Click")
End Sub

Sub btnTabAzzera_Click
	CallSubDelayed(Me, "SwiftButton3_Click")
End Sub

Sub btnTabSalva_Click
	CallSubDelayed(Me, "SwiftButton1_Click")
End Sub

' Striscia bianca tra un bottone e l'altro (separazione reale).
Private Sub MettiGapBianco (qualegap As Int, left As Int, top As Int, gapW As Int, h As Int) As Int
	Try
		Dim pnl As Panel
		If qualegap = 1 Then
			If pnlGap1.IsInitialized = False Then
				pnlGap1.Initialize("")
				Activity.AddView(pnlGap1, left, top, gapW, h)
			End If
			pnl = pnlGap1
		Else
			If pnlGap2.IsInitialized = False Then
				pnlGap2.Initialize("")
				Activity.AddView(pnlGap2, left, top, gapW, h)
			End If
			pnl = pnlGap2
		End If
		pnl.SetLayoutAnimated(0, left, top, gapW, h)
		pnl.Color = Colors.White
		pnl.Visible = True
		pnl.BringToFront
	Catch
		Log("MettiGapBianco: " & LastException)
	End Try
	Return gapW
End Sub

Private Sub NascondiGapBottoni
	Try
		If pnlGap1.IsInitialized Then pnlGap1.Visible = False
		If pnlGap2.IsInitialized Then pnlGap2.Visible = False
	Catch
		Log(LastException)
	End Try
End Sub

private Sub ListaTabSqlite
	Try
		Sleep(0)
		B4XTable1.Clear
		SelectedRows = B4XCollections.CreateSet
		FooterBarH = 60dip

		' Nasconde la search e libera lo spazio verticale
		B4XTable1.SearchField.mBase.Visible = False
		B4XTable1.SearchField.mBase.Height = 0
		B4XTable1.SelectionColor = XUI.Color_Transparent

		' Tabella fino al footer (altezza fissa: non usare Top bottoni, puo' essere 0)
		Dim tableTop As Int = B4XTable1.mBase.Top
		Dim footerTop As Int = 100%y - FooterBarH
		Dim tableH As Int = Max(180dip, footerTop - tableTop - 4dip)
		B4XTable1.mBase.Height = tableH

		Dim DataList As List
		DataList.Initialize
		Dim rs1 As ResultSet = SQLDataAccess.ExecQuery("SELECT name FROM sqlite_master WHERE Type IN ('table','view')" _
			& " AND name NOT LIKE 'sqlite_%' AND name <> 'android_metadata'" _
			& " AND name <> '" & Main.PrefixSQL & "_PALMDEVICE'" _
			& " ORDER BY name COLLATE NOCASE")
		Do While rs1.NextRow
			Dim rowx(2) As Object
			Dim tName As String = rs1.GetString("name")
			rowx(0) = tName
			Try
				Dim rs2 As ResultSet = SQLDataAccess.ExecQuery("SELECT COUNT(*) AS records FROM [" & tName & "]")
				If rs2.NextRow Then
					rowx(1) = rs2.GetInt("records")
				Else
					rowx(1) = 0
				End If
				rs2.Close
			Catch
				rowx(1) = 0
				Log("COUNT error " & tName & ": " & LastException)
			End Try
			DataList.Add(rowx)
			If DataList.Size Mod 8 = 0 Then Sleep(0)
		Loop
		rs1.Close

		' Righe basse per mostrarne di piu'
		Dim rowH As Int = 28dip
		Dim chrome As Int = 80dip ' navigazione + header
		Dim rowsPerPage As Int = Max(1, (tableH - chrome) / rowH)

		B4XTable1.RowHeight = rowH
		B4XTable1.MaximumRowsPerPage = rowsPerPage
		B4XTable1.BuildLayoutsCache(rowsPerPage)

		Dim Col1_Column As B4XTableColumn = B4XTable1.AddColumn("Nome Tabella", B4XTable1.COLUMN_TYPE_TEXT)
		Col1_Column.Width = 72%x
		Dim Col2_Column As B4XTableColumn = B4XTable1.AddColumn("Records", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col2_Column.Width = 26%x
		Col2_Column.Sortable = True
		ExtraUtility.CreateCustomFormat(Col2_Column, B4XTable1)

		B4XTable1.SetData(DataList)

		' Tipografia sobria allineata alla toolbar
		Dim padLeft As Int = 12dip
		Dim colHeader As Int = Colors.RGB(55, 71, 79)
		Dim colRow As Int = Colors.RGB(38, 50, 56)
		For i = 0 To Col1_Column.CellsLayouts.Size - 1
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			If i = 0 Then
				lbl1.TextSize = 12
				lbl1.Typeface = Typeface.DEFAULT_BOLD
				lbl1.TextColor = colHeader
			Else
				lbl1.TextSize = 14
				lbl1.Typeface = Typeface.DEFAULT
				lbl1.TextColor = colRow
			End If
			lbl1.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl1.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl1.SingleLine = True
			lbl1.Ellipsize = "END"

			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			If i = 0 Then
				lbl2.TextSize = 12
				lbl2.Typeface = Typeface.DEFAULT_BOLD
				lbl2.TextColor = colHeader
			Else
				lbl2.TextSize = 14
				lbl2.Typeface = Typeface.DEFAULT
				lbl2.TextColor = colRow
			End If
			lbl2.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
			lbl2.Padding = Array As Int(2dip, 0, 10dip, 0)
		Next
		' Bottoni per ultimi: sopra la tabella e visibili
		Wait For (StileBottoniListaTabelle) Complete (ok2 As Boolean)
		If B4XTable1.mBase.IsInitialized Then
			B4XTable1.mBase.Height = Max(180dip, (100%y - FooterBarH) - B4XTable1.mBase.Top - 4dip)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

private Sub ListinoTab
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.Clear
		SelectedRows = B4XCollections.CreateSet
		Wait For (PreparaFrecciaConferma) Complete (okF As Boolean)

		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.Update
		B4XTable1.SelectionColor = XUI.Color_Transparent

		Dim tableTop As Int = B4XTable1.mBase.Top
		Dim footerTop As Int = 100%y - FooterBarH
		Dim tableH As Int = Max(220dip, footerTop - tableTop - 4dip)
		B4XTable1.mBase.Height = tableH

		Dim DataList As List
		DataList.Initialize
		Dim rs As ResultSet = SQLDataAccess.ExecQuery("select NRLISTINO, DESCRIZIONE from IS_TABLISTINI")
		Do While rs.NextRow
			Dim rowx(2) As Object
			rowx(0) = SafeStr(rs.GetString("NRLISTINO"))
			rowx(1) = SafeStr(rs.GetString("DESCRIZIONE"))
			DataList.Add(rowx)
		Loop
		rs.Close

		Dim rowH As Int = 28dip
		Dim chrome As Int = 80dip
		Dim rowsPerPage As Int = Max(1, (tableH - chrome) / rowH)
		B4XTable1.RowHeight = rowH
		B4XTable1.MaximumRowsPerPage = rowsPerPage
		B4XTable1.BuildLayoutsCache(rowsPerPage)

		Dim Col1_Column As B4XTableColumn = B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_TEXT)
		Col1_Column.Width = 18%x
		Dim Col2_Column As B4XTableColumn = B4XTable1.AddColumn("Descrizione Listino", B4XTable1.COLUMN_TYPE_TEXT)
		Col2_Column.Width = 80%x

		B4XTable1.SetData(DataList)

		Dim padLeft As Int = 12dip
		For i = 0 To Col1_Column.CellsLayouts.Size - 1
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			If i = 0 Then
				lbl1.TextSize = 12
				lbl1.Typeface = Typeface.DEFAULT_BOLD
			Else
				lbl1.TextSize = 13
				lbl1.Typeface = Typeface.DEFAULT
			End If
			lbl1.TextColor = Colors.RGB(20, 20, 20)
			lbl1.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl1.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl1.SingleLine = True
			lbl1.Ellipsize = "END"

			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			If i = 0 Then
				lbl2.TextSize = 12
				lbl2.Typeface = Typeface.DEFAULT_BOLD
			Else
				lbl2.TextSize = 13
				lbl2.Typeface = Typeface.DEFAULT
			End If
			lbl2.TextColor = Colors.RGB(20, 20, 20)
			lbl2.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			lbl2.Padding = Array As Int(padLeft, 0, 2dip, 0)
			lbl2.SingleLine = True
			lbl2.Ellipsize = "END"
		Next

		Wait For (PreparaFrecciaConferma) Complete (okF2 As Boolean)
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 0 To column.CellsLayouts.Size - 1 ' include header (0) per allineare titolo e righe
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		Select NewDocument.vTipoTab
		Case 1, 2 ' Clienti/Fornitori e Listino
			lbl.Padding = Array As Int(12dip, 0, 4dip, 0)
		Case 3 ' Tabelle SQLite: stacca il testo dal bordo, allineato al titolo
			If alignment = Gravity.RIGHT Then
				lbl.Padding = Array As Int(4dip, 0, 12dip, 0)
			Else
				lbl.Padding = Array As Int(12dip, 0, 4dip, 0)
			End If
		Case 4 ' Tabelle ListaDoc
			lbl.Padding = Array As Int(5dip, 0, 5dip, 0)
		Case Else
			lbl.Padding = Array As Int(5dip, 0, 0, 0)
		End Select
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

Sub B4XTable1_CellLongClicked (ColumnId As String, RowId As Long)
	If (NewDocument.vTipoTab=3) Then ' solo in caso della lista delle tabelle
		Dim vTable_Pressed As String = B4XTable1.GetRow(RowId).GetValueAt(0)
		If (vTable_Pressed<>"") Then								
			If(vTable_Pressed<>"IMPOSTAZIONI") Then
				If(DB_SQLite.CheckIfTableExist(SQLDataAccess,vTable_Pressed)) Then
					Msgbox2Async("Vuoi ricreare la tabella '" & vTable_Pressed & "' ?", "Pocket ISA", "SI", "NO", "", Null, False)
					Wait For MsgBox_Result (Result As Int)
					If Result = DialogResponse.POSITIVE Then
						Dim query As String = "DROP TABLE IF EXISTS" & DBUtilsExtra.EscapeField(vTable_Pressed)
						Log("Drop Table: " & query)
						SQLDataAccess.ExecNonQuery(query)
					End If
				End If
				If(DB_SQLite.CheckIfViewExist(SQLDataAccess,vTable_Pressed)) Then
					Msgbox2Async("Vuoi ricreare la vista '" & vTable_Pressed & "' ?", "Pocket ISA", "SI", "NO", "", Null, False)
					Wait For MsgBox_Result (Result As Int)
					If Result = DialogResponse.POSITIVE Then
						Dim query As String = "DROP VIEW IF EXISTS" & DBUtilsExtra.EscapeField(vTable_Pressed)
						Log("Drop View: " & query)
						SQLDataAccess.ExecNonQuery(query)
					End If
				End If
			Else
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("La tabella 'IMPOSTAZIONI' non può essere eliminata!","ATTENZIONE")
			End If
		End If
	End If
End Sub


Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If(MultiSelection=False) Then
		SelectedRows.Clear
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
	B4XTable1.Refresh
	Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId)
	SetRowColor(Index, Selected)
	Select NewDocument.vTipoTab
		Case 1	' CodCliFor
			Col1Value = B4XTable1.GetRow(RowId).GetValueAt(0)    ' CODICE
			Col2Value = B4XTable1.GetRow(RowId).GetValueAt(1)    ' RAGIONESOCIALE
			Codice = Col1Value
			Descrizione = Col2Value
			'Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' LOCALITA
						
		Case 2  ' Listino
			Col1Value = B4XTable1.GetRow(RowId).GetValueAt(0)    ' NRLISTINO
			Col2Value = B4XTable1.GetRow(RowId).GetValueAt(1)    ' DESCRIZIONE
			Codice = Col1Value
			Descrizione = Col2Value
			
		Case 4  ' Lista Documenti
			Col1Value = B4XTable1.GetRow(RowId).GetValueAt(0)    ' TIPO DOCUMENTO
			Col2Value = B4XTable1.GetRow(RowId).GetValueAt(1)    ' NUM. DOCUMENTO
			Col3Value = B4XTable1.GetRow(RowId).GetValueAt(2)    ' DATA DOCUMENTO
			Codice = Col1Value
			Descrizione = Col2Value
			
	End Select
'	Log($"Number of rows selected: ${SelectedRows.Size}"$)
'	Log($"Row selected: ${RowId}"$)
'	Log($"Value of row selected: ${Col1Value}"$)
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		NewDocument.vTipoTab = 0
		Activity.Finish
		Return True
	Else
		Return False
	End If
End Sub

Sub SwiftButton1_Click
	' Freccia conferma: Lista Tabelle, Clienti, Listino
	ConfermaSelezione
End Sub

Private Sub ConfermaSelezione
	Try
		Log("ConfermaSelezione vTipoTab=" & NewDocument.vTipoTab & " Codice=" & Codice)
		If NewDocument.vTipoTab = 1 Or NewDocument.vTipoTab = 2 Then
			If Codice = Null Or Codice.Trim = "" Then
				MsgboxAsync("Seleziona una riga prima di confermare.", "Attenzione")
				Return
			End If
		End If
		Select Main.Ditta
			Case "Kuore"			
					If(Choose_Menu.vOperazioneMenu="SpuntaCarnet") Then
						TesteDoc_Kuore_Spunta.vTipoDoc = Col1Value
						TesteDoc_Kuore_Spunta.vCodice = Col2Value
						TesteDoc_Kuore_Spunta.vDescrizione = Col3Value
					Else
						TesteDoc_Kuore.vCodice = Codice
						TesteDoc_Kuore.vDescrizione = Descrizione
					End If
					
			Case Else
				NewDocument.vCodice = Codice
				NewDocument.vDescrizione = Descrizione
		End Select
		Activity.Finish
	Catch
		Log(LastException)
		MsgboxAsync("Errore conferma: " & LastException.Message, "Errore")
	End Try
End Sub

Sub SwiftButton2_Click' Leggi aRCHIVI/Metodo
	Msgbox2Async("Vuoi azzerare tutte le tabelle escluso teste/righe?", "Pocket ISA", "SI", "NO", "", Null, False)
	Wait For MsgBox_Result (Result As Int)
	If Result = DialogResponse.POSITIVE Then
		Dim sql As String
		'Dim Tables() As String = Array As String("IS_TABCAMBI","IS_PARAMETRIDOC","IS_ANAGRAFICADEPOSITI","IS_LISTINIARTICOLI")
		Select Main.Ditta	
			Case "ZelariVi"
				Dim Tables() As String = Array As String("IS_TABCAMBI","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI", _
				"IS_TABLISTINI","IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI","IS_PALMDEVICE")
			Case "Florenzi"
				Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_ANAGRAFICACF","GS_TABPARAMETRIDOC","GS_ARTICOLI")
			Case "Trendy"
				Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_TABPARAMETRIDOC","GS_ANAGRAFICACF","GS_ARTICOLI")
			Case "Gefin"
				Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_OPERATORI","GS_ARTICOLI")
			Case "Kuore"
				Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_PARAMETRIDOC","IS_ANAGRAFICACF","IS_ANAGRAFICAARTICOLI","IS_RIGHEDOCPARTITE", "IS_TABLISTINI","IS_LISTINIARTICOLI")
			Case "Esseci"
				Dim Tables() As String = Array As String("IS_TABCAMBI","IS_BARCODE","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI", _
				"IS_TABLISTINI","IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI","IS_LISTINOART","IS_VISTAPUNTIVENDITAPALMARE","IS_PALMDEVICE","VISTAGIACENZAPERPALMARE")
			Case "Nesti"
				Dim Tables() As String = Array As String("IS_BARCODE","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI", "IS_ANAGRAFICAARTICOLI","IS_PALMDEVICE","IS_VISTADOCPALM", _
				"IS_VISTA_UMPREF","VISTA_FATTORICONV","IS_TABCODIFICAEAN","VISTA_GIACENZA","IS_SEMAFOROCORSIE","IS_SEMAFOROCORSIE_local","VISTA_GIACENZA_ARTICOLO", _
				"IS_VISTA_CLIENTI_GIRO","IS_PARAMETRIDOC","IS_IMPOSTAZIONICTRLINV","VISTA_DISPONIBILITA_ARTICOLO","VISTA_DISPONIBILITA_CORSIA","IS_TABLISTINI", _
				"IS_LISTINIARTICOLI","IS_VISTA_NOTE_ORDINI","IS_PARTITE_ANNULLATE","IS_ARTICOLI_PESOREALE_CASH")
				
			Case "Carbon"
				' Dim Tables() As String = Array As String("GS_OPERATORI","GS_RICETTE","GS_REPARTI","GS_ARTICOLI","GS_AUTOCLAVI")
				' Dim Tables() As String = Array As String("GS_OPERATORI","GS_REPARTI","GS_ARTICOLI","GS_AUTOCLAVI")
				Dim Tables() As String = Array As String("GS_REPARTI","GS_RICETTE","GS_OPERATORI","GS_ARTICOLI","GS_AUTOCLAVI")
				
			Case Else
				Dim Tables() As String = Array As String("IS_TABCAMBI","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI","IS_TABLISTINI", _
				"IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI") 
		End Select	
		For Each table In Tables		
			If (DB_SQLite.CheckIfTableExist(SQLDataAccess,table)=True) Then			
				sql = "DELETE FROM " & table
				Log ("DELETE FROM " & table)
				SQLDataAccess.ExecNonQuery(sql)
			Else
				Log ("TABELLA " & table & " NON TROVATA")
			End If
		Next	
		MsgboxAsync("Operazione terminata con successo!","Pocket ISA")
		ListaTabSqlite
	End If
End Sub

Sub SwiftButton3_Click
	Msgbox2Async("Vuoi azzerare teste/righe?", "Pocket ISA", "SI", "NO", "", Null, False)	
	Wait For MsgBox_Result (Result As Int)
	If Result = DialogResponse.POSITIVE Then
		Dim input As B4XInputTemplate
		input.Initialize
		input.lblTitle.Text = "Password:"
		input.ConfigureForNumbers(False, False) 'AllowDecimals, AllowNegative
		Wait For (Dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
		If Result = XUI.DialogResponse_Positive Then
			If (input.Text="1969") Then
				Dim sql As String
				Select  Main.Ditta
					Case "Carbon"
						Dim Tables() As String = Array As String(Main.PrefixSQL & "_AUTOCLAVE_STORY_H", Main.PrefixSQL & "_AUTOCLAVE_STORY_D","GS_AUTOCLAVE_EVENT","GS_AUTOCLAVI")
					Case "Gefin"
						Dim Tables() As String = Array As String(Main.PrefixSQL & "_TESTEDOCUMENTI_LT", Main.PrefixSQL & "_RIGHEDOCUMENTI_LT")
					Case "Florenzi"
						Dim Tables() As String = Array As String(Main.PrefixSQL & "_TESTEDOCUMENTI_LT", Main.PrefixSQL & "_RIGHEDOCUMENTI_LT")
					Case Else
						Dim Tables() As String = Array As String(Main.PrefixSQL & "_TESTEDOCUMENTI", Main.PrefixSQL & "_RIGHEDOCUMENTI")
				End Select
				For Each table In Tables
					If (DB_SQLite.CheckIfTableExist(SQLDataAccess,table)=True) Then
						If(Main.Ditta="Carbon") Then
							Select table
								Case "GS_AUTOCLAVI"
									Starter.CodDip1 = ""
									Starter.CodDip2 = ""
									Starter.CodDip3 = ""
									sql = "UPDATE GS_AUTOCLAVI SET ULTIMOPROC = NULL, CODRICETTA = NULL, CODDIP1 = NULL, CODDIP2 = NULL, CODDIP3 = NULL, DATAORA_AGG = NULL, ULTIMOCICLO = NULL, UUID_CICLO = NULL, DATA_TRASMESSO = NULL"
									#if debug
										Log ("UPDATE " & table)
									#End If
									SQLDataAccess.ExecNonQuery(sql)
								Case Else
									sql = "DELETE FROM " & table
									#if debug
										Log ("DELETE FROM " & table)
									#end if
									SQLDataAccess.ExecNonQuery(sql)
							End Select
						Else
							sql = "DELETE FROM " & table
							#if debug
								Log ("DELETE FROM " & table)
							#end if
							SQLDataAccess.ExecNonQuery(sql)
						End If								
					Else
						Log ("TABELLA " & table & " NON TROVATA")
					End If
				Next
				MsgboxAsync("Operazione terminata con successo!","Pocket ISA")
				ListaTabSqlite				
			Else
				MsgboxAsync("Password errata!","Pocket ISA")
			End If
		End If		
	End If
End Sub
