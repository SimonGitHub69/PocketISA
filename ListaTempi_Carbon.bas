B4A=true
Group=Default Group\Carbon
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
	Public xui As XUI
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private EditText1 As EditText
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private Panel1 As Panel
	Private CodArt As String
	Private CodArtSer As String
	Private CodArtSer2 As String
	Private CodDip As String
	Private Col1Column As B4XTableColumn
	Private Col2Column As B4XTableColumn
	Private Col3Column As B4XTableColumn
	Private Col4Column As B4XTableColumn
	Private Col5Column As B4XTableColumn
	Private Col6Column As B4XTableColumn
	Private SelectedRows As B4XSet
	Private MultiSelection As Boolean = False
	Private SelectionColor As Int = 0xFF009DFF
	Public vTipoTab As Int ' Tipo tabella (1 = CliFor, 2 = Listino )
	Public vOperazione As String
	Private B4XTable1 As B4XTable
	Private btnDate As SwiftButton
	Public vDataDocNew As String
	Private SwiftButton6 As SwiftButton
	Private SwiftButton7 As SwiftButton
	Private SwiftButton8 As SwiftButton
	Private SwiftButton9 As SwiftButton
	Private Label8 As Label
	Private DataList As List
	Private sqlstr As String
	Private SwiftButton3 As SwiftButton
	Private SwiftButton4 As SwiftButton
	Private SwiftButton10 As SwiftButton
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Sleep(0)
	ListaDoc.vTrasmesso=0
	'Do not forget to load the layout file created with the visual designer. For example:
	If(Main.Ditta="Carbon") Then
		If FirstTime Then
			ExtraUtility.CopyDBIfNeeded(Main.DBName)
			SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
		End If
		ListaRilevazTempi(True)
	End If
	If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	Else
		MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
	End If
	DateTime.DateFormat = "dd-MM-yyyy"
	Activity.RemoveAllViews
	Activity.LoadLayout("ListaTempi_Carbon")
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	EditText1.RequestFocus
	vTipoTab = 0
	Dim gradient As GradientDrawable
	Dim clrs(2) As Int
	clrs(0) = 0xFFD5D5D5
	clrs(1) = 0xFFB0ACAC
	gradient.Initialize("BL_TR",clrs)
	gradient.CornerRadius = 5dip
	Label5.Background=gradient
	'SwiftButton6.xLBL.SetColorAndBorder(0xFF9C27B0, 0dip, 0x00FFFFFF, 100dip)
	'gradient.Initialize("SwiftButton6",clrs)
	'gradient.CornerRadius = 50dip
	'SwiftButton6.SetColors(clrs(0),clrs(1))
	'SwiftButton6.CornersRadius = 50dip
			
End Sub

Sub Activity_Resume
	
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub ListaRilevazTempi(FirstTime As Boolean)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.MaximumRowsPerPage = 6
		B4XTable1.RowHeight=30dip
		B4XTable1.HeadersHeight=30dip
		Col1Column = B4XTable1.AddColumn("Pos", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col1Column.Width=-1
		Col2Column = B4XTable1.AddColumn("Dip.", B4XTable1.COLUMN_TYPE_TEXT)
		Col2Column.Width=10%x
		Col3Column = B4XTable1.AddColumn("Causale", B4XTable1.COLUMN_TYPE_TEXT)
		Col3Column.Width=16%x  		' 	CAUSALE
		Col4Column = B4XTable1.AddColumn("Articolo", B4XTable1.COLUMN_TYPE_TEXT)
		Col4Column.Width=35%x
		Col5Column = B4XTable1.AddColumn("Data Ora", B4XTable1.COLUMN_TYPE_TEXT)
		Col5Column.Width=28%x ' 38%x 		'	DATA		
		Col6Column = B4XTable1.AddColumn("Rep.", B4XTable1.COLUMN_TYPE_TEXT)
		Col6Column.Width=20%x 		'	DATA
		SelectedRows = B4XCollections.CreateSet
		If(FirstTime) Then
			DataList.Initialize
			B4XTable1.SetData(DataList)
			B4XTable1.Refresh
		End If
	Catch
		Log(LastException)
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

Sub Button4_Click
	Activity.Finish
End Sub

Sub AnotherDatePicker1_DateChanged (NewDate As Long)
	EditText1.Text = ExtraUtility.DateToFormat(NewDate,"yyyy","it","")
End Sub

Sub EditText1_TextChanged (Old As String, New As String)
	
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	
End Sub

Sub EditText1_EnterPressed
	Try
		Select Case Main.Ditta
			Case "Carbon"
				Dim Prefix As String = EditText1.Text.SubString2(0,4)
				Select Case Prefix
					Case "DIP-"
						CodDip = EditText1.Text.substring(4)
						Dim NomeDip As String = SQLDataAccess.ExecQuerySingleResult("SELECT NOME FROM GS_OPERATORI WHERE CODICE ='" & CodDip & "'")						
						Label4.Text = NomeDip

					Case Else
						Dim Pos As Int
						Pos = EditText1.Text.IndexOf("|")
						If (Pos=-1) Then
							Pos = EditText1.Text.IndexOf("$")
						End If				
						If(Pos=-1) Then
							Pos =  EditText1.Text.IndexOf("/")
							If(Pos>0) Then
								Pos = EditText1.Text.Length
							End If
						End If
						If (Pos>0) And (CodDip<>"") Then
							CodArtSer = EditText1.Text.SubString2(0,Pos)
							Pos = CodArtSer.IndexOf("/")
							If(Pos>0) Then
								CodArt = CodArtSer.SubString2(0,Pos)
								CodArtSer2 = CodArtSer.SubString2(Pos,Pos+6)
								Dim DescArt As String = SQLDataAccess.ExecQuerySingleResult("SELECT DESCRIZIONE FROM GS_ARTICOLI WHERE CODICE ='" & CodArt & "'")
								Label7.Text = DescArt
								Label8.Text = CodArt & CodArtSer2
								B4XTable1.ClearDataView
								DataList.Clear
								sqlstr = "SELECT POS,CODICEDIP,CAUSALE,CODART,DATAORA,CODICEREP FROM GS_LISTATEMPI WHERE CODART=?"						
								Dim rs As ResultSet = SQLDataAccess.ExecQuery2(sqlstr,Array As String(Label8.Text))
								If(rs.RowCount>0) Then
									Do While rs.NextRow
										Dim rowx(6) As Object
										rowx(0) = rs.GetInt("POS")
										rowx(1) = rs.GetString("CODICEDIP")
										rowx(2) = rs.GetString("CAUSALE")
										rowx(3) = rs.getstring("CODART")
										rowx(4) = rs.GetString("DATAORA") 
										rowx(5) = rs.GetString("CODICEREP")
										' Log( rs.getstring("TipoDoc") & "-" & rs.getstring("Numerodoc") & "-" &  rs.getint("Esercizio"))
										DataList.Add(rowx)
									Loop
									rs.Close									
								End If		
								B4XTable1.SetData(DataList)
								B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
								B4XTable1.Refresh
							End If
						Else
							If(CodDip="") Then
								ExtraUtility.Play_Sound("Error.wav")
								MsgboxAsync("INSERIRE PRIMA L'OPERATORE!","ERRORE")
							End If
						End If
						
				End Select
				EditText1.Text = ""
				EditText1.RequestFocus
				
		End Select
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button1_Click
	vTipoTab = 1
	StartActivity(ListaTab)
End Sub

Sub Button2_Click
	vTipoTab = 2
	StartActivity(ListaTab)
End Sub

Sub btnDate_Click
	Try
		DateTime.DateFormat = "dd-MM-yyyy"
		Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
			vDataDocNew = btnDate.xLBL.Text
			'Dim DataDoc As Long
			'DataDoc = DateTime.DateParse(vDataDocNew)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraDettaglioTempi(Pos As Int,Causale As String, CodArticolo As String, CodDipendente As String, CodReparto As String, DataOra As String, AcceptDuplicate As Boolean)
	Try
		sqlstr  = "INSERT INTO GS_LISTATEMPI (POS,CAUSALE,CODART,DATAORA,CODICEDIP,CODICEREP) VALUES " _
		& "(" & Pos & ",'" & Causale & "','" & CodArticolo & "','" & DataOra & "','"  & CodDipendente & "','" & CodReparto & "')"
		' Log(sqlstr)
		SQLDataAccess.ExecNonQuery(sqlstr)
		
	Catch
		Log(LastException)
	End Try
End Sub

Sub SwiftButton1_Click ' bottone di conferma finale
	Try
		If(Main.Ditta="Carbon") Then
			Dim rowdata As Map
			If(Label8.Text<>"") Then
				SQLDataAccess.ExecNonQuery2("DELETE FROM GS_LISTATEMPI WHERE CODART=?",Array As String (Label8.Text))
			End If			
			If(B4XTable1.Size>0) Then			
				For i=1 To B4XTable1.Size
					rowdata = B4XTable1.GetRow(i)
					If rowdata.Size>0 Then
						' RowData.GetValueAt(1)
						DateTime.DateFormat = "dd-MM-yyyy HH:MM:SS"
						RegistraDettaglioTempi(rowdata.Get("Pos"),rowdata.Get("Causale"),rowdata.Get("Articolo"),rowdata.Get("Dip."),rowdata.Get("Rep."),rowdata.Get("Data Ora"),False)
					End If
				Next
			End If
			DataList.Clear
			B4XTable1.SetData(DataList)
			B4XTable1.Refresh
			Label4.Text=""
			Label8.Text=""
			Label7.Text=""
			CodArt=""
			CodDip=""
			ToastMessageShow("OPERAZIONE SALVATAGGIO CONCLUSA!",False)
		End If
	Catch
		MsgboxAsync("Errore: " & LastException.Message,"ERRORE IS_TESTEDOCUMENTI") 'no changes will be made
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish
		' CallSubDelayed(ListaDoc, "ListaDocChkNew")
		Return True
	Else
		Return False
	End If
End Sub

Sub SwiftButton2_Click
	Select Case Main.Ditta
		Case "Carbon"
			If(CodDip="") Then
				ExtraUtility.Play_Sound("Error.wav")
				MsgboxAsync("INSERIRE PRIMA L'OPERATORE!","ERRORE")
			Else
				If(B4XTable1.Size>0) Then
					Dim CausaleOld As String				
					CausaleOld = B4XTable1.sql1.ExecQuerySingleResult($"SELECT c2 FROM data ORDER BY c0 DESC LIMIT 1"$)
					If(CausaleOld="Sospesa") Then
						SwiftButton3.Enabled=False
						SwiftButton4.Enabled=True
						SwiftButton9.Enabled=False
						SwiftButton4.xLBL.Text="RIPRENDI"
					End If
					If(CausaleOld="Inizio") Then
						SwiftButton3.Enabled=False
						SwiftButton4.Enabled=True
						SwiftButton9.Enabled=True
						SwiftButton4.xLBL.Text="SOSPENDI"
					End If
					If(CausaleOld="Ripresa") Then
						SwiftButton3.Enabled=False
						SwiftButton4.Enabled=True
						SwiftButton9.Enabled=True
						SwiftButton4.xlbl.Text="SOSPENDI"					
					End If
					If(CausaleOld="Fine") Then
						SwiftButton3.Enabled=False					
						SwiftButton4.Enabled=False					
						SwiftButton9.Enabled=False					
						SwiftButton4.xlbl.Text="SOSPENDI"
					End If
				Else
					SwiftButton3.Enabled=True
					SwiftButton4.Enabled=False
					SwiftButton9.Enabled=False
				End If			
				Panel1.Visible=True
			End If
		Case Else
			vTipoTab = 1
			StartActivity(ListaTab)
	End Select
End Sub

Sub SwiftButton5_Click	
	StartActivity("Signature")
End Sub

Private Sub B4XTable1_DataUpdated
	Try
		SetColumnAlignment(B4XTable1,"Pos",Gravity.CENTER)
		SetColumnAlignment(B4XTable1,"Dip.",Gravity.CENTER)
		SetColumnAlignment(B4XTable1,"Causale",Gravity.CENTER)
		SetColumnAlignment(B4XTable1,"Articolo",Gravity.LEFT)
		SetColumnAlignment(B4XTable1,"Data Ora",Gravity.CENTER)
		SetColumnAlignment(B4XTable1,"Rep.",Gravity.CENTER)
		For i = 0 To B4XTable1.VisibleRowIds.Size - 1
			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
			SetRowColor(i, SelectedRows.Contains(RowId))
			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
			For j = 0 To B4XTable1.Columns.size - 1
				Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
				ExtraUtility.SetSingleLine(i+1, column,True,"END")
			Next
		Next
		For i = 0 To Col1Column.CellsLayouts.Size - 1
			' Posizione
			Dim pnl As B4XView = Col1Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Black
			lbl.TextSize = 12
			lbl.Gravity=Gravity.RIGHT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' Dipendente
			Dim pnl As B4XView = Col2Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Black
			lbl.TextSize = 12
			lbl.Gravity=Gravity.RIGHT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' Cusale
			Dim pnl As B4XView = Col3Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Blue
			lbl.TextSize = 12
			lbl.Gravity=Gravity.LEFT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' Articolo
			Dim pnl As B4XView = Col4Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.DarkGray
			lbl.TextSize = 11
			lbl.Gravity=Gravity.LEFT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' Data e Ora
			Dim pnl As B4XView = Col5Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Black
			lbl.TextSize = 12
			lbl.Gravity=Gravity.LEFT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
	Catch
		Log(LastException)
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
		Log(LastException)
	End Try
End Sub

Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Try
		If(MultiSelection=False) Then
			SelectedRows.Clear
			B4XTable1.Refresh
		End If
		' Log($"Number of rows selected: ${SelectedRows.Size}"$)
		If SelectedRows.Contains(RowId) Then
			SelectedRows.Remove(RowId)
		Else
			SelectedRows.Add(RowId)
		End If
		'Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Log($"Row selected: ${RowId}"$)
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub DrawButton(btn As SwiftButton, Color1 As Int, Color2 As Int)
	Dim dr As GradientDrawable
	dr.Initialize("TOP_BOTTOM", Array As Int(Color1, Color2))
	dr.CornerRadius = 10dip
End Sub

Private Sub SwiftButton6_Click
	Dim lbl3_Top As Int = Label3.Top
	Label3.Top=lbl3_Top+3dip
	Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)
	Sleep(50)
	Label3.Top=lbl3_Top
	Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)	
End Sub

Private Sub SwiftButton6_ButtonDown
	Dim lbl3_Top As Int = Label3.Top
	Label3.Top = lbl3_Top+3dip
	Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)	
End Sub

Private Sub SwiftButton6_ButtonUp
	Dim lbl3_Top As Int = Label3.Top
	Label3.Top = lbl3_Top-3dip
	Label3.SetLayoutAnimated(1000,Label3.Left,Label3.Top,Label3.Width,Label3.Height)	
End Sub

Private Sub SwiftButton7_Click
	Dim lbl6_Top As Int = Label6.Top
	Label6.Top=lbl6_Top+3dip
	Label6.SetLayoutAnimated(1000,Label6.Left,Label6.Top,Label6.Width,Label6.Height)
	Sleep(50)
	Label6.Top=lbl6_Top
	Label6.SetLayoutAnimated(1000,Label6.Left,Label6.Top,Label6.Width,Label6.Height)
End Sub

Private Sub SwiftButton7_ButtonDown
	Dim lbl6_Top As Int = Label6.Top
	Label6.Top = lbl6_Top+3dip
	Label6.SetLayoutAnimated(1000,Label6.Left,Label6.Top,Label6.Width,Label6.Height)
End Sub

Private Sub SwiftButton7_ButtonUp
	Dim lbl6_Top As Int = Label6.Top
	Label6.Top = lbl6_Top-3dip
	Label6.SetLayoutAnimated(1000,Label6.Left,Label6.Top,Label6.Width,Label6.Height)
End Sub

Private Sub SwiftButton8_Click
	If(SelectedRows.Size>0) Then
		Dim RowId As Int = SelectedRows.AsList.get(0)
		Dim sf As Object = xui.Msgbox2Async("Elimino la registrazione selezionata?", "CANCELLAZIONE", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			wait for (DeleteRow(B4XTable1, RowId)) complete (Success As Boolean)
			If (Success) Then
				SelectedRows.Clear
			End If
		End If
	End If
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long)  As ResumableSub
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		' Dim RowData As Map = tbl.GetRow(RowId)
		Dim sql As String = ""
		sql = "DELETE FROM " & Main.PrefixSQL & "_LISTATEMPI" '  WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
		Log(sql)
		'SQLDataAccess.BeginTransaction
		'SQLDataAccess.ExecNonQuery(sql)
		'SQLDataAccess.TransactionSuccessful
		'SQLDataAccess.EndTransaction
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

Sub InserisciRigaDettaglio(Causale As String, CodArticolo As String, CodDipendente As String, DataOra As String, CodReparto As String, AcceptDuplicate As Boolean)
	Dim maxPos As Int
	If(B4XTable1.mCurrentCount=0) Then
		maxPos = 0
	Else
		maxPos = B4XTable1.sql1.ExecQuerySingleResult("SELECT max(c0) FROM data")
	End If	
	Dim nrecs As Int=0
	If(AcceptDuplicate=False) And (maxPos>0) Then
		nrecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT COUNT(*) FROM data WHERE c3=?"$,Array As String(CodArticolo))
	End If
	maxPos = maxPos + 1
	B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?)"$ , Array As Object(maxPos,CodDipendente,Causale,CodArticolo,DataOra,CodReparto))
	B4XTable1.ClearDataView
	B4XTable1.Refresh
	B4XTable1.UpdateTableCounters
	Dim column1 As B4XTableColumn = B4XTable1.GetColumn("Pos")
	column1.InternalSortMode="DESC"
	B4XTable1.SearchField.mBase.Visible=False
