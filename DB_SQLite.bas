B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Crea_NuovoDocumento(SQLData As SQL, TipoDoc As String) As List
	Try	
		Dim rs As ResultSet
		Dim sqlstr As String
		Dim ListNewDoc As List
		sqlstr = "SELECT IFNULL(MAX(numerodoc),0)+1 AS NUMDOC,strftime('%Y','now') AS ESERCIZIO,strftime('%d/%m/%Y','now') AS DATADOC FROM IS_TESTEDOCUMENTI WHERE TIPODOC = '" & TipoDoc & "'"		
		rs = SQLData.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then		
			ListNewDoc.Initialize
			Do While rs.NextRow
				ListNewDoc.Add(TipoDoc)
				ListNewDoc.Add(rs.GetInt("NUMDOC"))
				ListNewDoc.Add(rs.GetInt("ESERCIZIO"))
				ListNewDoc.Add(rs.GetString("DATADOC"))			
			Loop
		End If
		rs.Close
		Return(ListNewDoc)
	Catch
		Return(Null)
		Log(LastException)
	End Try
End Sub

Sub Leggi_UM_Articolo(SQLData As SQL, TipoClifor As String, CodArt As String) As String
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim UM As String
	sqlstr = "SELECT UMA,UMV,UM from IS_ANAGRAFICAARTICOLI WHERE CODICE ='" & CodArt & "'"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then
		UM = ""
	Else
		Do While rs.NextRow
			Select Case TipoClifor
				Case "C"
					UM = rs.GetString("UMV")
				Case "F"
					UM = rs.GetString("UMA")
				Case Else
					UM = rs.GetString("UM")
			End Select
		Loop		
	End If
	rs.Close
	Return(UM)
End Sub

Sub Leggi_PrezzoListinoArt(SQLData As SQL, NRListino As Int, CodArt As String) As Double	
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Prezzo As Double
	sqlstr = "SELECT LI.PREZZOEURO from IS_ANAGRAFICAARTICOLI AA JOIN IS_LISTINIARTICOLI LI ON LI.CODART=AA.CODICE " _
	& "WHERE CODICE ='" & CodArt & "' AND NRLISTINO = '" & NRListino & "'"	
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then		
		Prezzo = 0
	Else
		Do While rs.NextRow
			Prezzo = rs.GetDouble("PREZZOEURO")	
		Loop
		rs.Close		
	End If
	rs.Close
	Return(Prezzo)
End Sub

Sub Leggi_NRListinoAcquisto (SQLData As SQL) As String
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Listino As String
	sqlstr = "SELECT NRLISTINO,DESCRIZIONE FROM IS_TABLISTINI WHERE FLGCOSTISTD=1"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then
		Listino="0§*** LISTINO ERR *** (FLGCOSTISTD NON TROVATO)"
	Else
		Do While rs.NextRow
			Listino = rs.GetInt("NRLISTINO") & "§" & rs.GetString("DESCRIZIONE")
		Loop
		rs.Close
	End If
	rs.Close
	Return(Listino)
End Sub

Sub Leggi_AnagraficaCF (SQLData As SQL, CodConto As String, Field As String) As String
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Value As String
	sqlstr = "SELECT * FROM IS_ANAGRAFICACF WHERE CODCLIFOR='" & CodConto & "'"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then
		Value = "*** FORNITORE ERRATO ***"
	Else
		Do While rs.NextRow
			'Value = rs.GetString("DSCCONTO1") 
			Value = rs.GetString(Field)
		Loop
		rs.Close
	End If
	rs.Close
	Return(Value)
End Sub

Sub Leggi_NRListinoVendita (SQLData As SQL) As String
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Listino As String
	sqlstr = "SELECT CODLISTINO,DESCRIZIONE FROM IS_LISTINOART WHERE CODICE=1"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then
		Listino="0"
	Else
		Do While rs.NextRow
			Listino = rs.GetInt("CODLISTINO") & "§" & rs.GetString("DESCRIZIONE")
		Loop
		rs.Close
	End If
	rs.Close
	Return(Listino)
End Sub

Sub Leggi_NRListinoMinimo(SQLData As SQL) As Int	
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Listino As Int
	sqlstr = "SELECT NRLISTINO FROM IS_TABLISTINI WHERE PREZZOMINIMOVEND='1'"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then		
		Listino=0
	Else
		Do While rs.NextRow
			Listino = rs.GetInt("NRLISTINO")
		Loop
		rs.Close		
	End If
	rs.Close
	Return(Listino)
End Sub

Sub Leggi_NRListinoTesteDoc(SQLData As SQL, TipoDoc As String, NumeroDoc As Int, Esercizio As Int ) As Int	
	Dim rs As ResultSet
	Dim sqlstr As String
	Dim Listino As Int
	sqlstr = "SELECT NrListino FROM IS_TESTEDOCUMENTI WHERE TIPODOC ='" & TipoDoc & "' AND NUMERODOC ='" & NumeroDoc & "' AND ESERCIZIO = '" & Esercizio & "'"
	rs = SQLData.ExecQuery(sqlstr)
	If (rs.RowCount=0) Then		
		Listino=0
	Else
		Do While rs.NextRow
			Listino = rs.GetInt("NrListino")
		Loop
		rs.Close		
	End If
	rs.Close
	Return(Listino)
End Sub

Sub Create_Table_IS_PALMDEVICE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_PALMDEVICE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_PALMDEVICE] (" _
		 & "SERIALNUMBER VARCHAR(32)," _ 
		 & "DATASCAD DATETIME," _
		 & "UTENTEMODIFICA VARCHAR(80)," _
		 & "DATAMODIFICA DATETIME)")
	End If
End Sub

Sub Create_Table_IS_TESTEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_TESTEDOCUMENTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_TESTEDOCUMENTI] (" _
		& "IDKEY INTEGER PRIMARY KEY AUTOINCREMENT," _
		& "TipoDoc        [VARCHAR] (3)  Not Null," _
		& "Numerodoc      [DECIMAL] (10, 0) Not Null," _
		& "Bis			  [VARCHAR] (3)," _
		& "Esercizio      [DECIMAL] (5, 0)  Not Null," _
		& "CodClifor      [VARCHAR] (7)," _
		& "Datadoc        [DATETIME]," _
		& "DataRifDoc     [DATETIME]," _
		& "NumRifDoc	  [VARCHAR] (14)," _
		& "UtenteModifica [VARCHAR] (25)," _
		& "NrListino      [INT]," _
		& "Valuta         [INT]," _
		& "Trasmesso      [INT]," _
		& "Elaborato      [INT]," _
		& "flag_stp       [INT]," _
		& "flg_stp        [INT]," _
		& "rifidtesta     [DECIMAL] (10, 0))")
	End If
End Sub

Sub Create_Table_IS_SYNC_STATE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_SYNC_STATE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE IS_SYNC_STATE (" _
	    & "Table_Sync       [VARCHAR] (200)  Null," _
	    & "Sync_State      	[DECIMAL] (1, 0) Not Null)")
	End If
End Sub

