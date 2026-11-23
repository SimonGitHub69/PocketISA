B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.2
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
	Private CheckedRows As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione	
	Public vTipoDoc As String
	Public vNumerodoc As Int
	Public vEsercizio As Int
	Public vDataDoc As String
	Public vTrasmesso As Int
	Public vCodCliFor As String
	Public vRagSoc As String
	Public vOperazione As String
	Public vTitle As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.	
	Private B4XTable1 As B4XTable
	Private xui As XUI
	Private xlbl As B4XView
	Private SelectedColumn As B4XTableColumn
	Private CheckedColumn As B4XTableColumn
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private DataList As List
	Private RowID_Riga As Long
	Private sqlstr As String
	Private Title1 As Label
	'Private MyFont As Typeface
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:
	Sleep(0)
	blobColumns.Initialize
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("ListaDocTablet")
	' Colonna Data: anno a 2 cifre (B4XTable usa DateTime.DateFormat)
	DateTime.DateFormat = "dd/MM/yy"
	Select Choose_Menu.vOperazioneMenu 
		Case "Carico Ordine Fornitore"
			ListaDocChk("F")
			Title1.text = "CARICAMENTO MERCE DA ORDINE FORNITORE"
		Case "Inventario"
			ListaDocChk("X")
			Title1.text = "INVENTARIO"
		Case "Spostamento"
			ListaDocChk("Z")
			Title1.text = "SPOSTAMENTO MERCE DI MAGAZZINO"
		Case "Cash"
			If(Main.Ditta="Nesti") Then
				If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
					ListaDocChk("W")
				Else
					ListaDocChk_PalmDevice("W")
				End If
			End If
			Title1.text = "CASH"					
		Case "Picking"
			ListaDocChk("G")
			Title1.text = "PICKING"
		Case Else
			Title1.Text = ""
	End Select
	If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then	
		CreaPanel_Bottoni_Tablet
	Else
		CreaPanel_Bottoni_PalmDevice	
	End If
	vNumerodoc = 0
	vTipoDoc = ""
	vEsercizio = 0
End Sub

Sub Activity_Resume
	DateTime.DateFormat = "dd/MM/yy"
	Sleep(1000)
	ListaDocChkNew
End Sub

Sub CreaPanel_Bottoni_Tablet
	' ----------------------------------
	' Creazione Pannello con bottoni per tablet
	' ----------------------------------
	Dim Panel1 As Panel
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)
	Dim offset As Int = 6
	Button1.Initialize("Button1")
	Panel1.AddView(Button1, offset, 0, 67dip, 60dip)
	Button2.Initialize("Button2")
	Panel1.AddView(Button2, offset+(100%x / 5+60), 0, 67dip, 60dip)
	Button3.Initialize("Button3")
	Panel1.AddView(Button3, offset+(100%x / 5+60) * 2, 0, 67dip, 60dip)
	Button4.Initialize("Button4")
	Panel1.AddView(Button4, offset+(100%x / 5+60) * 3, 0, 67dip, 60dip)
	Button5.Initialize("Button5")
	Panel1.AddView(Button5, offset+(100%x / 5+60) * 4, 0, 67dip, 60dip)
	Activity.AddView(Panel1, 0, 100%y - 60dip, 100%x, 70dip)
	CreateLabel(Button1, Chr(0xF15C), "Apri")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Cancella")
	CreateLabel(Button4, Chr(0xF13E), "Sblocca")
	CreateLabel(Button5, Chr(0xF023), "Blocca")
	B4XTable1.LabelsFont = xui.CreateDefaultFont(13)
	' B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(30)
	' B4XTable1.mBase.Height = 200dip
	' MyFont = Typeface.LoadFromAssets("myfont.ttf")
	' ---------------------------------------------------------------
End Sub

