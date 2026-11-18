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
	Dim blobColumns As Map
	Private SQLDataAccess As SQL
	' Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Public vTipoDoc As String
	Public vNumerodoc As Int
	Public vEsercizio As Int
	Public vDataDoc As String
	Public vTrasmesso As Int
	Public vCodCliFor As String
	Public vRagSoc As String
	Public vNoteDoc As String
	Public vCodNegozio As String
	Public vTipoOperazione As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private SelectionColor As Int = 0xFF009DFF
	Private SelectedColumn As B4XTableColumn
	Private RagSocColumn As B4XTableColumn
	Private CheckedRows As B4XSet
	' Private SelectedRows As B4XSet
	Private xRowsSelection As B4XTableSelections
	Private B4XTable1 As B4XTable
	Private xui As XUI
	Private Label1 As Label
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private PanelFooter As Panel
	Private FooterBarH As Int
	Private FooterTop As Int
	Private DataList As List
	Private RowID_Riga As Long
	Private sqlstr As String
	'Private MyFont As Typeface
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	Sleep(0)
	blobColumns.Initialize
	ExtraUtility.CopyDBIfNeeded(Main.DBName)
	SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	' Upgrade schema sul DB in uso (es. DB copiato sulla SD senza colonna Note)
	AssicuraSchemaDocumenti
	Activity.RemoveAllViews
	Activity.LoadLayout("ListaDoc")
	CheckedRows = B4XCollections.CreateSet
	' Prima i bottoni in basso (sopra nav bar), poi la tabella fino a loro
	CreaBarraBottoniDocumenti
	ListaDocChk(False)
	' B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(30)
	xRowsSelection.Initialize(B4XTable1)
	xRowsSelection.Mode = xRowsSelection.MODE_SINGLE_LINE_PERMANENT	
	Select Main.Ditta
		Case "Gefin"		
			xRowsSelection.mDefaultTextColor = xRowsSelection.COLOR_NONE ' Colors.blue 'xRowsSelection.COLOR_NONE
		Case Else
			xRowsSelection.mDefaultTextColor = xRowsSelection.COLOR_DEFAULT
	End Select
	B4XTable1.LabelsFont = xui.CreateDefaultFont(13)	
	' MyFont = Typeface.LoadFromAssets("myfont.ttf")
	vNumerodoc = 0
	vTipoDoc = ""
	vEsercizio = 0
End Sub

Private Sub CreaBarraBottoniDocumenti
	' Bottoni a filo del bordo basso activity (niente gap grigio sotto)
	FooterBarH = 60dip
	FooterTop = 100%y - FooterBarH
	Dim btnH As Int = FooterBarH
	Dim offset As Int = 2dip
	Dim n As Int = 5
	Dim iconW As Int = Min(67dip, (100%x / n) - 2dip)
	PanelFooter.Initialize("")
	PanelFooter.Color = Colors.RGB(128, 128, 128)
	Button1.Initialize("Button1")
	PanelFooter.AddView(Button1, offset, 0, iconW, btnH)
	Button2.Initialize("Button2")
	PanelFooter.AddView(Button2, offset + (100%x / n), 0, iconW, btnH)
	Button3.Initialize("Button3")
	PanelFooter.AddView(Button3, offset + (100%x / n) * 2, 0, iconW, btnH)
	Button4.Initialize("Button4")
	PanelFooter.AddView(Button4, offset + (100%x / n) * 3, 0, iconW, btnH)
	Button5.Initialize("Button5")
	PanelFooter.AddView(Button5, offset + (100%x / n) * 4, 0, iconW, btnH)
	Activity.AddView(PanelFooter, 0, FooterTop, 100%x, FooterBarH)
	PanelFooter.BringToFront
	CreateLabel(Button1, Chr(0xF15C), "Apri")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Cancella")
	CreateLabel(Button4, Chr(0xF13E), "Sblocca")
	CreateLabel(Button5, Chr(0xF023), "Blocca")
End Sub