Sub Create_Table_IS_RIGHEDOCUMENTI_Ligth(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE IS_RIGHEDOCUMENTI (" _
	    & "TipoDoc        [VARCHAR] (3)     Not Null," _
	    & "Numerodoc      [DECIMAL] (10, 0) Not Null," _
	    & "Esercizio      [DECIMAL] (5, 0)  Not Null," _
	    & "Idriga         [DECIMAL] (5, 0)  Not Null," _
	    & "UtenteModifica [VARCHAR] (25)," _
	    & "Codart         [VARCHAR] (50)," _
		& "Partita        [VARCHAR] (15)," _
	    & "Qta            [DECIMAL] (19, 4)," _
		& "PrzUnit        [DECIMAL] (19, 4)," _
		& "CodCliFor      [VARCHAR] (10)," _
		& "Note      	  [VARCHAR] (100))")
	End If
End Sub

Sub Create_Table_IS_RIGHEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE IS_RIGHEDOCUMENTI (" _
	    & "TipoDoc        [VARCHAR] (3)     Not Null," _
	    & "Numerodoc      [DECIMAL] (10, 0) Not Null," _
	    & "Esercizio      [DECIMAL] (5, 0)  Not Null," _
	    & "Idriga         [DECIMAL] (5, 0)  Not Null," _
	    & "UtenteModifica [VARCHAR] (25)," _
	    & "Codart         [VARCHAR] (50)," _
	    & "Qta            [DECIMAL] (19, 4)," _
	    & "UM             [VARCHAR] (3)," _
	    & "PrzUnit        [DECIMAL] (19, 6)," _
	    & "Sconto         [VARCHAR] (15)," _
	    & "Note           [VARCHAR] (128)," _
	    & "DataConsegna   [DATETIME]," _
	    & "Magazzino      [VARCHAR] (10)," _
	    & "MagazzinoColl  [VARCHAR] (10)," _
		& "rifidtesta     [DECIMAL] (10,0)," _
	    & "RifTipoDoc     [VARCHAR] (3)," _
	    & "RifNumerodoc   [DECIMAL] (10, 0)," _
	    & "RifEsercizio   [DECIMAL] (5, 0)," _
	    & "RifIdriga      [DECIMAL] (5, 0)," _
		& "NrRifPartita   [VARCHAR] (15)," _
	    & "VariaMisure    [VARCHAR] (50)," _
	    & "RifCliente     [VARCHAR] (10)," _
	    & "Descrizione    [VARCHAR] (250)," _
	    & "TipoRiga       [VARCHAR] (1)," _
	    & "UM2      	  [VARCHAR] (3)," _
	    & "Qta2     	  [DECIMAL] (19,4))")
	End If
End Sub

Sub Drop_table(SQLData As SQL, tablename As String) As Boolean
	If (CheckIfTableExist(SQLData, tablename)=False) Then		
		SQLData.ExecNonQuery("DROP TABLE [" & tablename & "]")
		Return(True)
	Else
		Return(False)
	End If
End Sub

Sub Alter_Table_IS_PALMDEVICE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_PALMDEVICE")=True) Then
		If (FieldExists(SQLData,"IS_PALMDEVICE","DATASCAD")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_PALMDEVICE] ADD DATASCAD DATETIME")
		End If
	End If
End Sub

Sub Alter_Table_Vista_GIACENZA(SQLData As SQL)
	Try
		If (CheckIfTableExist(SQLData,"VISTA_GIACENZA")=True) Then
			If (FieldExists(SQLData,"VISTA_GIACENZA","UM")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [VISTA_GIACENZA] ADD UM VARCHAR(3)")
			End If
			If (FieldExists(SQLData,"VISTA_GIACENZA","LOTTO")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [VISTA_GIACENZA] ADD LOTTO VARCHAR(15)")
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Alter_Table_IS_VISTADOCPALM(SQLData As SQL)
	Try
		If (CheckIfTableExist(SQLData,"IS_VISTADOCPALM")=True) Then
			If (FieldExists(SQLData,"IS_VISTADOCPALM","CORSIA")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_VISTADOCPALM] ADD CORSIA VARCHAR(5)")
			End If
			If (FieldExists(SQLData,"IS_VISTADOCPALM","UBICAZIONE")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_VISTADOCPALM] ADD UBICAZIONE VARCHAR(10)")
			End If
			If (FieldExists(SQLData,"IS_VISTADOCPALM","ORDINAMENTO")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_VISTADOCPALM] ADD ORDINAMENTO INT")
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Alter_Table_IS_IMPOSTAZIONICTRLINV(SQLData As SQL)
	Try
		If (CheckIfTableExist(SQLData,"IS_IMPOSTAZIONICTRLINV")=True) Then
			If (FieldExists(SQLData,"IS_IMPOSTAZIONICTRLINV","FLAG_UBICAZIONECORSIA")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_IMPOSTAZIONICTRLINV] ADD FLAG_UBICAZIONECORSIA VARCHAR(1)")
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Alter_Table_IS_RIGHEDOCUMENTI_Light(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI")=True) Then
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Descrizione")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Descrizione varchar(255)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Note")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Note varchar(100)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","TipoRiga")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD TipoRiga varchar(1)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Sconto")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Sconto varchar(15)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Barcode")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Barcode varchar(20)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","UM")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD UM varchar(3)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Canc")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Canc varchar(1)")
		End If
	End If
End Sub

Sub Alter_Table_IS_RIGHEDOCUMENTI_NESTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI")=True) Then
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QtaTotUMAConv")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QtaTotUMAConv decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QtaTotUM2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QtaTotUM2 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","CoeffConvUMA")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD CoeffConvUMA decimal(20,10)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Ubicazione")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Ubicazione varchar(10)")			
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","UbicazioneColl")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD UbicazioneColl varchar(10)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Priorita")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Priorita INT")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Flag_SvuotaCella")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Flag_SvuotaCella INT")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","TipoReadGiac")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD TipoReadGiac varchar(6)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Partita1")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Partita1 varchar(15)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Partita2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Partita2 varchar(15)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Partita3")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Partita3 varchar(15)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QP1")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QP1 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QP2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QP2 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QP3")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QP3 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Corsia")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Corsia varchar(5)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Ordinamento")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Ordinamento decimal(5,0)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","DataScadenza")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD DataScadenza datetime")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Peso")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Peso decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","NumEtichette")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD NumEtichette decimal(5,0)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Status")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Status varchar(1)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Ordinato")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Ordinato varchar(8)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","UM3")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD UM3 varchar(5)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QtaTotUMBase")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QtaTotUMBase decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","UMBase")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD UMBase varchar(5)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","CodCliFor")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD CodCliFor varchar(7)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Qta3")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Qta3 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","QtaTotUMBaseDisp")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD QtaTotUMBaseDisp decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","PrezzoUn")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD PrezzoUn decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","UMPrezzo")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD UMPrezzo varchar(5)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","TotaleRiga")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD TotaleRiga decimal(19,2)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","PesoReale")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD PesoReale decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","PesoReale2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD PesoReale2 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Qta1_UM2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Qta1_UM2 decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI","Qta2_UM2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI] ADD Qta2_UM2 decimal(19,4)")
		End If
	End If
End Sub