Sub CreaPanel_Bottoni_PalmDevice
	' ----------------------------------
	' Creazione Pannello con bottoni per palmare
	' ----------------------------------
	Dim Panel1 As Panel
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)
	Dim offset As Int = 6
	Dim botton_Width As Int = 55dip
	Dim botton_Height As Int = 60dip
	Dim Botton_Distance As Int = 5
	Button1.Initialize("Button1")
	Panel1.AddView(Button1, offset, 0, botton_Width, botton_Height)
	Button2.Initialize("Button2")
	Panel1.AddView(Button2, offset+(100%x / 5+Botton_Distance), 0, botton_Width, botton_Height)
	Button3.Initialize("Button3")
	Panel1.AddView(Button3, offset+(100%x / 5+Botton_Distance) * 2, 0, botton_Width, botton_Height)
	Button4.Initialize("Button4")
	Panel1.AddView(Button4, offset+(100%x / 5+Botton_Distance) * 3, 0, botton_Width, botton_Height)
	Button5.Initialize("Button5")
	Panel1.AddView(Button5, offset+(100%x / 5+Botton_Distance) * 4, 0, botton_Width, botton_Height)
	Activity.AddView(Panel1, 0, 100%y - botton_Height, 100%x, 70dip)
	CreateLabel(Button1, Chr(0xF15C), "Apri")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Cancella")
	CreateLabel(Button4, Chr(0xF13E), "Sblocca")
	CreateLabel(Button5, Chr(0xF023), "Blocca")
	B4XTable1.LabelsFont = xui.CreateDefaultFont(13)
	' B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(30)
	' B4XTable1.mBase.Height = 200dip
	' MyFont = Typeface.LoadFromAssets("myfont.ttf")
	' ---------------------------------------------------------------
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Dim cs As CSBuilder
	cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(30).Append(Text1).Pop.Append(CRLF).Size(10).Append(Text2).Alignment("ALIGN_CENTER").PopAll
	xlbl = Label
	xlbl.Text = cs
	xlbl.TextColor = xui.Color_RGB(105, 105, 105)
	Return xlbl.Snapshot
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub B4XTable1_DataUpdated
	Try
		SetColumnAlignment(B4XTable1,"RagSoc",Gravity.LEFT)
		For i = 0 To B4XTable1.VisibleRowIds.Size - 1
			Dim rowid As Long = B4XTable1.VisibleRowIds.Get(i)			
			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i + 1)
			Dim chkx As B4XView = p.GetView(1) 'first view is the label
			If (rowid>0) Then
				SetRowColor(i, SelectedRows.Contains(rowid))				
				chkx.Visible = True	
				chkx.Tag = rowid
				chkx.Checked = CheckedRows.Contains(rowid)
			Else
				chkx.Visible = False				
			End If
		Next
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub ListaDocChkNew
	Try
		'Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		CheckedRows = B4XCollections.CreateSet
		Dim DataList As List
		DataList.Initialize
		Select Choose_Menu.vTipoCliFor
			Case "F"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" & Choose_Menu.vTipoCliFor & "%'" _
				& " AND td.TipoDoc <> 'INV' AND td.TipoDoc <> 'SPO' ORDER BY IDKEY DESC")			
			Case "G"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio,td.rifidtesta from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE td.TIPODOC='GIR' ORDER BY IDKEY DESC")
			Case "C"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" _
				& Choose_Menu.vTipoCliFor & "%' AND td.TIPODOC<>'GIR' ORDER BY IDKEY DESC")			
			Case "X"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'F%'" _
				& " AND td.TipoDoc='INV' ORDER BY IDKEY DESC")				
			Case "Z"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'C%'" _
				& " AND td.TipoDoc='SPO' ORDER BY IDKEY DESC")
			Case Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR ORDER BY IDKEY DESC")
			Case "W"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE td.TIPODOC='CAS' ORDER BY IDKEY DESC")
		End Select
		sqlstr = "select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
			& "td.Esercizio,td.rifidtesta from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" _
			& Choose_Menu.vTipoCliFor & "%' ORDER BY IDKEY DESC"
		' Log(sqlstr)		
		If(Choose_Menu.vTipoCliFor="G") Then
			Do While rs.NextRow
				Dim rowx(9) As Object
				rowx(0) = "" ' CHECKBOX
				rowx(1) = rs.GetString("TipoDoc")
				rowx(2) = rs.getint("Numerodoc")
				rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("Datadoc"),"dd/MM/yy","ITX")  ' Simone
				rowx(4) = rs.GetString("CodClifor")
				rowx(5) = rs.GetString("RagSoc")
				rowx(6) = rs.Getint("Trasmesso")
				rowx(7) = rs.Getint("Esercizio")
				rowx(8) = rs.GetLong("rifidtesta")
				DataList.Add(rowx)
			Loop
		Else
			Do While rs.NextRow
				Dim rowx(8) As Object
				rowx(0) = "" ' CHECKBOX
				rowx(1) = rs.GetString("TipoDoc")
				rowx(2) = rs.getint("Numerodoc")
				rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("Datadoc"),"dd/MM/yy","ITX")  ' Simone
				rowx(4) = rs.GetString("CodClifor")
				rowx(5) = rs.GetString("RagSoc")
				rowx(6) = rs.Getint("Trasmesso")
				rowx(7) = rs.Getint("Esercizio")
				DataList.Add(rowx)
			Loop
		End If
		rs.Close
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		Dim chk As CheckBox
		' B4XTable1.mCurrentCount
		B4XTable1.SetData(DataList)
		For i = 0 To B4XTable1.VisibleRowIds.Size-1
			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i+1) '0 = header
			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
			If (RowId>0) Then
				If(Not(chk.IsInitialized)) Then
					chk.Initialize("chk")
					p.AddView(chk, 0, 10dip, 30dip, 30dip)
					chk.Tag = RowId
					chk.Checked = CheckedRows.Contains(RowId)
					chk.Visible = True
				End If
			End If
		Next
		Dim RagSocColumn As B4XTableColumn = B4XTable1.GetColumn("RagSoc") ' RAGSOC
		For i = 1 To RagSocColumn.CellsLayouts.Size - 1
			Dim pnl As B4XView = RagSocColumn.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextSize = 14
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.TextColor = Colors.RGB(9,0,104)
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.Refresh
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub ListaDocChk_PalmDevice(xTipoCliFor As String)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.RowHeight=50dip
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		CheckedRows = B4XCollections.CreateSet
		SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
		SelectedColumn.Width = 30dip
		B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=10%x  ' TIPO
		B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=14%x ' NUMERODOC
		B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=22%x ' DATADOC
		B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=-1  ' CODCLIFOR
		' B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT).Width=200 ' RAGSOC
		Dim RagSocColumn As B4XTableColumn =  B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC
		RagSocColumn.Width = 0
		B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' TRASMESSO
		B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=-1 ' ESERCIZIO
		'Dim col_font As B4XTableColumn
		'Dim ColSize As Int
		'ColSize = column.Pnel.Font.Size
		Dim DataList As List
		DataList.Initialize
		Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
			& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE td.TIPODOC='CAS' ORDER BY IDKEY DESC")
		Do While rs.NextRow
			Dim rowx(8) As Object
			rowx(0) = "" ' CHECKBOX
			rowx(1) = rs.GetString("TipoDoc")
			rowx(2) = rs.getint("Numerodoc")
			rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("Datadoc"),"dd/MM/yy","ITX")  ' Simone
			rowx(4) = rs.GetString("CodClifor")
			rowx(5) = rs.GetString("RagSoc")
			rowx(6) = rs.Getint("Trasmesso")
			rowx(7) = rs.Getint("Esercizio")
			' Log( rs.getstring("TipoDoc") & "-" & rs.getstring("Numerodoc") & "-" &  rs.getint("Esercizio"))
			DataList.Add(rowx)
		Loop
		rs.Close
		B4XTable1.MaximumRowsPerPage = 15
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		' Log("Current Page ListaDocChk " & B4XTable1.CurrentPage)
		B4XTable1.SetData(DataList)
		For i = 0 To B4XTable1.MaximumRowsPerPage - 1
			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i + 1) '0 = header
			Dim chk As CheckBox
			chk.Initialize("chk")
			p.AddView(chk, 0, 10dip, 30dip, 30dip)
		Next
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		For i = 1 To RagSocColumn.CellsLayouts.Size - 1
			Dim pnl As B4XView = RagSocColumn.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextSize = 14
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.TextColor = Colors.RGB(9,0,104)
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
		B4XTable1.Refresh
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub ListaDocChk(xTipoCliFor As String)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'		
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		CheckedRows = B4XCollections.CreateSet
		SelectedColumn = B4XTable1.AddColumn("-", B4XTable1.COLUMN_TYPE_TEXT)
		SelectedColumn.Width = 30dip
		B4XTable1.AddColumn("Tipo", B4XTable1.COLUMN_TYPE_TEXT).Width=7%x  ' TIPO
		B4XTable1.AddColumn("N", B4XTable1.COLUMN_TYPE_NUMBERS).Width=8%x ' NUMERODOC
		B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_DATE).Width=10%x ' DATADOC
		B4XTable1.AddColumn("C/F", B4XTable1.COLUMN_TYPE_TEXT).Width=10%x  ' CODCLIFOR
		' B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT).Width=200 ' RAGSOC
		Dim RagSocColumn As B4XTableColumn =  B4XTable1.AddColumn("RagSoc", B4XTable1.COLUMN_TYPE_TEXT) ' RAGSOC
		If(xTipoCliFor="G") Then
			RagSocColumn.Width = 60%x - 40dip
		Else
			RagSocColumn.Width = 60%x + 35dip
		End If
		B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_NUMBERS).Width=1 ' TRASMESSO
		B4XTable1.AddColumn("A", B4XTable1.COLUMN_TYPE_NUMBERS).Width=1 ' ESERCIZIO
		If(xTipoCliFor="G") Then
			B4XTable1.AddColumn("Rif. ID", B4XTable1.COLUMN_TYPE_NUMBERS).Width=75dip ' Rif. IdTesta
		End If
		'Dim col_font As B4XTableColumn
		'Dim ColSize As Int
		'ColSize = column.Pnel.Font.Size
		Dim DataList As List
		DataList.Initialize
		Select xTipoCliFor
			Case "F"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" _
				& Choose_Menu.vTipoCliFor & "%' AND td.TIPODOC <> 'INV' AND td.TIPODOC <> 'SPO' ORDER BY IDKEY DESC")		
			Case "G"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio,td.rifidtesta from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE td.TIPODOC='GIR' ORDER BY IDKEY DESC")
			Case "C"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE '" _
				& Choose_Menu.vTipoCliFor & "%' AND td.TIPODOC<>'GIR' ORDER BY IDKEY DESC")			
			Case "X"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'F%'" _
				& " AND td.TIPODOC='INV' ORDER BY IDKEY DESC")
			Case "Z"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE TD.CODCLIFOR LIKE 'C%'" _
				& " AND td.TIPODOC='SPO' ORDER BY IDKEY DESC")
			Case "W"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR WHERE td.TIPODOC='CAS' ORDER BY IDKEY DESC")
			Case Else
				Dim rs As ResultSet = SQLDataAccess.ExecQuery("select td.TipoDoc, td.Numerodoc, td.Datadoc, td.CodClifor, ifnull(cf.DSCCONTO1,'') as RagSoc, td.Trasmesso, " _
				& "td.Esercizio from is_testedocumenti td LEFT OUTER JOIN IS_ANAGRAFICACF cf on td.CodClifor=cf.CODCLIFOR ORDER BY IDKEY DESC")
		End Select
		If(xTipoCliFor="G") Then 
			Do While rs.NextRow			
				Dim rowx(9) As Object
				rowx(0) = "" ' CHECKBOX
				rowx(1) = rs.GetString("TipoDoc")
				rowx(2) = rs.getint("Numerodoc")
				rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("Datadoc"),"dd/MM/yy","ITX")  ' Simone
				rowx(4) = rs.GetString("CodClifor")
				rowx(5) = rs.GetString("RagSoc")
				rowx(6) = rs.Getint("Trasmesso")
				rowx(7) = rs.Getint("Esercizio")
				rowx(8) = rs.GetLong("rifidtesta")
				DataList.Add(rowx)
			Loop		
		Else
			Do While rs.NextRow			
				Dim rowx(8) As Object
				rowx(0) = "" ' CHECKBOX
				rowx(1) = rs.GetString("TipoDoc")
				rowx(2) = rs.getint("Numerodoc")
				rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("Datadoc"),"dd/MM/yy","ITX")  ' Simone
				rowx(4) = rs.GetString("CodClifor")
				rowx(5) = rs.GetString("RagSoc")
				rowx(6) = rs.Getint("Trasmesso")
				rowx(7) = rs.Getint("Esercizio")				
				DataList.Add(rowx)
			Loop
		End If
		rs.Close
		B4XTable1.MaximumRowsPerPage = 15
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		' Log("Current Page ListaDocChk " & B4XTable1.CurrentPage)
		B4XTable1.SetData(DataList)
		For i = 0 To B4XTable1.MaximumRowsPerPage - 1
			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i + 1) '0 = header
			Dim chk As CheckBox
			chk.Initialize("chk")
			p.AddView(chk, 0, 5dip, 30dip, 30dip)
		Next
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		For i = 1 To RagSocColumn.CellsLayouts.Size - 1
			Dim pnl As B4XView = RagSocColumn.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextSize = 14
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.TextColor = Colors.RGB(9,0,104)
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
		B4XTable1.Refresh
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub chk_CheckedChange(Checked As Boolean)
	Try
		Dim chk As B4XView = Sender
		Dim rowid As Long = chk.Tag
		If Checked Then
			CheckedRows.Add(rowid)
		Else
			CheckedRows.Remove(rowid)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Try
		Dim column As B4XTableColumn = tableName.GetColumn(columnID)
		For i = 1 To column.CellsLayouts.Size-1     'starts at 1 due to header
			Dim pnl As B4XView = column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		Next
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean)
	Try
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
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Try
		Dim res As ResultSet = B4XTable1.sql1.ExecQuery("SELECT c1,c2,c3,c4,c5,c6,c7 FROM data WHERE RowId =" & RowId)
		If (res.RowCount>0) Then
			Do While res.NextRow
				vTipoDoc = res.Getstring("c1")
				vNumerodoc = res.Getstring("c2")
				vEsercizio = res.Getint("c7")
				vDataDoc = ExtraUtility.DateToFormat(res.GetString("c3"),"dd/MM/yyyy","it","")
				vCodCliFor = res.GetString("c4")
				vTrasmesso = res.Getint("c6")
				vRagSoc = res.GetString("c5")
			Loop
		Else
			vTipoDoc = ""
			vNumerodoc = ""
			vEsercizio = 0
			vDataDoc = ""
			vCodCliFor = ""
			vTrasmesso = 0
			vRagSoc = ""
		End If
		res.Close
		Log(vNumerodoc & "-" & vEsercizio & "-" & vTipoDoc & " trasmesso " & vTrasmesso)
		B4XTable1.Refresh
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
		Dim txtLabel As String
		Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId)
		SetRowColor(Index, Selected)
		If(vRagSoc.Length>30) Then
			vRagSoc = vRagSoc.SubString2(0,30)
		End If
		txtLabel = vTipoDoc & " n. " & vNumerodoc &  " del " & vDataDoc & CRLF & vRagSoc  & Chr(13) & Chr(10)
		Select vTrasmesso
			Case 1
				txtLabel=txtLabel & "*** BLOCCATO TRASMESSO ***"
				Title1.Color=Colors.Red
			Case 2
				txtLabel=txtLabel & "*** BLOCCATO MANUALE ***"
				Title1.Color=Colors.Cyan
			Case Else
				txtLabel=txtLabel & ""
				Title1.Color=Colors.LightGray
		End Select
		Title1.Text=txtLabel
		vTitle=Title1.Text
		RowID_Riga = RowId
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Try 
		If KeyCode = KeyCodes.KEYCODE_BACK Then
			Activity.Finish
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