Private Sub RiposizionaBarraBottoniDocumenti
	Try
		If PanelFooter.IsInitialized = False Then Return
		FooterTop = 100%y - FooterBarH
		PanelFooter.SetLayoutAnimated(0, 0, FooterTop, 100%x, FooterBarH)
		PanelFooter.BringToFront
		If B4XTable1.IsInitialized And B4XTable1.mBase.IsInitialized Then
			B4XTable1.mBase.Height = Max(180dip, FooterTop - B4XTable1.mBase.Top - 4dip)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_Resume
	RiposizionaBarraBottoniDocumenti
End Sub

Private Sub AssicuraSchemaDocumenti
	Try
		Select Main.Ditta
			Case "Gefin", "Florenzi"
				DB_SQLite.Create_Table_GS_TESTEDOCUMENTI_LT(SQLDataAccess)
			Case "Trendy"
				DB_SQLite.Create_Table_GS_TESTEDOCUMENTI(SQLDataAccess)
				DB_SQLite.Alter_Table_GS_TESTEDOCUMENTI(SQLDataAccess)
			Case Else
				' ZelariVi, Esseci, Kuore, Nesti, ...
				DB_SQLite.Create_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
				DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
				DB_SQLite.Create_Table_IS_RIGHEDOCUMENTI(SQLDataAccess)
				DB_SQLite.Alter_Table_IS_RIGHEDOCUMENTI_Light(SQLDataAccess)
		End Select
	Catch
		Log("AssicuraSchemaDocumenti: " & LastException)
	End Try
End Sub

Private Sub SafeStr (v As Object) As String
	If v = Null Then Return ""
	Dim s As String = v
	If s = Null Then Return ""
	Return s
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Try
		Dim cs As CSBuilder
		cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(26).Append(Text1).Pop.Append(CRLF).Size(9).Append(Text2).Alignment("ALIGN_CENTER").PopAll
		Dim xlbl As B4XView
		xlbl = Label
		xlbl.Text = cs
		xlbl.TextColor = xui.Color_RGB(105, 105, 105)
		xlbl.SetTextAlignment("CENTER", "CENTER")
		Dim lbl As Label = Label
		lbl.Gravity = Gravity.CENTER
		lbl.Padding = Array As Int(0, 0, 0, 4dip)
		Return xlbl.Snapshot
	Catch
		Return Null
		Log(LastException)
	End Try
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Sub B4XTable1_DataUpdated
	Try		
		xRowsSelection.Refresh(-1)
		Select Main.Ditta
			Case "Gefin"
				SetColumnAlignment(B4XTable1,"Note",Gravity.LEFT)
						
			Case Else
				SetColumnAlignment(B4XTable1,"RagSoc",Gravity.LEFT)
		End Select
		For i = 0 To B4XTable1.VisibleRowIds.Size -1
			Dim rowid As Long = B4XTable1.VisibleRowIds.Get(i)
			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i + 1)
			If  p.NumberOfViews > 1 Then
				Dim chk As B4XView = p.GetView(1) 'first view is the 
				chk.Visible =  rowid > 0
				chk.Tag = rowid
				chk.Checked = CheckedRows.Contains(rowid)
				#If DEBUG
					Log("chk_Tag -> " & chk.Tag & " V=" & chk.Visible & " rowid=" & rowid)
				#End If		
			End If
		Next
		For i = 1 To RagSocColumn.CellsLayouts.Size - 1
			Dim pnl As B4XView = RagSocColumn.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextSize = 13
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.TextColor = Colors.RGB(9,0,104)
			lbl.Padding = Array As Int (5dip, 0, 5dip, 0)
		Next
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub ListaDocChkNew
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		CheckedRows.Clear
		Dim DataList As List
		DataList.Initialize
		Select Main.Ditta
		Case "Trendy"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.RAGSOC,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio, ifnull(td.Note,'') as Note, ifnull(td.CodNegozio,'') as CodNegozio from GS_testedocumenti td LEFT OUTER JOIN GS_ANAGRAFICACF cf on td.CodClifor=cf.CODICE")						
				sqlstr = "select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio, td.CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR"	
		
		Case "Gefin"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("SELECT td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, " _
				& "td.Esercizio, td.Note from GS_TESTEDOCUMENTI_LT td")
				sqlstr = "SELECT td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, td.Esercizio, td.Note from GS_TESTEDOCUMENTI_LT td"
		
		Case "Florenzi"			
				sqlstr = "select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, td.Esercizio, td.Note " _
				& "from GS_TESTEDOCUMENTI_LT td order by numerodoc desc"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				
		Case Else
			Select Choose_Menu.vTipoCliFor
				Case "F"
						Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
				& "td.Esercizio, '' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" & Choose_Menu.vTipoCliFor & "%' AND td.TIPODOC <> 'INV'")			
				Case "C"
						Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
				& "td.Esercizio, '' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" & Choose_Menu.vTipoCliFor & "%'")			
				Case "X"
						Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
				& "td.Esercizio, '' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'F%' AND td.TIPODOC='INV'" )
				Case Else
						Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
				& "td.Esercizio, '' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR ORDER BY td.Numerodoc DESC")
			End Select			
				sqlstr = "select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
			& "td.Esercizio, '' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR"
		End Select
		' Log(sqlstr)
		Do While rs.NextRow
			Dim rowx(8) As Object
			Dim sTipoDoc As String = SafeStr(rs.GetString("TipoDoc"))
			Dim sDataDoc As String = SafeStr(rs.GetString("Datadoc"))
			Dim sCodCliFor As String = SafeStr(rs.GetString("CodClifor"))
			Dim sRagSoc As String = SafeStr(rs.GetString("RagSoc"))
			Dim sNote As String = SafeStr(rs.GetString("Note"))
			rowx(0) = ""
			rowx(1) = sTipoDoc
			rowx(2) = rs.getint("Numerodoc")
			rowx(3) = ExtraUtility.ConvertDataStrToLong(sDataDoc,"dd/MM/yyyy","IT") 'Simone
			rowx(4) = sCodCliFor
			Select Main.Ditta
				Case "Gefin"
					rowx(5) = sNote
						
				Case Else
					If sNote.Trim <> "" Then
						rowx(5) = sRagSoc & CRLF & sNote
					Else
						rowx(5) = sRagSoc
					End If
			End Select			
			rowx(6) = rs.Getint("Trasmesso")
			rowx(7) = rs.Getint("Esercizio")						
			DataList.Add(rowx)
		Loop
		rs.Close
		'B4XTable1.MaximumRowsPerPage = 20
		'B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		xRowsSelection.Clear
		'B4XTable1.ClearDataView ' ------
		Wait For (B4XTable1.SetData(DataList)) Complete (Unused As Boolean)
		' Sleep(0)
				
		'   B4XTable1.Refresh
		
			'B4XTable1.MaximumRowsPerPage = 20
			'B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
			'B4XTable1.Refresh
		'	Sleep(1000)
			