Sub Alter_Table_IS_TESTEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_TESTEDOCUMENTI")=True) Then
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","NumRifDoc")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD NumRifDoc varchar(15)")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","DataRifDoc")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD DataRifDoc datetime")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","NumDocOrig")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD NumDocOrig integer")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","DataDocOrig")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD DataDocOrig Datetime")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","TipoDocOrig")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD TipoDocOrig varchar(3)")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","NomeImpostazione")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD NomeImpostazione varchar(80)")
		End If		
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","TotNumRighe")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD TotNumRighe int")
		End If
		If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","Note")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD Note varchar(80)")
		End If
		If(Main.Ditta="Kuore") Then
			If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","CodiceUnico")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD CodiceUnico int")
			End If
			If (FieldExists(SQLData,"IS_TESTEDOCUMENTI","MezzoOrecchino")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [IS_TESTEDOCUMENTI] ADD MezzoOrecchino int")
			End If
		End If
	End If
End Sub

Sub Alter_Table_IS_RIGHEDOCUMENTI_GIRO(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI_GIRO")=True) Then
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI_GIRO","PesoReale")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI_GIRO] ADD PesoReale decimal(19,4)")
		End If
		If (FieldExists(SQLData,"IS_RIGHEDOCUMENTI_GIRO","PesoReale2")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_RIGHEDOCUMENTI_GIRO] ADD PesoReale2 decimal(19,4)")
		End If
	End If
End Sub

Sub Alter_Table_IS_VISTADOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_VISTADOCUMENTI")=True) Then
		If (FieldExists(SQLData,"IS_VISTADOCUMENTI","DESCRIZIONEAGG")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_VISTADOCUMENTI] ADD DESCRIZIONEAGG TEXT")
		End If
	End If
End Sub

Sub Alter_Table_IS_ANAGRAFICACF(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICACF")=True) Then
		If (FieldExists(SQLData,"IS_ANAGRAFICACF","TipoDoc")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICACF] ADD TipoDoc VARCHAR(3)")
		End If
	End If
End Sub

Sub Alter_Table_IS_ANAGRAFICAARTICOLI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICAARTICOLI")=True) Then
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","ESAURITO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD ESAURITO INT")
		End If
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","CORSIA")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD CORSIA TEXT")
		End If
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","UBICAZIONE")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD UBICAZIONE TEXT")
		End If
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","FLAG_BILANCIA")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD FLAG_BILANCIA TEXT")
		End If
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","ORDINAMENTO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD ORDINAMENTO DECINAL(10,0)")
		End If
	End If
End Sub

Sub Alter_Table_IS_ANAGRAFICAARTICOLI_KUORE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICAARTICOLI")=True) Then
		If (FieldExists(SQLData,"IS_ANAGRAFICAARTICOLI","FLAGCOPPIE")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICAARTICOLI] ADD FLAGCOPPIE INT")
		End If
	End If
End Sub