private Sub SbloccaDoc (tbl As B4XTable, RowId As Long)
	Try
		Msgbox2Async("Vuoi sbloccare il documento?", "SBLOCCO DOCUMENTO", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			' c6 corrisponde alla 7-1 colonna della tabella virtuale.. si inizia a contare le colonne da 0
			tbl.sql1.ExecNonQuery2($"UPDATE data SET c6 = ? WHERE rowid = ?"$, Array As String(0, RowId))	' data è la tabella  a video
			sqlstr = "UPDATE IS_TESTEDOCUMENTI SET TRASMESSO=0 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
			sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
			tbl.Refresh
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub BloccaDoc (tbl As B4XTable, RowId As Long)
	Try
		Msgbox2Async("Vuoi bloccare il documento?", "BLOCCO DOCUMENTO", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			' c6 corrisponde alla 7-1 colonna della tabella virtuale.. si inizia a contare le colonne da 0
			tbl.sql1.ExecNonQuery2($"UPDATE data SET c6 = ? WHERE rowid = ?"$, Array As String(2, RowId))	' data è la tabella  a video
			sqlstr = "UPDATE IS_TESTEDOCUMENTI SET TRASMESSO=2 WHERE TipoDoc = '" & vTipoDoc & "' AND Numerodoc = '" & vNumerodoc
			sqlstr = sqlstr & "' AND Esercizio = '" & vEsercizio & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
			tbl.Refresh
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button1_Click ' Apri Documento
	' Activity.Finish	
	Try
		vOperazione = "ApriDoc"
		If (vNumerodoc > 0) Then
			Select Choose_Menu.vOperazioneMenu
				Case "Carico Ordine Fornitore"
					StartActivity(Picking)
				Case "Picking"
					StartActivity(PickingNew)
				Case "Inventario"
					StartActivity(Picking)
				Case "Spostamento"
					StartActivity(Picking)
				Case "Cash"
					StartActivity(Cash)
				Case Else
					StartActivity(NewDocument)
			End Select
		Else
			ToastMessageShow("Selezionare il documento da aprire!",False)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button2_Click ' Nuovo Documento
	Try		
		vNumerodoc = 0
		vTipoDoc = ""
		vEsercizio = 0
		vTrasmesso=0
		vOperazione = "NuovoDoc"
		Select Choose_Menu.vOperazioneMenu
			Case "Carico Ordine Fornitore"
				StartActivity(Picking)
			Case "Picking"
				StartActivity(PickingNew)
			Case "Inventario"
				StartActivity(Picking)
			Case "Spostamento"
				StartActivity(Picking)
			Case "Cash"
				StartActivity(Cash)
			Case Else
				StartActivity(NewDocument)
		End Select
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub LeggiRifIdTesta(TipoDoc As String, NumDoc As Long, Esercizio As Int) As Long
	Try		
		Dim RifIDTesta As Long = SQLDataAccess.ExecQuerySingleResult("SELECT ifnull(RifIdTesta,0) as RifIdTesta FROM IS_TESTEDOCUMENTI WHERE Tipodoc = '" & _
		TipoDoc & "' AND Numerodoc = " & NumDoc & " AND Esercizio ='" & Esercizio & "'")
		Return RifIDTesta
	Catch
		Return 0
	End Try
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long)  As ResumableSub
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		' Dim RowData As Map = tbl.GetRow(RowId)
		Dim sql As String = ""
		SQLDataAccess.BeginTransaction
		sql = "DELETE FROM IS_RIGHEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
		SQLDataAccess.ExecNonQuery(sql)
		If(vTipoDoc="GIR") Then ' modifica NESTI
			'--------------------------------------------------------------------------
			' Leggo Eventuali 'TV' collegati al giro andando a leggere il rifidtesta
			'--------------------------------------------------------------------------
			Dim RifIdTesta As Long = LeggiRifIdTesta(vTipoDoc,vNumerodoc,vEsercizio)
			sql = "DELETE FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA = '" & RifIdTesta & "'"
			SQLDataAccess.ExecNonQuery(sql)
			sql = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = 'TV' And Esercizio = '" & vEsercizio & "' AND RifIdTesta = '" & RifIdTesta & "'"
			SQLDataAccess.ExecNonQuery(sql)	
			sql = "DELETE FROM IS_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
		Else
			Select Main.Ditta
				Case "Nesti" 
					If( vTipoDoc="CAS") Then
						Dim IDTesta As Long = SQLDataAccess.ExecQuerySingleResult("SELECT ifnull(rifidtesta,0) FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI WHERE Numerodoc = '" _
						& vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'")
						sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = " & IDTesta
						SQLDataAccess.ExecNonQuery(sqlstr)
					End If
					
			End Select							
			sql = "DELETE FROM IS_TESTEDOCUMENTI WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"			
		End If		
		Log(sql)
		SQLDataAccess.ExecNonQuery(sql)
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
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Button3_Click ' Canc. Documento
	Try
		Log ("inizio cancellazione")
		Dim sf As Object = xui.Msgbox2Async("Elimino i " & CheckedRows.Size & " documenti selezionati?", "CANCELLAZIONE DOCUMENTI", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			'	Log ("RowID_Riga: "& RowID_Riga)	
			If (CheckedRows.AsList.Size=0) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun documento da cancellare!","ATTENZIONE")
			Else
'				Dim pnl As B4XView 
'				Dim ColCheckBox As CheckBox
				Dim RowId As Long				
				For Each RowId As Long In CheckedRows.AsList
				'For i = 0 To B4XTable1.VisibleRowIds.Size - 1
					'RowId = B4XTable1.VisibleRowIds.Get(i)
					If RowId > 0 Then
						'Log($"Deleted inizio ${RowId} "$)
						Dim row As Map = B4XTable1.GetRow(RowId)
						If(row.Size>0) Then
							vNumerodoc = row.Get("N")
							vTipoDoc = row.Get("Tipo")
							vDataDoc  = row.Get("Data")
							vEsercizio = ExtraUtility.DateToFormat(vDataDoc,  "yyyy","it","")				
							'Log($"Deleted rowid ${RowId} -> ${vNumerodoc} OK!"$)
							wait for (DeleteRow(B4XTable1, RowId)) complete (Success As Boolean)
							If (Success) Then
								Log($"Deleted rowid ${RowId} -> ${vNumerodoc} OK!"$)
							End If
						End If			
					End If
				Next
			End If
'			Dim chk As CheckBox
'			For Each RowId As Long In CheckedRows.AsList
'				Log($"CHECKED rowid ${RowId}"$)
'				chk.Checked=False
'			Next
'			B4XTable1.Refresh
		End If
'		For Each RowId As Long In B4XTable1.VisibleRowIds
'			If CheckedRows.Contains(RowId) Then			
'				Dim row As Map = B4XTable1.GetRow(RowId)
'				Dim F_Check As CheckBox = row.Get("-")
'				F_Check.Checked = False
'				Log($"CHECKED rowid ${RowId}"$)
'			Else
'				Log($"NOT CHECKED rowid ${RowId}"$)
'				F_Check.Checked = True
'			End If
'		Next
		SelectedRows.Clear
		If(CheckedRows.Size>0) Then
			CheckedRows.Clear
		End If
		B4XTable1.Refresh
'		For i = 0 To B4XTable1.VisibleRowIds.Size -1
'			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
'			Dim p As B4XView = SelectedColumn.CellsLayouts.Get(i + 1)
'			Dim chkx As B4XView = p.GetView(1) 'first view is the label
'			If (RowId>0) Then
'				chkx.Visible = True
'				chkx.Tag = RowId
'				chkx.Color=Colors.Cyan
'				chkx.Checked = CheckedRows.Contains(RowId+1)
'				chkx.Visible=False
'			Else
'				chkx.Visible = False
'			End If
'		Next		
		Log ("Fine cancellazione")
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button4_Click ' Sblocca Documento
	Try
		SbloccaDoc(B4XTable1,RowID_Riga)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button5_Click ' Blocca Documento
	Try
		BloccaDoc(B4XTable1,RowID_Riga)		
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub InsertRowData(ListaPar As Map)
	Try
		SelectedRows.Clear
		Dim TipoDoc As String
		Dim NumDoc As Int
		Dim DataDoc As Long
		Dim CodCli As String
		Dim RagSoc As String
		Dim Trasmesso As Int
		Dim Esercizio As Int
		TipoDoc = ListaPar.Get("TipoDoc")
		NumDoc = ListaPar.Get("NumDoc")
		DataDoc = ListaPar.Get("DataDoc")
		CodCli = ListaPar.Get("CodCli")
		RagSoc = ListaPar.Get("RagSoc")
		Trasmesso = ListaPar.Get("Trasmesso")
		Esercizio = ListaPar.Get("Esercizio")
	   	Dim tbl As B4XTable = B4XTable1
	   	tbl.sql1.ExecNonQuery2("INSERT INTO data VALUES(?,?,?,?,?,?,?,?)", Array As Object("",TipoDoc,NumDoc,DataDoc,CodCli,RagSoc,Trasmesso,Esercizio))
	   	Dim page As Int = tbl.CurrentPage
	   	tbl.ClearDataView 'Updates the rows count.
	  	tbl.CurrentPage = page
	   	Dim column As B4XTableColumn = tbl.GetColumn("N")
	   	column.InternalSortMode= "DESC"
	   	tbl.UpdateTableCounters
	Catch
		Log(LastException)
	End Try
End Sub