'		For i = 1 To B4XTable1.Size
'			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i)
'			If  p.NumberOfViews > 0 Then
'				Dim chk As CheckBox
'				chk.Initialize("chk")
'				p.AddView(chk, p.Width / 2 - 15dip, B4XTable1.RowHeight / 2 - 20dip, 40dip, 40dip)
'			End If
'		Next
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub ListaDocChk(FirstTime As Boolean)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		' Tabella fino ai bottoni a filo basso
		If FooterBarH = 0 Then FooterBarH = 60dip
		If FooterTop = 0 Then FooterTop = 100%y - FooterBarH
		Dim tableTop As Int = B4XTable1.mBase.Top
		Dim tableH As Int = Max(200dip, FooterTop - tableTop - 4dip)
		B4XTable1.mBase.Height = tableH
		Dim rowH As Int = 40dip
		Dim chrome As Int = 90dip ' search + header + nav tabella
		Dim rowsPerPage As Int = Max(4, (tableH - chrome) / rowH)
		B4XTable1.MaximumRowsPerPage = rowsPerPage
		B4XTable1.RowHeight = rowH
		B4XTable1.HeadersHeight = 30dip
		If(FirstTime=False) Then
			Select Main.Ditta
				Case "Florenzi"
					SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
					SelectedColumn.Width = 30dip
					B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=15%x  ' TIPO			c1
					B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=25%x ' NUMERODOC		c2
					B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=27%x ' DATADOC			c3
					B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=24%x ' CODCLIFOR		c4
					RagSocColumn = B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC	c5
					RagSocColumn.Width = 1
					B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' TRASMESSO		c6
					B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' ESERCIZIO		c7
					B4XTable1.AddColumn("Note", B4XTable1.COLUMN_TYPE_TEXT).Width=-1 ' NOTE				c8
				Case "Trendy"
					SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
					SelectedColumn.Width = 30dip
					B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=80  ' TIPO			c1
					B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=110 ' NUMERODOC		c2
					B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=160 ' DATADOC			c3
					B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=110 ' CODCLIFOR		c4
					RagSocColumn = B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC	c5
					RagSocColumn.Width = 200
					B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' TRASMESSO		c6
					B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' ESERCIZIO		c7
					B4XTable1.AddColumn("Note", B4XTable1.COLUMN_TYPE_TEXT).Width=-1 ' NOTE				c8
				Case "Gefin"
					SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
					SelectedColumn.Width = 30dip
					B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=80  		' TIPO			c1
					B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=110 		' NUMERODOC		c2
					B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=160 		' DATADOC		c3
					B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=-1 		' CODCLIFOR		c4
					RagSocColumn = B4XTable1.AddColumn("Note", B4XTable1.COLUMN_TYPE_TEXT) 	' NOTE			c5
					RagSocColumn.Width = 0
					B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 		' TRASMESSO		c6
					B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 		' ESERCIZIO		c7
					B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT).Width=-1 		' RAGSOC		c8
				Case Else
					SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
					SelectedColumn.Width = 30dip
					B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=80  ' TIPO			c1
					B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=105 ' NUMERODOC		c2
					B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=150 ' DATADOC			c3
					B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=125 ' CODCLIFOR		c4
					RagSocColumn = B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC	c5
					RagSocColumn.Width = 200															
					B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' TRASMESSO		c6
					B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' ESERCIZIO		c7
					B4XTable1.AddColumn("Note", B4XTable1.COLUMN_TYPE_TEXT).Width=-1 ' NOTE				c8
			End Select		
			B4XTable1.SearchField.HintText = "Cerca"
			B4XTable1.SearchField.HintColor = Colors.Green
			B4XTable1.SearchField.Update
			B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
			Dim DataList As List
			DataList.Initialize
			Dim rs As ResultSet
			Select Main.Ditta
				Case "Gefin"
					rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, '' as CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note from GS_TESTEDOCUMENTI_LT td")
					sqlstr = "SELECT td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, td.Esercizio, td.Note from " _
					& "GS_TESTEDOCUMENTI_LT td WHERE TipoDoc='INV'"

				Case "Florenzi"
					sqlstr = "SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, 'INVENTARIO' as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note from GS_TESTEDOCUMENTI_LT td"
					rs = SQLDataAccess.ExecQuery(sqlstr)
					
				Case "Trendy"
					rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.RAGSOC,'') as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note, ifnull(td.CodNegozio,'') as CodNegozio from GS_TESTEDOCUMENTI td LEFT OUTER JOIN GS_ANAGRAFICACF cf on td.CodClifor=cf.CODICE")								
					sqlstr = "select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.RAGSOC,'') as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note from GS_TESTEDOCUMENTI td LEFT OUTER JOIN GS_ANAGRAFICACF cf on td.CodClifor=cf.CODICE"
				
				Case "Kuore"
					If(Choose_Menu.vOperazioneMenu="SpuntaCarnet") Then
						sqlstr = "select td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note from IS_TESTEDOCUMENTI td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.Codclifor WHERE td.TipoDoc='SPX'"	
						' Log(sqlstr)
					Else
						sqlstr = "select td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
					& "td.Esercizio, ifnull(td.Note,'') as Note from IS_TESTEDOCUMENTI td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.Codclifor"	
						' Log(sqlstr)
					End If
					rs = SQLDataAccess.ExecQuery(sqlstr)
					
				Case Else
					' ZelariVi / Esseci / ... : "" = tutti i documenti
					Select Choose_Menu.vTipoCliFor
						Case "F"
							rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note," _
					& "td.Esercizio,'' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" & Choose_Menu.vTipoCliFor & "%' AND td.TIPODOC <> 'INV'")		
						Case "C"
							rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note," _
					& "td.Esercizio,'' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" & Choose_Menu.vTipoCliFor & "%'")			
						Case "X"
							rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
					& "td.Esercizio,'' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'F%' AND td.TIPODOC='INV'")
						Case Else
							rs = SQLDataAccess.ExecQuery("SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
					& "td.Esercizio,'' as CodNegozio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR ORDER BY td.Numerodoc DESC")
					End Select
					sqlstr = "SELECT td.IDKEY, td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, ifnull(td.Note,'') as Note, " _
					& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR"			
			End Select
			' Log (sqlstr)
			Do While rs.NextRow
				Dim rowx(8) As Object
				Dim sTipoDoc As String = SafeStr(rs.GetString("TipoDoc"))
				Dim sDataDoc As String = SafeStr(rs.GetString("Datadoc"))
				Dim sCodCliFor As String = SafeStr(rs.GetString("CodClifor"))
				Dim sRagSoc As String = SafeStr(rs.GetString("RagSoc"))
				Dim sNote As String = SafeStr(rs.GetString("Note"))
				rowx(0) = "" ' CHECKBOX
				rowx(1) = sTipoDoc
				rowx(2) = rs.getint("Numerodoc")
				rowx(3) = ExtraUtility.ConvertDataStrToLong(sDataDoc,"dd/MM/yyyy","IT") 'Simone
				rowx(4) = sCodCliFor
				Select Main.Ditta
					Case "Gefin"
						rowx(5) = sNote
					
					Case Else
						If sNote.Trim <> "" Then
							rowx(5) = sRagSoc & CRLF & sNote
						Else
							rowx(5) = sRagSoc
						End If
				End Select
				rowx(6) = rs.Getint("Trasmesso")
				rowx(7) = rs.Getint("Esercizio")
				' Log( rs.getstring("TipoDoc") & "-" & rs.getstring("Numerodoc") & "-" &  rs.getint("Esercizio"))
				DataList.Add(rowx)
			Loop
			rs.Close
			Log("ListaDoc documenti caricati: " & DataList.Size)
			Wait For (B4XTable1.SetData(DataList)) Complete (Unused As Boolean)
			For i = 1 To B4XTable1.Size
				Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i)
				If p.NumberOfViews > 0 Then
					Dim chk As CheckBox
					chk.Initialize("chk")
					p.AddView(chk, p.Width / 2 - 15dip, B4XTable1.RowHeight / 2 - 20dip, 40dip, 40dip)
				End If
			Next
			B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
			B4XTable1.Refresh
		End If
		RiposizionaBarraBottoniDocumenti

	Catch
		Log(LastException.Message) 'no changes will be made				
	End Try
End Sub

Sub chk_CheckedChange(Checked As Boolean)
	Try			
		Dim chk As CheckBox = Sender.As(CheckBox)
		If(Not(chk.IsInitialized)) Then
			chk.Initialize("chk")
		End If
		If(chk.Tag<>Null) Then
			Dim index As Int = chk.Tag.As(Int)
			' Log("chk_Checked " & index & " -> " & chk.Checked)
			If(index>0) Then
				Dim rowid As Long = chk.Tag
				If (rowid>0) Then
					If Checked Then
						CheckedRows.Add(rowid)
					Else
						CheckedRows.Remove(rowid)
					End If
				End If
			End If
		Else
			Log("chk_Checked is NULL")
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Try
		Dim column As B4XTableColumn = tableName.GetColumn(columnID)
		For i = 1 To column.CellsLayouts.Size - 1   'starts at 1 due to header
			Dim pnl As B4XView = column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub B4XTable1_CellClicked (columnID As String, RowId As Long)	
	Try		
		xRowsSelection.CellClicked(columnID, RowId,-1)
		Dim res As ResultSet = B4XTable1.sql1.ExecQuery("SELECT c0,c1,c2,c3,c4,c5,c6,c7 FROM data WHERE RowId =" & RowId)
		If (res.RowCount>0) Then
			Do While res.NextRow
				vTipoDoc = res.Getstring("c1")
				vNumerodoc = res.Getstring("c2")
				vEsercizio = res.Getint("c7")
				vDataDoc = ExtraUtility.DateToFormat(res.GetString("c3"),"dd-MM-yy","it","")
				vCodCliFor = res.GetString("c4")
				vTrasmesso = res.Getint("c6")
				vRagSoc = res.GetString("c5").Replace(CRLF," - ")
				vCodNegozio = res.GetString("c4")
			Loop
		Else
			vTipoDoc = ""
			vNumerodoc = ""
			vEsercizio = 0		
			vDataDoc = ""
			vCodCliFor = ""
			vTrasmesso = 0
			vRagSoc = ""
			vCodNegozio = ""
		End If
		res.Close
		#if debug
			Log(vNumerodoc & "-" & vEsercizio & "-" & vTipoDoc & " trasmesso " & vTrasmesso)
		#end if
		B4XTable1.Refresh
		Dim txtLabel As String
		Select Case Main.Ditta			
			Case "Trendy"
				If(vRagSoc.Length>30) Then
					vRagSoc = vRagSoc.SubString2(1,30)
				End If
				txtLabel = vTipoDoc & " n. " & vNumerodoc &  " del " & vDataDoc & CRLF & vRagSoc & CRLF
			Case Else
				If(vRagSoc.Length>30) Then
					vRagSoc = vRagSoc.SubString2(1,30)
				End If			
				txtLabel = vTipoDoc & " n. " & vNumerodoc &  " del " & vDataDoc & CRLF & vRagSoc  & CRLF
		End Select
		Select vTrasmesso
			Case 1
				txtLabel=txtLabel & "*** BLOCCATO TRASMESSO ***"
				Label1.Color=Colors.Red
			Case 2
				txtLabel=txtLabel & "*** BLOCCATO MANUALE ***"
				Label1.Color=Colors.Cyan
			Case Else
				txtLabel=txtLabel & ""
				Label1.Color=Colors.LightGray
		End Select
		Label1.Text=txtLabel
		RowID_Riga = RowId
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		Return True
	Else
		Return False
	End If