Sub Alter_Table_IS_ANAGRAFICADEPOSITI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICADEPOSITI")=True) Then
		If (FieldExists(SQLData,"IS_ANAGRAFICADEPOSITI","FLAG_UBICAZIONICORSIA")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICADEPOSITI] ADD FLAG_UBICAZIONICORSIA VARCHAR(1)")
		End If
		If (FieldExists(SQLData,"IS_ANAGRAFICADEPOSITI","TIPO_MAGAZZINO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IS_ANAGRAFICADEPOSITI] ADD TIPO_MAGAZZINO VARCHAR(1)")
		End If
	End If
End Sub

Sub Alter_Table_IS_IMPOSTAZIONI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IMPOSTAZIONI")=True) Then
		If (FieldExists(SQLData,"IMPOSTAZIONI","QTA_DEFAULT")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD QTA_DEFAULT INT")
		End If
		If (FieldExists(SQLData,"IMPOSTAZIONI","AltRiga")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD AltRiga TEXT")
		End If
		If (FieldExists(SQLData,"IMPOSTAZIONI","LargDescRiga")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD LargDescRiga INT")
		End If		
		If (FieldExists(SQLData,"IMPOSTAZIONI","Mode_SPP")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD Mode_SPP INT")
		End If
		If (FieldExists(SQLData,"IMPOSTAZIONI","Path_Images")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD Path_Images TEXT")
		End If
		If (FieldExists(SQLData,"IMPOSTAZIONI","Path_DB")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [IMPOSTAZIONI] ADD Path_DB TEXT")
		End If
	End If
End Sub

Sub Create_Table_IS_LISTINOART(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_LISTINOART")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_LISTINOART](CODICE INT, CODLISTINO INT, DESCRIZIONE TEXT)")
	End If
End Sub

Sub Create_Table_IS_LISTINIARTICOLI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_LISTINIARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_LISTINIARTICOLI](CODART VARCHAR(50), NRLISTINO INT, UM VARCHAR(3), PREZZO DECIMAL(19,6)," _
		& "PREZZOEURO DECIMAL(19,6), UTENTE VARCHAR(25))")
	End If
End Sub

Sub Create_Table_IS_VISTAPUNTIVENDITAPALMARE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_VISTAPUNTIVENDITAPALMARE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_VISTAPUNTIVENDITAPALMARE](PALMARE TEXT, CODDEPOSITO TEXT)")
	End If
End Sub

Sub Create_Table_IS_VISTADOCPALM(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_VISTADOCPALM")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_VISTADOCPALM] (" _
		 & "IDTESTA DECIMAL(10,0)," _ 
		 & "ESERCIZIO DECIMAL(10,0)," _
		 & "TIPODOC TEXT," _
		 & "NUMERODOC DECIMAL(10,0)," _
		 & "BIS TEXT," _
		 & "DATADOC DATETIME," _
		 & "DOCCHIUSO INT," _
		 & "BLOCCATO INT," _
		 & "CODCLIFOR TEXT," _
		 & "NUMRIFDOC TEXT," _
		 & "DATARIFDOC DATETIME," _
		 & "CODCFFATT TEXT," _
		 & "TIPOPAR TEXT," _
		 & "IDRIGA DECIMAL(16,0)," _
		 & "POSIZIONE DECIMAL(10,0)," _
		 & "TIPORIGA TEXT," _
		 & "RIGACHIUSA INT," _
		 & "RIGABLOCCATA INT," _
		 & "CODART TEXT," _
		 & "DESCRIZIONEART TEXT," _
		 & "DATACONSEGNA DATETIME," _
		 & "NUMLISTINO DECIMAL(10,0)," _
		 & "UMGEST TEXT," _
		 & "SCONTORIGA DECIMAL(15,5)," _
		 & "SCONTIESTESI TEXT," _
		 & "NRRIFPARTITA TEXT," _
		 & "PREZZOUNITNETTOEURO DECIMAL(19,6)," _
		 & "PREZZOUNITLORDOEURO DECIMAL(19,6)," _
		 & "QTAGEST DECIMAL(38,6)," _
		 & "QTAGESTRES DECIMAL(38,6)," _
		 & "QTAPREZZO DECIMAL(38,6)," _
		 & "QTAPREZZORES DECIMAL(38,6)," _
		 & "QTAGESTPRELEVATA DECIMAL(38,6)," _		 
		 & "DSCCONTO1 TEXT," _
		 & "UMV TEXT," _ 
		 & "UMP TEXT," _
		 & "UMA TEXT," _
		 & "UM2 TEXT," _
		 & "QTAEVASAP DECIMAL(38,6)," _			
		 & "NUMEROETICHETTE INT," _
		 & "FLAG_BILANCIA TEXT)")
	End If
End Sub

Sub Create_Table_VISTA_GIACENZA(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_GIACENZA")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_GIACENZA] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "CODDEPOSITO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10)," _
		 & "FLAG_UBICAZIONICORSIA VARCHAR(1)," _
		 & "NRIFPARTITA VARCHAR(15)," _
		 & "LOTTO VARCHAR(15)," _
		 & "UM1 VARCHAR(3)," _
		 & "UM2 VARCHAR(3)," _
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "GIACENZA1 DECIMAL(19,6)," _
		 & "GIACENZA2 DECIMAL(19,6)," _
		 & "GIACENZAPESO DECIMAL(19,6))")
	End If
End Sub

Sub Create_Table_IS_VISTA_NOTE_ORDINI(sqldata As SQL)
	If (CheckIfTableExist(sqldata,"IS_VISTA_NOTE_ORDINI")=False) Then
		sqldata.ExecNonQuery("CREATE TABLE [IS_VISTA_NOTE_ORDINI] (" _
		& "IDT_GIRO DECIMAL(10,0)," _
		& "IDTESTA DECIMAL(10,0)," _
		& "CODART VARCHAR(50)," _
		& "UMGEST VARCHAR(5)," _
		& "QTAGEST DECIMAL(19,6)," _
		& "ANNOTAZIONI VARCHAR(250)" _
		& ")")
	End If
End Sub

Sub Create_Table_IS_VISTA_CLIENTI_GIRO(sqldata As SQL)
	If (CheckIfTableExist(sqldata,"IS_VISTA_CLIENTI_GIRO")=False) Then
		sqldata.ExecNonQuery("CREATE TABLE [IS_VISTA_CLIENTI_GIRO] (" _
		& "CODCLIFOR VARCHAR(7)," _
		& "RAGSOC VARCHAR(100)," _
		& "IDT_GIRO DECIMAL(10,0)" _
		& ")")
	End If
End Sub

Sub Create_Table_VISTA_GIACENZA_CORSIA(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_GIACENZA_CORSIA")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_GIACENZA_CORSIA] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "CODDEPOSITO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10)," _
		 & "FLAG_UBICAZIONICORSIA VARCHAR(1)," _
		 & "NRIFPARTITA VARCHAR(15)," _
		 & "LOTTO VARCHAR(15)," _
		 & "UM1 VARCHAR(3)," _
		 & "UM2 VARCHAR(3)," _
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "GIACENZA1 DECIMAL(19,6)," _
		 & "GIACENZA2 DECIMAL(19,6)," _
		 & "GIACENZAPESO DECIMAL(19,6)," _
		 & "GIACENZAPESOTEORICO DECIMAL(19,6))")
	End If
End Sub

Sub Create_Table_VISTA_GIACENZA_ARTICOLO(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_GIACENZA_ARTICOLO")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_GIACENZA_ARTICOLO] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "CODDEPOSITO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10)," _
		 & "FLAG_UBICAZIONICORSIA VARCHAR(1)," _
		 & "NRIFPARTITA VARCHAR(15)," _
		 & "LOTTO VARCHAR(15)," _
		 & "UM1 VARCHAR(3)," _
		 & "UM2 VARCHAR(3)," _
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "GIACENZA1 DECIMAL(19,6)," _
		 & "GIACENZA2 DECIMAL(19,6)," _
		 & "GIACENZAPESO DECIMAL(19,6)," _
		 & "GIACENZAPESOTEORICO DECIMAL(19,6))")
	End If
End Sub

Sub Create_Table_VISTA_DISPONIBILITA_ARTICOLO(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_DISPONIBILITA_ARTICOLO")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_DISPONIBILITA_ARTICOLO] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "CODDEPOSITO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10)," _
		 & "FLAG_UBICAZIONICORSIA VARCHAR(1)," _
		 & "NRIFPARTITA VARCHAR(15)," _
		 & "LOTTO VARCHAR(15)," _
		 & "UM1 VARCHAR(3)," _
		 & "UM2 VARCHAR(3)," _
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "GIACENZA1 DECIMAL(19,6)," _
		 & "GIACENZA2 DECIMAL(19,6)," _
		 & "GIACENZAPESO DECIMAL(19,6)," _
		 & "GIACENZAPESOTEORICO DECIMAL(19,6))")
	End If
End Sub

Sub Create_Table_VISTA_DISPONIBILITA_CORSIA(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_DISPONIBILITA_CORSIA")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_DISPONIBILITA_CORSIA] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "CODDEPOSITO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10)," _
		 & "FLAG_UBICAZIONICORSIA VARCHAR(1)," _
		 & "NRIFPARTITA VARCHAR(15)," _
		 & "LOTTO VARCHAR(15)," _
		 & "UM1 VARCHAR(3)," _
		 & "UM2 VARCHAR(3)," _
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "GIACENZA1 DECIMAL(19,6)," _
		 & "GIACENZA2 DECIMAL(19,6)," _
		 & "GIACENZAPESO DECIMAL(19,6)," _
		 & "GIACENZAPESOTEORICO DECIMAL(19,6))")
	End If
End Sub

Sub Create_Table_IS_RIGHEDOCUMENTI_GIRO(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCUMENTI_GIRO")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_RIGHEDOCUMENTI_GIRO] (" _
		& "[TipoDoc] [varchar](3) Not Null," _
		& "[RifIdTesta] [decimal](10, 0) Not Null," _
		& "[RifIdRiga] [decimal](5, 0) Not Null," _
		& "[Pos] [decimal](5, 0) Not Null," _
		& "[Corsia] [varchar](5) Not Null," _
		& "[CodCliFor] [varchar](7) Not Null," _
		& "[Ubicazione] [varchar](10) Null," _
		& "[TipoRiga] [varchar](1) Null," _
		& "[Codart] [varchar](50) Not Null," _
		& "[Descrizione] [varchar](250) Null," _
		& "[Ordinato] [varchar](10) Null," _
		& "[UM1] [varchar](5) Null," _
		& "[Acq_UM1] [decimal](16, 6) Null," _
		& "[UM2] [varchar](5) Null," _
		& "[Acq_UM2] [decimal](16, 6) Null," _
		& "[UM3] [varchar](5) Null," _
		& "[Acq_UM3] [decimal](16, 6) Null," _
		& "[Ordinamento] [decimal](16, 6) Null," _
		& "[QtaTotUMBase] [decimal](16, 6) Null," _
		& "[UMBase] [varchar](5) Null," _
		& "[Partita1] [varchar](15) Null," _
		& "[QtaP1] [decimal](16, 6) Null," _		
		& "[Partita2] [varchar](15) Null," _
		& "[QtaP2] [decimal](16, 6) Null," _
		& "[Partita3] [varchar](15) Null," _
		& "[QtaP3] [decimal](16, 6) Null," _
		& "[StatoRiga] [varchar](1) Null," _
		& "[UtenteModifica] [varchar](25) Not Null," _
		& "[DataModifica] [datetime] Null," _
		& "[DispUMBase] [decimal](16, 6) Null," _
		& "[PrezzoUn] [decimal](19, 6) Null)")
	End If
End Sub

