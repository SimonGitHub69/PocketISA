B4A=true
Group=Default Group\Carbon
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
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
	Private Phone As IME
	Private DataList As List
	Private DateTemplate As B4XDateTemplate
	Private btnDate As SwiftButton
	Private B4XTable1 As B4XTable
	Private SwiftButton5 As SwiftButton
	Private SwiftButton8 As SwiftButton
	Private SwiftButton1 As SwiftButton
	Private Col1Column As B4XTableColumn
	Private Col2Column As B4XTableColumn
	Private Col3Column As B4XTableColumn
	Private Col4Column As B4XTableColumn
	Private Col5Column As B4XTableColumn
	Private SelectedRows As B4XSet
	Private Base As B4XView
	Private lbl_autoclave As Label
	Private Label1 As Label
	Private EditText1 As EditText
	Private Panel1 As Panel
	Private Label2 As Label
	Private EditText2 As EditText
	Private SwiftButton2 As SwiftButton
	Private SwiftButton10 As SwiftButton
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Private Label4 As Label
	Private EditText4 As EditText
	Private Label3 As Label
	Private Label5 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	lbl_autoclave.Initialize("")
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		If File.Exists(ExtraUtility.DirExt, Main.DBName) = True Then
			SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
		Else
			MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!","ERRORE PATH")
		End If
	End If
	Sleep(0)
	ListaEventiAutoclavi(True)
	DateTime.DateFormat = "dd-MM-yyyy"
	Activity.RemoveAllViews
	Activity.LoadLayout("Autoclave_Reg")
	lbl_autoclave.Text ="Autoclave: " & Starter.Parametro2
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	Label1.Text = "Press. (bar)"
	Label2.Text ="Temp. (C°)"
	EditText1.Text = ""
	EditText2.Text = ""
	EditText4.Text = ""
	Label5.Text = ""
	Leggi_Dettaglio_Eventi(Starter.Parametro2)	
End Sub

Sub Activity_Resume
	
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub SwiftButton1_Click	
	Registra_EventiToSQL
	ToastMessageShow("Operazione salvataggio conclusa!",False)
	Activity.Finish
	Sleep(0)
End Sub

Sub Leggi_Dettaglio_Eventi(CodiceAutoclave As String)
	Try
		' 0) DB pronto?
		Sleep(0)
		If SQLDataAccess.IsInitialized = False Then
			Log("[ERR] SQLDataAccess non inizializzato")
			Return
		End If

		' 1) UI pronta?
		If B4XTable1.IsInitialized = False Then
			Log("[ERR] B4XTable1 non inizializzato (chiama Activity.LoadLayout prima)")
			Return
		End If

		' 2) Setup tabella UNA SOLA VOLTA
		If B4XTable1.Columns.Size = 0 Then
			B4XTable1.AddColumn("Pos", B4XTable1.COLUMN_TYPE_NUMBERS)
			B4XTable1.AddColumn("Data", B4XTable1.COLUMN_TYPE_TEXT)
			B4XTable1.AddColumn("Press.", B4XTable1.COLUMN_TYPE_NUMBERS)
			B4XTable1.AddColumn("Temp.", B4XTable1.COLUMN_TYPE_NUMBERS)
			B4XTable1.AddColumn("Dip.", B4XTable1.COLUMN_TYPE_NUMBERS)
		End If

		' 3) Opzioni tabella (niente mBase se non serve!)
		B4XTable1.MaximumRowsPerPage = 12
		B4XTable1.RowHeight = 30dip
		B4XTable1.SearchVisible = False
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.ClearDataView

		' 4) Dati

		DataList.Initialize
		Dim c As Cursor = SQLDataAccess.ExecQuery2( _
            "SELECT POS, DATAORA, PRESS, TEMP, CODDIP FROM GS_AUTOCLAVE_EVENT WHERE CODAUTOCLAVE = ?", _
            Array As String(CodiceAutoclave))

		For i = 0 To c.RowCount - 1
			c.Position = i
			Dim r() As Object = Array As Object( _
                c.GetInt("POS"), _
                c.GetString("DATAORA"), _
                c.GetString("PRESS"), _
				c.GetString("TEMP"), _
				c.GetInt("CODDIP")) 
			DataList.Add(r)
		Next
		c.Close

		' 5) Bind dati
		B4XTable1.SetData(DataList)
		B4XTable1.UpdateTableCounters

	Catch
		Log("[EX] " & LastException)
		' fallback: evita crash in UI
		Dim vuota As List : vuota.Initialize
		B4XTable1.SetData(vuota)
		B4XTable1.UpdateTableCounters
	End Try
End Sub