End Sub

private Sub SbloccaDoc (tbl As B4XTable, RowId As Long)
	Try
		Msgbox2Async("Vuoi sbloccare il documento?", "SBLOCCO DOCUMENTO", "SI", "NO", "", Null, False)			
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			' c6 corrisponde alla 7-1 colonna della tabella virtuale.. si inizia a contare le colonne da 0		
			tbl.sql1.ExecNonQuery2($"UPDATE data SET c6 = ? WHERE rowid = ?"$, Array As String(0, RowId))	' data è la tabella  a video
			Select Main.Ditta
				Case "Florenzi"
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET TRASMESSO=0 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
				Case "Gefin"
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET TRASMESSO=0 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
				Case Else
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI SET TRASMESSO=0 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"				
			End Select
			SQLDataAccess.ExecNonQuery(sqlstr)
			tbl.Refresh
		End If
	Catch
		Log(LastException)
	End Try
End Sub

private Sub BloccaDoc (tbl As B4XTable, RowId As Long)
	Try		
		Msgbox2Async("Vuoi bloccare il documento?", "BLOCCO DOCUMENTO", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			' c6 corrisponde alla 7-1 colonna della tabella virtuale.. si inizia a contare le colonne da 0
			tbl.sql1.ExecNonQuery2($"UPDATE data SET c6 = ? WHERE rowid = ?"$, Array As String(2, RowId))	' data è la tabella  a video
			Select Main.Ditta
				Case "Florenzi"
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET TRASMESSO=2 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
				Case "Gefin"
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET TRASMESSO=2 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
				Case Else
					sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI SET TRASMESSO=2 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
					sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
			End Select
			SQLDataAccess.ExecNonQuery(sqlstr)
			tbl.Refresh
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button1_Click ' Apri Documento
	Try		
		vTipoOperazione="OpenDoc"
		NewDocument.vOperazione=""
		If (vNumerodoc > 0) Then
			Select Case Main.Ditta
				Case "ZelariVi"
					StartActivity(RigheDoc_ZelariVi)
				Case "Gefin"
					StartActivity(RigheDoc_Gefin)
				Case "Florenzi"
					StartActivity(RigheDoc_Florenzi)
				Case "Trendy"
					StartActivity(RigheDoc_Trendy)
				Case "Esseci"				
					StartActivity(RigheDoc_Esseci)
				Case "Nesti"
					StartActivity(RigheDoc_Esseci)
				Case "Kuore"					
					If(Choose_Menu.vOperazioneMenu="SpuntaCarnet") Then
						StartActivity(TesteDoc_Kuore_Spunta)
					Else
						StartActivity(TesteDoc_Kuore)
					End If
			End Select
		Else
			ToastMessageShow("Selezionare il documento da aprire!",False)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button2_Click ' Nuovo Documento
	Try		
		vNumerodoc = 0
		vTipoDoc = ""
		vEsercizio = 0
		vTipoOperazione="NewDoc"	
		Select Main.Ditta
			Case "Kuore"			
				If(Choose_Menu.vOperazioneMenu="SpuntaCarnet") Then
					StartActivity(TesteDoc_Kuore_Spunta)
				Else				
					StartActivity(TesteDoc_Kuore)
					Activity.Finish
				End If
							
			Case Else
				StartActivity(NewDocument)
				
		End Select
	Catch
		Log(LastException)
	End Try
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long)  As ResumableSub
	Try		
		Sleep(0) 'this is required as the table layout is not immediately created.'
		' Dim RowData As Map = tbl.GetRow(RowId)
		SQLDataAccess.BeginTransaction	
		Select Case Main.ditta
			Case "Gefin"
				Dim sql1 As String = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
				Dim sql2 As String = "DELETE FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
			Case "Kuore"
				Dim sql1 As String = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
				Dim sql2 As String = "DELETE FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"				
			Case "Nesti" 
				Dim IDTesta As Long = SQLDataAccess.ExecQuerySingleResult("SELECT ifnull(rifidtesta,0) FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" _
					& vTipoDoc & "' And Esercizio = '" & vEsercizio & "'")
				Dim sql1 As String = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
				Dim sql2 As String = "DELETE FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
				Dim sql3 As String = "DELETE FROM " & Main.PrefixSQL & "_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = " & IDTesta
				SQLDataAccess.ExecNonQuery(sql3)
			Case Else
				Dim sql1 As String = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
				Dim sql2 As String = "DELETE FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"			
		End Select
		' Log(sql1)
		' Log(sql2)
		SQLDataAccess.ExecNonQuery(sql1)	
		SQLDataAccess.ExecNonQuery(sql2)
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array (RowId))	 			' deletes record from Table
		Dim page As Int = tbl.CurrentPage
		Dim FirstIndex As Int = tbl.FirstRowIndex	
		tbl.ClearDataView 'Updates the rows count.
		tbl.UpdateTableCounters
		If FirstIndex + 1 >= tbl.mCurrentCount Then
			page = page - 1
		End If
		tbl.CurrentPage = page
		tbl.Refresh
		Return(True)
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub Button3_Click ' Cancella Documento
	Try
		Log ("inizio cancellazione")
		Dim sf As Object = xui.Msgbox2Async("Elimino i " & CheckedRows.Size & " documenti selezionati?", "CANCELLAZIONE DOCUMENTI", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			'	Log ("RowID_Riga: "& RowID_Riga)			
			If (CheckedRows.AsList.Size=0) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun documento da cancellare!","ATTENZIONE")
				' CheckedRows.Clear
				B4XTable1.Refresh
			Else
				Dim RowId As Long
				For Each RowId As Long In CheckedRows.AsList
					If RowId > 0 Then
						Dim row As Map = B4XTable1.GetRow(RowId)
						vNumerodoc = row.Get("N")
						vTipoDoc = row.Get("Tipo")
						vDataDoc  = row.Get("Data")
						Select Case Main.ditta
							Case "Kuore"
								vEsercizio = row.Get("A")
							Case Else
								vEsercizio = ExtraUtility.DateToFormat(vDataDoc,  "yyyy","it","")
						End Select					
						wait for (DeleteRow(B4XTable1, RowId)) complete (Success As Boolean)
						If (Success) Then
							Log($"Deleted rowid ${RowId} -> ${vNumerodoc} OK!"$)
						End If
					End If
				Next
				xRowsSelection.Clear
				If(CheckedRows.Size>0) Then
					CheckedRows.Clear
				End If
				B4XTable1.Refresh
			End If
		End If
		Log ("Fine cancellazione")
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try	
End Sub

Sub Button4_Click ' Sblocca Documento
	Try
		SbloccaDoc(B4XTable1,RowID_Riga)
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button5_Click ' Blocca Documento
	Try
		BloccaDoc(B4XTable1,RowID_Riga)
	Catch
		Log(LastException)
	End Try
End Sub