Sub Create_Table_IS_SEMAFOROCORSIE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_SEMAFOROCORSIE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_SEMAFOROCORSIE] (" _
		 & "CORSIA VARCHAR(5)," _ 		  
		 & "UTENTE VARCHAR(25)," _
		 & "OCCUPATA INT," _
		 & "PRIMARY KEY(CORSIA))")		 
	End If
End Sub

Sub Create_Table_IS_SEMAFOROCORSIE_local(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_SEMAFOROCORSIE_local")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_SEMAFOROCORSIE_local] (" _
		 & "IDTESTA DECIMAL(10,0)," _ 		  
		 & "CORSIA VARCHAR(5)," _ 
		 & "TIPOCORSIA VARCHAR(3)," _		  
		 & "UTENTE VARCHAR(100)," _
		 & "OCCUPATA INT," _
		 & "PRIMARY KEY(IDTESTA,CORSIA))")
	End If
End Sub

Sub Create_Table_IS_TABCODIFICAEAN(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_TABCODIFICAEAN")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_TABCODIFICAEAN] (" _
		 & "CODICE VARCHAR(5)," _ 
		 & "NUMCIFRE INT," _
		 & "LUNG INT," _
		 & "VARIABILE INT," _
		 & "TIPO VARCHAR(1)," _
		 & "DESCRIZIONE VARCHAR(40))")
	End If
End Sub

Sub Create_Table_IS_RIGHEDOCPARTITE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_RIGHEDOCPARTITE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_RIGHEDOCPARTITE](IDTESTA DECIMAL(10,0), IDRIGA INT, QTAGEST DECIMAL(9,1)," _ 
		& "CODART VARCHAR(50), PARTITA VARCHAR(15), TIPODOC VARCHAR(3), NUMERODOC DECIMAL(10,0), ESERCIZIO DECIMAL(5,0)," _
		& "DATADOC DATETIME, NUMRIFDOC VARCHAR(15), RIFERIMENTI VARCHAR(19), DESCRIZIONE VARCHAR(80), VERDIBA VARCHAR(50)," _
		& "PESOORO VARCHAR(50), CARATI VARCHAR(50), FLAG_VISPALM INT)")
	End If
End Sub

Sub Create_Table_IS_ANAGRAFICADEPOSITI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICADEPOSITI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ANAGRAFICADEPOSITI](CODICE VARCHAR(10), DESCRIZIONE VARCHAR(80))")
	End If
End Sub

Sub Create_Table_IS_ANAGRAFICACF(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICACF")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ANAGRAFICACF](CODCLIFOR VARCHAR(7), DSCCONTO1 VARCHAR(80), SCONTO VARCHAR(10)," _
		& "CODCAMBIO DECIMAL(5,0), MAGAZZINO VARCHAR(10), CODAGENTE1 VARCHAR(7), NOTE VARCHAR(1000), FAX VARCHAR(25)," _
		& "TELEFONO VARCHAR(25), LISTINO DECIMAL(5,0), TIPOCONTO VARCHAR(1), LOCALITA VARCHAR(80), Visibile VARCHAR(1)," _
		& "utente VARCHAR(25))")
	End If
End Sub

Sub Create_Table_IS_ANAGRAFICACF_KUORE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICACF")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ANAGRAFICACF](CODCLIFOR VARCHAR(7), DSCCONTO1 VARCHAR(80), LOCALITA VARCHAR(80), TIPOCLIFOR VARCHAR(1))")
	End If
End Sub

Sub Create_Table_IS_ARTICOLI_PESOREALE_CASH(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ARTICOLI_PESOREALE_CASH")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ARTICOLI_PESOREALE_CASH] (" _
		 & "IDTESTA DECIMAL(10,0)," _ 
		 & "CODART VARCHAR(50)," _
		 & "POS INT," _		 
		 & "PESOREALE DECIMAL(19,3)," _
		 & "BARCODE VARCHAR(100)," _
		 & "DA_CANC INT)")
	End If
End Sub

Sub Create_Table_IS_IMPOSTAZIONICTRLINV(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_IMPOSTAZIONICTRLINV")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_IMPOSTAZIONICTRLINV] (" _
		 & "NOMEIMPOSTAZIONE VARCHAR(80)," _ 
		 & "CODMAGAZZINO VARCHAR(10)," _
		 & "CODUBICAZIONE VARCHAR(10))")		 
	End If
End Sub

Sub Create_Table_VISTA_FATTORICONV(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTA_FATTORICONV")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTA_FATTORICONV] (" _
		 & "CODART VARCHAR(50)," _ 
		 & "FLAG_BILANCIA VARCHAR(1)," _
		 & "UMBASE VARCHAR(3)," _
		 & "UMA VARCHAR(3)," _
		 & "FATTORE DECIMAL(20,10))")
	End If
End Sub

Sub Create_Table_GS_TESTEDOCUMENTI_LT(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_TESTEDOCUMENTI_LT")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE GS_TESTEDOCUMENTI_LT (" _
		& "TipoDoc [varchar] (3) Not Null, " _
		& "Numerodoc [decimal] (10, 0) Not Null, " _
		& "Esercizio [decimal] (5, 0) Not Null, " _
		& "CodClifor [varchar] (7), " _
		& "Datadoc [datetime], " _
		& "UtenteModifica [varchar] (25), " _
		& "NrListino [int], " _
		& "Trasmesso [int], " _
		& "Elaborato [int], " _
		& "IDKEY INTEGER PRIMARY KEY AUTOINCREMENT, " _
		& "Note varchar(80))")
	End If
End Sub

Sub Create_Table_GS_RIGHEDOCUMENTI_LT(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_RIGHEDOCUMENTI_LT")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE GS_RIGHEDOCUMENTI_LT (" _
	    & "TipoDoc        [VARCHAR] (3)     Not Null," _
	    & "Numerodoc      [DECIMAL] (10, 0) Not Null," _
	    & "Esercizio      [DECIMAL] (5, 0)  Not Null," _
	    & "Idtesta        [DECIMAL] (10, 0) Null," _
		& "Idriga         [DECIMAL] (5, 0)  Not Null," _
	    & "UtenteModifica [VARCHAR] (25)," _
	    & "Codart         [VARCHAR] (50)," _
		& "Descrizione    [VARCHAR] (250)," _
		& "Barcode        [VARCHAR] (50)," _
	    & "Qta            [DECIMAL] (19, 4)," _
	    & "UM             [VARCHAR] (3)," _
	    & "PrzUnit        [DECIMAL] (19, 6)," _
		& "CodIva         [VARCHAR] (5)," _
	    & "Sconto         [VARCHAR] (15)," _
	    & "Note           [VARCHAR] (128))")
	End If
End Sub

Sub Create_Table_GS_TESTEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_TESTEDOCUMENTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_TESTEDOCUMENTI] (" _
		& "TipoDoc        [VARCHAR] (3)  Not Null," _
		& "Numerodoc      [DECIMAL] (10, 0) Not Null," _
		& "Bis			  [VARCHAR] (3)," _
		& "Esercizio      [DECIMAL] (5, 0)  Not Null," _
		& "CodClifor      [VARCHAR] (7)," _
		& "Datadoc        [DATETIME]," _
		& "UtenteModifica [VARCHAR] (25)," _
		& "NrListino      [INT]," _
		& "Valuta         [INT]," _
		& "Trasmesso      [INT]," _
		& "Elaborato      [INT]," _
		& "flag_stp       [INT]," _
		& "flg_stp        [INT]," _
		& "rifidtesta     [DECIMAL] (10, 0)," _
		& "NumRifDoc      [VARCHAR] (15)," _
		& "DataRifDoc     DateTime)")
	End If
End Sub

Sub Create_Table_GS_RIGHEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_RIGHEDOCUMENTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE GS_RIGHEDOCUMENTI (" _
	    & "TipoDoc        [VARCHAR] (3)     Not Null," _
	    & "Numerodoc      [DECIMAL] (10, 0) Not Null," _
	    & "Esercizio      [DECIMAL] (5, 0)  Not Null," _
	    & "Idriga         [DECIMAL] (5, 0)  Not Null," _
	    & "UtenteModifica [VARCHAR] (25)," _
	    & "Codart         [VARCHAR] (50)," _
	    & "Qta            [DECIMAL] (19, 4)," _
	    & "UM             [VARCHAR] (3)," _
	    & "PrzUnit        [DECIMAL] (19, 6)," _
	    & "Sconto         [VARCHAR] (15)," _
	    & "Note           [VARCHAR] (128)," _
	    & "DataConsegna   [DATETIME]," _
	    & "Magazzino      [VARCHAR] (10)," _
	    & "MagazzinoColl  [VARCHAR] (10)," _
	    & "RifTipoDoc     [VARCHAR] (3)," _
	    & "RifNumerodoc   [DECIMAL] (10, 0)," _
	    & "RifEsercizio   [DECIMAL] (5, 0)," _
	    & "RifIdriga      [DECIMAL] (5, 0)," _
	    & "VARIAMISURE    [VARCHAR] (50)," _
	    & "RIFCLIENTE     [VARCHAR] (10)," _
	    & "Descrizione    [VARCHAR] (250)," _
	    & "rifidtesta     [DECIMAL] (10, 0)," _
	    & "TipoRiga       [VARCHAR] (1)," _
	    & "NumRifDoc      [VARCHAR] (15)," _
	    & "DataRifDoc     [DATETIME]," _
		& "ArticoloAQta   [INTEGER])")
	End If
End Sub

Sub Create_Table_GS_PALMDEVICE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_PALMDEVICE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_PALMDEVICE] (" _
		 & "SERIALNUMBER VARCHAR(32)," _ 
		 & "DATASCAD DATETIME," _
		 & "UTENTEMODIFICA VARCHAR(25)," _
		 & "DATAMODIFICA DATETIME)")
	End If
End Sub

Sub Create_Table_GS_PARAMETRIDOC(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_PARAMETRIDOC")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_PARAMETRIDOC](CODICE VARCHAR(3), DESCRIZIONE VARCHAR(80),TIPOCLIFOR VARCHAR(1))")
	End If
End Sub

Sub Create_Table_IS_PARAMETRIDOC(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_PARAMETRIDOC")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_PARAMETRIDOC](CODICE VARCHAR(3), DESCRIZIONE VARCHAR(80), TIPO VARCHAR(1), CLIFOR VARCHAR(1), TIPOCLIFOR VARCHAR(1))")
	End If
End Sub

Sub Create_Table_VISTAGIACENZAPERPALMARE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"VISTAGIACENZAPERPALMARE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [VISTAGIACENZAPERPALMARE](GIACENZA DECIMAL(16,2), CODART TEXT, CODDEPOSITO TEXT)")
	End If
End Sub

Sub Create_Table_IS_VISTA_UMPREF(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_VISTA_UMPREF")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_VISTA_UMPREF](CODICE VARCHAR(50), UMB VARCHAR(5), UMV VAARCHAR(5), UML VARCHAR(5), FCVB DECIMAL(20,10), FCLB DECIMLA(20,10))")
	End If
End Sub

Sub Create_Table_IS_BARCODE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_BARCODE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_BARCODE](ARTICOLO VARCHAR(50), BARCODE VARCHAR(50))")
	End If
End Sub

Sub Create_Table_IS_TABLISTINI2(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_TABLISTINI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_TABLISTINI](NRLISTINO INT, DESCRIZIONE VARCHAR(100), CODCAMBIO DECIMAL(5,0), FLGCOSTISTD INT)")
	End If
End Sub

Sub Create_Table_IS_ANAGRAFICAARTICOLI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICAARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ANAGRAFICAARTICOLI](CODICE VARCHAR(50)," _
		& "DESCRIZIONE VARCHAR(250), PREZZORIF INT, ARTTIPOLOGIA SAMALLINT, CODICEARTIMBALLO VARCHAR(50)," _
		& "UM VARCHAR(3), CODICEPRIMARIO VARCHAR(50), BARCODE VARCHAR(50), GIACENZA DECIMAL(38,6)," _
		& "DATAMODIFICA DATETIME, GRUPPO DECIMAL(5,0),CATEGORIA DECIMAL(5,0), CODCATEGORIASTAT DECIMAL(5,0)," _
		& "SOTTOSCORTA VARCHAR(1), UMV VARCHAR(3), UMA VARCHAR(3))")
	End If
End Sub

Sub Create_Table_IS_ANAGRAFICAARTICOLI_KUORE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_ANAGRAFICAARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_ANAGRAFICAARTICOLI](CODART VARCHAR(50)," _
		& "PARTITA VARCHAR(15), BARCODE VARCHAR(15), DESCRIZIONE VARCHAR(100), " _
		& "VERDIBA VARCHAR(50), PESOORO VARCAHR(50), CARATI VARCHAR(50))")
	End If
End Sub

Sub Create_Table_IS_PARTITE_ANNULLATE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"IS_PARTITE_ANNULLATE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [IS_PARTITE_ANNULLATE](CODART VARCHAR(50)," _
		& "PARTITA VARCHAR(15), RIFIDTESTA DECIMAL(10,0), CORSIA VARCHAR(5))")
	End If
End Sub
'----------------------------------
' VISTE IS
'----------------------------------
Sub Create_View_Vista_IS_SEMAFOROCORSIE(SQLData As SQL)	
	If (CheckIfViewExist(SQLData,"Vista_IS_SEMAFOROCORSIE")=False) Then				
		SQLData.ExecNonQuery("CREATE VIEW Vista_IS_SEMAFOROCORSIE As " _
		& "Select ls.occupata As STATOGIRO,ls.idtesta,ls.corsia,ls.tipocorsia," _
		& "(Case when ls.utente<>'CHIUSO' then (Select ifnull(group_concat(utente),'') " _
		& "from is_semaforocorsie where corsia=LS.corsia) Else 'CHIUSO' end) AS UTENTE," _
		& "(Case when ls.utente<>'CHIUSO' then (case when ifnull(sc.occupata,0)=0 then ((case when ls.occupata=2 then 1 end) " _
		& "or (Case when ls.occupata=4 Then 1 End) or (Case when ls.occupata=1 Then 1 End)) Else sc.occupata End) Else 3 End) As STATOCORSIA " _
		& "from IS_SEMAFOROCORSIE_local As ls left outer join IS_SEMAFOROCORSIE As sc on sc.corsia=ls.corsia group by " _
		& "ls.idtesta,ls.corsia,ls.tipocorsia,ls.utente,sc.occupata")		
	End If
End Sub

Sub Create_View_Vista_VARIAZIONI_CLIENTI_GIRO(SQLData As SQL)
	If (CheckIfViewExist(SQLData,"Vista_VARIAZIONI_CLIENTI_GIRO")=False) Then
		SQLData.ExecNonQuery("CREATE VIEW Vista_VARIAZIONI_CLIENTI_GIRO AS SELECT VG.IDT_GIRO,0 AS RIFIDRIGA,VG.CODCLIFOR,VG.RAGSOC,0 As QTA,Null As CODART, " _
		& "Null As TIPODOC	FROM IS_VISTA_CLIENTI_GIRO VG UNION Select VG.IDT_GIRO,ifnull(RD.RIFIDRIGA,0) As RIFIDRIGA,VG.CODCLIFOR,VG.RAGSOC,ifnull(RD.QTA,0) As " _
		& "QTA,RD.CODART, RD.TIPODOC FROM IS_VISTA_CLIENTI_GIRO VG LEFT OUTER JOIN IS_RIGHEDOCUMENTI RD ON RD.RifIdTesta=VG.IDT_GIRO AND RD.CODCLIFOR=VG.CODCLIFOR")
	End If
End Sub

Sub Create_View_Vista_CORSIE_GIRO(SQLData As SQL)
	If (CheckIfViewExist(SQLData,"Vista_CORSIE_GIRO")=False) Then	
		SQLData.ExecNonQuery("CREATE VIEW Vista_CORSIE_GIRO AS SELECT IDTESTA,CORSIA FROM IS_VISTADOCPALM UNION SELECT 0 AS IDTESTA,CODICE AS CORSIA FROM " _
		& "IS_ANAGRAFICADEPOSITI WHERE CODICE LIKE 'CS%'")
	End If
End Sub

'Sub Create_View_Vista_CORSIE_GIRO(SQLData As SQL)
'	If (CheckIfViewExist(SQLData,"Vista_CORSIE_GIRO")=False) Then
'		SQLData.ExecNonQuery("CREATE VIEW Vista_CORSIE_GIRO AS SELECT LS.IDTESTA,LS.CORSIA,(Case when ls.idtesta>0 Then '*' else '' end) as TIPOCORSIA, " _
'   	& "ifnull(sc.utente,'') as UTENTE,ifnull(sc.occupata,0) As OCCUPATA,FROM Vista_CORSIE_GIRO1 As LS  left outer join IS_SEMAFOROCORSIE As sc on sc.corsia=ls.corsia")
'	End If
'End Sub
		
'----------------------------------
' Tabelle GREEN SOFT
'----------------------------------
Sub Alter_Table_GS_TESTEDOCUMENTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_TESTEDOCUMENTI")=True) Then
		If (FieldExists(SQLData,"GS_TESTEDOCUMENTI","NomeImpostazione")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_TESTEDOCUMENTI] ADD NomeImpostazione varchar(80)")
		End If
		If (FieldExists(SQLData,"GS_TESTEDOCUMENTI","TotNumRighe")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_TESTEDOCUMENTI] ADD TotNumRighe int")
		End If
		If (FieldExists(SQLData,"GS_TESTEDOCUMENTI","Note")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_TESTEDOCUMENTI] ADD Note varchar(80)")
		End If
		If (FieldExists(SQLData,"GS_TESTEDOCUMENTI","CodNegozio")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_TESTEDOCUMENTI] ADD CodNegozio varchar(10)")
		End If
		If (FieldExists(SQLData,"GS_TESTEDOCUMENTI","Bis")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_TESTEDOCUMENTI] ADD Bis varchar(3)")
		End If
	End If
End Sub

Sub Alter_Table_GS_RIGHEDOCUMENTI(SQLData As SQL)
	Try
		If (CheckIfTableExist(SQLData,"GS_RIGHEDOCUMENTI")=True) Then
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","Barcode")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD Barcode Int")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","ArticoloAQta")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD ArticoloAQta integer")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","CodIva")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD CodIva integer")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","Bis")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD Bis varchar(3)")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","DesCat1")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD DesCat1 varchar(80)")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","DesCat2")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD DesCat2 varchar(80)")
			End If
			If (FieldExists(SQLData,"GS_RIGHEDOCUMENTI","DesCat3")=False) Then
				SQLData.ExecNonQuery("ALTER TABLE [GS_RIGHEDOCUMENTI] ADD DesCat3 varchar(80)")
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Alter_Table_GS_AUTOCLAVI(Sqldata As SQL)
	If (CheckIfTableExist(Sqldata,"GS_AUTOCLAVI")=True) Then
		If (FieldExists(Sqldata,"GS_AUTOCLAVI","DATA_TRASMESSO")=False) Then
			Sqldata.ExecNonQuery("ALTER TABLE [GS_AUTOCLAVI] ADD DATA_TRASMESSO varchar(20)")
		End If
	End If
End Sub

Sub Alter_Table_GS_LISTATEMPI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_LISTATEMPI")=True) Then
		If (FieldExists(SQLData,"GS_LISTATEMPI","TRASMESSO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_LISTATEMPI] ADD TRASMESSO INT")
		End If
		If (FieldExists(SQLData,"GS_LISTATEMPI","CODICEREP")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_LISTATEMPI] ADD CODICEREP varchar(4)")
		End If
		If (FieldExists(SQLData,"GS_LISTATEMPI","REPARTO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_LISTATEMPI] ADD REPARTO varchar(30)")
		End If
		If (FieldExists(SQLData,"GS_LISTATEMPI","POS")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_LISTATEMPI] ADD POS INT")
		End If
	End If
End Sub

Sub Alter_Table_GS_PALMDEVICE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_PALMDEVICE")=True) Then
		If (FieldExists(SQLData,"GS_PALMDEVICE","DATASCAD")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_PALMDEVICE] ADD DATASCAD DATETIME")
		End If
	End If
End Sub

Sub Alter_Table_GS_ARTICOLI_TRENDY(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ARTICOLI")=True) Then
		If (FieldExists(SQLData,"GS_ARTICOLI","ARTICOLOAQTA")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD ARTICOLOAQTA INT")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","STATO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD STATO VARCHAR(3)")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","CODNEGOZIO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD CODNEGOZIO VARCHAR(2)")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","CODCLIENTE")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD CODCLIENTE VARCHAR(7)")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","NUMFILIALE")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD NUMFILIALE INT")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","NUMDOC")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD NUMDOC VARCAR(15)")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","DATADOC")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD DATADOC DATETIME")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","TIPODOC")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD TIPODOC VARCHAR(1)")
		End If
		If (FieldExists(SQLData,"GS_ARTICOLI","DUPLICATO")=False) Then
			SQLData.ExecNonQuery("ALTER TABLE [GS_ARTICOLI] ADD DUPLICATO INTEGER")
		End If
	End If
End Sub

Sub Create_Table_GS_TABPARAMETRIDOC(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_TABPARAMETRIDOC")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_TABPARAMETRIDOC](CODICE VARCHAR(3), DESCRIZIONE VARCHAR(80),TIPODOC VARCHAR(3), TIPOCLIFOR VARCHAR(1))")
	End If