Sub Leggi_IdTesta (CodiceAutoclave As String, ntubo As Int) As Int
	Try
		Dim IdTesta As Int
		Dim Cursor3 As Cursor
		Cursor3 = SQLDataAccess.ExecQuery2("SELECT ID FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND PROCESSO = 1 AND IFNULL(DATAORA_FINE,'')=''", Array As String(CodiceAutoclave,ntubo))
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			IdTesta = Cursor3.GetInt("ID")
		Else
			IdTesta = 0
		End If
		Cursor3.Close
		Return IdTesta
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub ListaEventiAutoclavi(FirstTime As Boolean)
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.MaximumRowsPerPage = 11
		B4XTable1.RowHeight=30dip
		B4XTable1.HeadersHeight=25dip
		B4XTable1.HeaderTextColor = Colors.Gray
		Col1Column = B4XTable1.AddColumn("Ctr.", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col1Column.Width=10%x
		Col2Column = B4XTable1.AddColumn("DataOra", B4XTable1.COLUMN_TYPE_TEXT)
		Col2Column.Width=42%x
		Col3Column = B4XTable1.AddColumn("P. bar", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col3Column.Width=15%x
		Col4Column = B4XTable1.AddColumn("T. C°", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col4Column.Width=15%x
		Col5Column = B4XTable1.AddColumn("Dip.", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col5Column.Width=15%x
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

Private Sub SwiftButton5_Click
	Try
		EditText4.Text = ""
		EditText1.Text = ""
		EditText2.Text = ""
		Panel1.Visible = True
		Label5.Text = ""
		Phone.ShowKeyboard(EditText1)
		EditText4.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton10_Click
	Try
		Dim Press As Double
		Dim Temp As Int
		If(EditText1.Text<>"") Then
			Press = EditText1.Text
		Else
			Press = 0
		End If
		If(EditText2.Text<>"") Then
			Temp = EditText2.Text
		Else
			Temp = 0
		End If
		If (Label5.Text<>"") And (Press>0) And (Temp>0) Then
			If ExtraUtility.Vaiid_EditText_Int(EditText1,False,1,6,"bar") Then
				If ExtraUtility.Vaiid_EditText_Int(EditText2,False,20,160,"C°") Then
					Registra_Riga_Evento(EditText1.Text, EditText2.Text, Starter.CodDipRegVal)
					Panel1.Visible = False
					Phone.HideKeyboard
				End If
			End If
		Else
			If(Label5.Text.Trim="") Then
				ExtraUtility.Play_Sound("error.wav")
				ToastMessageShow("INSERIRE OPERATORE CORRETTAMENTE!",True)
			Else				
				If(Press=0) Then
					ExtraUtility.Play_Sound("error.wav")
					ToastMessageShow("INSERIRE PRESSIONE CORRETTAMENTE!",True)
				Else
					If(Temp=0) Then
						ExtraUtility.Play_Sound("error.wav")
						ToastMessageShow("INSERIRE TEMPERATURA CORRETTAMENTE!",True)
					End If
				End If
			End If
			EditText4.RequestFocus
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton2_Click
	Panel1.Visible = False
	Phone.HideKeyboard
End Sub

Sub Registra_Riga_Evento(Press As Double, Temp As Double, CodDip As Int)
	Dim maxPos As Int
	Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
	If(B4XTable1.mCurrentCount=0) Then
		maxPos = 0
	Else
		maxPos = B4XTable1.sql1.ExecQuerySingleResult("SELECT max(c0) FROM data")
	End If
	Dim nrecs As Int = 0
	If(nrecs=0) Then
		maxPos = maxPos + 1		
		Dim tbl As B4XTable = B4XTable1
		tbl.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?)"$, Array As Object (maxPos, DataOra, Press, Temp, CodDip))
		B4XTable1.ClearDataView
		B4XTable1.Refresh
		B4XTable1.UpdateTableCounters
		Dim column1 As B4XTableColumn = B4XTable1.GetColumn("Ctr.")
		column1.InternalSortMode="DESC"
		B4XTable1.SearchField.mBase.Visible=False		
	End If
	
End Sub

Sub Registra_EventiToSQL
	Try
		Dim DataToSave As List
		DataToSave.Initialize
		Log("Size: " & B4XTable1.Size)
		For i = 1 To B4XTable1.Size 
			Dim r As Map 
			r = B4XTable1.GetRow(i)
			Dim RowCopy As Map
			RowCopy.Initialize
			For Each k As String In r.Keys
				Log ("Col: " & k )
				RowCopy.Put(k, r.Get(k))
			Next
			DataToSave.Add(RowCopy)
		Next
		SQLDataAccess.BeginTransaction		
		' Se vuoi riscrivere tutta la tabella:
		SQLDataAccess.ExecNonQuery2("DELETE FROM GS_AUTOCLAVE_EVENT WHERE CODAUTOCLAVE = ?",Array As String(Starter.Parametro2))
		Dim Val1 As Object 
		Dim Val2 As Object
		Dim Val3 As Object
		Dim Val4 As Object
		Dim Val5 As Object
		Dim cmd As String = "INSERT INTO GS_AUTOCLAVE_EVENT(CODAUTOCLAVE, POS, DATAORA, PRESS, TEMP, CODDIP, UUID_CICLO) VALUES (?, ?, ?, ?, ?, ?, ?)"
		For Each r As Map In DataToSave
			Val1 = r.Get("Ctr.")
			Val2 = r.Get("DataOra")
			Val3 = r.Get("P. bar")
			Val4 = r.Get("T. C°")
			Val5 = r.Get("Dip.")
			SQLDataAccess.ExecNonQuery2(cmd, Array As Object(Starter.Parametro2, Val1, Val2, Val3, Val4, Val5, Starter.UUID_Ciclo))
		Next
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		
	Catch
		Log(LastException)
	End Try
		
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Sleep(0)
	SelectedRows.Clear
	B4XTable1.Refresh
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
	'leggo il valore della prima colonna (Codice)
	Dim m As Map = B4XTable1.GetRow(RowId)
	Starter.CodRicetta = m.Get("Codice")
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

Sub B4XTable1_DataUpdated
	Sleep(0)
	Dim RowId As Long
	Dim column As B4XTableColumn
	SetColumnAlignment(B4XTable1,"Ctr.",Gravity.CENTER)
	SetColumnAlignment(B4XTable1,"DataOra",Gravity.CENTER)
	SetColumnAlignment(B4XTable1,"P. bar",Gravity.CENTER)
	SetColumnAlignment(B4XTable1,"T. C°",Gravity.CENTER)
	SetColumnAlignment(B4XTable1,"Dip.",Gravity.CENTER)
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		RowId = B4XTable1.VisibleRowIds.Get(i)
		For j = 0 To B4XTable1.Columns.size - 1
			column = B4XTable1.Columns.Get(j)
			ExtraUtility.SetSingleLine(i+1, column,True,"END")
		Next
		SetRowColor(i, SelectedRows.Contains(RowId))
	Next
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
	Next
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
		Dim res As ResultSet
		Dim k As Int
		sql = "DELETE FROM GS_AUTOCLAVE_EVENT" '  WHERE Numerodoc = '" & vNumerodoc & "' And TipoDoc = '" & vTipoDoc & "' And Esercizio = '" & vEsercizio & "'"
		Log(sql)
		'SQLDataAccess.BeginTransaction
		'SQLDataAccess.ExecNonQuery(sql)
		'SQLDataAccess.TransactionSuccessful
		'SQLDataAccess.EndTransaction
		tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array (RowId))	 			' deletes record from Table
		' --------------------------------------------------------------
		' Rinumerazione delle righe in seguito alle righe cancellate
		' --------------------------------------------------------------
		res = B4XTable1.sql1.ExecQuery("SELECT rowid,c0 FROM data ORDER BY c0 ASC")
		k = 0
		Do While res.NextRow
			k = k + 1
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ? where rowid = ?", Array As Object(k,res.GetInt("rowid")))
		Loop
		B4XTable1.sql1.ExecNonQuery("UPDATE data SET rowid = c0")
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

Private Sub EditText1_FocusChanged (HasFocus As Boolean)
	If ExtraUtility.Vaiid_EditText_Int(EditText1,HasFocus,1,6,"bar") Then
		' OK
	Else
		EditText1.Text = ""
	End If
End Sub

Private Sub EditText2_FocusChanged (HasFocus As Boolean)
	If ExtraUtility.Vaiid_EditText_Int(EditText2,HasFocus,20,160,"C°") Then 
		' OK 
	Else
		EditText2.Text = ""
	End If
End Sub

Private Sub EditText4_EnterPressed
	Try
		Dim CodDip As String
		If(EditText4.Text.Length>4) Then
			Dim Prefix As String = EditText4.Text.SubString2(0,4).ToUpperCase
			If(Prefix="DIP-") Then
				CodDip = EditText4.Text.substring(4)
				Dim NomeDip As String = SQLDataAccess.ExecQuerySingleResult("SELECT NOME FROM GS_OPERATORI WHERE CODICE ='" & CodDip & "'")
				Label5.Text = NomeDip
			End If
			Starter.CodDipRegVal = CodDip
		End If
		EditText4.Text=""
		EditText4.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub EditText4_TextChanged (Old As String, New As String)
	Try
		Dim CodDip As String
		If(New.Length>4) Then
			Dim Prefix As String = New.SubString2(0,4).ToUpperCase
			If(Prefix="DIP-") Then
				CodDip = New.substring(4)
				Dim NomeDip As String = SQLDataAccess.ExecQuerySingleResult("SELECT NOME FROM GS_OPERATORI WHERE CODICE ='" & CodDip & "'")
				Label5.Text = NomeDip
			End If
			Starter.CodDipRegVal = CodDip
		End If
		EditText4.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub