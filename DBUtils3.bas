B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.01
@EndOfDesignText@
'DBUtils
' Version 2.06
Sub Process_Globals
	Type tRec_EANCODE (Codart As String, Lotto As String, Qta As Double)
	Public DB_REAL, DB_INTEGER, DB_BLOB, DB_TEXT As String
	DB_REAL = "REAL"
	DB_INTEGER = "INTEGER"
	DB_BLOB = "BLOB"
	DB_TEXT = "TEXT"
	Private HtmlCSS As String = $"
		table {width: 100%;border: 1px solid #cef;text-align: left; }
		th { font-weight: bold;	background-color: #acf;	border-bottom: 1px solid #cef; }
		td,th {	padding: 4px 5px; }
		.odd {background-color: #def; } 
		.odd td {border-bottom: 1px solid #cef; }
		a { text-decoration:none; color: #000;}"$
End Sub

#if B4J
'Returns the path to a folder where you can create a database, preferably on the secondary storage.
Public Sub GetDBFolder (AppName As String) As String
	Return File.DirData(AppName)
End Sub

'Copies a database file that was added in the Files tab. The database must be copied to a writable location.
'This method copies the database to the storage card. If the storage card is not available the file is copied to the internal folder.
'The target folder is returned.
'If the database file already exists then no copying is done.
Public Sub CopyDBFromAssets (FileName As String, AppName As String) As String
	Dim TargetDir As String = GetDBFolder(AppName)
	If File.Exists(TargetDir, FileName) = False Then
		File.Copy(File.DirAssets, FileName, TargetDir, FileName)
	End If
	Return TargetDir
End Sub

#Else
'Returns the path to a folder where you can create a database, preferably on the secondary storage.
Public Sub GetDBFolder As String
#If B4A
	Dim rp As RuntimePermissions
	If File.ExternalWritable Then Return rp.GetSafeDirDefaultExternal("") Else Return File.DirInternal
#Else If B4i
	Return File.DirDocuments
#End If
End Sub

'Copies a database file that was added in the Files tab. The database must be copied to a writable location.
'This method copies the database to the storage card. If the storage card is not available the file is copied to the internal folder.
'The target folder is returned.
'If the database file already exists then no copying is done.
Public Sub CopyDBFromAssets (FileName As String) As String
	Dim TargetDir As String = GetDBFolder
	If File.Exists(TargetDir, FileName) = False Then
		File.Copy(File.DirAssets, FileName, TargetDir, FileName)
	End If
	Return TargetDir
End Sub

#End If

Private Sub EscapeField(f As String) As String
	Return "[" & f & "]"
End Sub

#If B4i
'Creates a new table with the given name.
'FieldsAndTypes - A map with the fields names as keys and the types as values.
'You can use the DB_... constants for the types.
'PrimaryKey - The column that will be the primary key. Pass empty string if not needed.
Public Sub CreateTable(SQL As SQL, TableName As String, Fields As List, Types As List, PrimaryKey As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For i = 0 To Fields.Size - 1
		If i > 0 Then sb.Append(", ")
		sb.Append("[").Append(Fields.Get(i)).Append("] ").Append(Types.Get(i))
		If Fields.Get(i) = PrimaryKey Then sb.Append(" PRIMARY KEY")
	Next
	sb.Append(")")
	Dim query As String
	query = "CREATE TABLE IF NOT EXISTS [" & TableName & "] " & sb.ToString
	Log("CreateTable: " & query)
	SQL.ExecNonQuery(query)
End Sub
#Else
'Creates a new table with the given name.
'FieldsAndTypes - A map with the fields names as keys and the types as values.
'You can use the DB_... constants for the types.
'PrimaryKey - The column that will be the primary key. Pass empty string if not needed.
Public Sub CreateTable(SQL As SQL, TableName As String, FieldsAndTypes As Map, PrimaryKey As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For i = 0 To FieldsAndTypes.Size - 1
		Dim field, ftype As String
		field = FieldsAndTypes.GetKeyAt(i)
		ftype = FieldsAndTypes.GetValueAt(i)
		If i > 0 Then sb.Append(", ")
		sb.Append(EscapeField(field)).Append(" ").Append(ftype)
		If field = PrimaryKey Then sb.Append(" PRIMARY KEY")
	Next
	sb.Append(")")
	Dim query As String = "CREATE TABLE IF NOT EXISTS " & EscapeField(TableName) & " " & sb.ToString
	Log("CreateTable: " & query)
	SQL.ExecNonQuery(query)
End Sub
#End If

'Deletes the given table.
Public Sub DropTable(SQL As SQL, TableName As String)
	Dim query As String = "DROP TABLE IF EXISTS" & EscapeField(TableName)
	Log("DropTable: " & query)
	SQL.ExecNonQuery(query)
End Sub

'Inserts the data to the table.
'ListOfMaps - A list with maps as items. Each map represents a record where the map keys are the columns names
'and the maps values are the values.
'Note that you should create a new map for each record (this can be done by calling Dim to redim the map).
Public Sub InsertMaps(SQL As SQL, TableName As String, ListOfMaps As List)
	Dim sb, columns, values As StringBuilder
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return
	End If
	SQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			sb.Initialize
			columns.Initialize
			values.Initialize
			Dim listOfValues As List
			listOfValues.Initialize
			sb.Append("INSERT INTO [" & TableName & "] (")
			Dim m As Map = ListOfMaps.Get(i1)
			For Each col As String In m.Keys
				Dim value As Object = m.Get(col)
				If listOfValues.Size > 0 Then
					columns.Append(", ")
					values.Append(", ")
				End If
				columns.Append(EscapeField(col))
				values.Append("?")
				listOfValues.Add(value)
			Next
			sb.Append(columns.ToString).Append(") VALUES (").Append(values.ToString).Append(")")
			If i1 = 0 Then Log("InsertMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
			SQL.ExecNonQuery2(sb.ToString, listOfValues)
		Next
		SQL.TransactionSuccessful
	Catch
		Log(LastException)
		#If B4i OR B4J
		SQL.Rollback
		#End If
	End Try
#If B4A
	SQL.EndTransaction
#End If
End Sub

Sub Decodifica_CodiceEAN (SQL As SQL, vEAN As String) As tRec_EANCODE   ' la definizione la trovi nelle process globals
	Try
		Dim Results As tRec_EANCODE
		Dim i As Int
		Dim vStringa As String = vEAN
		Dim vStringaOld As String = ""
		Dim vStr As String
		Dim vf_Stop As Int = 0
		Dim vTag As String
		Dim vCodice As String
		Dim vNumCifre As Int
		Dim vLung As Int
		Dim vVariabile As Int
		Dim vTipo As String
		Dim vArticolo As String
		Dim vArt As String
		Dim vVarianti As String
		Dim vPartita As String = ""
		Dim vPeso As Double = 0
		Dim vM As Int
		Dim vN As Int
		Dim vBarcode As String
		Dim Cursor As Cursor
		vArticolo = vStringa.Trim	
		If ((vStringa.Length) > 13)  And (vStringa.IndexOf("$")=-1) Then
			Do While((vStringa.Length>0) And (vf_Stop=0))
				i = 2
				Do While (i<=4)				
					vTag = vStringa.SubString2(1,i).Trim										
					Cursor = SQL.ExecQuery2("SELECT CODICE,ifnull(NUMCIFRE,0) AS NUMCIFRE,LUNG,VARIABILE,TIPO FROM IS_TABCODIFICAEAN WHERE CODICE LIKE ?",Array As String(vTag)) 
					For i = 0 To Cursor.RowCount - 1
						Cursor.Position = i
						vCodice = Cursor.GetString("CODICE")
						vNumCifre = Cursor.GetInt("NUMCIFRE")
						vLung = Cursor.GetInt("LUNG")
						vVariabile = Cursor.GetInt("VARIABILE")
						vTipo = Cursor.GetString("TIPO")					
					Next
					Cursor.Close
					If vNumCifre <> 0 Then
							' 01 e 02 come sinomnimo articolo
							If (vCodice="01") Or (vCodice="02") Then
								vArticolo = vStringa.SubString2(vNumCifre+1,vLung)
							End If
							' 10 = Partita
							If (vCodice="10") Then
								vPartita = vStringa.SubString2(vNumCifre+1,vLung)
							End If
							' 310 = Peso 005462
							If (vCodice="310") Then
								vStr = vStringa.SubString2(vNumCifre+1,vLung)						
								vStr = vStr.SubString2(1,3)+vStr.SubString2(4,3)
							End If	
							vM = vNumCifre + vLung + 1
							vN = vStringa.Length-vNumCifre-vLung
							If (vN>1) Then
								vStringa = vStringa.SubString2(vM,vN)							
							End If
							If (vVariabile=1) Then
								vf_Stop =1
							End If
							i = 4
					End If
					i=i+1
				Loop
				If(vStringa=vStringaOld) Then
					vf_Stop=1
				Else
					vStringaOld = vStringa
				End If
			Loop
			Dim Cursor As Cursor
			Cursor = SQL.ExecQuery2("SELECT ARTICOLO,VARIANTI FROM RELAZIONICFV WHERE RIFERIMENTO = ? AND CODCLIFOR='C'",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("ARTICOLO")
				vVarianti = Cursor.GetString("VARIANTI")			
			Next
			Cursor.Close
			If (vArt.Trim="") Then
				Cursor = SQL.ExecQuery2("SELECT CODICE FROM IS_ANAGRAFICAARTICOLI WHERE CODICE = ?",Array As String (vArticolo))
				For i = 0 To Cursor.RowCount - 1
					vArt = Cursor.GetString("CODICE")
				Next
				Cursor.Close
			End If
			' --------- fine an 128 ------------
		End If
		If (vStringa.Length=13) And (vStringa.SubString2(1,1)="2") Then ' EAN a Peso
			Dim vPeso As Double
			vArticolo = vStringa.SubString2(2,6)
			vStr = vStringa.SubString2(8,2) & "." & vStringa.SubString2(10,3)
			vPeso = vStr
			Cursor = SQL.ExecQuery2("SELECT ARTICOLO,VARIANTI FROM RELAZIONICFV WHERE RIFERIMENTO = ? AND CODCLIFOR='C'",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("ARTICOLO")
				vVarianti = Cursor.GetString("VARIANTI")
			Next
			Cursor.Close
			If (vVarianti<>"") Then
				vArt = vArt + "#" + vVarianti
			End If
			Cursor = SQL.ExecQuery2("SELECT CODICE FROM IS_ANAGRAFICAARTICOLI WHERE CODICE = ?",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				vArt = Cursor.GetString("CODICE")
			Next
			Cursor.Close						
		End If		
		' -------------------------------------------------------------------------------------
		If (vStringa.Length=13) And (vStringa.SubString2(1,1)<>"2") Then ' EAN non a Peso		
			vArticolo = vStringa.Trim
			Cursor = SQL.ExecQuery2("SELECT ARTICOLO,VARIANTI FROM RELAZIONICFV WHERE RIFERIMENTO = ? AND CODCLIFOR='C'",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("ARTICOLO")
				vVarianti = Cursor.GetString("VARIANTI")
			Next
			Cursor.Close
			If (vVarianti<>"") Then
				vArt = vArt + "#" + vVarianti
			End If
			Cursor = SQL.ExecQuery2("SELECT CODICE FROM IS_ANAGRAFICAARTICOLI WHERE CODICE = ?",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				vArt = Cursor.GetString("CODICE")
			Next
			Cursor.Close
		End If
		' -----------------------------------------------------> EAN 8
		If (vStringa.Length=8) Then
			vArticolo = vStringa.Trim
			Cursor = SQL.ExecQuery2("SELECT ARTICOLO,VARIANTI FROM RELAZIONICFV WHERE RIFERIMENTO = ? AND CODCLIFOR='C'",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("ARTICOLO")
				vVarianti = Cursor.GetString("VARIANTI")
			Next
			Cursor.Close
			If (vVarianti<>"") Then
				vArt = vArt + "#" + vVarianti
			End If
			Cursor = SQL.ExecQuery2("SELECT CODICE FROM IS_ANAGRAFICAARTICOLI WHERE CODICE = ?",Array As String (vArticolo))
			For i = 0 To Cursor.RowCount - 1
				vArt = Cursor.GetString("CODICE")
			Next
			Cursor.Close
		End If
		' -----------------------------------------------------> Codici con $
		Dim vPosD As Int = vStringa.IndexOf("$")
		If (vPosD<>-1) Then
			vArticolo = vStringa.Trim			
			Dim vStringaD As String = "00" + vStringa.SubString2(1,5)
			Dim vEsercizio As Int = ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
			Cursor = SQL.ExecQuery2("SELECT CODICEART FROM ANAGRAFICARTICOLICOMM WHERE BARCODE = ? AND ESERCIZIO = ?",Array As String (vStringaD,vEsercizio))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("CODICEART")
			Next
			Cursor.Close			
			vPartita = vStringa.SubString2(vPosD+1,8) & vStringa.SubString2(1,5)
		End If
		' -----------------------------------------------------> Codici con NB
		Dim vPosL As Int = vStringa.IndexOf("NB")
		If (vPosL<>-1) And (vPosD=-1) Then						
			vArticolo = vStringa.Trim
			Dim vStringaL As String = "00" + vStringa.SubString2(1,5)
			Dim vEsercizio As Int = ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
			Cursor = SQL.ExecQuery2("SELECT CODICEART FROM ANAGRAFICARTICOLICOMM WHERE BARCODE = ? AND ESERCIZIO = ?",Array As String (vStringaL,vEsercizio))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vArt = Cursor.GetString("CODICEART")
			Next
			Cursor.Close			
			Cursor = SQL.ExecQuery2("SELECT BARCODE FROM ANAGRAFICARTICOLICOMM WHERE CODICEART = ? AND ESERCIZIO = ?",Array As String (vArt,vEsercizio))
			For i = 0 To Cursor.RowCount - 1
				Cursor.Position = i
				vBarcode = Cursor.GetString("BARCODE")
			Next
			Cursor.Close
			vBarcode = vBarcode.SubString(vBarcode.Length-5)				
			vPartita = vStringa.SubString2(3,8) 
		End If		
		Results.Initialize	
		Results.Codart = vArt
		Results.Lotto = vPartita
		Results.Qta = vPeso
		Return Results
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

'Executes the query and returns the result as a list of arrays.
'Each item in the list is a strings array.
'StringArgs - Values to replace question marks in the query. Pass Null if not needed.
'Limit - Limits the results. Pass 0 for all results.
Public Sub ExecuteMemoryTable(SQL As SQL, Query As String, StringArgs() As String, Limit As Int) As List
	Dim cur As ResultSet
	If StringArgs = Null Then
		Dim StringArgs(0) As String
	End If
	cur = SQL.ExecQuery2(Query, StringArgs)
	Log("ExecuteMemoryTable: " & Query)
	Dim table As List
	table.Initialize
	Do While cur.NextRow
		Dim values(cur.ColumnCount) As String
		For col = 0 To cur.ColumnCount - 1
			Log("Col " & col & " " & cur.GetString2(col))
			values(col) = cur.GetString2(col)
		Next
		table.Add(values)
		' Log ("Valore: " & values)
		If Limit > 0 And table.Size >= Limit Then Exit
	Loop
	cur.Close
	Return table
End Sub

'Executes the query and returns a Map with the column names as the keys 
'and the first record values As the entries values.
'The keys are lower cased.
'Returns an uninitialized map if there are no results.
Public Sub ExecuteMap(SQL As SQL, Query As String, StringArgs() As String) As Map
	Dim res As Map
	Dim cur As ResultSet
	If StringArgs <> Null Then
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log("ExecuteMap: " & Query)
	If cur.NextRow = False Then
		Log("No records found.")
		Return res
	End If
	res.Initialize
	For i = 0 To cur.ColumnCount - 1
		res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
	Next
	cur.Close
	Return res
End Sub

#if B4A
'Executes the query and fills the Spinner with the values in the first column
'Sub ExecuteSpinner(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, Spinner1 As Spinner)
'	Spinner1.Clear
'	Dim Table As List
'	Table = ExecuteMemoryTable(SQL, Query, StringArgs, Limit)	   
'	Dim Cols() As String
'	For i = 0 To Table.Size - 1
'		Cols = Table.Get(i)
'		Spinner1.Add(Cols(0))
'	Next
'End Sub

'Executes the query and fills the ListView with the value.
'If TwoLines is true then the first column is mapped to the first line and the second column is mapped
'to the second line.
'In both cases the value set to the row is the array with all the records values.
Public Sub ExecuteListView(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, ListView1 As ListView, _
	TwoLines As Boolean)
	ListView1.Clear
	Dim Table As List
	Table = ExecuteMemoryTable(SQL, Query, StringArgs, Limit)
	Dim Cols() As String
	For i = 0 To Table.Size - 1
		Cols = Table.Get(i)
		If TwoLines Then
			ListView1.AddTwoLines2(Cols(0), Cols(1), Cols)
		Else
			ListView1.AddSingleLine2(Cols(0), Cols)
		End If
	Next
End Sub

#Else If B4J
Public Sub ExecuteTableView(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, _
	TableView1 As TableView)
	TableView1.Items.Clear
	Dim cur As ResultSet
	If StringArgs = Null Then
		Dim StringArgs(0) As String
	End If
	cur = SQL.ExecQuery2(Query, StringArgs)
	Dim cols As List
	cols.Initialize
	For i = 0 To cur.ColumnCount - 1
		cols.Add(cur.GetColumnName(i))
	Next
	TableView1.SetColumns(cols)
	Do While cur.NextRow
		Dim values(cur.ColumnCount) As String
		For col = 0 To cur.ColumnCount - 1
			values(col) = cur.GetString2(col)
		Next
		TableView1.Items.Add(values)
		If Limit > 0 And TableView1.Items.Size >= Limit Then Exit
	Loop
	cur.Close
End Sub
#End If

'Executes the query and fills the given list with the values in the first column.
Public Sub ExecuteList2(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, List As List)
	List.Clear
	List.AddAll(ExecuteList(SQL, Query, StringArgs, Limit))
End Sub
'Executes the query and returns a list with the values in the first column.
Public Sub ExecuteList(SQL As SQL, Query As String, StringArgs() As String, Limit As Int) As List
	Dim Table As List = ExecuteMemoryTable(SQL, Query, StringArgs, Limit)
	Dim res As List
	res.Initialize
	For Each Cols() As String In Table
		res.Add(Cols(0))
	Next
	Return res
End Sub

'Executes the given query and creates a Map that you can pass to JSONGenerator and generate JSON text.
'DBTypes - Lists the type of each column in the result set.
'Usage example: (don't forget to add a reference to the JSON library)
'	Dim gen As JSONGenerator
'	gen.Initialize(DBUtils.ExecuteJSON(SQL, "SELECT Id, Birthday FROM Students", Null, _
'		0, Array As String(DBUtils.DB_TEXT, DBUtils.DB_INTEGER)))
'	Dim JSONString As String
'	JSONString = gen.ToPrettyString(4)
'	Msgbox(JSONString, "")
Public Sub ExecuteJSON (SQL As SQL, Query As String, StringArgs() As String, Limit As Int, DBTypes As List) As Map
	Dim table As List
	Dim cur As ResultSet
	If StringArgs <> Null Then
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log("ExecuteJSON: " & Query)
	Dim table As List
	table.Initialize
	Do While cur.NextRow
		Dim m As Map
		m.Initialize
		For i = 0 To cur.ColumnCount - 1
			Select DBTypes.Get(i)
				Case DB_TEXT
					m.Put(cur.GetColumnName(i), cur.GetString2(i))
				Case DB_INTEGER
					m.Put(cur.GetColumnName(i), cur.GetLong2(i))
				Case DB_REAL
					m.Put(cur.GetColumnName(i), cur.GetDouble2(i))
				Case Else
					Log("Invalid type: " & DBTypes.Get(i))
			End Select
		Next
		table.Add(m)
		If Limit > 0 And table.Size >= Limit Then Exit
	Loop
	cur.Close
	Dim root As Map
	root.Initialize
	root.Put("root", table)
	Return root
End Sub

'Creates a html text that displays the data in a table.
'The style of the table can be changed by modifying HtmlCSS variable.
Public Sub ExecuteHtml(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, Clickable As Boolean) As String
	Dim cur As ResultSet
	If StringArgs <> Null Then
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log("ExecuteHtml: " & Query)
																														 
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<html><body>").Append(CRLF)
	sb.Append("<style type='text/css'>").Append(HtmlCSS).Append("</style>").Append(CRLF)
	sb.Append("<table><thead><tr>").Append(CRLF)
	For i = 0 To cur.ColumnCount - 1
		sb.Append("<th>").Append(cur.GetColumnName(i)).Append("</th>")
	Next
	sb.Append("</thead>")
	
	'	For i = 0 To cur.ColumnCount - 1
	'		If i = 1 Then
	'			sb.Append("<th style='width:200px;'>").Append(cur.GetColumnName(i)).Append("</th>")
	'		Else
	'			sb.Append("<th>").Append(cur.GetColumnName(i)).Append("</th>")
	'		End If
	'	Next
		
	sb.Append("</tr>").Append(CRLF)
	Dim row As Int
	Do While cur.NextRow
		If row Mod 2 = 0 Then
			sb.Append("<tr>")
		Else
			sb.Append("<tr class='odd'>")
		End If
		For i = 0 To cur.ColumnCount - 1
			sb.Append("<td>")
			If Clickable Then
				sb.Append("<a href='http://").Append(i).Append(".")
				sb.Append(row)
				sb.Append(".stub'>").Append(cur.GetString2(i)).Append("</a>")
			Else
				sb.Append(cur.GetString2(i))
			End If
			sb.Append("</td>")
		Next
		sb.Append("</tr>").Append(CRLF)
		row = row + 1
	Loop
	cur.Close
	sb.Append("</table></body></html>")
	Return sb.ToString
End Sub

'Gets the current version of the database. If the DBVersion table does not exist it is created and the current
'version is set to version 1.
Public Sub GetDBVersion (SQL As SQL) As Int
	Dim version As Int
	If TableExists(SQL, "DBVersion") Then
		version = SQL.ExecQuerySingleResult("SELECT version FROM DBVersion")
	Else
		'Create the versions table.
		#if B4i
			CreateTable(SQL, "DBVersion", Array("version"), Array(DB_INTEGER), "version")		
		#Else
		Dim m As Map = CreateMap("version": DB_INTEGER)
		CreateTable(SQL, "DBVersion", m, "version")
		#End If
		SQL.ExecNonQuery("INSERT INTO DBVersion VALUES (1)")
		version = 1
	End If
	Return version
End Sub



'Sets the database version to the given version number.
Public Sub SetDBVersion (SQL As SQL, Version As Int)
	SQL.ExecNonQuery2("UPDATE DBVersion set version = ?", Array As Object(Version))
End Sub

' updates a single field in a record
' Field is the column name
Public Sub UpdateRecord(SQL As SQL, TableName As String, Field As String, NewValue As Object, _
		WhereFieldEquals As Map)
	UpdateRecord2(SQL, TableName, CreateMap(Field: NewValue), WhereFieldEquals)
End Sub

' updates multiple fields in a record
' in the Fields map the keys are the column names
Public Sub UpdateRecord2(SQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map)
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return
	End If
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ")
	Dim args As List
	args.Initialize
	For Each col As String In Fields.Keys
		sb.Append(EscapeField(col)).Append("=?")
		sb.Append(",")
		args.Add(Fields.Get(col))
	Next
	sb.Remove(sb.Length - 1, sb.Length)
	sb.Append(" WHERE ")
	For Each col As String In WhereFieldEquals.Keys
		sb.Append(EscapeField(col)).Append(" = ?")
		sb.Append(" AND ")
		args.Add(WhereFieldEquals.Get(col))
	Next
	sb.Remove(sb.Length - " AND ".Length, sb.Length)
	Log("UpdateRecord: " & sb.ToString)
	SQL.ExecNonQuery2(sb.ToString, args)
End Sub


' deletes a record
Public Sub DeleteRecord(SQL As SQL, TableName As String, WhereFieldEquals As Map)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("DELETE FROM " & EscapeField(TableName) & " WHERE ")
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	Dim args As List
	args.Initialize
	For Each col As String In WhereFieldEquals.Keys
		If args.Size > 0 Then sb.Append(" AND ")
		sb.Append(EscapeField(col)).Append(" = ?")
		args.Add(WhereFieldEquals.Get(col))
	Next
	Log("DeleteRecord: " & sb.ToString)
	SQL.ExecNonQuery2(sb.ToString, args)
End Sub

'Tests whether the given table exists
Public Sub TableExists(SQL As SQL, TableName As String) As Boolean
	Dim count As Int = SQL.ExecQuerySingleResult2("SELECT count(name) FROM sqlite_master WHERE type='table' AND name=? COLLATE NOCASE", Array As String(TableName))
	Return count > 0
End Sub

#if java
	
#End If