End Sub

Sub Create_Table_GS_REPARTI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_REPARTI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_REPARTI](CODICE VARCHAR(4) PRIMARY KEY, DESCRIZIONE VARCHAR(30))")
	End If
End Sub

Sub Create_Table_GS_RICETTE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_RICETTE")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_RICETTE](CODICE VARCHAR(15) PRIMARY KEY, DESCRIZIONE VARCHAR(100))")
	End If
End Sub

Sub Create_Table_GS_AUTOCLAVI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_AUTOCLAVI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_AUTOCLAVI](CODICE VARCHAR(10) PRIMARY KEY, DESCRIZIONE VARCHAR(30), NUMTUBI INT, DA_NUM1 INT," _
		& "A_NUM1 INT, DA_NUM2 INT, A_NUM2 INT, DA_NUM3 INT, A_NUM3 INT, ULTIMOPROC NUMERIC, CODRICETTA VARCHAR(15), CODDIP1 VARCHAR(5)," _
		& "CODDIP2 VARCHAR(5), CODDIP3 VARCHAR(5), DATAORA_AGG TEXT, ULTIMOCICLO INT, UUID_CICLO VARCHAR(36))")
	End If
End Sub

Sub Create_Table_GS_OPERATORI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_OPERATORI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_OPERATORI](CODICE VARCHAR(5), NOME VARCHAR(50), REPARTO VARCHAR(30))")
	End If
End Sub

Sub Create_Table_GS_ANAGRAFICACF(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ANAGRAFICACF")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_ANAGRAFICACF](CODICE VARCHAR(7), RAGSOC VARCHAR(80), LOCALITA VARCHAR(80), TIPOCLIFOR VARCHAR(1))")
	End If
End Sub

Sub Create_Table_GS_ARTICOLI_CARBON(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_ARTICOLI](CODICE VARCHAR(50), DESCRIZIONE VARCHAR(255), CODCICLO1 VARCAHAR(15), CODCICLO2 VARCHAR(15), CODCICLO3 VARCHAR(15))")
	End If
End Sub

Sub Create_Table_GS_ARTICOLI_EUREKA(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_ARTICOLI](CODICE VARCHAR(50), DESCRIZIONE VARCHAR(255))")
	End If
End Sub

Sub Create_Table_GS_ARTICOLI_BASE(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_ARTICOLI](CODART VARCHAR(50), DESCRIZIONE VARCHAR(255), BARCODE VARCHAR(20), MAGAZZINO VARCHAR(15))")
	End If
End Sub

Sub Create_Table_GS_ARTICOLI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_ARTICOLI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_ARTICOLI](BARCODE INT, CODART VARCHAR(20), DESCRIZIONE VARCHAR(80)," _
		& "CODCAT1 VARCHAR(3), DESCCAT1 VARCHAR(80), CODCAT2 VARCHAR(3), DESCCAT2 VARCHAR(80), CODCAT3 VARCHAR(3), DESCCAT3 VARCHAR(80)," _
		& "CODMARCHIO VARCHAR(4), DESCMARCHIO VARCHAR(80), TIPOMATERIALE VARCHAR(6), DESCMATERIALE VARCHAR(80), PESO DECIMAL(12,3),PREZZOLISTINO DECIMAL(12,2))")
	End If
End Sub

Sub Create_Table_GS_LISTATEMPI(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_LISTATEMPI")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_LISTATEMPI](POS INT,CAUSALE VARCAHR(10), CODART VARCHAR(50), DATAORA DATETIME, CODICEDIP VARCHAR(5))")
	End If
End Sub

Sub Create_Table_GS_AUTOCLAVE_EVENT(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_AUTOCLAVE_EVENT")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_AUTOCLAVE_EVENT] (ID INTEGER PRIMARY KEY AUTOINCREMENT, CODAUTOCLAVE VARCHAR(10), POS INT, DATAORA TEXT, " _
		& "PRESS INT, TEMP INT, CODDIP INT, UUID_CICLO VARCHAR(36))")
	End If
End Sub

Sub Create_Table_GS_AUTOCLAVE_STORY_D(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_AUTOCLAVE_STORY_D")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_AUTOCLAVE_STORY_D] (id INTEGER PRIMARY KEY AUTOINCREMENT, IDTESTA INT, POS INT, CODART VARCHAR(50), CODAUTOCLAVE VARCAHR(10), " _
		& "DESCART VARCHAR(80), MD5_COMP VARCHAR(36), UUID_CICLO VARCHAR(36), DATAORA VARCHAR(20), NUMTUBO INT, FOREIGN KEY (IDTESTA) REFERENCES GS_AUTOCLAVE_STORY_H(ID) ON DELETE CASCADE)")
	End If
End Sub

Sub Create_Table_GS_AUTOCLAVE_STORY_H(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_AUTOCLAVE_STORY_H")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_AUTOCLAVE_STORY_H] (ID INTEGER PRIMARY KEY AUTOINCREMENT, CODICEDIP1 VARCHAR(5), CODICEDIP2 VARCHAR(5), " _ 
		& "CODICEDIP3 VARCHAR(5), DATAORA_INIZIO TEXT, DATAORA_FINE TEXT, CODAUTOCLAVE VARCHAR(10), NTUBO INT, NOTE TEXT, TRASMESSO INT, PROCESSO NUMERIC, " _
		& "STATO VARCHAR(1), REPLICA INT, MD5_COMP VARCHAR (36), UUID_CICLO VARCHAR(36))")
	End If
End Sub

Sub Create_Table_GS_AUTOCLAVE_X(SQLData As SQL)
	If (CheckIfTableExist(SQLData,"GS_AUTOCLAVE_STORY_X")=False) Then
		SQLData.ExecNonQuery("CREATE TABLE [GS_AUTOCLAVE_STORY_X] (ID INTEGER PRIMARY KEY AUTOINCREMENT, CODAUTOCLAVE VARCHAR(10), CODRICETTA VARCHAR(15))")
	End If
End Sub

Public Sub CheckIfTableExist(SQLData As SQL, tablename As String) As Boolean
	If SQLData.ExecQuerySingleResult("SELECT count(name) FROM sqlite_master WHERE type='table' AND name ='" & tablename &"'") = 0 Then
	  Return(False) 'don't exist
	Else
		Return(True) 'exist
	End If
End Sub

Public Sub CheckIfViewExist(SQLData As SQL, viewname As String) As Boolean
	If SQLData.ExecQuerySingleResult("SELECT count(name) FROM sqlite_master WHERE type='view' AND name ='" & viewname &"'") = 0 Then
		Return(False) 'don't exist
	Else
		Return(True) 'exist
	End If
End Sub

Sub FieldExists(SQL As SQL, TableName As String, TableField As String) As Boolean
	Dim result As Boolean
	result = False
	Dim t As List
	t = DBUtils.ExecuteMemoryTable(SQL, "PRAGMA table_info ('" & TableName & "')", Null, 0)
	For i = 0 To t.Size - 1
		Dim values() As String
		values = t.Get(i)
		If values(1).ToLowerCase = TableField.ToLowerCase Then  ' case insensitive
			result = True
			Exit
		End If
	Next
	Return result
End Sub