End Sub

Sub SwiftButton3_Click
	Select Case Main.Ditta
		Case "Carbon"
			' INIZIO COMMESSA
			Dim Causale As String = "Inizio"
			DateTime.DateFormat="yyyy-MM-dd HH:mm:ss"
			Dim MyDate As String=DateTime.Date(DateTime.Now)
			Dim CodArticolo As String = CodArt & CodArtSer2
			Dim CodReparto As String = "L100"
			InserisciRigaDettaglio(Causale,CodArticolo,CodDip,MyDate,CodReparto,False)
			Panel1.Visible=False
		Case Else
			vTipoTab = 2
			StartActivity(ListaTab)
	End Select
End Sub

Sub SwiftButton4_Click
	' SOSPENDI/RIPRENDI COMMESSA
	If(SwiftButton4.xLBL.Text="SOSPENDI") Then
		Dim Causale As String = "Sospesa"
	Else
		Dim Causale As String = "Ripresa"
	End If
	DateTime.DateFormat="yyyy-MM-dd HH:mm:ss"
	Dim MyDate As String=DateTime.Date(DateTime.Now)
	Dim CodArticolo As String = CodArt & CodArtSer2
	Dim CodReparto As String = "L100"
	If(B4XTable1.Size>0) Then
		InserisciRigaDettaglio(Causale,CodArticolo,CodDip,MyDate,CodReparto,False)
	End If
	Panel1.Visible=False
End Sub

Private Sub SwiftButton9_Click
	' FINE COMMESSA
	'Dim DataList As List
	'DataList.Initialize
	Dim Causale As String = "Fine"
	DateTime.DateFormat="yyyy-MM-dd HH:mm:ss"
	Dim MyDate As String=DateTime.Date(DateTime.Now)
	Dim CodArticolo As String = CodArt & CodArtSer2
	Dim CodReparto As String = "L100"
	InserisciRigaDettaglio(Causale,CodArticolo,CodDip,MyDate,CodReparto,False)
	Panel1.Visible=False
End Sub

Private Sub SwiftButton10_Click
	Panel1.Visible=False
End Sub