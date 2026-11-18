B4A=true
Group=Default Group\Gefin
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
	Private CodDip As String
	Private Col1Column As B4XTableColumn
	Private Col2Column As B4XTableColumn
	Private Col3Column As B4XTableColumn
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
	Private Label8 As Label
	Private Label9 As Label
	Private SwiftButton3 As SwiftButton
	Private SwiftButton4 As SwiftButton
	Private SwiftButton5 As SwiftButton
	Private SwiftButton9 As SwiftButton
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Sleep(0)
	ListaDoc.vTrasmesso=0
	'Do not forget to load the layout file created with the visual designer. For example:
	If(Main.Ditta="Gefin") Then
		If FirstTime Then
			ExtraUtility.CopyDBIfNeeded(Main.DBName)
			SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
			ListaRilevazTempi(True)
		End If
	End If
	If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	Else
		MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
	End If
	DateTime.DateFormat = "dd-MM-yyyy"
	Activity.RemoveAllViews
	Activity.LoadLayout("ListaTempi_Gefin")
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	Select Case Main.Ditta
		Case "Gefin"
			ListaRilevazTempi(False)
			EditText1.RequestFocus
	End Select
	vTipoTab = 0
			
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
		If(FirstTime=False) Then
			Col1Column = B4XTable1.AddColumn("Causale", B4XTable1.COLUMN_TYPE_TEXT)
			Col1Column.Width=20%x  		' 	CAUSALE
			Col2Column = B4XTable1.AddColumn("Partita", B4XTable1.COLUMN_TYPE_TEXT)
			Col2Column.Width=36%x
			Col3Column = B4XTable1.AddColumn("Data Ora", B4XTable1.COLUMN_TYPE_TEXT)
			Col3Column.Width=41%x 		'	DATA
			'B4XTable1.AddColumn("Ora", B4XTable1.COLUMN_TYPE_TEXT).Width=15%x		' 	ORA
			SelectedRows = B4XCollections.CreateSet
			Dim DataList As List
			DataList.Initialize
'			DateTime.DateFormat="yyyy-MM-dd HH:mm:ss"
'			' Dim DataInizio As String=DateTime.Date(DateTime.Now-300)
'			Dim DataFine As String=DateTime.Date(DateTime.Now)
'			Dim rowx(3) As Object
'			rowx(0) = "Inizio"
'			rowx(1) = "Partita1"
'			rowx(2) = "2021-12-20 08:30:18"
'			DataList.Add(rowx)
'			Sleep(0)
'			Dim rowx(3) As Object
'			rowx(0) = "Fine"
'			rowx(1) = "Partita1"
'			rowx(2) = DataFine
'			DataList.Add(rowx)
'			DrawButton(SwiftButton6,Colors.Green,Colors.Red)
			wait for(B4XTable1.SetData(DataList)) Complete (Unused As Boolean)
			B4XTable1.UpdateTableCounters
			B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
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
			Case "Gefin"
				Dim Prefix As String = EditText1.Text.SubString2(0,4)
				Select Case Prefix
					Case "DIP-"
						CodDip = EditText1.Text.substring(4)
						Dim NomeDip As String = SQLDataAccess.ExecQuerySingleResult("SELECT NOME FROM GS_OPERATORI WHERE CODICE ='" & CodDip & "'")
						Label4.Text = NomeDip
						
					Case Else
						Dim Pos As Int = EditText1.Text.IndexOf("|")
						If (Pos>0) And (CodDip<>"") Then
							CodArtSer = EditText1.Text.SubString2(0,Pos)
							Pos = CodArtSer.IndexOf("/")
							If(Pos>0) Then
								CodArt = CodArtSer.SubString2(0,Pos)
								Dim DescArt As String = SQLDataAccess.ExecQuerySingleResult("SELECT DESCRIZIONE FROM GS_ARTICOLI WHERE CODICE ='" & CodArt & "'")
								Label7.Text = DescArt
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

Sub SwiftButton1_Click ' bottone di conferma finale
	Try
		If(Main.Ditta="Gefin") Then
			Activity.Finish
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
		Case "Gefin"
			Panel1.Visible=True
		Case Else
			vTipoTab = 1
			StartActivity(ListaTab)
	End Select
End Sub

Sub SwiftButton3_Click
	Select Case Main.Ditta
		Case "Gefin"
			Panel1.Visible=False
		Case Else
			vTipoTab = 2
			StartActivity(ListaTab)
	End Select
End Sub

Sub SwiftButton4_Click
	Panel1.Visible=False
End Sub

Sub SwiftButton5_Click	
	' StartActivity("Signature")
	Dim qMap As Map
	Dim MyList As List
	qMap.Initialize
	MyList.Initialize
	For i=1 To 10000		
		MyList.Add(i)
	Next
	qMap.Put("idkey",MyList)
		
	Dim t1 As Long =DateTime.now
	For i = 0 To MyList.Size - 1
		'Dim qMap As Map
		qMap = MyList.get(i)
		Dim str As String
		str = qMap.get("idkey")
	Next
	Dim t2 As Long =DateTime.now
	Log(t2-t1)
	Log("----")
   
	Dim t1 As Long =DateTime.now
	For i = 0 To MyList.Size - 1
		Dim qMap As Map = MyList.get(i)
		Dim str As String = qMap.get("idkey")
	Next
	Dim t2 As Long =DateTime.now
	Log(t2-t1)
	Log("----")
      
	Dim t1 As Long =DateTime.now
	For Each qMap As Map In MyList
		Dim str As String
		str = qMap.get("idkey")
	Next
	Dim t2 As Long =DateTime.now
	Log(t2-t1)
End Sub

Private Sub B4XTable1_DataUpdated
	Try
		SetColumnAlignment(B4XTable1,"Causale",Gravity.CENTER)
		SetColumnAlignment(B4XTable1,"Articolo",Gravity.LEFT)
		SetColumnAlignment(B4XTable1,"Data Ora",Gravity.CENTER)
		For i = 0 To B4XTable1.VisibleRowIds.Size - 1
			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
			SetRowColor(i, SelectedRows.Contains(RowId))
			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
			For j = 0 To B4XTable1.Columns.size - 1
				Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
				ExtraUtility.SetSingleLine(i+1, column,True,"END")
			Next
		Next
		For i = 1 To Col1Column.CellsLayouts.Size - 1
			Dim pnl As B4XView = Col1Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Black
			lbl.TextSize = 14
			lbl.Gravity=Gravity.LEFT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			Dim pnl As B4XView = Col2Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.Blue
			lbl.TextSize = 14
			lbl.Gravity=Gravity.LEFT
			lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			Dim pnl As B4XView = Col3Column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.TextColor = Colors.DarkGray
			lbl.TextSize = 14
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

Private Sub SwiftButton9_Click
	Dim lbl8_Top As Int = Label8.Top
	Label8.Top=lbl8_Top+3dip
	Label8.SetLayoutAnimated(1000,Label8.Left,Label8.Top,Label8.Width,Label8.Height)
	Sleep(50)
	Label8.Top=lbl8_Top
	Label8.SetLayoutAnimated(1000,Label8.Left,Label8.Top,Label8.Width,Label8.Height)
End Sub

Private Sub SwiftButton9_ButtonDown
	Dim lbl8_Top As Int = Label8.Top
	Label8.Top = lbl8_Top+3dip
	Label8.SetLayoutAnimated(1000,Label8.Left,Label8.Top,Label8.Width,Label8.Height)
End Sub

Private Sub SwiftButton9_ButtonUp
	Dim lbl8_Top As Int = Label8.Top
	Label8.Top = lbl8_Top-3dip
	Label8.SetLayoutAnimated(1000,Label8.Left,Label8.Top,Label8.Width,Label8.Height)
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