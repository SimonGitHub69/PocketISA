B4A=true
Group=Default Group\Nesti
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
	' -----------------  GESTIONE SPP ------------------
	Dim serial1 As Serial 			' libreria Serial
	Dim AStream As AsyncStreams  	' libreria RandomAccessFile
	Dim T As Timer
	' -----------------  FINE SPP ----------------------
	Public xui As XUI
	Public SQLDataAccess As SQL
	Public vCodice As String
	Public vDescrizione As String
	Public vTipoTab As Int ' Tipo tabella (1 = CliFor, 2 = Listino )
	Public vTipoDocNew As String
	Public vNumDocNew As Int
	Public vEsercizioNew As Int
	Public vNumRifDoc As String
	Public vDataDocNew As String
	Public vDataRifDoc As String
	Public vOperazione As String
	Public vRifIdTesta As Long
	Public vRagSoc As String
	Public vValuta As String
	Public vCodCliFor As String
	Public vNumListino As Int
	Public vNumListinoNew As Int
	Public vDescListino As String
	Public SelectedRows As B4XSet
	Private vTrasmesso As Int
	Private MultiSelection As Boolean = True ' serve per gestire multiselezione	
	' Dim TimerLongClick As Timer
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	' -----------------  GESTIONE SPP ------------------
	Dim ScannerMacAddress As String
	Dim ScannerOnceConnected As Boolean
	' -----------------  FINE SPP ----------------------
	Private vBarcodeLetto As String = ""
	Private vBarcodeLettoOld As String = ""
	Private FolderPhp As String = "pocket_isa"
	Private Phone As IME
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private DataList As List
	Private Label1 As Label
	Private Label2 As Label
	Private Label5 As Label
	Private Label7 As Label
	Private Label6 As Label		
	Private Label8 As Label
	Private Label3 As Label
	Private EditText1 As EditText
	Private Label10 As Label
	Private Label12 As Label
	Private btnDate2 As SwiftButton
	Private sqlstr As String
	Private B4XTable1 As B4XTable
	Private Button1 As Button
	Private Button2 As Button
	Private EditText2 As EditText
	Private EditText3 As EditText
	Private EditText4 As EditText
	Private Label13 As Label
	Private Label14 As Label
	Private B4XTable1 As B4XTable
	' Private B4XTable2 As B4XTable
	Private Col1_Column As B4XTableColumn	'	N. Posizione
	Private Col2_Column As B4XTableColumn	'	Tipo Riga
	Private Col3_Column As B4XTableColumn	'	Cod. Art
	Private Col4_Column As B4XTableColumn 	' 	Descrizione Articolo
	Private Col5_Column As B4XTableColumn	' 	Ordinato
	Private Col6_Column As B4XTableColumn	' 	UM Ordinato
	Private Col7_Column As B4XTableColumn	'	Acquisito
	Private Col8_Column As B4XTableColumn	'	
	Private Col9_Column As B4XTableColumn	'	
	Private Col10_Column As B4XTableColumn	'	
	Private Col11_Column As B4XTableColumn	'	peso kg.
	Private Col12_Column As B4XTableColumn	'	N. etichette
	Private Col13_Column As B4XTableColumn	'	Data Scadenza
	Private Col14_Column As B4XTableColumn	'	Status
	Private Col15_Column As B4XTableColumn	'	Priorita
	Private Col16_Column As B4XTableColumn	'	IDRiga
	Private Col16_Column As B4XTableColumn	'	IDRiga
	Private Col17_Column As B4XTableColumn	'	QtaTotUMAConv
	Private Col18_Column As B4XTableColumn	'	QtaTotUM2
	Private Col19_Column As B4XTableColumn	'	CoeffConvUMA	
	Private Col20_Column As B4XTableColumn	'	TipoReadGiac
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private EditText5 As EditText
	Private Label11 As Label
	Private Label4 As Label
	Private Label9 As Label
	Private Panel1 As Panel
	Private Label15 As Label
	Private Label16 As Label
	Private acquisitoum1 As String = ""
	Private acquisitoum2 As String = ""
	Private Ordinatoum As String = ""
	Private UM1 As String = ""
	Private UM2 As String = ""
	Private UM3 As String = ""
	Private UMPeso As String = ""
	Private Priorita As Long = 0
	Private RowID_Riga As Long = 0
	Private SelectedColumn As B4XTableColumn
	Private TipoOperazione As String = ""
	Private XSelections As B4XTableSelections
	Private TotalSize As Int = 0
	Private Button7 As Button
	Private Label17 As Label
	Private Label18 As Label
	Public Title1 As Label
	Private Label28 As Label
	Private NumDocOrig As Int
	Private DataDocOrig As String
	Private TipoDocOrig As String
	Private DataDocum As String
	Private Panel2 As Panel
	Private Label29 As Label
	Private ComboBoxTipoDoc As B4XComboBox
	Private List_TipoDoc As List
	Private List_TipoDoc_Desc As List
	Private List_TipoDoc_TipoCliFor As List
	Private IDkey As Long
	Private MaskedEditText1 As MaskedEditText	
	Private CheckBox1 As CheckBox
	Private CheckBox2 As CheckBox
	Private Label30 As Label
	Private Label31 As Label
	Private Label32 As Label
	Private vCodArticolo As String = ""
	Private vRigaDoc As String
	Private ScrollView1 As ScrollView
	Private EditText6 As EditText
	Private Button9 As Button
	Private EditText7 As EditText 
	Private Button10 As Button
	Private Panel3 As Panel
	Private Button12 As Button
	Private Button11 As Button
	Private lblpaperRoll As Label
	Private stu As StringUtils
	Private txt As String =""
	Private Button13 As Button
	Private Label36 As Label
	Private Label37 As Label
	Private Label38 As Label
	Private Label39 As Label
	Private Label40 As Label
	Private Label41 As Label
	Private Label42 As Label
	Private vLottoCompleto As String = ""
	Private vLottoCompletoOld As String = ""
	Private vLotto As String = ""
	Private vLottoOld As String = ""	
	Private vCodArtLotto As String = ""
	Private vCodArtCella As String = ""
	Private vTipoLettura As Int = 0
	Private ColumnColor As Int
	Private EditText8 As EditText
	Private EditText9 As EditText
	Private Button14 As Button
	Private Button15 As Button
	Private PesoArt As Double = 0
	Private TotPesoArt As Double = 0
	Private TotQtaUM1 As Double = 0
	Private TotQtaUM2 As Double = 0
	Private TotQtaUMX As Double = 0
	Private Button16 As Button
	Private Label33 As Label
	Private Label34 As Label
	Private vFoglioInv As String = ""
	Private vCorsia As String = ""
	Private vCorsiaOrig As String = ""
	Private vCorsiaDest As String = ""
	Private vCorsiaUbicaz As String = ""
	Private vCorsiaUbicazColl As String = ""
	Private vFlagSvuotaCella As Int = 0
	Private Label35 As Label
	Private vDescrizioneArt As String = ""
	Private vNumPos As Int = 0
	Private vFattoreConv As Double = 0
	Private vQtaTotUMAConv As Double = 0
	Private vCodDeposito As String = ""
	Private vCodDepositoColl As String = ""
	Private vDescDeposito As String = ""
	Private Label44 As Label
	Private Label45 As Label
	Private Label46 As Label
	Private Label47 As Label
	Private Label48 As Label
	Private Label49 As Label
	Private Panel4 As Panel
	Private Label43 As Label
	Private Button18 As Button
	Private LottiGiacOrig As List
	Private LottiGiacDest As List
	Private Label50 As Label
	Private Label51 As Label
	Private Label52 As Label
	Private Button8 As Button
	Private EditText10 As EditText
	Private Label19 As Label
	Private Label20 As Label
	Private Label21 As Label
	Private Label22 As Label
	Private Label23 As Label
	Private Label24 As Label
	Private Label25 As Label
	Private Label26 As Label
	Private Label27 As Label
	Private Label53 As Label
	Private Label54 As Label
	Private Label55 As Label
	Private Label56 As Label
	Private Label57 As Label
	Private Label58 As Label
	Private Label59 As Label
	Private Label60 As Label
	Private Label61 As Label
	Private Label62 As Label
	Private Label63 As Label
	Private Button17 As Button
	Private Button19 As Button
	Private Label64 As Label
	Private vTipoReadGiac As String
	Private Label65 As Label
	Private vMaxQtaUM2 As Double
	Private vMaxQtaUM3 As Double
	Type LottoGiacenzeType(Lotto As String, Giac1 As String, Giac2 As String, GiacPeso As String)
End Sub

Sub Activity_Create(FirstTime As Boolean)
	btnDate2.Initialize("","")
	ListaDoc.vTrasmesso=0
	'Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		vRifIdTesta = 0
		vCodCliFor = ""
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)	
	'	TimerLongClick.Initialize("TimerLongClick",50)	
	'	TimerLongClick.Enabled = False
	End If
	Activity.LoadLayout("Picking")
	'--------- Panel 4 --------------
	Panel4.Visible=False
	'--------- Panel 3 --------------
	Panel3.Visible=False
	lblpaperRoll.Initialize("lblPaperRoll")
	ScrollView1.Panel.AddView(lblpaperRoll, 0, 0, 100%x, ScrollView1.Height)
	ScrollView1.Panel.Height = ScrollView1.Height
	lblpaperRoll.TextSize = 14
	lblpaperRoll.Color = Colors.LightGray
	lblpaperRoll.TextColor = Colors.Black
	lblpaperRoll.Height = ScrollView1.Height
	lblpaperRoll.SingleLine=False	
	' -----------------  GESTIONE SPP ------------------
	If(Main.SwitchMode_SPP=1) Then
		serial1.Initialize("Serial")
		T.Initialize("Timer", 2000)
	End If
	' -----------------  fine SPP ----------------------
	Sleep(0)
	Panel2.Visible=False
	Button13.Visible=False
	LottiGiacOrig.Initialize
	LottiGiacDest.Initialize
	'--------------------------------
	DateTime.DateFormat = "dd/MM/yyyy"
	Base = Activity	
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	Select Case ListaDocTablet.vOperazione
	 	Case "ApriDoc"
			Select Case Choose_Menu.vOperazioneMenu
				Case "Inventario"
					TipoOperazione = "INV"  ' Inventario
					ColumnColor = 11
					CheckBox1.Visible=False
					CheckBox2.Visible=False
					Label29.Text="SELEZIONARE IL FOGLIO INVENTARIO"
					Panel2.Visible=False
					Label7.Visible=False
					Label8.Visible=False
					Button1.Text="AGGIORNA E CHIUDI"
					Button2.Visible=False
					Button6.Visible=False
					Button7.Visible=False
					Label3.Width=Label3.Width+70dip
					Label11.Visible=False
					EditText5.Visible=False
					EditText4.Width=EditText4.Width+70dip
					Label14.Width=Label14.Width+70dip
					'Button13.Visible=True
					EditText2.Enabled=False
					EditText3.Enabled=False
					EditText4.Enabled=False
					B4XTable1.mBase.Visible=True
					ListaRigheTablet_INV(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					CheckBox2.Visible=False ' Chiusura manuale
						
				Case "Spostamento"
					TipoOperazione = "SPO"  ' Spostamento merce da magazzino o celle
					ColumnColor = 11
					CheckBox1.Visible=False
					CheckBox2.Visible=False
					Label29.Text="SELEZIONARE IL DEPOSITO DI ORIGINE"
					Panel2.Visible=False
					Label7.Visible=False
					Label8.Visible=False
					Button1.Text="AGGIORNA E CHIUDI"
					Button2.Visible=False
					Button6.Visible=False
					Button7.Visible=False
					Label3.Width=Label3.Width+70dip
					Label11.Visible=False
					EditText5.Visible=False
					EditText4.Width=EditText4.Width+70dip
					Label14.Width=Label14.Width+70dip
					'Button13.Visible=True
					EditText2.Enabled=False
					EditText3.Enabled=False
					EditText4.Enabled=False
					B4XTable1.mBase.Visible=True
					ListaRigheTablet_SPO(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					CheckBox2.Visible=False   ' Chiusura manuale
						
				Case Else
					TipoOperazione = "COF"  ' Carico Ordine Fornitore
					ColumnColor = 13
					B4XTable1.mBase.Visible=True
					ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					CheckBox2.Visible=True   ' Chiusura manuale
					
			End Select
		
		Case "NuovoDoc"
			B4XTable1.Clear
			B4XTable1.Refresh
			Select Case Choose_Menu.vOperazioneMenu
				
			Case "Inventario"				
				TipoOperazione = "INV"	    ' Inventario
				ColumnColor = 11
				CheckBox1.Visible=False
				CheckBox2.Visible=False
				Label29.Text="SELEZIONARE IL FOGLIO INVENTARIO"
				Leggi_NomeImpostazioni
				Panel2.Visible=True				
				Label7.Visible=False
				Label8.Visible=False
				Button1.Text="AGGIORNA E CHIUDI"
				Button2.Visible=False
				Button6.Visible=False
				Button7.Visible=False
				Label3.Width=Label3.Width+70dip
				Label11.Visible=False
				EditText5.Visible=False
				EditText4.Width=EditText4.Width+70dip
				Label14.Width=Label14.Width+70dip
				ListaRigheTablet_INV("INV",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)					
				'Button13.Visible=True
				EditText2.Enabled=False
				EditText3.Enabled=False
				EditText4.Enabled=False
					CheckBox2.Visible=False  ' Chiusura manuale
												
			Case "Spostamento"
				TipoOperazione = "SPO"	    ' Spostamento
				ColumnColor = 11
				CheckBox1.Visible=False
				CheckBox2.Visible=False
				Label29.Text="SELEZIONARE IL DEPOSITO, CELLA O CORSIA"
				Leggi_Depositi
				Panel2.Visible=True
				Label7.Visible=False
				Label8.Visible=False
				Button1.Text="AGGIORNA E CHIUDI"
				Button2.Visible=False
				Button6.Visible=False
				Button7.Visible=False
				Label3.Width=Label3.Width+70dip
				Label11.Visible=False
				EditText5.Visible=False
				EditText4.Width=EditText4.Width+70dip
				Label14.Width=Label14.Width+70dip
				ListaRigheTablet_SPO("SPO",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
				'Button13.Visible=True
				EditText2.Enabled=False
				EditText3.Enabled=False
				EditText4.Enabled=False
				CheckBox2.Visible=False   ' Chiusura manuale
				
			Case Else				
				TipoOperazione = "COF"   ' Carico Ordine Fornitore
				ColumnColor = 13
				ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)							
				B4XTable1.mBase.Visible=True												
				EditText2.Enabled=True
				CheckBox2.Visible=True    ' Chiusura manuale				
					
		End Select			
			
	End Select	
	Label2.Text="BARCODE :"
	Label5.Text="DATA SCAD. :"
	Label11.Text="ETICH."
	Label14.Text="PESO"
	Label28.Text = ExtraUtility.DateToFormat(DateTime.now,"dd/MM/yyyy","it","")
	Label8.Text=""
	ListaDoc.vTrasmesso=0
	vTipoTab = 0
	EditText1.RequestFocus
	XSelections.Initialize(B4XTable1)
	XSelections.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)		
	Col1_Column.InternalSortMode="ASC"
	Col1_Column.Sortable = True
	MaskedEditText1.TextColor=Colors.ARGB(255,82,1,182)
	MaskedEditText1.Color=Colors.Transparent
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	' Sleep(0)
	' -----------------  GESTIONE SPP ------------------
	If(Main.SwitchMode_SPP=1) Then
		Log ("Activity paused. Disconnecting...")
		AStream.Close
		serial1.Disconnect
		T.Enabled=False
	End If
	'TimerLongClick.Enabled = False
	' -----------------  fine SPP ----------------------
End Sub

Sub Activity_Resume
	' -----------------  GESTIONE SPP ------------------
	If(Main.SwitchMode_SPP=1) Then
		Log("Resuming...")
		ShowPairedDevices
		If ScannerOnceConnected=True Then
			T.Enabled=True
		End If
	End If
	' -----------------  fine SPP ----------------------
	'Sleep(0)
End Sub

Sub UpdateTape
	Dim h As Float
	lblpaperRoll.Text = txt
	h = stu.MeasureMultilineTextHeight(lblpaperRoll, txt)
	If h > ScrollView1.Height Then
		lblpaperRoll.Height = h
		ScrollView1.Panel.Height = h
		Sleep(0)
	End If
	ScrollView1.FullScroll(False)
End Sub

' -----------------  GESTIONE SPP ------------------
Sub ShowPairedDevices
	If(Main.SwitchMode_SPP=1) Then
		Dim PairedDevices As Map
		PairedDevices = serial1.GetPairedDevices
		Dim l As List
		l.Initialize
		For i = 0 To PairedDevices.Size - 1
			l.Add(PairedDevices.GetKeyAt(i))
		Next
		If l.Size=0 Then
			l.Add("No device(s) found...")
		End If
		Dim res As Int
		res = InputList(l, "Seleziona lettore", -1) ' show list with paired devices		
		If res <> DialogResponse.CANCEL Then
			If l.Get(res)="No device(s) found..." Then
				Return
			Else
				ScannerMacAddress=PairedDevices.Get(l.Get(res)) 'convert the name to mac address and connect
				serial1.Connect(ScannerMacAddress)
			End If
		End If
 	End If
End Sub

Sub Serial_Connected (success As Boolean)
	Try
		If(Main.SwitchMode_SPP=1) Then
			If success = True Then
				Log("Scanner is now connected. Waiting for data...")
				AStream.Initialize(serial1.InputStream, serial1.OutputStream, "AStream")
				ScannerOnceConnected=True
				T.Enabled=False
			Else
				If ScannerOnceConnected=False Then
					MsgboxAsync("Please switch on the scanner...","Scanner is offline")
					ShowPairedDevices
				Else
					Log("Still waiting for the scanner to reconnect: " & ScannerMacAddress)
					T.Enabled=True
				End If
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_MaxPriorita_Data As Int
	Try
		Dim MaxPriority As Int = 0
		'Dim sqlstr As String
		'sqlstr = $"SELECT (9999-ifnull(max(c0),0)) as MAXPRIORITA FROM data"$		
		'MaxPriority = B4XTable1.sql1.ExecQuerySingleResult(sqlstr)
		Return(MaxPriority)
	Catch
		Return(0)
		Log(LastException)
	End Try
End Sub

Sub AStream_NewData (Buffer() As Byte)
Try
		If(Main.SwitchMode_SPP=1) Then
			Log("Received: " & BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
			Dim F_Errore As Boolean = False
			' 8056455939510
			Dim Phone As IME
			Phone.HideKeyboard
			' vBarcodeLetto = EditText1.Text
			vBarcodeLetto = BytesToString(Buffer, 0, Buffer.Length, "UTF8")
			If (vBarcodeLetto <> Null )  And (vBarcodeLetto <> vBarcodeLettoOld) Then
				If (B4XTable1.Size=0) And (TipoOperazione="COF") Then
					vBarcodeLettoOld = vBarcodeLetto
					' Rilegge gli articoli
					' Caso carico da ordine
					wait for (Leggi_Metodo_Tabelle) complete (Success As Boolean)
					If (Success) Then
						' EditText1.Text=vBarcodeLetto
						' idtesta = 593578
						sqlstr = "select VI.rowid, VI.POSIZIONE, VI.TIPORIGA, VI.CODART, VI.DESCRIZIONEART, VI.QTAGEST, VI.UMGEST, VI.UMA, VI.UMP, VI.UMV, VI.TIPODOC, VI.NUMERODOC, VI.DATADOC, VI.DSCCONTO1, " _
						& "VI.NUMEROETICHETTE, VI.FLAG_BILANCIA, VI.CODCLIFOR, VI.IDRIGA, AA.ESAURITO FROM IS_VISTADOCPALM AS VI LEFT OUTER JOIN IS_ANAGRAFICAARTICOLI AS AA ON AA.CODICE=VI.CODART " _
						& "WHERE IDTESTA='" & vBarcodeLetto & "' ORDER BY POSIZIONE"	
						Log(sqlstr)
						Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
						Dim f_Esaurito As Boolean = False
						Do While rs.NextRow
							Dim rowx(19) As Object
							If rs.GetDouble("QTAGEST") Mod 1=0 Then 	' fa le stesse veci della funzione int() se intero elimno eventuali decimali
								Ordinatoum = NumberFormat2(rs.GetDouble("QTAGEST"),0,0,0,False)
							Else
								Ordinatoum = rs.GetDouble("QTAGEST")
							End If
							rowx(0) = rs.GetInt("POSIZIONE")
							rowx(1) = rs.Getstring("TIPORIGA")
							rowx(2) = rs.Getstring("CODART")
							If (rs.GetInt("ESAURITO")=1) Then
								rowx(3) = "**ESAURITO** " & rs.Getstring("DESCRIZIONEART")
								f_Esaurito = True
								F_Errore = True
							Else
								rowx(3) = rs.Getstring("DESCRIZIONEART")
							End If
							rowx(4) = Ordinatoum & " " & rs.GetString("UMGEST")
							rowx(5) = rs.GetString("UMGEST")
							rowx(6) = 0 ' Acquisito + UMGest
							rowx(7) = Leggi_UMBase(rowx(2),rowx(5))
							rowx(8) = 0	'Acquisito UM2
							If(rs.GetString("FLAG_BILANCIA")="S") Then
								rowx(9) = "KG" ' KG se a peso
							Else
								rowx(9) = ""   '
							End If
							rowx(10) = 0 ' Peso in KG
							rowx(11) = "" ' rs.GetString("NUMEROETICHETTE") ' num. etichette
							rowx(12) = ""									' Data Scadenza
							rowx(13) = ""                          			' status colore
							rowx(14) = rs.GetInt("POSIZIONE")     			' prorità variabile
							rowx(15) = rs.GetInt("IDRIGA")     				' IDriga
							rowx(16) = 0
							rowx(17) = 0
							rowx(18) = 0
							DataList.Add(rowx)
						Loop
						If (f_Esaurito) Then
							ExtraUtility.Play_Sound("error.wav")
							Label3.Text = "*** ATTENZIONE ARTICOLI ESAURITI ***"
						End If
						If(rs.RowCount>0) Then
							If (Label1.Text.Trim="") Then
								vRifIdTesta = vBarcodeLetto		' riferimento IDTesta
								Dim DataDoc As String = ExtraUtility.ConvertDateTimeTo_ITA_Format(rs.GetString("DATADOC"),False)
								Label1.Text = " " & rs.GetString("TIPODOC") & " N. " & rs.GetString("NUMERODOC") & " DEL " & DataDoc & " - " & rs.GetString("DSCCONTO1") '  & rs.GetString("DATADOC")
								TipoDocOrig = rs.GetString("TIPODOC")
								NumDocOrig = rs.GetInt("NUMERODOC")
								DataDocOrig = DataDoc
								vCodCliFor = rs.GetString("CODCLIFOR")
								Priorita = 0
								Col1_Column.InternalSortMode="ASC"
								Col1_Column.Sortable = True
								vTipoDocNew = DB_SQLite.Leggi_AnagraficaCF(SQLDataAccess,rs.GetString("CODCLIFOR"),"TipoDoc")
								If(vTipoDocNew="") Then
									Panel2.Visible=True
									Leggi_ParametriDoc("F")
								Else
									Label6.Text = vTipoDocNew
									Label6.TextSize = 11dip
								End If
							End If
						Else
							ExtraUtility.Play_Sound("error.wav")
							ToastMessageShow("DOCUMENTO CARICO NON TROVATO!" & CRLF & "SINCRONIZZARE IL DISPOSITIVO!",False)
							F_Errore = True
						End If
						rs.Close
						B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
						B4XTable1.SetData(DataList)
						If(DataList.Size>0) Then
							B4XTable1.UpdateTableCounters
							TotalSize = B4XTable1.Size
						Else
							TotalSize = 0
						End If
					End If
				Else
					Dim CodiceLetto As String = vBarcodeLetto.trim  ' EditText1.Text.Trim
					If( TipoOperazione="COF") Then
						'--------------------------------------------------
						' Carico Ordine Fornitore
						'--------------------------------------------------
						NewData_CaricoOrdineFornitore(CodiceLetto, F_Errore)	
					End If			
					If (TipoOperazione="INV") Then
						'--------------------------------------------------
						' inventario
						'--------------------------------------------------
						NewData_Inventario(CodiceLetto,F_Errore)
					End If
					If (TipoOperazione="SPO") Then
						'--------------------------------------------------
						' spsotamento
						'--------------------------------------------------
						NewData_Spostamento(CodiceLetto,F_Errore)
					End If
				End If
				If(TipoOperazione="COF") Then
					If (Button6.Text="ORDINE TOTALE") Then
							VerificaResiduo(True,TotalSize)
					Else
						Dim Finito As Boolean =	VerificaOrdineCompleto
						If(Finito) Then
							ExtraUtility.Play_Sound("Sound3.wav")
							MsgboxAsync("Ordine Completato con successo!","CONTROLLO ORDINE")
						End If
					End If
				End If
			End If
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Sub Azzera_Panel3
	TotQtaUM1=0
	TotQtaUM2=0
	TotQtaUMX=0
	txt=""
	Label36.Text = ""
	' Label37.Text = ""
	Label38.Text = ""
	Label39.Text = ""
	' Label40.Text = ""
	Label41.Text = ""
	Label42.Text = ""
	UpdateTape
End Sub

Sub NewData_CaricoOrdineFornitore(CodiceLettoCOF As String, F_Errore As Boolean)
	If (CodiceLettoCOF.Length=13) And (CodiceLettoCOF.SubString2(0,1)="2") And (vCodArticolo="") Then
		' Decodifico articolo a peso, in realtà solo l'articolo
		CodiceLettoCOF = ExtraUtility.LeggiArticoloConPeso(CodiceLettoCOF,1)	' estrae l'articolo dalla stringa letta
	End If
	sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLettoCOF & "'"
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	If (rs.RowCount>0) Then
		Do While rs.NextRow
			Label3.Text = rs.GetString("DESCRIZIONE")
			vCodArticolo = rs.GetString("CODICE")
			If (rs.GetInt("ESAURITO")<>0) Then
				Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
				F_Errore = True
			End If
		Loop
		rs.close
	Else
		sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
								& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & CodiceLettoCOF & "'"
		Log (sqlstr)
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label3.Text = rs.GetString("DESCRIZIONE")
				vCodArticolo = rs.GetString("ARTICOLO")
				If (rs.GetInt("ESAURITO")<>0) Then
					Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
					F_Errore = True
				End If
			Loop
			rs.close
		Else
			'--------------------------------------------------------------------------------
			' nel caso non venga decodificato il codice si applica funzione Decodifica_EAN
			'--------------------------------------------------------------------------------
			Dim vRes As tRec_EANCODE = DBUtilsExtra.Decodifica_CodiceEAN(SQLDataAccess,vBarcodeLetto)
			If (vRes.IsInitialized) Then
				vCodArticolo = vRes.Codart
				If (vCodArticolo<>"") Then
					Label3.Text = vRes.Descrizione
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label3.Text = "*** CODICE ERRATO ***"
					F_Errore = True
				End If
				' MsgboxAsync	("OK trovato -> " & vRes.Descrizione,"TEST EAN")
			Else
				ExtraUtility.Play_Sound("error.wav")
				Label3.Text = "*** CODICE ERRATO ***"
				F_Errore = True
				vCodArticolo = ""
			End If
		End If
	End If
	Dim cell As String
	Dim acquisito As Double = 0
	Dim ordinato As String = ""
	Dim OrdinatoNum As Double = 0
	Dim RowData As Map
	Dim f_Esaurito As Boolean = False
	' prova = B4XTable1.GetRow(0).GetValueAt(1).
	vRigaDoc = ""
	For i=1 To B4XTable1.Size
		RowData = B4XTable1.GetRow(i)
		' cell = RowData.Get("Cod. Art.")
		' RowData.GetValueAt(1)
		cell = RowData.GetValueAt(2)
		If cell = vCodArticolo Then
			RowID_Riga = RowData.GetValueAt(0)
			UM1 = RowData.GetValueAt(5)
			UM2 = RowData.GetValueAt(7)
			UMPeso = RowData.GetValueAt(9)
			UMPeso = UMPeso.Replace(".","")
			If UM1=UM2 Then
				Button3.Text = UM1
				Button4.Text = ""
			Else
				Button3.Text = UM1
				Button4.Text = UM2
			End If
			Button5.Text = UMPeso
			ordinato = RowData.GetValueAt(4)
			OrdinatoNum = ExtraUtility.ConvertToNumber(RowData.GetValueAt(4))
			ordinato = ordinato.Replace(" ",CRLF)
			Label8.Text = ordinato
			vRigaDoc =  NumberFormat( RowData.GetValueAt(0),0,0)	' NR riga
			Label16.Text = vRigaDoc
			acquisitoum1 =  RowData.GetValueAt(6) ' Acquisito + UM
			If (acquisitoum1.StartsWith("0")) Then
				acquisito = "0" ' OrdinatoNum
			Else
				If IsNumber(acquisitoum1) Then
					acquisito =  acquisitoum1
				Else
					Dim pos As Int = acquisitoum1.IndexOf(" ")
					If (pos>0) Then
						acquisito = acquisitoum1.SubString2(0,pos)
					End If
				End If
			End If
			Label30.Text =  Converti_Qta_UMBase(SQLDataAccess,RowData.GetValueAt(2),UM1,OrdinatoNum) & " " & UM2
			Label31.Text =  Converti_Qta_UMBase(SQLDataAccess,RowData.GetValueAt(2),UM1,acquisito) & " " & UM2
			'Label32.Text = "TOTALE " & (acquisitoum1+acquisitoum2) & UM2
			ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
			EditText2.Text = NumberFormat2( acquisito,0,0,0,False) 	' acquisito um1
			EditText3.Text = RowData.GetValueAt(8)  				' acquisito um2
			EditText4.Text = RowData.GetValueAt(10)					' peso kg
			EditText5.Text = RowData.GetValueAt(11)
			MaskedEditText1.Text = ""
			acquisitoum1 = EditText2.Text & " " & UM1
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6 = ? WHERE rowid = ?", Array (acquisitoum1, RowID_Riga))
			Dim Index As Int  = RowData.GetValueAt(0)
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c13 = ? WHERE rowid = ?", Array ("P",RowID_Riga))
			XSelections.CellClickedForced2("",Index,xui.Color_Magenta)
			B4XTable1.Refresh
		End If
		' Log("Pos. " & i & " - " & cell)
	Next
	If vRigaDoc.Trim="" Then
		Label16.Text = ""
		If(Choose_Menu.vOperazioneMenu="Carico da Ordine Fornitore") Then
			ToastMessageShow("ARTICOLO NON TROVATO NELL'ORDINE!",True)
		Else
			ToastMessageShow("ARTICOLO NON TROVATO!",True)
		End If
		ExtraUtility.Play_Sound("error.wav")
	Else
		If (F_Errore =False) Then
			ExtraUtility.Play_Sound("VoiceOK.wav")
		Else
			ExtraUtility.Play_Sound("error.wav")
		End If
	End If
			
End Sub

Sub NewData_Inventario(CodiceLettoInv As String, F_ErroreInv As Boolean)	
	'--------------------------------------
	' INVENTARIO
	'--------------------------------------
	If (TipoOperazione="INV") Then
		Dim vCorsiaArticolo As String =""
		Dim vResInv As List = Decodifica_Articolo_Inventario(CodiceLettoInv)
		' Cerco l'articolo x cella e corsia
		If(vResInv.Size>0) Then
			Dim Stringa As String = vResInv.Get(0)
			PesoArt = 0 
			Select Stringa
				Case "T=1"
					' caso lettura cella
					If(Panel3.Visible=True) Then
						Registra_Panel3("Hai selezionato una nuova cella vuoi registrare i seguenti dati?",Label34.Text)
					End If
					vTipoLettura = 1
					vCodArtCella = ""
					vCodArtLotto = ""
					vLottoCompleto = ""
					vLottoCompletoOld = ""
					vLotto = ""
					TotQtaUM1=0
					TotQtaUM2=0
					TotQtaUMX=0
					EditText7.Text=""
					EditText8.Text=""
					EditText9.Text=""
					Label39.Text=""
					Label41.Text=""
					Label42.Text=""
					Label36.Text=" Tot."
					Dim CorsiaEti As String = CodiceLettoInv.SubString2(0,5)
					Dim UbicazioneEti As String = CodiceLettoInv.SubString(5)
					vCorsiaUbicaz = CodiceLettoInv.Trim
					If(CorsiaEti<>vCorsia) Then
						sqlstr = ""
						ExtraUtility.Play_Sound("error.wav")
						Msgbox2Async("La corsia non corrisponde a quella del foglio inventario selezionato!", "Pocket ISA", "OK", "", "", Null, False)
					Else
						sqlstr = "SELECT CORSIA,CODICE,DESCRIZIONE,UMV,UMA,UM,ESAURITO,FLAG_BILANCIA from IS_ANAGRAFICAARTICOLI " _
										& " WHERE UBICAZIONE = '" & UbicazioneEti & "' AND CORSIA = '" & CorsiaEti & "'"																		
					End If
								
				Case "T=2"
					' caso lettura lotto
					vTipoLettura = 2
					If(vCorsiaUbicaz="N") Then
						vCodArtCella = ""
					End If
					vLottoCompleto=CodiceLettoInv
					Select vResInv.Size
						Case 1
							vLotto = vResInv.Get(1)
						Case 2
							vLotto = vResInv.Get(1)
							vCodArtLotto = vResInv.get(2)
						Case 3
							vLotto = vResInv.Get(1)
							vCodArtLotto = vResInv.get(2)
						Case 4 ' caso EAN128
							vLotto = vResInv.Get(1)
							vCodArtLotto = vResInv.get(2)
							vLottoCompleto = vResInv.Get(3)	
						Case 5 ' caso EAN128
							vLotto = vResInv.Get(1)
							vCodArtLotto = vResInv.get(2)
							vLottoCompleto = vResInv.Get(3)
							PesoArt = vResInv.Get(4)
						Case Else
							vCodArtLotto=""
							F_ErroreInv=True
					End Select
					Dim vLen As Int = 7-vCodArtLotto.Length
					vCodArtLotto = "00000000".SubString2(0,vLen) & vCodArtLotto
					sqlstr = "SELECT CORSIA,CODICE,DESCRIZIONE,UMV,UMA,UM,ESAURITO,FLAG_BILANCIA from IS_ANAGRAFICAARTICOLI " _
											& " WHERE BARCODE = '" & vCodArtLotto & "'" ' And (CORSIA ='" & vCorsia & "' OR IFNULL(CORSIA,'') ='')" 	
					TotQtaUM1 = 0
					TotQtaUM2 = 0
					TotQtaUMX = 0
					TotPesoArt = 0
					TotPesoArt = 0
					Label42.Text = TotPesoArt
					Button14.TextColor = ExtraUtility.Color_DarkGreen
					Button15.TextColor = xui.Color_Gray
					Button14.Tag="Pressed"
					Button15.Tag=""
										
				Case "T=4"
					' caso lettura EAN 128 integrato LOtto e Peso
					vTipoLettura = 2
					If(vCorsiaUbicaz="N") Then
						vCodArtCella = ""
					End If
					vLottoCompleto=CodiceLettoInv
					vLotto = vResInv.Get(1)
					vCodArtLotto = vResInv.get(2)
					vLottoCompleto = vResInv.Get(3)
					PesoArt = vResInv.Get(4)
					Dim vLen As Int = 7-vCodArtLotto.Length
					vCodArtLotto = "00000000".SubString2(0,vLen) & vCodArtLotto
					sqlstr = "SELECT CORSIA,CODICE,DESCRIZIONE,UMV,UMA,UM,ESAURITO,FLAG_BILANCIA from IS_ANAGRAFICAARTICOLI " _
											& " WHERE BARCODE = '" & vCodArtLotto & "'" ' And (CORSIA ='" & vCorsia & "' OR IFNULL(CORSIA,'') ='')" 	
					TotQtaUM1 = 0
					TotQtaUM2 = 0
					TotQtaUMX = 0
					TotPesoArt = 0
					TotPesoArt = 0
					Label42.Text = TotPesoArt
					Button14.TextColor = ExtraUtility.Color_DarkGreen
					Button15.TextColor = xui.Color_Gray
					Button14.Tag="Pressed"
					Button15.Tag=""
										
											
				Case Else
					If(vTipoLettura>=2) Then
						' caso lettura
						vTipoLettura = 3 ' caso lettura barcode articolo
						Dim Result As List = Leggi_Barcode_Articolo(CodiceLettoInv)
						If(Result.Size=4) Then
							vCodArticolo = Result.Get(2)
							F_ErroreInv = Result.Get(3)
						Else If(Result.Size=2) Then
							vCodArticolo = Result.Get(0)
							F_ErroreInv = Result.Get(1)
						Else if (Result.Size=1) Then
							vCodArticolo = ""
							F_ErroreInv = Result.Get(0)
						Else
							vCodArticolo=""
							F_ErroreInv = True
						End If
					Else
						vCodArticolo=""
						F_ErroreInv = True
						ExtraUtility.Play_Sound("error.wav")
						Msgbox2Async("Devi prima selezionare il lotto e poi l'articolo presente in cella!", "Pocket ISA", "OK", "", "", Null, False)
					End If
																																											
			End Select
		End If		
		If(vCorsia.SubString2(0,3)="MAG") Then			
			vCorsiaUbicaz="N"
		End If
		If (Panel3.Visible) And (vTipoLettura=3 Or PesoArt>0) And ((vCodArtCella=vCodArticolo) Or (vCorsiaUbicaz="N"))  Then ' qui
			Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
			If(PesoArt>0) Then
				vTipoLettura=3
				TotPesoArt = Round2(TotPesoArt + PesoArt,3)
				If (Button14.Tag="Pressed") Then
					txt =  DataOra & " - " & CodiceLettoInv & " + 1 " & UM1 & "  -  Kg " & PesoArt & CRLF & txt
					TotQtaUM1 = TotQtaUM1 + 1
					If (Button15.Text<>"") Then
						If(vCodArtCella<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
						End If	
					Else
						TotQtaUMX = TotQtaUM1
					End If
					Label39.Text = TotQtaUM1
				End If
				If (Button15.Tag="Pressed") Then
					txt =  DataOra & " - " & CodiceLettoInv & " + 1 " & UM2 & "  -  Kg " & PesoArt & CRLF & txt
					TotQtaUM2 = TotQtaUM2 + 1
					If (Button15.Text<>"") Then
						If(vCodArtCella<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
						End If
					Else
						TotQtaUMX = TotQtaUM1
					End If
					Label41.Text = TotQtaUM2
				End If
			Else
				If (Button14.Tag="Pressed") Then
					txt =  DataOra & " - " & CodiceLettoInv & " + 1 " & UM1 & CRLF & txt
					TotQtaUM1 = TotQtaUM1 + 1
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
					Label39.Text = TotQtaUM1
				End If
				If (Button15.Tag="Pressed") Then
					txt =  DataOra & " - " & CodiceLettoInv & " + 1 " & UM2 & CRLF & txt
					TotQtaUM2 = TotQtaUM2 + 1
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
					Label41.Text = TotQtaUM2
				End If
			End If
			Label42.Text = TotPesoArt
			If( Button15.Text<>"") Then
				Label36.Text=" Tot. " & TotQtaUMX & " " & UM2
			Else
				Label36.Text=" Tot. " & TotQtaUMX & " " & UM1
			End If
			If(Button15.Text="") Then
				EditText8.Visible=False
			Else
				EditText8.Visible=True
			End If
			If(Button16.Text="") Then
				EditText9.Visible = False
			Else
				EditText9.Visible = True
			End If
			' Aumenta valore 1
			If(Button16.Text<>"") Then
				EditText9.Visible = True
			Else
				EditText9.Visible = False
			End If
			ScrollView1.FullScroll(False)
			If (Button16.Text<>"") Then
				Label42.Visible = True
			Else
				Label42.Visible = False
			End If
			UpdateTape
		End If
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Select vTipoLettura
					Case 1
						vCodArtCella = rs.GetString("CODICE")
						Button3.Text = ""
						Button4.Text = ""
						Button5.Text = ""
									
					Case 2
						F_ErroreInv=False
						vCorsiaArticolo = rs.GetString("CORSIA")
						vCodArtLotto = rs.GetString("CODICE")
						vDescrizioneArt = rs.GetString("DESCRIZIONE")						
						If(vCorsiaArticolo="") Then
							ExtraUtility.Play_Sound("error.wav")
							Msgbox2Async("L' articolo: " & vCodArtLotto & CRLF & vDescrizioneArt & CRLF & "non ha una CORSIA associata!", "Pocket ISA", "OK", "", "", Null, False)
							Panel3.Visible=False
							F_ErroreInv=True
						else if (vCorsiaArticolo<>vCorsia) And (vCorsia.SubString2(0,3)<>"MAG") Then
							vCodArtLotto = rs.GetString("CODICE")
							vDescrizioneArt = rs.GetString("DESCRIZIONE")
							ExtraUtility.Play_Sound("error.wav")
							Msgbox2Async("L' articolo: " & vCodArtLotto & CRLF & vDescrizioneArt & CRLF & "NON risulta in questa CORSIA!", "Pocket ISA", "OK", "", "", Null, False)
							Panel3.Visible=False
							F_ErroreInv=True
						Else
							vCodArtLotto = rs.GetString("CODICE")
							If(vCodArtCella<>vCodArtLotto) And (vCodArtCella<>"") Then
								ExtraUtility.Play_Sound("error.wav")
								Msgbox2Async("L'articolo del lotto non è corrispondente all'articolo in cella!" & CRLF & "Selezionare un nuovo lotto o una nuova cella!", "Pocket ISA", "OK", "", "", Null, False)
								Wait For MsgBox_Result (ResultDial As Int)
								If ResultDial = DialogResponse.POSITIVE Then
									Azzera_Panel3
									Panel3.Visible = False
									F_ErroreInv = True
								End If
							Else
								Panel4.Visible=False
								Panel3.Visible=True
								Button1.Enabled=False
								Label35.Text=vDescrizioneArt
								Label34.Text=vNumPos
								Label33.Text=vLotto
								UM1 =  rs.GetString("UMA")
								UM2 =  rs.GetString("UM")
								Button3.Text = UM1
								If (UM2="KG")  And (rs.GetString("FLAG_BILANCIA")="S") Then
									If (rs.GetString("UMV")="KG") Then
										UM2 =""
									Else
										UM2 = rs.GetString("UMV")
									End If
								End If
								Button4.Text = UM2
								If (rs.GetString("FLAG_BILANCIA")="S") Then
									Button5.Text = "KG"
									UM3 = "KG"
								Else
									Button5.Text = ""
									UM3 = ""
								End If
								If (Button3.Text = Button4.Text) Then
									Button4.Text = ""
								End If
								Button14.Tag="Pressed"
								Button14.TextColor=ExtraUtility.Color_DarkGreen
								Button14.Text=Button3.Text
								Button15.Text=Button4.Text
								Button16.Text=Button5.text
								If(PesoArt=0) Then
									Label36.Text=""
								End If								
								Label37.Text=Button14.Text
								Label38.Text=Button15.Text
								If(PesoArt=0) Then
									Label39.Text=""
								End If
								Label40.Text=Button16.text
								If (Button15.Text<>"") Then
									EditText8.Visible=True
								Else
									EditText8.Visible=False
								End If
								If (Button16.Text<>"") Then
									Label40.Visible=True
									Label42.Visible = True
									EditText9.Visible=True
								Else
									Label40.Visible=False
									Label42.Visible = False
									EditText9.Visible=False
								End If
							End If
						End If
									
				End Select
				If(vTipoLettura<=1) Then
					' la descrizone viene aggiornata solo dopo aver selezionato la cella
					Label3.Text = rs.GetString("DESCRIZIONE")
					If rs.GetInt("ESAURITO")<>0 Then
						Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
						F_ErroreInv = True
					End If
				End If
				' vCodArticolo = rs.GetString("CODICE")
				If ((vCodArtCella=vCodArtLotto) Or (vCorsiaUbicaz="N")) And (vLotto<>"") And(F_ErroreInv=False) Then
					' Inserisco i dati nella tabella
					If(vLottoOld<>vLotto) And (vLottoOld<>"") And (txt <>"") And (Panel3.Visible=True) Then
						Registra_Panel3("Hai selezionato un nuovo lotto vuoi registrare i seguenti dati?",Label34.text)
					Else
						Label33.Text = vLotto
					End If
					vNumPos = B4XTable1.Size+1
					'B4XTable1.sql1.ExecNonQuery2("INSERT INTO data (c0,c1,c2,c3) VALUES (?,?,?)", Array (1,"",vCodArt,Label3.text))
					'B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?)"$ , Array As Object(Pos, EditText4.Text, Label9.Text, EditText2.text, EditText1.text, EditText3.Text))
					Dim NRecs As Int = 0
					If(vCodArtCella<>"") Then
						NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=?"$, Array As String(vCodArtCella))
					Else
						NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=?"$, Array As String(vCodArtLotto))
					End If
					If(NRecs<2) Then
						If(vCodArtCella<>"") Then
							NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
						Else
							NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
						End If
					End If
					Select NRecs
						Case 0
							Dim MaxPriority As Int = Leggi_MaxPriorita_Data
							B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz))
							Label34.Text = vNumPos
							Label36.Text=" Tot."
							Label39.Text=""
							Label41.Text=""
							Label42.Text=""
						Case 1
							If(vCodArtCella<>"") Then
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
							Else
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
							End If
							If (NRecs=0) Then
								Dim MaxPriority As Int = Leggi_MaxPriorita_Data
								B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt ,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz))
								Label34.Text = vNumPos
								Label36.Text=" Tot."
								Label39.Text=""
								Label41.Text=""
								Label42.Text=""
							Else
								If(TotQtaUMX=0) Then
									If(vCodArtCella<>"") Then
										Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
									Else
										Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
									End If
									If (res.RowCount>0) Then
										Do While res.NextRow
											vDescrizioneArt=res.GetString("c2")
											UM1=res.GetString("c3")
											TotQtaUM1 = res.Getint("c4")
											UM2=res.GetString("c5")
											TotQtaUM2 = res.Getint("c6")
											UM3=res.GetString("c7")
											TotPesoArt=res.GetDouble("c8")
											TotQtaUMX=res.GetInt("c14")
											vLottoCompleto = res.GetString("c9")
											If( UM2<>"") Then
												Label36.Text= " Tot. " & TotQtaUMX & " " & UM2
											Else
												Label36.Text= " Tot. " & TotQtaUMX & " " & UM1
											End If
											Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
											If (Pos>0) Then
												Label33.Text=vLottoCompleto.SubString(Pos+3)
											Else
												Label33.Text=vLottoCompleto
											End If										
											Label34.text = res.Getstring("c0")
											Label35.Text = vDescrizioneArt
											Label39.Text = TotQtaUM1
											Label41.Text = TotQtaUM2
											Label42.text = TotPesoArt
											MaskedEditText1.Text = res.GetString("c10")
										Loop
									Else
										'vDescrizioneArt=res.GetString("c2")
										UM1=""
										TotQtaUM1 = 0
										UM2=""
										TotQtaUM2 = 0
										UM3=""
										TotPesoArt=0
										TotQtaUMX=0
										vLottoCompleto=""
										Label36.Text= " Tot. "
										Label33.Text = ""
										Label34.text = ""
										Label35.Text = ""
										Label39.Text = ""
										Label41.Text = ""
										Label42.text = ""
										MaskedEditText1.Text = ""
									End If
								End If
							End If
						Case 2
							NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
							If(vCodArtCella<>"") Then
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
							Else
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
							End If
							If (NRecs=0) Then
								Dim MaxPriority As Int = Leggi_MaxPriorita_Data
								B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt ,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0))
								Label34.Text = vNumPos
								Label36.Text=" Tot."
								Label39.Text=""
								Label41.Text=""
								Label42.Text=""
							Else
								If(TotQtaUMX=0) Then
									If(vCodArtCella<>"") Then
										Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
									Else
										Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
									End If
									If (res.RowCount>0) Then
										Do While res.NextRow
											vDescrizioneArt=res.GetString("c2")
											UM1=res.GetString("c3")
											TotQtaUM1 = res.Getint("c4")
											UM2=res.GetString("c5")
											TotQtaUM2 = res.Getint("c6")
											UM3=res.GetString("c7")
											TotPesoArt=res.GetDouble("c8")
											TotQtaUMX=res.GetInt("c14")
											vLottoCompleto = res.GetString("c9")
											If( UM2<>"") Then
												Label36.Text= " Tot. " & TotQtaUMX & " " & UM2
											Else
												Label36.Text= " Tot. " & TotQtaUMX & " " & UM1
											End If
											Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
											If (Pos>0) Then
												Label33.Text=vLottoCompleto.SubString(Pos+3)
											Else
												Label33.Text=vLottoCompleto
											End If												
											Label34.text = res.Getstring("c0")
											Label35.Text = vDescrizioneArt
											Label39.Text = TotQtaUM1
											Label41.Text = TotQtaUM2
											Label42.text = TotPesoArt
											MaskedEditText1.Text = res.GetString("c10")
										Loop
									Else
										'vDescrizioneArt=res.GetString("c2")
										UM1=""
										TotQtaUM1 = 0
										UM2=""
										TotQtaUM2 = 0
										UM3=""
										TotPesoArt=0
										TotQtaUMX=0
										vLottoCompleto=""
										Label36.Text= " Tot. "
										Label33.Text = ""
										Label34.text = ""
										Label35.Text = ""
										Label39.Text = ""
										Label41.Text = ""
										Label42.text = ""
										MaskedEditText1.Text = ""
									End If
								End If
							End If
					End Select
					If(vDescrizioneArt<>"") Then
						Label3.Text=vDescrizioneArt
					End If
					B4XTable1_DataUpdated
					B4XTable1.UpdateTableCounters
					Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
					column.InternalSortMode= "DESC"
					B4XTable1.Refresh
					vLottoOld=vLotto
				End If
			Loop
			rs.close
		Else
			Dim Result As List = Leggi_Barcode_Articolo(CodiceLettoInv)
			If(Result.Size=4) Then
				vCodArticolo = Result.Get(2)
				F_ErroreInv = Result.Get(3)
			else If(Result.Size=2) Then
				vCodArticolo = Result.Get(0)
				F_ErroreInv = Result.Get(1)
			Else if (Result.Size=1) Then
				vCodArticolo = ""
				F_ErroreInv = Result.Get(0)
			Else
				vCodArticolo=""
				F_ErroreInv = True
			End If
		End If
	End If
End Sub

Sub NewData_Spostamento(CodiceLettoSpo As String, F_ErroreSpo As Boolean) 	
'--------------------------------------
' SPOSTAMENTO
'--------------------------------------
Try
	Dim txtold As String = txt
	Dim F_OK As Int = 0
	Dim F_Stop As Boolean = False
	Dim Stringa As String = ""
	Dim NRecs As Int = 0
	If (TipoOperazione="SPO") Then							
		Dim vCorsiaArticolo As String =""				
		If (Panel4.Visible=True) And (vTipoReadGiac.Length=6) Then
			' VERIFICO SE LA LETTURA DEL CODICE E' UN LOTTO DOPO AVER LETTO ORIGINE e DESTINAZIONE
			If(vTipoReadGiac<>"MAGCEL") And (vTipoReadGiac<>"CORCOR") And (vTipoReadGiac<>"MAGCOR") And (CodiceLettoSpo.IndexOf("$NB")>0) And (CodiceLettoSpo.Length=14)  Then
				Panel4.Visible=False
				RegistraPanel3
				Label1.Text="SPOSTAMENTO DA "
				F_Stop = True
			End If
		End If						
		If(F_Stop=False) Then
				If(CodiceLettoSpo.Length<=7) And (CodiceLettoSpo.SubString2(0,3)="MAG") And (vTipoReadGiac.Length=3) Then			
					vTipoReadGiac = vTipoReadGiac & "MAG"
					vCodDepositoColl  = CodiceLettoSpo
					vCorsiaUbicazColl = ""
				End If
				If(CodiceLettoSpo.Length=5) And (CodiceLettoSpo.SubString2(0,2)="CS") And (vTipoReadGiac.Length<=3) Then
					If(vTipoReadGiac.Length=0) Then
						vCodDeposito = CodiceLettoSpo.SubString2(0,5)
						Label1.Text ="SPOSTAMENTO DA CORSIA " & vCodDeposito & " A CORSIA "
					Else
						vCodDepositoColl = CodiceLettoSpo.SubString2(0,5)
					End If
					vTipoReadGiac=vTipoReadGiac & "COR"			
					F_OK = 1
					vTipoLettura = 1
					Stringa = "T=4"
				Else
					Dim vResInv As List = Decodifica_Articolo_Spostamento(CodiceLettoSpo)
					If (vResInv.Size>0) Then
						F_OK = 1
						Stringa = vResInv.Get(0)
						If(vTipoReadGiac.Length<=3) And (Stringa ="T=1") Then
							' CASO CELLA
							vTipoReadGiac = vTipoReadGiac & "CEL"
							If(vTipoReadGiac.Length<=3) Then
								' DA CELLA
								vCodDeposito = CodiceLettoSpo.SubString2(0,5)
								vCorsiaUbicaz = CodiceLettoSpo.SubString(5)
								Label1.Text ="SPOSTAMENTO DA CELLA " & CodiceLettoSpo & " A "
							Else
								' DA CELLA A CELLA							
								vCodDepositoColl = CodiceLettoSpo.SubString2(0,5)
								vCorsiaUbicazColl = CodiceLettoSpo.SubString(5)
								If (vCodDeposito=vCodDepositoColl) And (vCorsiaUbicaz=vCorsiaUbicazColl) Then
									vCodDepositoColl = ""
									vCorsiaUbicazColl = ""
									vTipoReadGiac = vTipoReadGiac.SubString2(0,3)
								End If
							End If
						End If				
					End If
				End If				
				If(vTipoReadGiac.Length=6) Then
						Select vTipoReadGiac
							Case "MAGCOR"
								Label1.Text = "SPOSTAMENTO DA MAG. " & vCodDeposito & " A CORSIA " & vCodDepositoColl
																		
							Case "MAGCEL"
								Label1.Text = "SPOSTAMENTO DA MAG. " & vCodDeposito & " A CELLA " & vCodDepositoColl & vCorsiaUbicazColl
																			
							Case "CORCOR"
								Label1.Text = "SPOSTAMENTO DA CORSIA " & vCodDeposito & " A CORSIA " & vCodDepositoColl
										
							Case "CELCOR"
								Label1.Text = "SPOSTAMENTO DA CELLA " & vCodDeposito & vCorsiaUbicaz & " A CORSIA " & vCodDepositoColl
					
							Case "CORMAG"
								Label1.Text = "SPOSTAMENTO DA CORSIA " & vCodDeposito & " A MAGAZZINO " & vCodDepositoColl
					
							Case "CELCEL"
								Label1.Text = "SPOSTAMENTO DA CELLA " & vCodDeposito & vCorsiaUbicaz & " A CELLA " & vCodDepositoColl & vCorsiaUbicazColl
							
							Case "CELMAG"
								Label1.Text = "SPOSTAMENTO DA CELLA " & vCodDeposito & vCorsiaUbicaz & " A MAGAZZINO " & vCodDepositoColl
														
						End Select
				End If
			' Cerco l'articolo x cella e corsia
			If (F_OK=1) Then		
				Select Stringa
					Case "T=1"
						' caso lettura cella
						If(Panel3.Visible=True) Then
							Registra_Panel3("Hai selezionato una nuova cella vuoi registrare i seguenti dati?",Label34.Text)
						End If
						vTipoLettura = 1			
						vLottoCompleto = ""
						vLottoCompletoOld = ""
						vLotto = ""
						TotQtaUM1=0
						TotQtaUM2=0
						TotQtaUMX=0
						EditText7.Text=""
						EditText8.Text=""
						EditText9.Text=""
						Label39.Text=""
						Label41.Text=""
						Label42.Text=""
						Label36.Text=" Tot."
						Dim CorsiaEti As String = CodiceLettoSpo.SubString2(0,5)
						Dim UbicazioneEti As String = CodiceLettoSpo.SubString(5)			
						If(vTipoReadGiac<>"") Then
							Select vTipoReadGiac
								Case "MAGCOR"
								'	vCorsiaUbicazColl = CorsiaEti
									vCodArtCella = ""
									vCodArtLotto = ""
																	
								Case "MAGCEL"
									vCodArtCella = ""
									vCodArtLotto = ""
																		
								Case "CORCOR"									
									
								Case "CELCOR"
				
								Case "CORMAG"
				
								Case "CELCEL"
										
							End Select
						End If
						sqlstr = "SELECT CORSIA,CODICE,DESCRIZIONE,UMV,UMA,UM,ESAURITO,FLAG_BILANCIA from IS_ANAGRAFICAARTICOLI " _
								& " WHERE UBICAZIONE = '" & UbicazioneEti & "' AND CORSIA = '" & CorsiaEti & "'"																		
		
					Case "T=2"
						' caso lettura lotto
						vTipoLettura = 2
						If(vCorsiaUbicaz="N") Then
							vCodArtCella = ""
						End If
						vLottoCompleto=CodiceLettoSpo
						Select vResInv.Size
							Case 1
								vLotto = vResInv.Get(1)
							Case 2
								vLotto = vResInv.Get(1)
								vCodArtLotto = vResInv.get(2)
							Case 3
								vLotto = vResInv.Get(1)
								vCodArtLotto = vResInv.get(2)
							Case 4 ' caso EAN128
								vLotto = vResInv.Get(1)
								vCodArtLotto = vResInv.get(2)
								vLottoCompleto = vResInv.Get(3)
							Case Else
								vCodArtLotto=""
								F_ErroreSpo=True
						End Select
						Dim vLen As Int = 7-vCodArtLotto.Length
						vCodArtLotto = "00000000".SubString2(0,vLen) & vCodArtLotto
						sqlstr = "SELECT CORSIA,CODICE,DESCRIZIONE,UMV,UMA,UM,ESAURITO,FLAG_BILANCIA from IS_ANAGRAFICAARTICOLI " _
												& " WHERE BARCODE = '" & vCodArtLotto & "'" ' And (CORSIA ='" & vCorsia & "' OR IFNULL(CORSIA,'') ='')" 	
						TotQtaUM1 = 0
						TotQtaUM2 = 0
						TotQtaUMX = 0
						TotPesoArt = 0
						TotPesoArt = 0
						Label42.Text = TotPesoArt
						Button14.TextColor = ExtraUtility.Color_DarkGreen
						Button15.TextColor = xui.Color_Gray
						Button14.Tag="Pressed"
						Button15.Tag=""									
		
					Case "T=4"
						' caso lettura corsia senza cella	
						If (vTipoReadGiac.SubString2(0,3)<>"COR") And (vTipoReadGiac.SubString2(0,3)<>"CEL")  Then
							vCorsiaUbicaz=""
							vCodArtCella=""
							vCodArticolo=""
							vCodArtLotto=""
						End If
						vLottoCompleto = ""
						vLottoCompletoOld = ""
						vCorsiaUbicazColl = CorsiaEti
						vTipoLettura = 4
												
					Case Else
						' lettura altri codici
						If(vTipoLettura>=2) Then
							' caso lettura
							vTipoLettura = 3 ' caso lettura barcode articolo
							Dim Result As List = Leggi_Barcode_Articolo(CodiceLettoSpo)
							If(Result.Size=4) Then
								vCodArticolo = Result.Get(2)
								F_ErroreSpo = Result.Get(3)
							Else If(Result.Size=2) Then
								vCodArticolo = Result.Get(0)
								F_ErroreSpo = Result.Get(1)
							Else if (Result.Size=1) Then
								vCodArticolo = ""
								F_ErroreSpo = Result.Get(0)
							Else
								vCodArticolo=""
								F_ErroreSpo = True
							End If
						Else
							If (CodiceLettoSpo.IndexOf("MAG")=-1) Then
								vCodArticolo=""
								F_ErroreSpo = True							
								ExtraUtility.Play_Sound("error.wav")
								Msgbox2Async("Devi prima selezionare il lotto e poi l'articolo presente in cella!", "Pocket ISA", "OK", "", "", Null, False)
							End If
						End If																																						
				End Select
			End If
			If (Panel3.Visible) And (vTipoLettura=3) And ((vCodArtLotto=vCodArticolo) Or (vCodArtCella=vCodArticolo) Or (vCorsiaUbicaz="N")) Then
				Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
				If(PesoArt>0) Then
					TotPesoArt = Round2(TotPesoArt + PesoArt,3)
				End If
				If(vCodArtCella<>"") Then
					If (Button14.Tag="Pressed") Then
						txt =  DataOra & " - " & CodiceLettoSpo & " + 1 " & UM1 & "  -  Kg " & PesoArt & CRLF & txt
						TotQtaUM1 = TotQtaUM1 + 1
						If (Button15.Text<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = TotQtaUM1
						End If
						Label39.Text = TotQtaUM1
					End If
					If (Button15.Tag="Pressed") Then
						txt =  DataOra & " - " & CodiceLettoSpo & " + 1 " & UM2 & "  -  Kg " & PesoArt & CRLF & txt
						TotQtaUM2 = TotQtaUM2 + 1
						If (Button15.Text<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = TotQtaUM1
						End If
						Label41.Text = TotQtaUM2
					End If
				Else
					If (Button14.Tag="Pressed") Then
						txt =  DataOra & " - " & CodiceLettoSpo & " + 1 " & UM1 & CRLF & txt
						TotQtaUM1 = TotQtaUM1 + 1
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
						Label39.Text = TotQtaUM1
					End If
					If (Button15.Tag="Pressed") Then
						txt =  DataOra & " - " & CodiceLettoSpo & " + 1 " & UM2 & CRLF & txt
						TotQtaUM2 = TotQtaUM2 + 1
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)+TotQtaUM2
						Label41.Text = TotQtaUM2
					End If
				End If
				Label42.Text = TotPesoArt
				If( Button15.Text<>"") Then
					Label36.Text=" Tot. " & TotQtaUMX & " " & UM2
				Else
					Label36.Text=" Tot. " & TotQtaUMX & " " & UM1
				End If
				If(Button15.Text="") Then
					EditText8.Visible=False
				Else
					EditText8.Visible=True
				End If
				If(Button16.Text="") Then
					EditText9.Visible = False
				Else
					EditText9.Visible = True
				End If
				' Aumenta valore 1
				If(Button16.Text<>"") Then
					EditText9.Visible = True
				Else
					EditText9.Visible = False
				End If
				ScrollView1.FullScroll(False)
				If (Button16.Text<>"") Then
					Label42.Visible = True
				Else
					Label42.Visible = False
				End If
				If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3)And (vMaxQtaUM3<>0))  Then
					txt = txtold
					If(PesoArt>0) Then
						TotPesoArt = Round2(TotPesoArt - PesoArt,3)
						If (Button14.Tag="Pressed") Then							
							TotQtaUM1 = TotQtaUM1 - 1
							If (Button15.Text<>"") Then
								TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)-TotQtaUM2
							Else
								TotQtaUMX = TotQtaUM1
							End If
							Label39.Text = TotQtaUM1
						End If
						If (Button15.Tag="Pressed") Then
							TotQtaUM2 = TotQtaUM2 - 1
							If (Button15.Text<>"") Then
								TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,Button14.Text,TotQtaUM1)-TotQtaUM2
							Else
								TotQtaUMX = TotQtaUM1
							End If
							Label41.Text = TotQtaUM2
						End If
					Else
						If (Button14.Tag="Pressed") Then
							TotQtaUM1 = TotQtaUM1 - 1
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)-TotQtaUM2
							Label39.Text = TotQtaUM1
						End If
						If (Button15.Tag="Pressed") Then
							TotQtaUM2 = TotQtaUM2 - 1
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,Button14.Text,TotQtaUM1)-TotQtaUM2
							Label41.Text = TotQtaUM2
						End If
					End If
					Label42.Text = TotPesoArt
					If( Button15.Text<>"") Then
						Label36.Text=" Tot. " & TotQtaUMX & " " & UM2
					Else
						Label36.Text=" Tot. " & TotQtaUMX & " " & UM1
					End If
					ExtraUtility.Play_Sound("error.wav")
					If(vMaxQtaUM3<>0) Then
						MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM3 & " " & UM3 & "!","CONTROLLO ORDINE")
					Else
						MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM2 & " " & UM2 & "!","CONTROLLO ORDINE")
					End If
				Else					
					UpdateTape
				End If
			End If
			F_OK = 0
			If(vTipoLettura<>4) Then ' verifico che non sia solo la corsia
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				If (rs.RowCount>0) Then
					F_OK=1
				End If		
			End If				
			If (F_OK = 1) Then
				Do While rs.NextRow
					Select vTipoLettura
						Case 1
							vCodArtCella = rs.GetString("CODICE")
							Button3.Text = ""
							Button4.Text = ""
							Button5.Text = ""
							vCorsiaArticolo=CodiceLettoSpo	
							'vTipoReadGiac="MAGCEL"
							'Leggi_GiacenzeLotti(vCodArtCella,vCorsiaArticolo,vCodDeposito,"MAGCEL")
																
						Case 2
							F_ErroreSpo=False
							vCorsiaArticolo = rs.GetString("CORSIA")
							vCodArtLotto = rs.GetString("CODICE")
							vDescrizioneArt = rs.GetString("DESCRIZIONE")
							Label3.Text=vDescrizioneArt
							If(vCorsiaArticolo="") Then
								ExtraUtility.Play_Sound("error.wav")
								Msgbox2Async("L' articolo: " & vCodArtLotto & CRLF & vDescrizioneArt & CRLF & "non ha una CORSIA associata!", "Pocket ISA", "OK", "", "", Null, False)
								Panel3.Visible=False
								F_ErroreSpo=True

							else if (vCorsiaArticolo<>vCorsia) And ((vCorsia<>"TUTTE") And (vCorsia<>"")) Then
								vCodArtLotto = rs.GetString("CODICE")
								vDescrizioneArt = rs.GetString("DESCRIZIONE")
								ExtraUtility.Play_Sound("error.wav")
								Msgbox2Async("L' articolo: " & vCodArtLotto & CRLF & vDescrizioneArt & CRLF & "NON risulta in questa CORSIA!", "Pocket ISA", "OK", "", "", Null, False)
								Panel3.Visible=False
								F_ErroreSpo=True
							Else
								vCodArtLotto = rs.GetString("CODICE")
								If(vCodArtCella<>vCodArtLotto) And (vCodArtCella<>"") Then
									ExtraUtility.Play_Sound("error.wav")
									Msgbox2Async("L'articolo del lotto non è corrispondente all'articolo in cella!" & CRLF & "Selezionare un nuovo lotto o una nuova cella!", "Pocket ISA", "OK", "", "", Null, False)
									Wait For MsgBox_Result (ResultDial As Int)
									If ResultDial = DialogResponse.POSITIVE Then
										Azzera_Panel3
										Panel3.Visible=False
										F_ErroreSpo=True
									End If
								Else
									Dim PosLotto As Int = FindItemInLottoGiac(LottiGiacOrig,vLottoCompleto)
									Dim ObjLotto As LottoGiacenzeType 
									ObjLotto = FindObjLottoGiac(LottiGiacOrig,PosLotto)								
									If(PosLotto=-1) And (vLottoCompletoOld<>"") And (LottiGiacOrig.Size>0) Then
										ExtraUtility.Play_Sound("error.wav")
										Msgbox2Async("Lotto inesistente o con giacenza errata!", "Pocket ISA", "OK", "", "", Null, False)
									End If
									If(PosLotto>=0) And (vLottoCompletoOld<>"") And (LeggiQta(ObjLotto.Giac2,Chr(32))=0)  Then
										ExtraUtility.Play_Sound("error.wav")
										Msgbox2Async("Lotto con giacenza errata!", "Pocket ISA", "OK", "", "", Null, False)
										PosLotto=-1
									End If
									vLottoCompletoOld = vLottoCompleto
									If (PosLotto>=0) Then   ' And (Panel4.Visible=True)										
										Panel4.Visible=False																
										If( vTipoReadGiac="MAGCEL") Or (vTipoReadGiac="MAGCOR") Then
											Panel3.Visible=True
										End If
										Button1.Enabled=False
										Label35.Text=vDescrizioneArt
										Label34.Text=vNumPos
										Label33.Text=vLotto
										UM1 =  rs.GetString("UMA")
										UM2 =  rs.GetString("UM")
										Button3.Text = UM1
										If (UM2="KG")  And (rs.GetString("FLAG_BILANCIA")="S") Then
											If (rs.GetString("UMV")="KG") Then
												UM2 = ""
											Else
												UM2 = rs.GetString("UMV")
											End If
										End If
										Button4.Text = UM2
										If (rs.GetString("FLAG_BILANCIA")="S") Then
											Button5.Text = "KG"
											UM3 = "KG"
										Else
											Button5.Text = ""
											UM3 = ""
										End If
										If(UM3="KG") Then
											vMaxQtaUM2 = 0
											vMaxQtaUM3 = LeggiQta(ObjLotto.GiacPeso,Chr(32))											
										Else
											vMaxQtaUM2 = LeggiQta(ObjLotto.Giac1,Chr(32))
											vMaxQtaUM3 = 0
										End If
										Label65.Text = vMaxQtaUM2
										If (Button3.Text = Button4.Text) Then
											Button4.Text = ""
										End If
										Button14.Tag="Pressed"
										Button14.TextColor=ExtraUtility.Color_DarkGreen
										Button14.Text=Button3.Text
										Button15.Text=Button4.Text
										Button16.Text=Button5.text
										Label36.Text=""
										Label37.Text=Button14.Text
										Label38.Text=Button15.Text
										Label39.Text=""
										Label40.Text=Button16.text
										If (Button15.Text<>"") Then
											EditText8.Visible=True
										Else
											EditText8.Visible=False
										End If
										If (Button16.Text<>"") Then
											Label40.Visible=True
											Label42.Visible = True
											EditText9.Visible=True
										Else
											Label40.Visible=False
											Label42.Visible = False
											EditText9.Visible=False
										End If	
										If(vCodArtCella<>"") Then
											NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
										Else
											NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
										End If
										If (NRecs=0) Then
											If(vCodArtCella<>"") Then
												NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c4>0 and c9<>?"$, Array As String(vCodArtCella,vLottoCompleto))
											Else
												NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c4>0 and c9<>?"$, Array As String(vCodArtLotto,vLottoCompleto))
											End If
											If (NRecs=2) Then
												ExtraUtility.Play_Sound("error.wav")
												Msgbox2Async("Lotto non inseribile, '" & vLottoCompleto & "' hai già inserito due lotti su questa cella!", "Pocket ISA", "OK", "", "", Null, False)
												Wait For MsgBox_Result (ResultDial As Int)
												If ResultDial = DialogResponse.POSITIVE Then
													Azzera_Panel3
													Panel3.Visible=False
													Button1.Enabled=True
												End If
											Else
												' Simone 23-04-2021
												' ToastMessageShow("INSERIRE RIGO",True)
												Select Case vTipoReadGiac
													Case "CORCOR"
														vCorsiaUbicaz=vCodDeposito
														vCorsiaUbicazColl=vCodDepositoColl
														
													
												End Select																
												vNumPos = B4XTable1.Size+1
												Dim MaxPriority As Int = Leggi_MaxPriorita_Data
												B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella,vTipoReadGiac))
												Label34.Text = vNumPos
												Label36.Text=" Tot."
												Label39.Text=""
												Label41.Text=""
												Label42.Text=""											
												B4XTable1_DataUpdated
												B4XTable1.UpdateTableCounters
												Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
												column.InternalSortMode= "DESC"
												B4XTable1.Refresh
												' vLottoOld=vLotto
											End If
										End If
										If (NRecs=1) Then	
											If(vCodArtCella<>"") Then
												Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
											Else
												Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
											End If								
											If (res.RowCount>0) Then
												Do While res.NextRow
													vDescrizioneArt=res.GetString("c2")
													UM1=res.GetString("c3")
													TotQtaUM1 = res.Getint("c4")
													UM2=res.GetString("c5")
													TotQtaUM2 = res.Getint("c6")
													UM3=res.GetString("c7")
													TotPesoArt=res.GetDouble("c8")
													TotQtaUMX=res.Getdouble("c14")
													vLottoCompleto=res.GetString("c9")
													If( UM2<>"") Then
														Label36.Text= " Tot. " & TotQtaUMX & " " & UM2
													Else
														Label36.Text= " Tot. " & TotQtaUMX & " " & UM1
													End If
													Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
													If (Pos>0) Then
														Label33.Text=vLottoCompleto.SubString(Pos+3)
													Else
														Label33.Text=vLottoCompleto
													End If
													Label34.text = res.Getstring("c0")
													Label35.Text = vDescrizioneArt
													Label39.Text = TotQtaUM1
													Label41.Text = TotQtaUM2
													Label42.text = TotPesoArt
													MaskedEditText1.Text = res.GetString("c10")
												Loop
											End If
											B4XTable1_DataUpdated
											B4XTable1.UpdateTableCounters
											Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
											column.InternalSortMode= "DESC"
											B4XTable1.Refresh
										End If
																			
									Else
										' 28-04-2021

										If(vCodDepositoColl<>"") Then																																				
											If (vTipoReadGiac="CORCOR") Or (vTipoReadGiac="CORMAG") Then
												If(vCorsiaArticolo<>vCodDeposito) Then  
													ExtraUtility.Play_Sound("error.wav")
													Msgbox2Async("La corsia non è coerente con il lotto inserito!", "Pocket ISA", "OK", "", "", Null, False)
												End If
											Else
												If(vCorsiaArticolo<>vCodDepositoColl) Then
													ExtraUtility.Play_Sound("error.wav")
													Msgbox2Async("La corsia non è coerente con il lotto inserito!", "Pocket ISA", "OK", "", "", Null, False)
												End If											
											End If																		
										Else
											If(LottiGiacOrig.Size>0) Then
												ExtraUtility.Play_Sound("error.wav")
												Msgbox2Async("Il lotto non è corrispondente a quelli disponibli!" & CRLF & "Selezionare un nuovo lotto o una nuova cella!", "Pocket ISA", "OK", "", "", Null, False)
											End If
										End If
									End If
								End If
							End If
										
					End Select
					If(vTipoLettura<=1) Then
						' la descrizone viene aggiornata solo dopo aver selezionato la cella
						Label3.Text = rs.GetString("DESCRIZIONE")
						If rs.GetInt("ESAURITO")<>0 Then
							Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
							F_ErroreSpo = True
						End If
					End If
					If ((vCodArtCella=vCodArtLotto) Or (vCorsiaUbicaz="N")) And (vLotto<>"") And(F_ErroreSpo=False) Then
						' Inserisco i dati nella tabella
						If(vLottoOld<>vLotto) And (vLottoOld<>"") And (txt <>"") And (Panel3.Visible=True) Then
							Registra_Panel3("Hai selezionato un nuovo lotto vuoi registrare i seguenti dati?",Label34.text)
						Else
							Dim Pos As Int = vLotto.IndexOf("$NB")
							If (Pos>0) Then
								Label33.Text=vLotto.SubString(Pos+3)
							Else
								Label33.Text=vLotto
							End If						
						End If
						vNumPos = B4XTable1.Size+1
						Dim NRecs As Int = 0
						If(vCodArtCella<>"") Then
							NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=?"$, Array As String(vCodArtCella))
						Else
							NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=?"$, Array As String(vCodArtLotto))
						End If
						If(NRecs<2) Then
							If(vCodArtCella<>"") Then
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
							Else
								NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
							End If
						End If
						Select NRecs
							Case 0
								If(LottiGiacDest.Size<2) Then
									Dim MaxPriority As Int = Leggi_MaxPriorita_Data
									B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella))
									Label34.Text = vNumPos
									Label36.Text=" Tot."
									Label39.Text=""
									Label41.Text=""
									Label42.Text=""
								Else
									Dim PosLottoD As Int = FindItemInLottoGiac(LottiGiacDest,vLottoCompleto)
									If(PosLottoD>=0) Then
										Dim MaxPriority As Int = Leggi_MaxPriorita_Data
										B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella))
										Label34.Text = vNumPos
										Label36.Text=" Tot."
										Label39.Text=""
										Label41.Text=""
										Label42.Text=""	
									Else
										ExtraUtility.Play_Sound("error.wav")
										Msgbox2Async("Lotto non inseribile, '" & vLottoCompleto & "' hai già inserito due lotti su questa cella!", "Pocket ISA", "OK", "", "", Null, False)
										Wait For MsgBox_Result (ResultDial As Int)
										If ResultDial = DialogResponse.POSITIVE Then
											Azzera_Panel3
											Panel3.Visible=False
											Button1.Enabled=True
										End If
									End If								
								End If							

							Case 1
								If(vCodArtCella<>"") Then
									NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
								Else
									NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
								End If
								If (NRecs=0) Then
									Dim MaxPriority As Int = Leggi_MaxPriorita_Data
									B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt ,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,vCorsiaUbicaz))
									Label34.Text = vNumPos
									Label36.Text=" Tot."
									Label39.Text=""
									Label41.Text=""
									Label42.Text=""
								Else
									If(TotQtaUMX=0) Then
										If(vCodArtCella<>"") Then
											Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
										Else
											Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
										End If
										If (res.RowCount>0) Then
											Do While res.NextRow
												vDescrizioneArt=res.GetString("c2")
												UM1=res.GetString("c3")
												TotQtaUM1 = res.Getint("c4")
												UM2=res.GetString("c5")
												TotQtaUM2 = res.Getint("c6")
												UM3=res.GetString("c7")
												TotPesoArt=res.GetDouble("c8")
												TotQtaUMX=res.GetInt("c14")
												vLottoCompleto=res.GetString("c9")
												If( UM2<>"") Then
													Label36.Text= " Tot. " & TotQtaUMX & " " & UM2
												Else										
													Label36.Text= " Tot. " & TotQtaUMX & " " & UM1
												End If
												Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
												If (Pos>0) Then
													Label33.Text=vLottoCompleto.SubString(Pos+3)
												Else
													Label33.Text=vLottoCompleto
												End If
												Label34.text = res.Getstring("c0")
												Label35.Text = vDescrizioneArt
												Label39.Text = TotQtaUM1
												Label41.Text = TotQtaUM2
												Label42.text = TotPesoArt
												MaskedEditText1.Text = res.GetString("c10")
											Loop
										Else
											'vDescrizioneArt=res.GetString("c2")
											UM1=""
											TotQtaUM1 = 0
											UM2=""
											TotQtaUM2 = 0
											UM3=""
											TotPesoArt=0
											TotQtaUMX=0
											vLottoCompleto=""
											Label36.Text= " Tot. "
											Label33.Text = ""
											Label34.text = ""
											Label35.Text = ""
											Label39.Text = ""
											Label41.Text = ""
											Label42.text = ""
											MaskedEditText1.Text = ""
										End If
									End If
								End If
								
							Case 2
									Button3.TextSize = 16
									If(vCodArtCella<>"") Then
										NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
									Else
										NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
									End If
									If (NRecs=0) Then
										Dim MaxPriority As Int = Leggi_MaxPriorita_Data
										B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(vNumPos,vCodArtLotto,vDescrizioneArt ,UM1,"",UM2,"",UM3,"",vLottoCompleto,"","P",MaxPriority,0,0,0,"",""))
										Label34.Text = vNumPos
										Label36.Text=" Tot."
										Label39.Text=""
										Label41.Text=""
										Label42.Text=""
									Else
										If(TotQtaUMX=0) Then
											If(vCodArtCella<>"") Then
												Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18 from data where c1=? and c9=?"$, Array As String(vCodArtCella,vLottoCompleto))
											Else
												Dim res  As ResultSet = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18 from data where c1=? and c9=?"$, Array As String(vCodArtLotto,vLottoCompleto))
											End If
											If (res.RowCount>0) Then
												Do While res.NextRow
													vDescrizioneArt=res.GetString("c2")
													UM1=res.GetString("c3")
													TotQtaUM1 = res.Getint("c4")
													UM2=res.GetString("c5")
													TotQtaUM2 = res.Getint("c6")
													UM3=res.GetString("c7")
													TotPesoArt=res.GetDouble("c8")
													TotQtaUMX=res.GetInt("c14")
													vLottoCompleto= res.GetString("c9")
													If( UM2<>"") Then
														Label36.Text= " Tot. " & TotQtaUMX & " " & UM2
													Else
														Label36.Text= " Tot. " & TotQtaUMX & " " & UM1
													End If												
													Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
													If (Pos>0) Then
														Label33.Text=vLottoCompleto.SubString(Pos+3)
													Else
														Label33.Text=vLottoCompleto
													End If
													Label34.text = res.Getstring("c0")
													Label35.Text = vDescrizioneArt
													Label39.Text = TotQtaUM1
													Label41.Text = TotQtaUM2
													Label42.text = TotPesoArt
													MaskedEditText1.Text = res.GetString("c10")
												Loop
											Else
												'vDescrizioneArt=res.GetString("c2")
												UM1=""
												TotQtaUM1 = 0
												UM2=""
												TotQtaUM2 = 0
												UM3=""
												TotPesoArt=0
												TotQtaUMX=0
												vLottoCompleto = ""
												Label36.Text= " Tot. "
												Label33.Text = ""
												Label34.text = ""
												Label35.Text = ""
												Label39.Text = ""
												Label41.Text = ""
												Label42.text = ""
												MaskedEditText1.Text = ""
											End If
										End If
									End If
								'End If
						End Select
						If(vDescrizioneArt<>"") Then
							Label3.Text=vDescrizioneArt
						End If
						B4XTable1_DataUpdated
						B4XTable1.UpdateTableCounters
						Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
						column.InternalSortMode= "DESC"
						B4XTable1.Refresh
						vLottoOld=vLotto
					End If
				Loop
				rs.close
			Else
				If(vTipoLettura<>4) Then
					Dim Result As List = Leggi_Barcode_Articolo(CodiceLettoSpo)
					If(Result.Size=4) Then
						vCodArticolo = Result.Get(2)
						F_ErroreSpo = Result.Get(3)
					else If(Result.Size=2) Then
						vCodArticolo = Result.Get(0)
						F_ErroreSpo = Result.Get(1)
					Else if (Result.Size=1) Then
						vCodArticolo = ""
						F_ErroreSpo = Result.Get(0)
					Else
						vCodArticolo=""
						F_ErroreSpo = True
					End If
				Else
					' Caso solo Corsia
					If(vCorsiaOrig <> "") Then
						vCorsiaDest = vCodDepositoColl
						'Label1.Text="SPOSTAMENTO DA CORSIA: " & vCorsiaOrig & " A CORSIA: " & vCorsiaDest
						Button3.TextSize = 36
						Button3.Typeface = Typeface.FONTAWESOME
						Button3.Text = Chr(0xF1F8)
					Else					
						vCorsiaOrig = vCodDepositoColl
						'Label1.Text="SPOSTAMENTO Da CORSIA: " & vCodDepositoColl					
					End If				
				End If
			End If
		'	If(Panel3.Visible=True) Then
		'		If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM3=0)) Or ((TotQtaUMX>vMaxQtaUM3) And (vMaxQtaUM3>0)) Then
		'			ExtraUtility.Play_Sound("error.wav")
		'			Msgbox2Async("Hai superato la qtà massima del lotto selezionato!", "Pocket ISA", "OK", "", "", Null, False)
		'			Button11.Enabled=False
		'		Else
		'			Button11.Enabled=True
		'		End If			
		'	End If
			If(vTipoReadGiac<>"") And (Panel3.Visible=False) Then
					Select vTipoReadGiac
						Case "MAGCOR"
							Leggi_GiacenzeLotti(vCodArtLotto,vCodDeposito,vCodDepositoColl,vTipoReadGiac)
							
						Case "MAGCEL"
							Leggi_GiacenzeLotti(vCodArtCella,vCodDeposito,vCodDepositoColl&vCorsiaUbicazColl,vTipoReadGiac)
					
						Case "CELCOR"
							vCorsiaOrig = vCodDeposito & vCorsiaUbicaz
							vCorsiaDest = vCodDepositoColl 
							If(vCorsiaOrig<>"") And (vCorsiaDest<>"") Then
								Leggi_GiacenzeLotti(vCodArtCella,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
							
						Case "CORCEL"
							vCorsiaOrig = vCodDeposito
							vCorsiaDest = vCodDepositoColl & vCorsiaUbicazColl
							If(vCorsiaOrig<>"") And (vCorsiaDest<>"") Then
								Leggi_GiacenzeLotti(vCodArtLotto,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
							
						Case "CELCEL"
							vCorsiaOrig = vCodDeposito & vCorsiaUbicaz
							vCorsiaDest = vCodDepositoColl & vCorsiaUbicazColl					
							If(vCorsiaOrig<>"") And (vCorsiaDest<>"") Then
								Leggi_GiacenzeLotti(vCodArtCella,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
												
						Case "CORCOR"
							vCorsiaOrig = vCodDeposito
							vCorsiaDest = vCodDepositoColl
							If(vCodDeposito<>"") And (vCodDepositoColl<>"") Then
								Leggi_GiacenzeLotti(vCodArtLotto,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
							
						Case "CELMAG"
							vCorsiaOrig = vCodDeposito & vCorsiaUbicaz
							vCorsiaDest = vCodDepositoColl 
							If(vCodDeposito<>"") And (vCodDepositoColl<>"") Then
								Leggi_GiacenzeLotti(vCodArtCella,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
							
						Case "CORMAG"
							vCorsiaOrig = vCodDeposito 
							vCorsiaDest = vCodDepositoColl
							If(vCodDeposito<>"") And (vCodDepositoColl<>"") And (vCodArtLotto<>"") Then
								Leggi_GiacenzeLotti(vCodArtLotto,vCorsiaOrig,vCorsiaDest,vTipoReadGiac)
							End If
												
					End Select
			End If
		End If
	End If
Catch
	Log(LastException)	
End Try
End Sub

Sub FindObjLottoGiac(LGI As List, Idx As Int) As LottoGiacenzeType
	Try
		Dim obj As LottoGiacenzeType
		obj.Initialize
		If (LGI.Size>0) And (LGI.Size>=Idx) Then
			obj = LGI.Get(Idx)		
		End If
		Return obj
	Catch
		Return Null
		Log(LastException)
	End Try
End Sub

Sub FindItemInLottoGiac(LGI As List,Find As String) As Int
	Try
		Dim lx As LottoGiacenzeType
		For i=0 To LGI.Size-1
			lx =LGI.Get(i)
			If lx.lotto=Find Then
				Return i
			End If
		Next	
		Return -1
	Catch
		Return Null
		Log(LastException)
	End Try
End Sub

Sub Registra_Panel3(msg As String,npos As Int)
	If(msg.Trim<>"") Then
		ExtraUtility.Play_Sound("error.wav")
		Msgbox2Async(msg, "Pocket ISA", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (ResultDial As Int)
		If ResultDial = DialogResponse.POSITIVE Then
			' Activity.Finish
			' registrare
			Dim Pos As Int = vLotto.IndexOf("$NB")
			If (Pos>0) Then
				Label33.Text= vLotto.SubString(Pos+3)
			Else
				Label33.Text=vLotto
			End If
			Azzera_Panel3
			Panel3.Visible=False
			If(Label42.Visible=False) Then
				Label40.Text=""
				Label42.Text=""
			End If
			vFattoreConv  = Leggi_FattoreC(SQLDataAccess,vCodArtLotto,UM1)
			vQtaTotUMAConv = Round2(vFattoreConv*TotQtaUMX,4)
			If (TipoOperazione="SPO") Then
				vCorsiaUbicaz = EditText10.text
				vCorsiaUbicazColl = EditText6.Text
				B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c3=?,c4=?,c5=?,c6=?,c7=?,c8=?,c14=?,c13=?,c15=?,c16=?,c17=?,c18=? WHERE c0=?"$, Array As Object(Label37.Text,Label39.Text,Label38.Text,Label41.Text,Label40.Text,TotPesoArt,TotQtaUMX,vQtaTotUMAConv,vFattoreConv,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella,npos))
			Else
				B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c3=?,c4=?,c5=?,c6=?,c7=?,c8=?,c14=?,c13=?,c15=? WHERE c0=?"$, Array As Object(Label37.Text,Label39.Text,Label38.Text,Label41.Text,Label40.Text,TotPesoArt,TotQtaUMX,vQtaTotUMAConv,vFattoreConv,npos))
			End If
			B4XTable1_DataUpdated
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
		Else
			Dim Pos As Int = vLotto.IndexOf("$NB")
			If (Pos>0) Then
				Label33.Text=vLotto.SubString(Pos+3)
			Else
				Label33.Text=vLotto
			End If			
			Azzera_Panel3
		End If
	Else
		If(Label42.Visible=False) Then
			Label40.Text=""
			Label42.Text=""
		End If		
		vFattoreConv  = Leggi_FattoreC(SQLDataAccess,vCodArtLotto,UM1)
		vQtaTotUMAConv = Round2(vFattoreConv*TotQtaUMX,4)
		If (TipoOperazione="SPO") Then
			vCorsiaUbicaz = EditText10.text
			vCorsiaUbicazColl = EditText6.Text
			B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c3=?,c4=?,c5=?,c6=?,c7=?,c8=?,c14=?,c13=?,c15=?,c16=?,c17=?,c18=? WHERE c0=?"$, Array As Object(Label37.Text,Label39.Text,Label38.Text,Label41.Text,Label40.Text,TotPesoArt,TotQtaUMX,vQtaTotUMAConv,vFattoreConv,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella,npos))
		Else
			B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c3=?,c4=?,c5=?,c6=?,c7=?,c8=?,c14=?,c13=?,c15=? WHERE c0=?"$, Array As Object(Label37.Text,Label39.Text,Label38.Text,Label41.Text,Label40.Text,TotPesoArt,TotQtaUMX,vQtaTotUMAConv,vFattoreConv,npos))
		End If
		B4XTable1_DataUpdated
		B4XTable1.UpdateTableCounters
		B4XTable1.Refresh
	End If
	Button3.Text=Label37.Text
	Button4.Text=Label38.Text
	Button5.Text=Label40.Text
	EditText2.Text=Label39.Text
	EditText3.Text=Label41.text
	EditText4.Text=Label42.Text
End Sub

Sub Leggi_Barcode_Articolo(CodiceLetto As String) As List
	Dim Result As List
	Dim F_Errore As Boolean = False
	PesoArt = 0
	Result.Initialize
	Try		
		CodiceLetto = CodiceLetto.Trim
		If (CodiceLetto.Length=13) And (CodiceLetto.SubString2(0,1)="2") Then 'And (vCodArticolo="") Then
			' Decodifico articolo a peso, in realtà solo l'articolo			
			Dim Result As List			
			Result = ExtraUtility.LeggiArticoloConPeso(CodiceLetto,2)	' estrae l'articolo dalla stringa letta
			CodiceLetto = Result.Get(0)
			PesoArt	 = Result.Get(1)
		End If
		sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLetto & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label3.Text = rs.GetString("DESCRIZIONE")
				vCodArticolo = rs.GetString("CODICE")
				Result.Add(vCodArticolo)			
				If (rs.GetInt("ESAURITO")<>0) Then
					Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
					F_Errore = True
				End If
			Loop
			rs.close
		Else
			sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
				& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE ='" & CodiceLetto & "'"  '" & vCodArtLotto & "'" 
			Log (sqlstr)
			Dim vDescArticolo As String = ""
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If (rs.RowCount>0)  Then
				Do While rs.NextRow
					vDescArticolo = rs.GetString("DESCRIZIONE")
					vCodArticolo = rs.GetString("ARTICOLO")
					Result.Add(vCodArticolo)
					If (rs.GetInt("ESAURITO")<>0) Then
						vDescArticolo = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
						F_Errore = True
					End If
				Loop
				If(vTipoLettura <=1) Then
					Label3.Text = vDescArticolo
				Else
					If (vCodArticolo<>vCodArtCella) And (vCodArticolo<>vCodArtLotto) And (vCorsiaUbicaz<>"N") Then												
						ExtraUtility.Play_Sound("error.wav")
						Msgbox2Async("L'articolo selezionato non è coerente con quello in cella!", "Pocket ISA", "OK", "", "", Null, False)
						F_Errore = True
					End If					
				End If
				rs.close
			Else
				'--------------------------------------------------------------------------------
				' nel caso non venga decodificato il codice si applica funzione Decodifica_EAN
				'--------------------------------------------------------------------------------
				Dim vRes As tRec_EANCODE = DBUtilsExtra.Decodifica_CodiceEAN(SQLDataAccess,vBarcodeLetto)
				If (vRes.IsInitialized) Then					
					vCodArticolo = vRes.Codart
					PesoArt = Round2(vRes.Qta,3)
					Result.Add(vCodArticolo)
					If (vCodArticolo<>"") Then
						If (vTipoLettura<=1) Then
							Label3.Text = vRes.Descrizione
						End If
					Else
						If(vTipoReadGiac<>"CELCEL") And (vTipoReadGiac<>"CORMAG") Then
							ExtraUtility.Play_Sound("error.wav")
							If (vTipoLettura<=1) Then
								Label3.Text = "*** CODICE ERRATO ***"
							Else
								ToastMessageShow("*** CODICE ERRATO ***",True)
							End If
							F_Errore = True
						End If
					End If
					' MsgboxAsync	("OK trovato -> " & vRes.Descrizione,"TEST EAN")								
				Else
					ExtraUtility.Play_Sound("error.wav")
					If (vTipoLettura<=1) Then
						Label3.Text = "*** CODICE ERRATO ***"
					Else
						ToastMessageShow("*** CODICE ERRATO ***",True)
					End If
					F_Errore = True
					vCodArticolo = ""
				End If
			End If
		End If
		Result.Add(F_Errore)
		Return Result
	Catch
		Log(LastException)
		Result.Add(True)
		Return Result
	End Try
End Sub

Sub AStream_Error
	Try
		If(Main.SwitchMode_SPP=1) Then
			Log("Connection broken...")
			AStream.Close
			serial1.Disconnect
			If ScannerOnceConnected=True Then
				T.Enabled=True
			Else
				ShowPairedDevices
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub AStream_Terminated
	Try
		If(Main.SwitchMode_SPP=1) Then
				Log("Connection terminated...")
				AStream_Error
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Timer_Tick
	Try
		If(Main.SwitchMode_SPP=1) Then
			T.Enabled=False
			serial1.Connect(ScannerMacAddress)
			Log ("Trying to connect...")
		End If
	Catch
		Log(LastException)
	End Try
End Sub

' -----------------  fine SPP ------------------

Sub Decodifica_Articolo_Spostamento(Codice As String) As List
	' 1 - TipLettura = 1,2,3
	' 2 - Articolo (string)
	' 3 - Errore (boolean)
	Try
		Dim Check As List
		Dim F_Check As  Boolean = False
		Check.Initialize
		'Dim Scaffale As String = ""
		'Dim Ripiano As String = ""
		'Dim Cella As String = ""
		' LA CODIFICA DI LOTTI E ALTRO DEVE ESSERE FATTA QUANDO IL PANNELLO3 (calcolatrice è spenta) 
		If(Panel3.Visible=False) Then
			Dim Idx As Int
			Idx = Codice.IndexOf("$NB")
			If Idx=-1 Then
				Idx = Codice.IndexOf("10NB")
				If(Idx=26) And (Codice.Length=36)  Then
					' Codice EAN128 con incluso lotto
					Idx=999
				End If
			End If
			If (Idx>0) And (Idx<>999) Then
				' Caso di Lotto con $NB
				Check.Add("T=2")    ' Tipo Lettura Codice Lotto
				Check.Add(Codice.SubString(Idx+3))
				Check.Add(Codice.SubString2(0,Idx))
			Else if (Idx=999) Then 
				' Caso di codice particolare con lotto 10NB incluso nel EAN 128
				Check.Add("T=2")    ' Tipo Lettura Codice Lotto			
				Check.Add(Codice.SubString(30))
				' Leggo codice EAN14 e lo cerco su IS_BARCODE			
				Dim CArt As String = SQLDataAccess.ExecQuerySingleResult2("SELECT articolo FROM IS_BARCODE WHERE barcode = ?", Array As String(Codice.SubString2(2,16)))
				If (CArt<>"") Then
					Dim BCode As String = SQLDataAccess.ExecQuerySingleResult2("SELECT barcode FROM IS_ANAGRAFICAARTICOLI WHERE codice = ?", Array As String(CArt))
					If(BCode<>"") And (BCode.Length=7) Then
						' Aggiungo barcode
						Check.Add(BCode.SubString2(2,7))					
						' Aggiungo LottoCompleto
						Check.Add(BCode.SubString2(2,7)& "$NB" & Codice.SubString(30))
					End If
				End If				
			Else		
				If(Codice.Length=5) And (Codice.SubString2(0,2)="CS") Then
					'-----------------------------
					' caso solo corsia
					'-----------------------------				
					Check.Add("T=4")  ' Tipo Lettura (corsia)
					vCodDepositoColl=Codice
					F_Check = True				
				Else
					F_Check = True
					If (Codice.SubString2(0,2)<>"CS") Then     ' Corsia
						'Corsia=Codice.SubString2(0,2)
						F_Check = False
					Else If (Codice.SubString2(5,6)<>"S") Then ' Scaffale
						'Scaffale=Codice.SubString2(0,3)
						F_Check = False
					Else if (Codice.SubString2(8,9)<>"R") Then ' Ripiano
						'Ripiano=Codice.SubString2(3,6)
						F_Check = False
					Else If (Codice.SubString2(11,12)="C") And (F_Check) Then ' Cella
						Check.Add("T=1")  ' Tipo Lettura Codice Cella
						Check.Add("C=" & Codice)
					Else
						F_Check = False
					End If
					If(F_Check=False) Then
						Check.Add("T=3")  ' Tipo Lettura (codici vari articolo)
						Check.Add(Codice)
					End If
				End If
				
			End If
		Else
			F_Check = False
			Check.Add("T=3")  ' Tipo Lettura (codici vari articolo)			
		End If
		Return (Check)
	Catch
		Log(LastException)
		Return (Check)
	End Try
End Sub

Sub Decodifica_Articolo_Inventario(Codice As String) As List
	' 1 - TipLettura = 1,2,3
	' 2 - Articolo (string)
	' 3 - Errore (boolean)
	Try
		Dim Idx As Int = Codice.IndexOf("$NB")
		Dim Check As List
		Dim F_Check As  Boolean = False
		Check.Initialize
		'Dim Scaffale As String = ""
		'Dim Ripiano As String = ""
		'Dim Cella As String = ""
		If (Idx=-1) Then
			Idx = Codice.IndexOf("10NB")
			If(Idx=26) And (Codice.Length=36)  Then
				' Codice EAN128 con incluso lotto
				Idx=999
			End If
		End If
		If (Idx>0) Then
			If (Idx>0) And (Idx<>999) Then
				' Caso di Lotto con $NB
				Check.Add("T=2")    ' Tipo Lettura Codice Lotto
				Check.Add(Codice.SubString(Idx+3))
				Check.Add(Codice.SubString2(0,Idx))
			Else if (Idx=999) Then
				' Caso di codice particolare con lotto 10NB incluso nel EAN 128
				If(PesoArt>0) Then
					Check.Add("T=5")    ' Tipo Lettura Codice Lotto + Peso integrato
				Else
					Check.Add("T=4")    ' Tipo Lettura Codice Lotto + Peso Integrato
				End If
				Check.Add(Codice.SubString(30))
				' Leggo codice EAN14 e lo cerco su IS_BARCODE
				Dim CArt As String = SQLDataAccess.ExecQuerySingleResult2("SELECT articolo FROM IS_BARCODE WHERE barcode = ?", Array As String(Codice.SubString2(2,16)))
				If (CArt<>"") Then
					Dim BCode As String = SQLDataAccess.ExecQuerySingleResult2("SELECT barcode FROM IS_ANAGRAFICAARTICOLI WHERE codice = ?", Array As String(CArt))
					If(BCode<>"") And (BCode.Length=7) Then
						' Aggiungo barcode
						Check.Add(BCode.SubString2(2,7))
						' Aggiungo LottoCompleto
						Check.Add(BCode.SubString2(2,7)& "$NB" & Codice.SubString(30))
						' Aggiungo Peso integrato nel codice 003628 (3Kg e 628g)
						Dim PesoInt As String = Codice.substring2(20,23)
						Dim PesoDec As String = Codice.substring2(23,26)
						Dim Peso As Double = PesoInt & "." & PesoDec
						Check.Add(Peso)
					End If
				End If
			End If
		Else
			F_Check = True			
			If (Codice.SubString2(0,2)<>"CS") Then     ' Corsia
				'Corsia=Codice.SubString2(0,2)
				F_Check = False			
			Else If (Codice.SubString2(5,6)<>"S") Then ' Scaffale
				'Scaffale=Codice.SubString2(0,3)
				F_Check = False
			Else if (Codice.SubString2(8,9)<>"R") Then ' Ripiano
				'Ripiano=Codice.SubString2(3,6)
				F_Check = False
			Else If (Codice.SubString2(11,12)="C") And (F_Check) Then ' Cella			
				Check.Add("T=1")  ' Tipo Lettura Codice Cella
				Check.Add("C=" & Codice)			
			Else
				F_Check = False
			End If			
			If(F_Check=False) Then
				Check.Add("T=3")  ' Tipo Lettura (codici vari articolo)
				Check.Add(Codice)
			End If
		End If
		Return (Check)
	Catch
		Log(LastException)
		Return (Check)
	End Try
End Sub

Sub Button6_Click	
	Try
		' Ordine Residuo o Totale
		If (Button6.Text="VERIFICA RESIDUO") Then
			VerificaResiduo(True,TotalSize)
			Button6.Text="ORDINE TOTALE"
		Else
			VerificaOrdineCompleto
			Button6.Text="VERIFICA RESIDUO"		
		End If	
		vTipoTab = 0
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button7_Click
	Try
		' Sospendi Ordine
		XSelections.Clear
		Sleep(0)
		Msgbox2Async("Vuoi sospendere l'ordine?", "SOSPENSIONE", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			RegistraDocumento(vTipoDocNew,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,0,vRifIdTesta,"DA ASSEGNARE",False,ListaDocTablet.vOperazione)
			Activity.Finish
			' CallSubDelayed2(ListaDocTablet, "ListaDocChkNew","")
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button1_Click
	' Registra Documento con stampa etichette
	If (Check_Peso(TotalSize,False) And Check_Etichette(TotalSize)) Then				
		XSelections.Clear
		Sleep(0)
		Select TipoOperazione
			Case "COF"  ' Carico Ordine Fornitore
				RegistraDocumento(vTipoDocNew,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"DA ASSEGNARE",False,ListaDocTablet.vOperazione)
				IDkey = Leggi_IDkey(SQLDataAccess,vTipoDocNew,vNumDocNew,vEsercizioNew)
				Msgbox2Async("Vuoi sincronizzare il documento con il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Sleep(0)
					wait for (RegistraSulServer(IDkey)) Complete (Success As Boolean)
					If (Success) Then
						vTipoTab = 1
						Activity.Finish
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					End If
				Else
					vTipoTab = 1
					Activity.Finish
					CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
				End If
			
			Case "INV"   ' Inventario				
				Select Case ListaDocTablet.vOperazione
					Case "ApriDoc"
						RegistraDocumentoInventario(TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione)
						IDkey = Leggi_IDkey(SQLDataAccess,TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					Case "NuovoDoc"
						RegistraDocumentoInventario(TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione)
						IDkey = Leggi_IDkey(SQLDataAccess,TipoOperazione,vNumDocNew,vEsercizioNew)
				End Select
				Msgbox2Async("Vuoi sincronizzare il documento con il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Sleep(0)
					wait for (RegistraSulServerINV(IDkey)) Complete (Success As Boolean)
					If (Success) Then
						vTipoTab = 1
						Activity.Finish
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					End If
				Else
					vTipoTab = 1
					Activity.Finish
					CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
				End If

			Case "SPO"   ' Spostamento
				Select Case ListaDocTablet.vOperazione
					Case "ApriDoc"
 						RegistraDocumentoSpostamento(TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione)
						IDkey = Leggi_IDkey(SQLDataAccess,TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					Case "NuovoDoc"
						RegistraDocumentoSpostamento(TipoOperazione,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione)
						IDkey = Leggi_IDkey(SQLDataAccess,TipoOperazione,vNumDocNew,vEsercizioNew)
				End Select
				Msgbox2Async("Vuoi sincronizzare il documento con il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Sleep(0)
					wait for (RegistraSulServerSPO(IDkey)) Complete (Success As Boolean)
					If (Success) Then
						vTipoTab = 1
						Activity.Finish
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					End If
				Else
					vTipoTab = 1
					Activity.Finish
					CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
				End If
		End Select
	End If
End Sub

Sub Button2_Click
	' Registra Documento senza stampa etichette
	If (Check_Peso(TotalSize,False) And Check_Etichette(TotalSize)) Then
		XSelections.Clear
		Sleep(0)
		RegistraDocumento(vTipoDocNew,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,0,vRifIdTesta,"DA ASSEGNARE",False,ListaDocTablet.vOperazione)
		IDkey = Leggi_IDkey(SQLDataAccess,vTipoDocNew,vNumDocNew,vEsercizioNew)
		Msgbox2Async("Vuoi sincronizzare il documento con il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Sleep(0)
			wait for (RegistraSulServer(IDkey)) Complete (Success As Boolean)
			If (Success) Then
				vTipoTab = 2
				Activity.Finish				
				CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
			End If
		Else
			vTipoTab = 2
			Activity.Finish
			CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
		End If
	End If
End Sub

private Sub ListaRigheTablet_SPO(TipoDoc As String, NumDoc As Int, Esercizio As Int)
	Sleep(0) 'this is required as the table layout is not immediately created.'	
	B4XTable1.SearchVisible=False
	B4XTable1.MaximumRowsPerPage = 15
	B4XTable1.RowHeight = DipToCurrent(Main.AltRiga)
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim Col1_Column As B4XTableColumn = B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			    ' Posizione (C0)
	Col1_Column.Width=40dip
	Dim Col2_Column As B4XTableColumn = B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo (C1)
	Col2_Column.Width=85dip ' 85dip
	Dim Col3_Column As B4XTableColumn = B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione (C2)
	Col3_Column.Width=400dip  ' per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
	Dim Col4_Column As B4XTableColumn = B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM1 (C3)
	Col4_Column.Width=50dip '1 TEXT
	Dim Col5_Column As B4XTableColumn = B4XTable1.AddColumn("Qta UM1", B4XTable1.COLUMN_TYPE_TEXT)				' Qta UM1 (c4)
	Col5_Column.Width=80dip '140 TEXT
	Dim Col6_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2 (c5)
	Col6_Column.Width=50dip ' 1 '140 TEXT
	Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Qta UM2", B4XTable1.COLUMN_TYPE_TEXT)				' Qta UM2 (c6)
	Col7_Column.Width=80dip '140 TEXT
	Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3 (c7)
	Col8_Column.Width=50dip ' 1  TEXT
	Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Peso Kg", B4XTable1.COLUMN_TYPE_NUMBERS)			' Peso Kg UM3 (c8)
	Col9_Column.Width=95dip ' TEXT  85dip
	Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("Lotto",B4XTable1.COLUMN_TYPE_TEXT)				' Lotto Completo (c9)
	Col10_Column.Width=150dip '86dip ' TEXT per SAMSUNG NESTI = 100dip, per HUAWEI = 90dip
	Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Scad.",B4XTable1.COLUMN_TYPE_TEXT)				' Data Scadenza (c10)
	Col11_Column.Width=1 ' TEXT per SAMSUNG NESTI = 100dip, per HUAWEI = 90dip
	Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c11)
	Col12_Column.Width=1 '  1
	Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Priorita", B4XTable1.COLUMN_TYPE_NUMBERS)			' priorità variabile (c12)
	Col13_Column.Width=1 '  1
	Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMAConv", B4XTable1.COLUMN_TYPE_NUMBERS)	' QtaTotUMAConv	 (c13)
	Col14_Column.Width=1 '  1
	Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUM2", B4XTable1.COLUMN_TYPE_TEXT)			' QtaTotUM2	(c14)
	Col15_Column.Width=100dip '  1
	Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c15)
	Col16_Column.Width=1 '  1
	Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("CorsiaUbic", B4XTable1.COLUMN_TYPE_TEXT)		    ' CorsiaUbic (c16)
	Col17_Column.Width=175dip '  1
	Dim Col18_Column As B4XTableColumn = B4XTable1.AddColumn("CorsiaUbicColl", B4XTable1.COLUMN_TYPE_TEXT)		' CorsiaUbicColl (c17)	
	Col18_Column.Width=175dip '  1
	Dim Col19_Column As B4XTableColumn = B4XTable1.AddColumn("Flag_SvuotaCella", B4XTable1.COLUMN_TYPE_NUMBERS)	' Flag_SvuotaCella (c18)
	Col19_Column.Width=1 '  1
	Dim Col20_Column As B4XTableColumn = B4XTable1.AddColumn("TipoReadGiac", B4XTable1.COLUMN_TYPE_TEXT)		' TipoReadGiac (c19)
	Col20_Column.Width=1 ' 100dip 
	' ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
	' ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		Dim ListNewDoc As List = DB_SQLite.Crea_NuovoDocumento(SQLDataAccess, TipoDoc)
		vTipoDocNew = ListNewDoc.Get(0)
		vNumDocNew = ListNewDoc.Get(1)
		vEsercizioNew = ListNewDoc.Get(2)
		vDataDocNew = ListNewDoc.Get(3)
	End If
	If(ListaDocTablet.vOperazione="ApriDoc") Then
		Label1.Text=ListaDocTablet.vTitle.Replace(CRLF," - ")
		TipoDocOrig = ""
		NumDocOrig = 0
		DataDocOrig = ""
		sqlstr = "select * from IS_TESTEDOCUMENTI WHERE TipoDoc = '" & TipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rst.NextRow
			DataDocum = rst.GetString("Datadoc")
			vRifIdTesta = 0
			vTrasmesso = rst.GetInt("Trasmesso")
		Loop
		If (vTrasmesso=1) Then
			Button1.Enabled = False
			Button2.Enabled = False
			Button7.Enabled = False
			Label1.Color = Colors.Red
		End If
		If (NumDoc > 0) Then
			Label6.Text = TipoDoc & " n. " & NumDoc & CRLF & " del " & DataDocum
		End If
		Log(sqlstr)
	End If
	DataList.Initialize
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
		& " AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
		 & " AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
	End If
	Log(sqlstr)
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(20) As Object
		rowx(0) = rs.GetInt("Idriga")
		rowx(1) = rs.Getstring("Codart")										   				' Codart
		rowx(2) = rs.Getstring("Descrizione")									   				' Descrizione
		rowx(3) = rs.GetString("UM")											   				' UM1 (Acquistato)
		If(rs.Getint("Qta")>0) Then
			rowx(4) = rs.Getint("Qta") 											   				' Quantita
		Else
			rowx(4) = 0
		End If
		rowx(5) = rs.GetString("UM2")											   				' UM2
		If(rs.GetInt("Qta2")>0) Then
			rowx(6) = rs.Getint("Qta2")	& " " & rs.GetString("UM2")				   				' Acquisito UM2
		Else
			rowx(6) = 0
		End If
		rowx(7) = rs.Getstring("UM3")	   										   				' UM3
		rowx(8) = rs.GetDouble("Peso") 											   				' Peso in KG
		rowx(9) = rs.GetString("NrRifPartita") 									   				' Lotto
		rowx(10) = rs.GetString("DataScadenza")       							   				' Data Scadenza
		rowx(11) = rs.GetString("Status") 			                               				' status colore
		rowx(12) = 0     														   				' prorità variabile
		rowx(13) = rs.GetDouble ("QtaTotUMAConv")     							   				' QtaTotUMAConv
		rowx(14) = rs.GetDouble ("QtaTotUM2")        							   				' QtaTotUM2
		rowx(15) = rs.GetDouble ("CoeffConvUMA")     							   				' CoeffConvUMA		
		rowx(16) = rs.GetString ("Magazzino") & rs.GetString ("Ubicazione")  				    ' Magazzino-Ubicazione
		rowx(17) = rs.GetString ("MagazzinoColl") & rs.GetString ("UbicazioneColl")  		    ' MagazzinoColl-UbicazioneColl
		rowx(18) = rs.GetString ("Flag_SvuotaCella") 											' Flag_SvuotaCella
		rowx(19) = rs.GetString ("TipoReadGiac")     											' TipoReadGiac
		DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	EditText1.RequestFocus
End Sub

private Sub ListaRigheTablet_INV(TipoDoc As String, NumDoc As Int, Esercizio As Int)
	Sleep(0) 'this is required as the table layout is not immediately created.'	
	B4XTable1.SearchVisible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 15
	B4XTable1.RowHeight = DipToCurrent(Main.AltRiga)
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			' Posizione (C0)
	Col1_Column.Width=40dip
	Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo (C1)
	Col2_Column.Width=130dip ' 85dip
	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione (C2)
	Col3_Column.Width=DipToCurrent(Main.LargDescRiga) ' 350dip  per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
	Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM1 (C3)
	Col4_Column.Width=100 '1 TEXT
	Dim Col5_Column As B4XTableColumn = B4XTable1.AddColumn("Qta UM1", B4XTable1.COLUMN_TYPE_TEXT)				' Qta UM1 (c4)
	Col5_Column.Width=80dip '140 TEXT
	Dim Col6_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2 (c5)
	Col6_Column.Width=100 ' 1 '140 TEXT
	Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Qta UM2", B4XTable1.COLUMN_TYPE_TEXT)				' Qta UM2 (c6)
	Col7_Column.Width=80dip '140 TEXT
	Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3 (c7)
	Col8_Column.Width=100 ' 1  TEXT
	Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Peso Kg", B4XTable1.COLUMN_TYPE_NUMBERS)			' Peso Kg UM3 (c8)
	Col9_Column.Width=95dip ' TEXT  85dip
	Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("Lotto",B4XTable1.COLUMN_TYPE_TEXT)				' Lotto Completo (c9)
	Col10_Column.Width=150dip '86dip ' TEXT per SAMSUNG NESTI = 100dip, per HUAWEI = 90dip
	Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Scad.",B4XTable1.COLUMN_TYPE_TEXT)				' Data Scadenza (c10)
	Col11_Column.Width=86dip ' TEXT per SAMSUNG NESTI = 100dip, per HUAWEI = 90dip
	Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c11)
	Col12_Column.Width=100 '  1
	Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Priorita", B4XTable1.COLUMN_TYPE_NUMBERS)			' priorità variabile (c12)
	Col13_Column.Width=100 '  1
	Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMAConv", B4XTable1.COLUMN_TYPE_NUMBERS)	' QtaTotUMAConv	 (c13)
	Col14_Column.Width=100 '  1
	Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUM2", B4XTable1.COLUMN_TYPE_NUMBERS)		' QtaTotUM2	(c14)
	Col15_Column.Width=100 '  1
	Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c15)
	Col16_Column.Width=100 '  1
	Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("CorsiaUbic", B4XTable1.COLUMN_TYPE_TEXT)		    ' CorsiaUbic (c16)
	Col17_Column.Width=300 '  1
	' ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
	' ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		Dim ListNewDoc As List = DB_SQLite.Crea_NuovoDocumento(SQLDataAccess, TipoDoc)					
		vTipoDocNew = ListNewDoc.Get(0)
		vNumDocNew = ListNewDoc.Get(1)
		vEsercizioNew = ListNewDoc.Get(2)
		vDataDocNew = ListNewDoc.Get(3)
	End If
	If(ListaDocTablet.vOperazione="ApriDoc") Then
		Label1.Text=ListaDocTablet.vTitle.Replace(CRLF," - ")
		TipoDocOrig = ""
		NumDocOrig = 0
		DataDocOrig = ""
		sqlstr = "select * from IS_TESTEDOCUMENTI WHERE TipoDoc = '" & TipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rst.NextRow
			DataDocum = rst.GetString("Datadoc")
			vRifIdTesta = 0
			vTrasmesso = rst.GetInt("Trasmesso")
		Loop
		If (vTrasmesso=1) Then
			Button1.Enabled = False
			Button2.Enabled = False
			Button7.Enabled = False
			Label1.Color = Colors.Red
		End If
		If (NumDoc > 0) Then
			Label6.Text = TipoDoc & " n. " & NumDoc & CRLF & " del " & DataDocum
		End If
		Log(sqlstr)
	End If
	DataList.Initialize
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
		& " AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
		 & " AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
	End If
	Log(sqlstr)
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(17) As Object
		rowx(0) = rs.GetInt("Idriga")
		rowx(1) = rs.Getstring("Codart")										' Codart
		rowx(2) = rs.Getstring("Descrizione")									' Descrizione
		rowx(3) = rs.GetString("UM")											' UM1 (Acquistato)
		If(rs.Getint("Qta")>0) Then
			rowx(4) = rs.Getint("Qta") 											' Quantita
		Else
			rowx(4) = 0
		End If
		rowx(5) = rs.GetString("UM2")											' UM2
		If(rs.GetInt("Qta2")>0) Then
			rowx(6) = rs.Getint("Qta2")	& " " & rs.GetString("UM2")				' Acquisito UM2
		Else
			rowx(6) = 0
		End If
		rowx(7) = rs.Getstring("UM3")	   										' UM3
		rowx(8) = rs.GetDouble("Peso") 											' Peso in KG
		rowx(9) = rs.GetString("NrRifPartita") 									' Lotto
		rowx(10) = rs.GetString("DataScadenza")       							' Data Scadenza
		rowx(11) = rs.GetString("Status") 			                            ' status colore
		rowx(12) = 0     														' prorità variabile
		rowx(13) = rs.GetDouble ("QtaTotUMAConv")     							' QtaTotUMAConv
		rowx(14) = rs.GetDouble ("QtaTotUM2")        							' QtaTotUM2
		rowx(15) = rs.GetDouble ("CoeffConvUMA")     							' CoeffConvUMA
		rowx(16) = rs.GetString ("Magazzino") & rs.GetString ("Ubicazione")     ' Magazzino-Ubicazione
	DataList.Add(rowx)
	Loop
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	EditText1.RequestFocus
End Sub

private Sub ListaRigheTablet(TipoDoc As String, NumDoc As Int, Esercizio As Int)
	Sleep(0) 'this is required as the table layout is not immediately created.'	
	B4XTable1.SearchVisible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update
	B4XTable1.MaximumRowsPerPage = 15
	B4XTable1.RowHeight = DipToCurrent(Main.AltRiga)
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			' Posizione
	Col1_Column.Width=40dip
	Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_TEXT) 					' Tipo Riga
	Col2_Column.Width=25dip
	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo
	Col3_Column.Width=130dip ' 85dip
	Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione
	Col4_Column.Width=DipToCurrent(Main.LargDescRiga) ' 350dip  per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
	Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Ordinato", B4XTable1.COLUMN_TYPE_TEXT)			' Ordinato + UM Ordinato
	Col5_Column.Width=80dip ' TEXT
	Dim Col6_Column As B4XTableColumn =  B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM Ordinato
	Col6_Column.Width=1 '1 TEXT
	Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Acq. UM1", B4XTable1.COLUMN_TYPE_TEXT)				' Acquisito UM1
	Col7_Column.Width=80dip '140 TEXT
	Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2
	Col8_Column.Width=1 ' 1 '140 TEXT
	Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Acq. UM2", B4XTable1.COLUMN_TYPE_TEXT)				' Acquisito UM2 (c8)
	Col9_Column.Width=80dip '140 TEXT
	Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3
	Col10_Column.Width=1 ' 1  TEXT
	Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Peso Kg", B4XTable1.COLUMN_TYPE_NUMBERS)			' Peso Kg	
	Col11_Column.Width=95dip ' TEXT  85dip
	Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Etic.", B4XTable1.COLUMN_TYPE_TEXT)				' Num. Etichette
	Col12_Column.Width=40dip ' TEXT
	Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Scad.",B4XTable1.COLUMN_TYPE_TEXT)				' Data Scadenza	
	Col13_Column.Width=86dip ' TEXT per SAMSUNG NESTI = 100dip, per HUAWEI = 90dip
	Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c13)
	Col14_Column.Width=1 '  1 	
	Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("Priorita", B4XTable1.COLUMN_TYPE_NUMBERS)			' priorità variabile
	Col15_Column.Width=1 '  1
	Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdriga", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIDriga
	Col16_Column.Width=1 '  1
	Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMAConv", B4XTable1.COLUMN_TYPE_NUMBERS)	' QtaTotUMAConv	 (c16)
	Col17_Column.Width=1 '  1
	Dim Col18_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUM2", B4XTable1.COLUMN_TYPE_NUMBERS)		' QtaTotUM2	(c17)
	Col18_Column.Width=1 '  1
	Dim Col19_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c18)
	Col19_Column.Width=1 '  1
	' ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)	
	' ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
	vTipoDocNew = ""
	vNumDocNew = 0
	vEsercizioNew = 0
	If(ListaDocTablet.vOperazione="ApriDoc") Then
		Label1.Text=ListaDocTablet.vTitle.Replace(CRLF," - ")
		TipoDocOrig = ""		
		NumDocOrig = 0
		DataDocOrig = ""
		sqlstr = "select * from IS_TESTEDOCUMENTI WHERE TipoDoc = '" & TipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rst.NextRow
			TipoDocOrig = rst.GetString("TipoDocOrig")
			NumDocOrig = rst.GetInt("NumDocOrig")
			DataDocOrig = rst.GetString("DataDocOrig")
			vRifIdTesta = rst.GetLong("rifidtesta")			
			vTrasmesso = rst.GetInt("Trasmesso")			
		Loop
		If (vTrasmesso=1) Then
			Button1.Enabled = False
			Button2.Enabled = False
			Button7.Enabled = False
			Label1.Color = Colors.Red
		End If
		If (NumDocOrig > 0) Then
			Label6.Text = TipoDocOrig & " n. " & NumDocOrig & CRLF & " del " & DataDocOrig
		End If		
     	vTipoDocNew = TipoDoc
		vNumDocNew = NumDoc
		vEsercizioNew = Esercizio
		Log(sqlstr)
	End If
	DataList.Initialize	
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & vTipoDocNew
		sqlstr = sqlstr & "' AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "select * from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
	End If
	Log(sqlstr)			
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(19) As Object
	'	If rs.GetDouble("QTAGEST") Mod 1=0 Then 	' fa le stesse veci della funzione int() se intero elimno eventuali decimali
	'		Ordinatoum = NumberFormat(rs.GetDouble("QTAGEST"),0,0)
	'	Else
	'		Ordinatoum = rs.GetDouble("QTAGEST")
	'	End If
		rowx(0) = rs.GetInt("Idriga")
		If (rs.Getstring("TipoRiga")="N") Then		
			rowx(1) = ""														' TipoRiga
		Else
			rowx(1) = rs.Getstring("TipoRiga")									' TipoRiga
		End If
		rowx(2) = rs.Getstring("Codart")										' Codart
		rowx(3) = rs.Getstring("Descrizione")									' Descrizione
		rowx(4) = rs.GetString("Ordinato") 										' Ordinato
		rowx(5) = rs.GetString("UM")											' UM1 (Acquistato)
		If(rs.Getint("Qta")>0) Then
			rowx(6) = rs.Getint("Qta") & " " & rs.GetString("UM")				' Acquisito + UMGest
		Else
			rowx(6) = 0
		End If
		rowx(7) = rs.GetString("UM2")											' UM2
		If(rs.GetInt("Qta2")>0) Then
			rowx(8) = rs.Getint("Qta2")	& " " & rs.GetString("UM2")				' Acquisito UM2
		Else
			rowx(8) = 0
		End If
		rowx(9) = rs.Getstring("UM3")	   										' UM3
		rowx(10) = rs.GetDouble("Peso") 										' Peso in KG
		rowx(11) = rs.Getstring("NumEtichette") 								' Num. etichette
		rowx(12) = rs.GetString("DataScadenza")       							' Data Scadenza
		rowx(13) = rs.GetString("Status") 			                            ' status colore
		rowx(14) = 0     														' prorità variabile
		rowx(15) = rs.GetInt("RifIdriga")     									' RifIdRiga
		rowx(16) = rs.GetDouble ("QtaTotUMAConv")     							' QtaTotUMAConv
		rowx(17) = rs.GetDouble ("QtaTotUM2")        							' QtaTotUM2
		rowx(18) = rs.GetDouble ("CoeffConvUMA")     							' CoeffConvUMA
		DataList.Add(rowx)
	Loop	
	rs.Close
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)	
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	EditText1.RequestFocus		
	'-----------------------------------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-----------------------------------------------------------------------------------------------------------------
	'Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	'Dim total As Double = 0
	'Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
	'Dim totalriga As Double
	'Do While rs.NextRow
'		totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga'
'		total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"), rs.GetString("c6"))
'	Loop
'	rs.Close
'	Label11.Text = formatter.Format(total)
	'-------------------------------------------------------------------------------------------------------------------
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean,SelectionColor As Long)
	Dim clr As Long = 0
	Try
		If Selected Then
			clr = SelectionColor
		Else If RowIndex Mod 2 = 0 Then
			clr = B4XTable1.EvenRowColor
		Else
			clr = B4XTable1.OddRowColor
		End If
		'For Each c As B4XTableColumn In B4XTable1.VisibleColumns
		'	Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex) '+1 because of the header
		'	pnl.Color = clr
		'Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub Execute_Scrivi_DB_TesteDocINV(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String,ID_key As Long) As ResumableSub
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			Dim PathPHP As String
			If (Main.PortaPhp <> "") Then
				PathPHP = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			Else
				PathPHP = $"http://${Main.IP_ServerPHP}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,TD.CodClifor,TD.NrListino,1 as Trasmesso,TD.IDKEY,replace(TD.Datadoc,'/','-') as Datadoc,ifnull(TD.Valuta,0) as Valuta,ifnull(TD.Elaborato,0) " _
			& " As Elaborato,TD.DataRifDoc,TD.NumRifDoc,TD.rifidtesta,TD.flag_stp,TD.NomeImpostazione from IS_TESTEDOCUMENTI as TD left outer join IS_PARAMETRIDOC AS PD ON TD.TipoDoc=PD.Tipodoc WHERE ifnull(Trasmesso,0)=0 AND IDKEY='" & ID_key & "'"
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
			Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
			job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
			'job.Poststring(Path_Php & "users_post.php","action=" & mAction&"&json_data="&json)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log("response: " & job.GetString)
				Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
				Return True
			Else
				Log("Error: " & job.ErrorMessage)
				Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
				MsgboxAsync("Errore IS_TESTEDOCUMENTI " & job.ErrorMessage,"Errore")
				Return False
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_TESTEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_TesteDoc(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String,ID_key As Long) As ResumableSub
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			Dim PathPHP As String
			If (Main.PortaPhp <> "") Then
				PathPHP = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			Else
				PathPHP = $"http://${Main.IP_ServerPHP}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,TD.CodClifor,TD.NrListino,1 as Trasmesso,TD.IDKEY,replace(TD.Datadoc,'/','-') as Datadoc,ifnull(TD.Valuta,0) as Valuta,ifnull(TD.Elaborato,0) " _
			& " As Elaborato,TD.DataRifDoc,TD.NumRifDoc,TD.rifidtesta,TD.flag_stp from IS_TESTEDOCUMENTI as TD left outer join IS_PARAMETRIDOC AS PD ON TD.TipoDoc=PD.Tipodoc WHERE ifnull(Trasmesso,0)=0 AND IDKEY='" & ID_key & "'"
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
			Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
			job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
			'job.Poststring(Path_Php & "users_post.php","action=" & mAction&"&json_data="&json)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log("response: " & job.GetString)
				Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
				Return True
			Else
				Log("Error: " & job.ErrorMessage)
				Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
				MsgboxAsync("Errore IS_TESTEDOCUMENTI " & job.ErrorMessage,"Errore")
				Return False
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_TESTEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Check_Etichette(Tsize As Int) As Boolean
	Try
		XSelections.Clear
		If(CheckBox2.Checked) Then
			B4XTable1.CreateDataView($"(c6 NOT LIKE '0%') AND (c11 = '')"$)
		Else
			B4XTable1.CreateDataView($"c11 = ''"$)
		End If		
		For i=0 To Tsize
			SetRowColor(i,False,0)
		Next
		B4XTable1.Refresh
		Dim size As Int =  B4XTable1.Size
		If size = 0 Then
			Return True
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("VERIFICARE NUMERO ETICHETTE!",True)
			Return False
		End If
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub Check_Peso(Tsize As Int,Mute As Boolean) As Boolean
	Try
		XSelections.Clear
		If (CheckBox2.Checked) Then		
			B4XTable1.CreateDataView($"(c6 NOT LIKE '0%') AND ((c9 <> '' AND c10 = '0') OR (c11 = ''))"$)
			'B4XTable1.CreateDataView($"(c9 <> '' AND c10 <> '0') OR (c11 = '')"$)		
		Else
			B4XTable1.CreateDataView($"(c9 <> '' AND c10 = '0') OR (c11 = '')"$)
		End If	
		For i=0 To Tsize
			SetRowColor(i,False,0)
		Next	
		B4XTable1.Refresh
		Dim size As Int =  B4XTable1.Size		
		If size = 0 Then
			Return True
		Else
			If(Mute = False) Then
				ExtraUtility.Play_Sound("error.wav")
				ToastMessageShow("VERIFICARE PESO, ETICHETTE SULLE RIGHE!",True)
			End If
			Return False
		End If
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub Execute_Scrivi_DB_RigheDocINV(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, ID_key As Long) As ResumableSub
	' SCRIVE LE RIGHE SUL SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			'Dim DataConsegna As String
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			Dim PathPHP As String
			If (Main.PortaPhp <> "") Then
				PathPHP = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			Else
				PathPHP = $"http://${Main.IP_ServerPHP}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,TD.UtenteModifica,RD.Idriga," _
			& "RD.Codart,RD.QtaTotUMAConv as Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,ifnull(RD.VARIAMISURE,'') as VARIAMISURE," _
			& "RD.Magazzino,RD.DataConsegna, ifnull(RD.rifidtesta,0) As rifidtesta,ifnull(RD.RIFCLIENTE,'') AS RIFCLIENTE,RD.TipoRiga,RD.Descrizione, " _
			& "RD.NumEtichette,RD.Peso,RD.UM2,RD.QtaTotUM2 as Qta2,RD.Rifidriga,RD.NrRifPartita,ifnull(RD.MagazzinoColl,'') AS MagazzinoColl, " _
			& "ifnull(RD.RifTipoDoc,'') AS RifTipoDoc, ifnull(RD.RifNumeroDoc,0) AS RifNumeroDoc, ifnull(RD.RifEsercizio,0) AS RifEsercizio,RD.DataScadenza, " _
			& "RD.Ubicazione, ifnull(RD.UbicazioneColl,'') AS UbicazioneColl, ifnull(RD.Flag_SvuotaCella,0) AS Flag_SvuotaCella " _
			& "FROM IS_RIGHEDOCUMENTI As RD JOIN IS_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio " _			
			& "WHERE ifnull(TD.Trasmesso,0)=0 AND IDKEY='" & ID_key & "'"				
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_INTEGER))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				MsgboxAsync("Nessun Documento da inviare!","SCRIVI DATI")
				Return False
			Else
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI inizio"$) 'Current time is 11:17:45
				Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore IS_RIGHEDOCUMENTI " & job.errorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore IS_RIGHEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_RIGHEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_RigheDoc(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, ID_key As Long) As ResumableSub
	' SCRIVE LE RIGHE SUL SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			'Dim DataConsegna As String
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			Dim PathPHP As String
			If (Main.PortaPhp <> "") Then
				PathPHP = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			Else
				PathPHP = $"http://${Main.IP_ServerPHP}/${FolderPhp}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,TD.UtenteModifica,RD.Idriga," _
			& "RD.Codart,RD.QtaTotUMAConv as Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,ifnull(RD.VARIAMISURE,'') as VARIAMISURE," _
			& "'' AS MAGAZZINO,RD.DataConsegna, ifnull(RD.rifidtesta,0) As rifidtesta,ifnull(RD.RIFCLIENTE,'') AS RIFCLIENTE,RD.TipoRiga,RD.Descrizione, " _
			& "RD.NumEtichette,RD.Peso,RD.UM2,RD.QtaTotUM2 as Qta2,RD.Rifidriga,RD.NrRifPartita,ifnull(RD.MagazzinoColl,'') AS MagazzinoColl, " _
			& "ifnull(RD.RifTipoDoc,'') AS RifTipoDoc, ifnull(RD.RifNumeroDoc,0) AS RifNumeroDoc, ifnull(RD.RifEsercizio,0) AS RifEsercizio,RD.DataScadenza " _
			& "FROM IS_RIGHEDOCUMENTI As RD JOIN IS_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio " _			
			& "WHERE ifnull(TD.Trasmesso,0)=0 AND IDKEY='" & ID_key & "'"				
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				MsgboxAsync("Nessun Documento da inviare!","SCRIVI DATI")
				Return False
			Else
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI inizio"$) 'Current time is 11:17:45
				Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore IS_RIGHEDOCUMENTI " & job.errorMessage,"Errore")
					Return False
				End If
			End If			
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore IS_RIGHEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_RIGHEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub RegistraSulServerSPO(ID_key As Long) As ResumableSub
	' SCRITTURA TABELLE DAL SERVER
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" &straction&" is_testedocumenti_spo.php e is_righedocumenti_inv.php)")
		straction = "insert_righedocinv"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDocINV(Me, dbAction, straction, "is_testedocumenti_spo.php","",ID_key)) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_testedocinv"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_TesteDocINV(Me, dbAction, straction, "is_testedocumenti_spo.php","",ID_key))  complete (Result3 As Boolean)
			If (Result3) Then
				SQLDataAccess.BeginTransaction
				sqlstr = "UPDATE IS_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0 AND IDKEY = '" & ID_key & "'"
				Log(sqlstr)
				SQLDataAccess.ExecNonQuery(sqlstr)
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
				Return True
			Else
				MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
				Return False
			End If
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub RegistraSulServerINV(ID_key As Long) As ResumableSub
	' SCRITTURA TABELLE DAL SERVER
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" &straction&" is_testedocumenti_inv.php e is_righedocumenti_inv.php)")
		straction = "insert_righedocinv"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDocINV(Me, dbAction, straction, "is_testedocumenti_inv.php","",ID_key)) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_testedocinv"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_TesteDocINV(Me, dbAction, straction, "is_testedocumenti_inv.php","",ID_key))  complete (Result3 As Boolean)
			If (Result3) Then
				SQLDataAccess.BeginTransaction
				sqlstr = "UPDATE IS_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0 AND IDKEY = '" & ID_key & "'"
				Log(sqlstr)
				SQLDataAccess.ExecNonQuery(sqlstr)
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
				Return True
			Else
				MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
				Return False
			End If
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub


Sub RegistraSulServer(ID_key As Long) As ResumableSub
	' SCRITTURA TABELLE DAL SERVER
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" &straction&" is_testedocumenti.php e is_righedocumenti.php)")
		straction = "insert_righedoc"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDoc(Me, dbAction, straction, "is_testedocumenti.php","",ID_key)) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_testedoc"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_TesteDoc(Me, dbAction, straction, "is_testedocumenti.php","",ID_key))  complete (Result3 As Boolean)
			If (Result3) Then
				SQLDataAccess.BeginTransaction
				sqlstr = "UPDATE IS_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0 AND IDKEY = '" & ID_key & "'"
				Log(sqlstr)
				SQLDataAccess.ExecNonQuery(sqlstr)
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
				Return True
			Else
				MsgboxAsync("Operazione errata, problema di sincronizzazione!", "Sincronizzazione " & Main.MessageBoxText)
				Return False
			End If
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub VerificaOrdineCompleto As Boolean
	Try
		Dim size1 As Int
		Dim size2 As Int
		B4XTable1.CreateDataView($"(c6 = '0') OR (c9 <> '' AND c10 = '0') OR (c11 = '')"$)
		size1 = B4XTable1.Size
		B4XTable1.CreateDataView($"c4 > ''"$)
		size2 =  B4XTable1.Size
		B4XTable1.Refresh
		If (size1 = 0) And (size2>0)	Then
			Return True
		Else
			Return False
		End If
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub VerificaResiduo(flag As Boolean,TSize As Int )
	Try
		XSelections.Clear
		Dim Finito As Boolean =	VerificaOrdineCompleto
		If(Finito) Then
			ExtraUtility.Play_Sound("Sound3.wav")
			MsgboxAsync("Ordine Completato con successo!","CONTROLLO ORDINE")
		Else If (flag) Then		
			If(CheckBox2.Checked) Then
				If Check_Peso(TSize,True)=False Then
					B4XTable1.CreateDataView($"(c6 NOT LIKE '0%') AND ((c13 <> 'G') OR (c9 <> '' AND c10 = '0') OR (c11 = ''))"$)
					' B4XTable1.CreateDataView($"(c6 <> '0%') AND ((c13 <> 'G') OR (c9 <> '' AND c10 = '0') OR (c11 = ''))"$)
				Else
					B4XTable1.CreateDataView($"(c6 NOT LIKE '0%') AND ((c13 <> 'G') OR (c11 = ''))"$)
				End If
			Else			
				If Check_Peso(TSize,True)=False Then		
					B4XTable1.CreateDataView($"(c13 <> 'G') OR (c9 <> '' AND c10 = '0') OR (c11 = '')"$)
				Else
					B4XTable1.CreateDataView($"(c13 <> 'G') OR (c11 = '')"$)
				End If
			End If
			Dim Tsize2 As Int = B4XTable1.size
			For i=0 To Tsize2
				SetRowColor(i,False,0)
			Next
			B4XTable1.Refresh
		Else
			Dim rowdata As Map
			B4XTable1.CreateDataView($"c4 > ''"$)
			B4XTable1.Refresh
			Dim Row_IDriga As Int = 0
			Dim ColoreInt As Int = 0		
			Dim Colore As String = ""
			For i = 0 To TSize 
				'Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)			
				rowdata = B4XTable1.GetRow(i)
				If(rowdata.Size>0) Then
					Row_IDriga = rowdata.GetValueAt(0)				
					Colore = rowdata.GetValueAt(13)
					If Colore <> "" Then
						'ColoreInt = Decodifica_Colore_Int(Colore)
						SetRowColor(Row_IDriga,True,ColoreInt)
					Else
						SetRowColor(Row_IDriga,False,0)
					End If
				End If
			Next
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraDocumentoSpostamento(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String)
	Try
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		vTipoDocNew = TipoDoc
		B4XTable1.CreateDataView($"c0 >0"$)
		B4XTable1.Refresh
		If(Operazione="NuovoDoc") Then
			Dim ListNewDoc As List
			ListNewDoc = DB_SQLite.Crea_NuovoDocumento(SQLDataAccess,TipoDoc)
			TipoDoc = ListNewDoc.Get(0)
			NumDoc = ListNewDoc.Get(1)
			Esercizio = ListNewDoc.Get(2)
			DataDoc = ListNewDoc.Get(3)
			sqlstr = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,NomeImpostazione) VALUES "
			sqlstr = sqlstr & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & Choose_Menu.vCodCliForInventario  & "','" _
			 & DataDoc & "','" & vFoglioInv & "')"
		Else
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			'sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
			'SQLDataAccess.ExecNonQuery(sqlstr)
			sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "' AND Esercizio ='" & Esercizio & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
		SQLDataAccess.ExecNonQuery(sqlstr)
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)
				RowID_Riga = rowdata.Get("Pos.")
				Dim CodArt As String = rowdata.Get("Cod. Art.")
				Dim DescArt As String = rowdata.Get("Descrizione Art.")
				Dim UM1 As String = rowdata.Get("UM1")
				Dim Qta1 As String = rowdata.Get("Qta UM1")
				Dim UM2 As String = rowdata.Get("UM2")
				Dim Qta2 As String = rowdata.Get("Qta UM2")
				Dim UM3 As String = rowdata.Get("UM3")
				Dim Peso As Double = rowdata.Get("Peso Kg")
				Dim Lotto As String = rowdata.Get("Lotto")
				Dim DataScadenza As String = rowdata.Get("Scad.")
				Dim Status As String = rowdata.Get("Status")
				Dim Priority As Int = rowdata.Get("Priorita")
				Dim QtaTotUMAConv As Double = rowdata.Get("QtaTotUMAConv")
				Dim QtaTotUM2 As Int = rowdata.Get("QtaTotUM2")
				Dim CoeffConvUMA As Double = rowdata.Get("CoeffConvUMA")
				Dim CorsiaUbicazione As String = rowdata.Get("CorsiaUbic")
				Dim CorsiaUbicazioneColl As String = rowdata.Get("CorsiaUbicColl")
				Dim Flag_SvuotaCella As Int = rowdata.Get("Flag_SvuotaCella")	
				Dim TipoReadGiac As String = rowdata.Get("TipoReadGiac")			
				If(TipoReadGiac<>"") Then
					Select TipoReadGiac
						Case "MAGCOR"
							Dim Magazzino As String = CorsiaUbicazione
							Dim Ubicazione As String = ""
							Dim MagazzinoColl As String = CorsiaUbicazioneColl.SubString2(0,5)
							Dim UbicazioneColl As String = CorsiaUbicazioneColl.SubString(5)
																
						Case "MAGCEL"
							Dim Magazzino As String = CorsiaUbicazione
							Dim Ubicazione As String = ""
							Dim MagazzinoColl As String = CorsiaUbicazioneColl.SubString2(0,5)
							Dim UbicazioneColl As String = CorsiaUbicazioneColl.SubString(5)
																	
						Case "CORCOR"
							Dim Magazzino As String = CorsiaUbicazione
							Dim Ubicazione As String = ""
							Dim MagazzinoColl As String = CorsiaUbicazioneColl
							Dim UbicazioneColl As String = ""
							
						Case "CELCOR"
							Dim Magazzino As String = CorsiaUbicazione.SubString2(0,5)
							Dim Ubicazione As String = CorsiaUbicazione.SubString(5)
							Dim MagazzinoColl As String = CorsiaUbicazioneColl
							Dim UbicazioneColl As String = ""
							
						Case "CELMAG"
							Dim Magazzino As String = CorsiaUbicazione.SubString2(0,5)
							Dim Ubicazione As String = CorsiaUbicazione.SubString(5)
							Dim MagazzinoColl As String = CorsiaUbicazioneColl
							Dim UbicazioneColl As String = ""
			
						Case "CORMAG"
							Dim Magazzino As String = CorsiaUbicazione
							Dim Ubicazione As String = ""
							Dim MagazzinoColl As String = CorsiaUbicazioneColl
							Dim UbicazioneColl As String = ""
							
						Case "CELCEL"
							Dim Magazzino As String = CorsiaUbicazione.SubString2(0,5)
							Dim Ubicazione As String = CorsiaUbicazione.SubString(5)
							Dim MagazzinoColl As String = CorsiaUbicazioneColl.SubString2(0,5)
							Dim UbicazioneColl As String = CorsiaUbicazioneColl.SubString(5)
							
					End Select
				Else
					ExtraUtility.Play_Sound("error.wav")
					Msgbox2Async("ERRORE NELLA PROCEDURA 'RegistraDocumentoSpostaamento'", "Pocket ISA", "OK", "", "", Null, False)
				End If
				
				sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,UM,Qta,Descrizione," _
				& "DataScadenza,NrRifPartita,UM2,Qta2,UM3,Peso,Status,Priorita,QtaTotUMAConv,QtaTotUM2,CoeffConvUMA,Magazzino,Ubicazione," _
				& "TipoRiga,Sconto,Note,DataConsegna,NumEtichette,Ordinato,MagazzinoColl,UbicazioneColl,Flag_SvuotaCella,TipoReadGiac) VALUES " _
				& "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente  & "','" & CodArt & "','" & UM1 & "','" _
				& Qta1 & "','" & DescArt & "','" & DataScadenza & "','" & Lotto & "','" & UM2 & "','" & Qta2 & "','"  & UM3 & "','" & Peso & "','" _
				& Status & "','"  & Priority & "','" & QtaTotUMAConv & "','"  & QtaTotUM2 & "','"  & CoeffConvUMA & "','" & Magazzino & "','" & Ubicazione _
				& "','N','','','','','','" & MagazzinoColl & "','" & UbicazioneColl & "','" & Flag_SvuotaCella & "','" & TipoReadGiac & "')"
				SQLDataAccess.ExecNonQuery(sqlstr)
				
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraDocumentoInventario(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String)
	Try		
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		vTipoDocNew = TipoDoc
		B4XTable1.CreateDataView($"c0 >0"$)
		B4XTable1.Refresh
		If(Operazione="NuovoDoc") Then
			Dim ListNewDoc As List				
			ListNewDoc = DB_SQLite.Crea_NuovoDocumento(SQLDataAccess,TipoDoc)
			TipoDoc = ListNewDoc.Get(0)
			NumDoc = ListNewDoc.Get(1)
			Esercizio = ListNewDoc.Get(2)
			DataDoc = ListNewDoc.Get(3)
			sqlstr = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,NomeImpostazione) VALUES " 
			sqlstr = sqlstr & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & Choose_Menu.vCodCliForInventario  & "','" _
			 & DataDoc & "','" & vFoglioInv & "')"
		Else
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")			
			'sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
			'SQLDataAccess.ExecNonQuery(sqlstr)
			sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
		SQLDataAccess.ExecNonQuery(sqlstr)
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)
				RowID_Riga = rowdata.Get("Pos.")
				Dim CodArt As String = rowdata.Get("Cod. Art.")
				Dim DescArt As String = rowdata.Get("Descrizione Art.")
				Dim UM1 As String = rowdata.Get("UM1")
				Dim Qta1 As String = rowdata.Get("Qta UM1")
				Dim UM2 As String = rowdata.Get("UM2")
				Dim Qta2 As String = rowdata.Get("Qta UM2")
				Dim UM3 As String = rowdata.Get("UM3")
				Dim Peso As Double = rowdata.Get("Peso Kg")
				Dim Lotto As String = rowdata.Get("Lotto")
				Dim DataScadenza As String = rowdata.Get("Scad.")
				Dim Status As String = rowdata.Get("Status")
				Dim Priority As Int = rowdata.Get("Priorita")
				Dim QtaTotUMAConv As Double = rowdata.Get("QtaTotUMAConv")				
				Dim QtaTotUM2 As Int = rowdata.Get("QtaTotUM2")
				Dim CoeffConvUMA As Double = rowdata.Get("CoeffConvUMA")
				Dim CorsiaUbicazione As String = rowdata.Get("CorsiaUbic")
				If(CorsiaUbicazione.Length>=5) Then
					Dim Corsia As String = CorsiaUbicazione.SubString2(0,5)
					Dim Ubicazione As String = CorsiaUbicazione.SubString(5)
				Else
					' caso corsia N
					Dim Corsia As String = vCorsia
					Dim Ubicazione As String = ""
				End If
				sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,UM,Qta,Descrizione," _
				& "DataScadenza,NrRifPartita,UM2,Qta2,UM3,Peso,Status,Priorita,QtaTotUMAConv,QtaTotUM2,CoeffConvUMA,Magazzino,Ubicazione," _
				& "TipoRiga,Sconto,Note,DataConsegna,NumEtichette,Ordinato) VALUES " _
				& "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente  & "','" & CodArt & "','" & UM1 & "','" _
				& Qta1 & "','" & DescArt & "','" & DataScadenza & "','" & Lotto & "','" & UM2 & "','" & Qta2 & "','"  & UM3 & "','" & Peso & "','" _
				& Status & "','"  & Priority & "','" & QtaTotUMAConv & "','"  & QtaTotUM2 & "','"  & CoeffConvUMA & "','" & Corsia & "','" & Ubicazione _
				& "','N','','','','','')"
				SQLDataAccess.ExecNonQuery(sqlstr)
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraDocumento(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String)
	Try		
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		B4XTable1.CreateDataView($"c0 >0"$)
		B4XTable1.Refresh	
		If(Operazione="NuovoDoc") Then
			CodCliFor = vCodCliFor
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			'DataDoc = DateTime.DateParse(vDataDocNew)				
			Esercizio = ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
			sqlstr = "SELECT max(numerodoc) as maxnumdoc FROM IS_TESTEDOCUMENTI where tipodoc='" & vTipoDocNew & "'"
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If(rs.RowCount>0) Then
				Do While rs.NextRow
					NumDoc =  rs.GetInt("maxnumdoc")+1
				Loop
			End If
			rs.close
			vNumDocNew = NumDoc
			vEsercizioNew = Esercizio
		Else
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"		
			SQLDataAccess.ExecNonQuery(sqlstr)
			sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
		sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,flag_stp,rifidtesta,NumRifDoc,TipoDocOrig,NumDocOrig,DataDocOrig) VALUES "
		sqlstr = sqlstr & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDoc & "','" & Stp_Etich & "','" & RifIDTesta & "','" _
		& NumRifDoc & "','" & TipoDocOrig & "','" & NumDocOrig & "','" & DataDocOrig & "')"
		SQLDataAccess.ExecNonQuery(sqlstr)
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)		
				Dim Ordinato As String = rowdata.Get("Ordinato")
				Dim Qta As Double = LeggiQta(rowdata.Get("Acq. UM1"),Chr(32))
				Dim Qta2 As Double = LeggiQta(rowdata.Get("Acq. UM2"),Chr(32))
				Dim Peso As Double = rowdata.Get("Peso Kg") 
				Dim Sconto As String = ""
				Dim Note As String = ""
				Dim NumEtichette As  String = rowdata.Get("Etic.")
				UM1 = LeggiUM(rowdata.Get("Ordinato"),Chr(32))
				UM2 = rowdata.Get("UM2")			
				UM3 = rowdata.Get("UM3")			
				Dim Status As String = rowdata.Get("Status")
				Dim DataConsegna As String = ""
				Dim DataScadenza As String = rowdata.Get("Scad.")			
				RowID_Riga =  rowdata.Get("Pos.") ' rowdata.GetValueAt(0)
				Dim TipoRiga As String = rowdata.Get("T")
				If TipoRiga.Trim = "" Then
					TipoRiga ="N"			
				End If								
				Dim NrRifPartita As String = Leggi_NB_Partita
			 	sqlstr  = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,UM,DataConsegna," _					
				 & "RifIdriga,Descrizione,rifidtesta,TipoRiga,DataScadenza,NrRifPartita,UM2,Qta2,Peso,NumEtichette,Status,Sconto,Note,Ordinato,UM3," _
				 & "QtaTotUMAConv,QtaTotUM2,CoeffConvUMA) VALUES " _
				 & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente & "','" & rowdata.Get("Cod. Art.") & "','" & Qta & "','" _
				 & UM1 & "','" & DataConsegna & "','" & rowdata.Get("RifIdriga") & "','" & rowdata.Get("Descrizione Art.") & "','" & RifIDTesta & "','" & TipoRiga & "','" & DataScadenza & "','" _
				 & NrRifPartita & "','" & UM2 & "','" & Qta2 & "','" & Peso & "','" & NumEtichette & "','" & Status & "','" & Sconto & "','" & Note & "','" & Ordinato & "','" & UM3 _
				 & "','" & rowdata.Get("QtaTotUMAConv") & "','" & rowdata.Get("QtaTotUM2")  & "','" & rowdata.Get("CoeffConvUMA")  & "')"
				SQLDataAccess.ExecNonQuery(sqlstr)
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Sleep(0)
	Dim Path_Php  As String = ""
	Dim job As HttpJob
	job.Initialize(JobName, frm)
	job.Tag = phpTag
	Try
		Dim mAction As String =  JobName.ToLowerCase
		If (Main.PortaPhp <> "") Then
			Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
		Else
			Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
		End If
		job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
			ProgressDialogHide
			If job.Success = True Then
				Dim jobResult As String = job.GetString
				job.release
				If (Main.DEBUG=1) Then
					MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
				End If
				Select job.JobName.ToLowerCase
					Case "get_is_anagraficaarticoli"
						Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

					Case "get_is_barcode"
						Log(Path_Php & "is_barcode.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_IS_Barcode(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
					Case "get_is_vistadocpalm"
						Log(Path_Php & "is_vista_docpalm.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						DB_SQLite.Create_Table_IS_VISTADOCPALM(SQLDataAccess)
						Wait For(DB_SQLSERVER.Leggi_Is_Vista_DocPalm(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
					Case "get_vista_fattoriconv"
						Log(Path_Php & "vista_fattoriconv.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						DB_SQLite.Create_Table_VISTA_FATTORICONV(SQLDataAccess)
						Wait For(DB_SQLSERVER.Leggi_Vista_FattoriConv(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
					Case Else
						Log("Errore nella procedura: Picking Execute_LeggiTab_PHP_POST_NESTI")
									
				End Select
				If (Main.DEBUG=1) Then
					MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
				End If
			End If
		Else
			MsgboxAsync("Errore " & job.JobName.ToLowerCase & " " & job.ErrorMessage,"ERRORE")
			Log("Error: " & job.ErrorMessage)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
	Return(True)
End Sub

Sub Leggi_Metodo_Tabelle As ResumableSub
	' LEGGI TABELLE DAL SERVER
		Try
			If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
				Label2.Visible = True
				DateTime.DateFormat = "yyyyMMdd HHmmss"
				'Dim dt As Long = DateTime.now
				'Dim OraInizio As String = ""
				Dim F_Device As Boolean = True
				Dim nt As Int = 0
				' Orainizio = DateTime.Time(dt)
				Log($"INIZIO IMPORTAZIONE ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
				Select Main.Ditta					
					Case "Nesti"
						Dim Tables() As String = Array As String("IS_ANAGRAFICAARTICOLI")
					Case Else
					Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_TABCAMBI","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF", _
					 "IS_ANAGRAFICADEPOSITI","IS_TABLISTINI","IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI","IS_VISTA_NOTE_ORDINI")
				End Select
				Dim Passo As Int = 100 / Tables.Length
				For Each table In Tables
					If (F_Device) Then
						nt = nt + 1
						Dim straction As String = "get_" & table
						Dim dbAction As Map = CreateMap("action=": straction)
						Select Main.Ditta
							Case "Nesti"
								WAIT FOR(Execute_LeggiTab_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
							Case Else
								WAIT FOR(Execute_LeggiTab_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						End Select						
					End If
				Next																
				Log($"FINE IMPORTAZIONE ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
				ToastMessageShow("Importazione Articoli terminata!",False)
				' Dim dt As Long = DateTime.now
				' Dim OraFine As String = ""
				' OraFine = DateTime.Time(dt)				
				Return True
			Else
				MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
				Return False
			End If
		Catch
			Log(LastException.Message) 'no changes will be made
			Return False
		End Try
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowID As Long)
	' Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowID)
	' SetRowColor(Index, Selected, Main.SelectionColor_Green)
	' RowID_Riga = RowID			
	' B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c13 = ? WHERE rowid = ?", Array ("C",RowID))
	' XSelections.Mode = 5
Select TipoOperazione
	Case "COF"
		XSelections.CellClicked(ColumnId,RowID,xui.Color_cyan)
		Dim acquisito As Double = 0
		Dim ordinato As String = ""
		Dim OrdinatoNum As Double = 0
		Dim RowData As Map
		RowData = B4XTable1.GetRow(RowID)
		RowID_Riga = RowData.GetValueAt(0)
		UM1 = RowData.GetValueAt(5)
		'UM1 = UM1.Replace(".","")
		UM2 = RowData.GetValueAt(7)
		'UM2 = UM2.Replace(".","")
		UMPeso = RowData.GetValueAt(9)
		'UMPeso = UMPeso.Replace(".","")
		Button3.Text = UM1
		Button4.Text = UM2
		Button5.Text = UMPeso
		ordinato = RowData.GetValueAt(4)
		OrdinatoNum = ExtraUtility.ConvertToNumber(RowData.GetValueAt(4))
		ordinato = ordinato.Replace(" ",CRLF)
		ordinato = ordinato.Replace(",","")
		vCodArticolo = RowData.GetValueAt(2)
		Label8.Text = ordinato
		Label16.Text =  NumberFormat2( RowData.GetValueAt(0),0,0,0,False)	' NR riga
		Label3.Text = RowData.GetValueAt(3)
		If (Label3.Text.IndexOf("**ESAURITO**")<>-1) Then
			ExtraUtility.Play_Sound("error.wav")
		End If	
		acquisitoum1 =  RowData.GetValueAt(6) ' Acquisito + UM
		If (acquisitoum1.StartsWith("0")) Then
			acquisito =  0
		Else
			If (IsNumber(acquisitoum1)) Then
				acquisito =  acquisitoum1
			Else
				Dim Pos As Int = acquisitoum1.IndexOf(" ")
				If (Pos>0) Then
					acquisito = acquisitoum1.SubString2(0,Pos)
				End If
			End If
		End If
		ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
		EditText2.Text = NumberFormat2(acquisito,0,0,0,False) 										'  acquisito um1
		EditText3.Text = NumberFormat2(LeggiQta(RowData.GetValueAt(8),Chr(32)),0,0,0,False)  		'  acquisito um2
		EditText4.Text = RowData.GetValueAt(10)		
		EditText5.Text = RowData.GetValueAt(11)
		MaskedEditText1.Text = ExtraUtility.Convert_Date_YYYY_to_YY(RowData.GetValueAt(12))
		acquisitoum1 = EditText2.Text & " " & UM1
		Dim Qta1 As Double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)	
		If(QtaStr="") Then
			Qta1 = EditText2.text
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As Double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		Label30.Text =  Converti_Qta_UMBase(SQLDataAccess,RowData.GetValueAt(2),UM1,OrdinatoNum) & " " & UM2
		Label31.Text =  QtaStr & " " & UM2
		If (UM1=UM2) Then
			Button3.Text = UM1
			Button4.Text = ""
		Else
			Button3.Text = UM1
			Button4.Text = UM2
		End If
		Dim Row_IDriga As Int = Label16.Text
		Dim ColoreInt As Int = 0
		Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
		If Colore <> "" Then
			ColoreInt = ExtraUtility.Decodifica_Colore_Int(Colore)
			SetRowColor(Row_IDriga,True,ColoreInt)
		Else
			SetRowColor(Row_IDriga,False,0)
		End If
	
	Case "INV"
		Label30.Visible=False
		Label31.Visible=False
		Label32.Visible=False		
		Button14.textColor=ExtraUtility.Color_DarkGreen
		Button15.textColor=xui.Color_Gray
		Button14.Tag="Pressed"
		Button15.Tag=""		
		XSelections.CellClicked(ColumnId,RowID,xui.Color_cyan)
		Dim TotQta As Int=0
		Dim acquisito As Double = 0
		Dim RowData As Map
		RowData = B4XTable1.GetRow(RowID)
		RowID_Riga = RowData.GetValueAt(0)
		vCodArticolo = RowData.GetValueAt(1)
		vDescrizioneArt = RowData.GetValueAt(2)
		vLottoCompleto = RowData.GetValueAt(9)
		UM1 = RowData.GetValueAt(3)
		If(RowData.GetValueAt(4)="") Then  
			TotQtaUM1 = 0
		Else
			TotQtaUM1 = RowData.GetValueAt(4)
		End If
		UM2 = RowData.GetValueAt(5)
		If(RowData.GetValueAt(6)="") Then
			TotQtaUM2 = 0
		Else
			TotQtaUM2 = RowData.GetValueAt(6)
		End If
		UMPeso = RowData.GetValueAt(7)
		If(CDbl(RowData.GetValueAt(8))=0) Then
			TotPesoArt = 0
		Else
			TotPesoArt = RowData.GetValueAt(8)
		End If
		If(RowData.GetValueAt(14)="") Then
			TotQta = 0
		Else
			TotQta = Round(RowData.Getvalueat(14))
		End If
		TotQtaUMX = TotQta
		Label37.Text = UM1
		Label38.Text = UM2
		Label40.Text = UMPeso
		Label39.Text = TotQtaUM1		
		Label41.Text = TotQtaUM2
		Label42.Text = TotPesoArt
		Label42.Text = Label42.Text.Replace(".",",")
		Button3.Text=Label37.Text
		Button4.Text=Label38.Text
		Button5.Text=Label40.Text
		If(UM2<>"") Then
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
		Else
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
		End If
		vCodArticolo = RowData.GetValueAt(1)
		Label16.Text =  NumberFormat2( RowData.GetValueAt(0),0,0,0,False)	' NR riga
		Label3.Text = RowData.GetValueAt(2)
		ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
		EditText2.Text = NumberFormat2(TotQtaUM1,0,0,0,False) 			' qta um1
		EditText3.Text = NumberFormat2(TotQtaUM2,0,0,0,False)  		' qta um2
		EditText4.Text = TotPesoArt		
		MaskedEditText1.Text = ExtraUtility.Convert_Date_YYYY_to_YY(RowData.GetValueAt(12))
		acquisitoum1 = EditText2.Text & " " & UM1
		Dim Qta1 As Double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
		If(QtaStr="") Then
			Qta1 = EditText2.text
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As Double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		Label30.Text =  Converti_Qta_UMBase(SQLDataAccess,RowData.GetValueAt(2),UM1,OrdinatoNum) & " " & UM2
		Label31.Text =  QtaStr & " " & UM2
		If (UM1=UM2) Then
			Button3.Text = UM1
			Button4.Text = ""
			EditText3.Visible=False
		Else
			Button3.Text = UM1
			Button4.Text = UM2
			EditText3.Visible=True
		End If
		Button5.Text = UMPeso
		If(UMPeso=UM2) Then
			Button4.Text = ""
			EditText3.Visible=False
		End If
		Dim Row_IDriga As Int = Label16.Text
		Dim ColoreInt As Int = 0
		'Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
		If Colore <> "" Then
			ColoreInt = ExtraUtility.Decodifica_Colore_Int(Colore)
			SetRowColor(Row_IDriga,True,ColoreInt)
		Else
			SetRowColor(Row_IDriga,False,0)
		End If
		Panel4.Visible=False
		Panel3.Visible=True
		Button1.Enabled=False
		Button14.Text=Button3.Text
		Button15.Text=Button4.Text
		Button16.Text=Button5.text
		Label38.Text=Button15.Text
		If(Button15.Text="") Then
			EditText8.Visible=False
		Else
			EditText8.Visible=True
		End If
		If(Button16.Text="") Then
			EditText9.Visible = False
		Else
			EditText9.Visible = True
		End If
		Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
		If (Pos>0) Then
			Label33.Text=vLottoCompleto.SubString(Pos+3)
		Else
			Label33.Text=vLottoCompleto
		End If
		Label34.Text=RowID_Riga
		Label35.Text=vDescrizioneArt
		
	Case "SPO"		
		Label30.Visible=False
		Label31.Visible=False
		Label32.Visible=False
		Button14.textColor=ExtraUtility.Color_DarkGreen
		Button15.textColor=xui.Color_Gray
		Button14.Tag="Pressed"
		Button15.Tag=""
		Button3.TextSize=16
		Button3.Typeface=Typeface.DEFAULT_BOLD
		XSelections.CellClicked(ColumnId,RowID,xui.Color_cyan)
		Dim TotQta As Int=0
		Dim acquisito As Double = 0
		Dim RowData As Map
		RowData = B4XTable1.GetRow(RowID)
		RowID_Riga = RowData.GetValueAt(0)
		vCodArticolo = RowData.GetValueAt(1)
		vCodArtLotto =  RowData.GetValueAt(1)
		vDescrizioneArt = RowData.GetValueAt(2)
		vLottoCompleto = RowData.GetValueAt(9)
		UM1 = RowData.GetValueAt(3)
		If(RowData.GetValueAt(4)="") Then
			TotQtaUM1 = 0
		Else
			TotQtaUM1 = RowData.GetValueAt(4)
		End If
		UM2 = RowData.GetValueAt(5)
		If(RowData.GetValueAt(6)="") Then
			TotQtaUM2 = 0
		Else
			TotQtaUM2 = LeggiQta(RowData.GetValueAt(6),Chr(32))
		End If
		UMPeso = RowData.GetValueAt(7)
		If(CDbl(RowData.GetValueAt(8))=0) Then
			TotPesoArt = 0
		Else
			TotPesoArt = RowData.GetValueAt(8)
		End If
		If(RowData.GetValueAt(14)="") Then
			TotQta = 0
		Else
			TotQta = Round(RowData.Getvalueat(14))
		End If
		TotQtaUMX = TotQta
		Label37.Text = UM1
		Label38.Text = UM2
		Label40.Text = UMPeso
		Label39.Text = TotQtaUM1
		Label41.Text = TotQtaUM2
		Label42.Text = TotPesoArt
		Label42.Text = Label42.Text.Replace(".",",")
		Button3.Text=Label37.Text
		Button4.Text=Label38.Text
		Button5.Text=Label40.Text
		If(UM2<>"") Then
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
		Else
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
		End If
		vCodArticolo = RowData.GetValueAt(1)
		Label16.Text =  NumberFormat2( RowData.GetValueAt(0),0,0,0,False)	' NR riga
		Label3.Text = RowData.GetValueAt(2)
		ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
		EditText2.Text = NumberFormat2(TotQtaUM1,0,0,0,False) 			' qta um1
		EditText3.Text = NumberFormat2(TotQtaUM2,0,0,0,False)  		' qta um2
		EditText4.Text = TotPesoArt
		MaskedEditText1.Text = ExtraUtility.Convert_Date_YYYY_to_YY(RowData.GetValueAt(12))
		acquisitoum1 = EditText2.Text & " " & UM1
		Dim Qta1 As Double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
		If(QtaStr="") Then
			Qta1 = CDbl(EditText2.text)
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As Double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		Label30.Text =  Converti_Qta_UMBase(SQLDataAccess,RowData.GetValueAt(2),UM1,OrdinatoNum) & " " & UM2
		Label31.Text =  QtaStr & " " & UM2
		If (UM1=UM2) Then
			Button3.Text = UM1
			Button4.Text = ""
			EditText3.Visible=False
		Else
			Button3.Text = UM1
			Button4.Text = UM2
			EditText3.Visible=True
		End If
		Button5.Text = UMPeso
		If(UMPeso=UM2) Then
			Button4.Text = ""
			EditText3.Visible=False
		End If
		Dim Row_IDriga As Int = Label16.Text
		Dim ColoreInt As Int = 0
		'Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
		If Colore <> "" Then
			ColoreInt = ExtraUtility.Decodifica_Colore_Int(Colore)
			SetRowColor(Row_IDriga,True,ColoreInt)
		Else
			SetRowColor(Row_IDriga,False,0)
		End If
		Panel4.Visible=False
		If(vTipoReadGiac="MAGCEL") Or (vTipoReadGiac="MAGCOR") Then
			Panel3.Visible=True
		End If		
		Button1.Enabled=False
		Button14.Text=Button3.Text
		Button15.Text=Button4.Text
		Button16.Text=Button5.text
		Label38.Text=Button15.Text
		If(Button15.Text="") Then
			EditText8.Visible=False
		Else
			EditText8.Visible=True
		End If
		If(Button16.Text="") Then
			EditText9.Visible = False
		Else
			EditText9.Visible = True
		End If
		Dim Pos As Int = vLottoCompleto.IndexOf("$NB")
		If (Pos>0) Then
			Label33.Text=vLottoCompleto.SubString(Pos+3)
		Else
			Label33.Text=vLottoCompleto
		End If
		Label34.Text=RowID_Riga
		Label35.Text=vDescrizioneArt
		
	End Select
	XSelections.Refresh(ColumnColor)
	B4XTable1.Refresh
	
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Try
		Dim column As B4XTableColumn = tableName.GetColumn(columnID)
		For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
			Dim pnl As B4XView = column.CellsLayouts.Get(i)
			Dim lbl As Label = pnl.GetView(0)
			lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
			lbl.Padding= Array As Int (0, 0, 10, 0)
		Next
	Catch
		Log(LastException)
	End Try
End Sub

'Sub B4XTable1_DataUpdated
'	SetColumnAlignment(B4XTable1,"Descrizione Art.",Gravity.LEFT)
'	If (B4XTable1.mCurrentCount>=1) Then
'		For i = 0 To B4XTable1.VisibleRowIds.Size-1 'B4XTable1.VisibleRowIds.size-1
'			Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
'			SetRowColor(i, SelectedRows.Contains(RowId))
'		Next
'	End If
'End Sub

Sub Leggi_IDkey(SQLData As SQL, TipoDoc As String, NumeroDoc As Int, Esercizio As Int ) As Long
	Try
		Dim rs As ResultSet
		Dim sqlstr As String
		sqlstr = "SELECT IDKEY FROM IS_TESTEDOCUMENTI WHERE TipoDoc ='" & TipoDoc & "' AND Numerodoc ='" & NumeroDoc & "' AND Esercizio = '" & Esercizio & "'"
		rs = SQLData.ExecQuery(sqlstr)
		If (rs.RowCount=0) Then
			IDkey=0
		Else
			Do While rs.NextRow
				IDkey = rs.GetLong("IDKEY")
			Loop
			rs.Close
		End If
		rs.Close
		Return(IDkey)
	Catch
		Log("ERRORE!: " & LastException)
		Return 0
	End Try
End Sub

Sub B4XTable1_DataUpdated
	Try
		SetColumnAlignment(B4XTable1,"Cod. Art.",Gravity.LEFT)
		SetColumnAlignment(B4XTable1,"Descrizione Art.",Gravity.LEFT)
		XSelections.Refresh(ColumnColor)
		EditText1.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_NB_Partita As String	
	Try
		Dim DD As String = ExtraUtility.DateToFormat(DateTime.Now,"dd","it","")
		Dim MM As String = ExtraUtility.DateToFormat(DateTime.Now,"MM","it","")
		Dim AA As String = ExtraUtility.DateToFormat(DateTime.Now,"YY","it","")
		Dim Partita As String = "NB" & AA & MM & DD
		Return Partita
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Private Sub HandleBackKey
	Try
		Msgbox2Async("Vuoi uscire dalla maschera?", "Pocket ISA", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Activity.Finish
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Try
		If KeyCode = KeyCodes.KEYCODE_BACK Then		
			HandleBackKey
			Return True
		Else
			Return False
		End If
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub EditText5_EnterPressed ' numero etichette
	Phone.HideKeyboard	
	B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c11 = ? WHERE rowid = ?", Array (EditText5.text,RowID_Riga))	
	B4XTable1.Refresh
	EditText1.RequestFocus
End Sub

Sub EditText4_EnterPressed ' peso kg
	Try
		If(Button5.Text="KG") Then
			Phone.HideKeyboard
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c10 = ? WHERE rowid = ?", Array (EditText4.Text, RowID_Riga))
			B4XTable1.Refresh
			EditText1.RequestFocus
		Else
			EditText4.Text=""	
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("PESO NON RICHIESTO!",False)
		End If
	Catch
		Log(LastException)
	End Try
End Sub
																																									
Sub EditText3_EnterPressed ' acquisitoum2
	Try
		If(Button4.Text<>"") Then
			Phone.HideKeyboard
			acquisitoum2 = EditText3.Text & " " & UM2
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c8 = ? WHERE rowid = ?", Array (acquisitoum2, RowID_Riga))
			B4XTable1.Refresh
			EditText1.RequestFocus
		Else
			EditText3.Text=""
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("QUANTITA' NON INSERIBILE!",False)
		End If		
		Dim Qta1 As Double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
		If(QtaStr="") Then
			Qta1 = 0
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As Double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		If(Button4.Text<>"") Then
			Dim FattoreC As Double = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
			Dim QtaTotUMA As Double = Round2(FattoreC*QtaStr,4)
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c16 = ?, c17 = ?, c18 = ?  WHERE rowid = ?", Array (QtaTotUMA,QtaStr,FattoreC,RowID_Riga))
		End If
		Label31.Text =  QtaStr & " " & UM2
		Dim Row_IDriga As Int = Label16.Text
		Dim ColoreInt As Int = 0
		Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
		If Colore <> "" Then
			ColoreInt = ExtraUtility.Decodifica_Colore_Int(Colore)
			SetRowColor(Row_IDriga,True,ColoreInt)
		Else
			SetRowColor(Row_IDriga,False,0)
		End If
		XSelections.Refresh(ColumnColor)
		B4XTable1.Refresh
		EditText1.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub

Sub EditText2_EnterPressed ' acquisitoum1
	Try
		Phone.HideKeyboard
		Dim ordinato_num As Double = LeggiQta(Label8.Text,CRLF)
		Dim acquisito_num As Double = CDbl(EditText2.Text)
		acquisitoum1 = EditText2.Text & " " & UM1
		B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6 = ? WHERE rowid = ?", Array (acquisitoum1, RowID_Riga))	
		Dim Qta1 As Double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
		If(QtaStr="") Then
			Qta1 = 0
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As Double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		Label31.Text =  QtaStr & " " & UM2	
		Dim Row_IDriga As Int = Label16.Text
		Dim ColoreInt As Int = 0
		Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
		If Colore <> "" Then
			ColoreInt = ExtraUtility.Decodifica_Colore_Int(Colore)
			SetRowColor(Row_IDriga,True,ColoreInt)
		Else
			SetRowColor(Row_IDriga,False,0)
		End If
		If(EditText2.Text<>"") Then
			Dim FattoreC As Double = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
			Dim QtaTotUMA As Double = Round2(FattoreC*QtaStr,4)
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c16 = ?, c17 = ?, c18 = ?  WHERE rowid = ?", Array (QtaTotUMA,QtaStr,FattoreC,RowID_Riga))
		End If
		XSelections.Refresh(ColumnColor)
		B4XTable1.Refresh
		EditText1.RequestFocus
	Catch
		Log(LastException)
	End Try
End Sub

Sub MaskedEditText1_EnterPressed ' data scadenza	
	Try
		Phone.HideKeyboard
		Dim datascadenza As String = MaskedEditText1.Text.SubString2(0,8)		
		DateTime.DateFormat = "dd/MM/yy"
		DateTime.DateParse(datascadenza)
		datascadenza = ExtraUtility.Convert_Date_YY_to_YYYY(datascadenza)
		B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c12 = ? WHERE rowid = ?", Array (datascadenza, RowID_Riga))
		B4XTable1.Refresh
		Phone.HideKeyboard	
		EditText1.RequestFocus
	Catch
		MaskedEditText1.ShowError("Data Errata")
		MaskedEditText1.RequestFocus
		Return
	End Try
End Sub

Sub MaskedEditText1_FocusChanged (HasFocus As Boolean)  ' data scadenza
	If HasFocus=False Then
		If(MaskedEditText1.Text <> "__-__-__") And (Label16.Text.Trim <> "") Then
			'Is the date valid?
			Try				
				Phone.SetCustomFilter(MaskedEditText1, MaskedEditText1.INPUT_TYPE_PHONE, "0123456789-")
				Dim datascadenza As String = MaskedEditText1.Text.SubString2(0,8)
				DateTime.DateFormat = "dd/MM/yy"
				DateTime.DateParse(datascadenza)
				datascadenza = ExtraUtility.Convert_Date_YY_to_YYYY(datascadenza)
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c12 = ? WHERE rowid = ?", Array (datascadenza, RowID_Riga))
				B4XTable1.Refresh
				Phone.HideKeyboard
			Catch
				MaskedEditText1.ShowError("Data Errata")
				MaskedEditText1.RequestFocus
				Return
			End Try
		Else
			' EditText1.RequestFocus
		End If
	Else
		Try
			MaskedEditText1.SelectAll			
			Phone.SetCustomFilter(MaskedEditText1, MaskedEditText1.INPUT_TYPE_PHONE, "0123456789-")
			Dim datascadenza As String = MaskedEditText1.Text.SubString2(0,8)
			If (MaskedEditText1.Text <> "__-__-__") And (Label16.Text.Trim <> "") Then				
				DateTime.DateFormat = "dd/MM/yy"
				DateTime.DateParse(datascadenza)
				datascadenza = ExtraUtility.Convert_Date_YY_to_YYYY(datascadenza)
			End If
			' B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c12 = ? WHERE rowid = ?", Array (MaskedEditText1.Text, RowID_Riga))
			' 1B4XTable1.Refresh
			' Phone.HideKeyboard
			' EditText1.RequestFocus
		Catch
			MaskedEditText1.ShowError("Data Errata")
			MaskedEditText1.RequestFocus
			Return
		End Try
	End If
End Sub

Sub EditText1_EnterPressed
	' 8056455939510
	Dim Phone As IME
	Phone.HideKeyboard
	vBarcodeLetto = EditText1.Text
	If (B4XTable1.Size=0) Then
		' idtesta = 593578		
		sqlstr = "select rowid, POSIZIONE, TIPORIGA, CODART, DESCRIZIONEART, QTAGEST, UMGEST, UMA, UMP, UMV, TIPODOC, NUMERODOC, DATADOC, DSCCONTO1, " _
		& "NUMEROETICHETTE, FLAG_BILANCIA, CODCLIFOR, IDRIGA FROM IS_VISTADOCPALM WHERE IDTESTA='" & vBarcodeLetto & "' ORDER BY POSIZIONE"	
		Log(sqlstr)
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Dim i As Int = 0
		Do While rs.NextRow			
			Dim rowx(19) As Object
			If rs.GetDouble("QTAGEST") Mod 1=0 Then 	' fa le stesse veci della funzione int() se intero elimno eventuali decimali
				Ordinatoum = NumberFormat2(rs.GetDouble("QTAGEST"),0,0,0,False)
			Else
				Ordinatoum = rs.GetDouble("QTAGEST")
			End If
			rowx(0) = rs.GetInt("POSIZIONE")
			rowx(1) = rs.Getstring("TIPORIGA")
			rowx(2) = rs.Getstring("CODART")
			rowx(3) = rs.Getstring("DESCRIZIONEART")
			rowx(4) = Ordinatoum & " " & rs.GetString("UMGEST")
			rowx(5) = rs.GetString("UMGEST")
			rowx(6) = 0 ' Acquisito + UMGest							
			rowx(7) = Leggi_UMBase(rowx(2),rowx(5))
			rowx(8) = 0	'Acquisito UM2
			If(rs.GetString("FLAG_BILANCIA")="S") Then
				rowx(9) = "KG" ' KG se a peso
			Else
				rowx(9) = ""   '
			End If
			rowx(10) = 0 ' Peso in KG
			rowx(11) = "" ' rs.GetString("NUMEROETICHETTE") ' num. etichette
			rowx(12) = ""									' Data Scadenza
			rowx(13) = ""                          			' status colore
			rowx(14) = rs.GetInt("POSIZIONE")     			' prorità variabile
			rowx(15) = rs.GetInt("IDRIGA")     				' IDRiga
			rowx(16) = 0				    				' 
			rowx(17) = 0				    				'
			rowx(18) = 0				    				'
			DataList.Add(rowx)
		Loop
		If(rs.RowCount>0) Then			
			If (Label1.Text.Trim="") Then
				vRifIdTesta = vBarcodeLetto		' riferimento IDTesta
				Dim DataDoc As String = ExtraUtility.ConvertDateTimeTo_ITA_Format(rs.GetString("DATADOC"),False)		
				Label1.Text = " " & rs.GetString("TIPODOC") & " N. " & rs.GetString("NUMERODOC") & " DEL " & DataDoc & " - " & rs.GetString("DSCCONTO1") '  & rs.GetString("DATADOC")
				TipoDocOrig = rs.GetString("TIPODOC")
				NumDocOrig = rs.GetInt("NUMERODOC")
				DataDocOrig = DataDoc
				vCodCliFor = rs.GetString("CODCLIFOR")
				Priorita = 0
				Col1_Column.InternalSortMode="ASC"
				Col1_Column.Sortable = True
				vTipoDocNew = DB_SQLite.Leggi_AnagraficaCF(SQLDataAccess,rs.GetString("CODCLIFOR"),"TipoDoc")				
				If(vTipoDocNew="") Then
					Panel2.Visible=True			
					Leggi_ParametriDoc("F")	
				Else
					Label6.Text = vTipoDocNew
					Label6.TextSize = 11dip
				End If
			End If			
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("DOCUMENTO CARICO NON TROVATO!" & CRLF & "SINCRONIZZARE IL DISPOSITIVO!",False)		
		End If
		rs.Close
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.SetData(DataList)
		If(DataList.Size>0) Then
			' B4XTable1.UpdateTableCounters
			TotalSize = B4XTable1.Size	
		Else
			TotalSize = 0
		End If
	Else
		vCodArticolo = ""				
		Dim CodiceLetto As String = EditText1.Text.Trim
		If (CodiceLetto.Length=13) And (CodiceLetto.SubString2(0,1)="2") Then
			' Decodifico articolo a peso, in realtà solo l'articolo
			Dim Result As List
			Result = ExtraUtility.LeggiArticoloConPeso(CodiceLetto,1)	' estrae l'articolo dalla stringa letta
			CodiceLetto = Result.Get(0)
		End If
		sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLetto & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label3.Text = rs.GetString("DESCRIZIONE")
				vCodArticolo = rs.GetString("CODICE")
				If (rs.GetInt("ESAURITO")<>0) Then
					ExtraUtility.Play_Sound("error.wav")
					Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
				End If
			Loop
			rs.close
		Else
			sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
			& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & CodiceLetto & "'"
			Log (sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)				
			If (rs.RowCount>0) Then
				Do While rs.NextRow
					Label3.Text = rs.GetString("DESCRIZIONE")
					vCodArticolo = rs.GetString("ARTICOLO")
					If (rs.GetInt("ESAURITO")<>0) Then
						ExtraUtility.Play_Sound("error.wav")
						Label3.Text = "**ESAURITO** " & rs.GetString("DESCRIZIONE")
					End If
				Loop
				rs.close
			Else				
				'--------------------------------------------------------------------------------
				' nel caso non venga decodificato il codice si applica funzione Decodifica_EAN
				'--------------------------------------------------------------------------------
				Dim vRes As tRec_EANCODE = DBUtilsExtra.Decodifica_CodiceEAN(SQLDataAccess,vBarcodeLetto)
				If (vRes.IsInitialized) Then
					' MsgboxAsync	("OK trovato","TEST EAN")
					vCodArticolo = vRes.Codart		
					Label3.Text = vRes.Descrizione			
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label3.Text = "*** CODICE ERRATO ***"
					vCodArticolo = ""
				End If
			End If
		End If
		Dim cell As String
		Dim acquisito As Double = 0
		Dim ordinato As String = ""
		Dim OrdinatoNum As Double = 0
		Dim RowData As Map 
		' prova = B4XTable1.GetRow(0).GetValueAt(1).
		For i=1 To B4XTable1.Size
			RowData = B4XTable1.GetRow(i)
			' cell = RowData.Get("Cod. Art.")
			' RowData.GetValueAt(1)
			cell = RowData.GetValueAt(2)
			If( cell = vCodArticolo) Then			
				RowID_Riga = RowData.GetValueAt(0)
				UM1 = RowData.GetValueAt(5)				
				' UM1 = UM1.Replace(".","")
				UM2 = RowData.GetValueAt(7)
				' UM2 = UM2.Replace(".","")
				UMPeso = RowData.GetValueAt(9)
				UMPeso = UMPeso.Replace(".","")
				Button3.Text = UM1
				Button4.Text = UM2
				Button5.Text = UMPeso
				ordinato = RowData.GetValueAt(4)
				OrdinatoNum = ExtraUtility.ConvertToNumber(RowData.GetValueAt(4))
				ordinato = ordinato.Replace(" ",CRLF)
				ordinato = ordinato.Replace(",","")
				Label8.Text = ordinato
				vRigaDoc =  NumberFormat2( RowData.GetValueAt(0),0,0,0,False)	' NR riga
				Label16.Text = vRigaDoc
				acquisitoum1 =  RowData.GetValueAt(6) ' Acquisito + UM							
				If (acquisitoum1.StartsWith("0")) Then				
					acquisito = 0 ' OrdinatoNum
				Else
					If (IsNumber(acquisitoum1)) Then
						acquisito =  acquisitoum1
					Else
						Dim Pos As Int = acquisitoum1.IndexOf(" ")
						If (Pos>0) Then
							acquisito = acquisitoum1.SubString2(0,Pos)
						End If						
					End If
				End If
				ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)				
				EditText2.Text = NumberFormat2( acquisito,0,0,0,False) 	' acquisito um1
				EditText3.Text = RowData.GetValueAt(8)  				' acquisito um2
				EditText4.Text = RowData.GetValueAt(10)					' peso kg
				'	If (RowData.GetValueAt(11)="") Then
				'		EditText5.text = NumberFormat2(0,0,0,0,False)				' numero etichette
				'	Else
				'		EditText5.text = NumberFormat2( RowData.GetValueAt(11),0,0,0,False)				' numero etichette
				'	End If
				EditText5.Text = RowData.GetValueAt(11)
				MaskedEditText1.Text = ""
				acquisitoum1 = EditText2.Text & " " & UM1				
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6 = ? WHERE rowid = ?", Array (acquisitoum1, RowID_Riga))
				Dim Index As Int  = RowData.GetValueAt(0) 
				'B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c13 = ? WHERE rowid = ?", Array ("G",RowID_Riga))
				'XSelections.CellClickedForced2("",Index,xui.Color_green)
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c13 = ? WHERE rowid = ?", Array ("P",RowID_Riga))
				'SetRowColor(Index, True, Main.SelectionColor_Pink)  ' selected -> true
				XSelections.CellClickedForced2("",Index,xui.Color_Magenta)
				B4XTable1.Refresh
			End If
			Log("Pos. " & i & " - " & cell)
		Next
		If ( vRigaDoc.Trim = "") Then
			Label16.Text = ""
			ToastMessageShow("ARTICOLO NON TROVATO NELL'ORDINE!",True)
			ExtraUtility.Play_Sound("error.wav")
		End If
	End If
	Dim Finito As Boolean =	VerificaOrdineCompleto
	If(Finito) Then
		ExtraUtility.Play_Sound("Sound3.wav")
		MsgboxAsync("Ordine Completato con successo!","CONTROLLO ORDINE")
	End If
	EditText1.RequestFocus
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	Try
		If HasFocus=False Then
			If(EditText1.Text <> "")  Then
				EditText1.Text=""
				EditText1.RequestFocus
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub EditText2_FocusChanged (HasFocus As Boolean) ' acquisito um1
	If HasFocus=False Then
		If(EditText2.Text <> "")  Then			
			Dim ordinato_num As Double = LeggiQta(Label8.Text,CRLF)
			Dim acquisito_num As Double = EditText2.Text
			Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
			Dim ColoreInt As Int = ExtraUtility.Decodifica_Colore_Int(Colore)
			acquisitoum1 = EditText2.Text & " " & UM1
			Dim Qta1 As Double = 0
			Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
			If(QtaStr="") Then
				Qta1 = 0
			Else
				Qta1 = QtaStr
			End If
			Dim Qta2 As Double = CInt(EditText3.Text)
			QtaStr =  Qta1 + Qta2
			Label31.Text =  QtaStr & " " & UM2
			Dim Row_IDRiga As Int = Label16.text					
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6 = ?, c13 = ?  WHERE rowid = ?", Array (acquisitoum1, Colore, Row_IDRiga))
			SetRowColor(Row_IDRiga,True,ColoreInt)								
			If(EditText2.Text<>"") Then
				Dim FattoreC As Double = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
				Dim QtaTotUMA As Double = Round2(FattoreC*QtaStr,4)
				B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c16 = ?, c17 = ?, c18 = ?  WHERE rowid = ?", Array (QtaTotUMA,QtaStr,FattoreC,RowID_Riga))
			End If
			XSelections.Refresh(ColumnColor)
			B4XTable1.Refresh
			Phone.HideKeyboard
			EditText1.RequestFocus
		End If
	Else
		EditText2.SelectAll
	End If
End Sub

Sub Leggi_UMBase(Codart As String, UMA As String) As String
	Dim List_UM As List
	Dim UMBASE As List
	UMBASE.Initialize
	List_UM.Initialize
	UMBASE = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT UMBASE FROM VISTA_FATTORICONV WHERE CODART ='" & Codart & "' AND UMA ='" & UMA & "'",Null,1)
	For Each arr_umbase() As String In UMBASE
		List_UM.Add(arr_umbase(0))		
	Next	
	If List_UM.Size>0 Then
		Dim UM As String = arr_umbase(0)
		Return UM
	Else
		Return ""
	End If
End Sub

Sub CInt(o As Object) As Int
	Try
		If o = "" Then
			Return 0
		Else
			Return Floor(o)
		End If
	Catch
		Return 0
	End Try
End Sub

Sub CDbl(o As Object) As Double
	Try
		If (IsNumber(o)) Then
			Dim dbl As Double = o
			Return dbl
		Else
			If o = "" Then
				Return 0
			Else
				Dim str As String = o
				str = str.Replace(",",".")
				o = str
				Return o
			End If
		End If
	Catch
		Return 0
	End Try
End Sub

Sub Leggi_FattoreC(SQLData As SQL,Codart As String, UMA As String) As Double
	Try
		Dim FattoreFC As Double
		Dim rs As ResultSet = SQLData.ExecQuery2("SELECT FATTORE FROM VISTA_FATTORICONV WHERE CODART = ? AND UMA = ?", Array As String (Codart,UMA))
		Dim row(1) As Object
		row(0) = 0
		Do While rs.NextRow			
			row(0) = rs.GetDouble("FATTORE")
		Loop
		FattoreFC = row(0)
		Return FattoreFC		
	Catch
		Log("ERRORE!: " & LastException)
		Return 0
	End Try
End Sub

Sub Converti_Qta_UMBase(SQLData As SQL, Codart As String, UMA As String, Qta As String) As Double
	Try	
		Dim QtaStr As String
		Dim FattoreFC As Double
		If(Codart<>"") Then
			Dim rs As ResultSet = SQLData.ExecQuery2("SELECT FATTORE FROM VISTA_FATTORICONV WHERE CODART = ? AND UMA = ?", Array As String (Codart,UMA))
			Dim row(1) As Object
			row(0) = 0
			Do While rs.NextRow
				row(0) = rs.GetDouble("FATTORE")
			Loop
			FattoreFC = row(0)
			If FattoreFC<>0 Then			
				Dim QtaStr As String = ""
				Dim fx As Double = 0
				If(FattoreFC<>0) Then
					Dim QtaNum As Double = CDbl(Qta)
					fx = (QtaNum/FattoreFC)
					QtaStr = Round2(fx,2)
				End If			
				Return QtaStr
			Else
				Return 0
			End If
		Else
			Return 0
		End If
	Catch 
		Log("ERRORE!: " & LastException)
		Return 0
	End Try
End Sub

Sub LeggiQta(stringa As String, separator As Char) As Double
	' Estrae la quantità dalla stringa 10 CT
	Try
		If (stringa.Length>0) Then			
			Dim Pos As Int = stringa.IndexOf(separator)
			If Pos>=0 Then
				Dim Result As Double = stringa.SubString2(0,Pos)
				Return Result
			Else
				Result = stringa
				Return Result
			End If
		Else
			Return 0
		End If
	Catch
		Return 0
	End Try
End Sub

Sub LeggiUM(stringa As String, separator As Char) As String
	' Estrae la quantità dalla stringa 10 CT
	Dim Pos As Int = stringa.IndexOf(separator)
	If Pos>=0 Then
		Return stringa.SubString(Pos+1)
	Else
		Return ""
	End If
End Sub

Sub EditText3_FocusChanged (HasFocus As Boolean) ' acquisito um2
	If HasFocus=False Then
		If(EditText3.Text <> "")  Then
			acquisitoum2 = EditText3.Text & " " & UM2
			Dim Colore As String = ExtraUtility.Decodifica_Colore_Valore(LeggiQta(Label30.Text,Chr(32)),LeggiQta(Label31.text,Chr(32)))
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c8 = ?, c13 = ? WHERE rowid = ?", Array (acquisitoum2,Colore, RowID_Riga))
			Dim Qta1 As Double = 0
			Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
			If(QtaStr="") Then
				Qta1 = 0
			Else
				Qta1 = QtaStr
			End If
			Dim Qta2 As Double = CDbl(EditText3.Text)
			QtaStr =  Qta1 + Qta2
			Label31.Text =  QtaStr & " " & UM2
			Dim FattoreC As Double = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
			Dim QtaTotUMA As Double = Round2(FattoreC*QtaStr,4)
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c16 = ?, c17 = ?, c18 = ?  WHERE rowid = ?", Array (QtaTotUMA,QtaStr,FattoreC,RowID_Riga))			
			B4XTable1.Refresh
			Phone.HideKeyboard
			EditText1.RequestFocus
		Else
			' EditText1.RequestFocus
		End If
	Else
		EditText3.SelectAll
	End If
End Sub

Sub EditText4_FocusChanged (HasFocus As Boolean)  ' peso kg
	If HasFocus=False Then
		If(EditText4.Text <> "")  Then		
			Dim Peso As String = EditText4.Text.Replace(",",".").trim
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c10 = ? WHERE rowid = ?", Array (Peso, RowID_Riga))
			B4XTable1.Refresh
			Phone.HideKeyboard
			EditText1.RequestFocus
		Else
			' EditText1.RequestFocus
		End If
	Else
		EditText4.SelectAll
		Phone.SetCustomFilter(EditText4, EditText4.INPUT_TYPE_NUMBERS, "0123456789,")
	End If
End Sub

Sub EditText5_FocusChanged (HasFocus As Boolean)  ' numero etichette
	If HasFocus=False Then
		If(EditText5.Text <> "")  Then			
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c11 = ? WHERE rowid = ?", Array (EditText5.Text, RowID_Riga))
			B4XTable1.Refresh
			Phone.HideKeyboard
			EditText1.RequestFocus
		End If
	Else
		EditText5.SelectAll		
	End If
End Sub

Sub ComboBoxTipoDoc_SelectedIndexChanged (Index As Int)
	If (ComboBoxTipoDoc.SelectedIndex>0) Then
		Panel2.Visible=False		
		Dim listInv As List
		Dim ListCorsie As List
		Select Case Choose_Menu.vOperazioneMenu
			Case "Inventario"
				ListCorsie.Initialize
				vFoglioInv = List_TipoDoc_Desc.get(Index)				
				listInv  = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODMAGAZZINO,FLAG_UBICAZIONECORSIA FROM IS_IMPOSTAZIONICTRLINV WHERE NOMEIMPOSTAZIONE = '"& vFoglioInv & "'",Null,0)
				For Each arr_valore() As String In listInv
					ListCorsie.Add(arr_valore(0))
					ListCorsie.Add(arr_valore(1))
				Next
				vCorsia = ListCorsie.Get(0)
				vCorsiaUbicaz = ListCorsie.Get(1)
				Label1.Text = vFoglioInv
				B4XTable1.mBase.Visible=True

			Case "Spostamento"
				ListCorsie.Initialize
				vCodDeposito = ""
				vDescDeposito = List_TipoDoc_Desc.get(Index)
				If(vDescDeposito<>"DA CELLA/CORSIA") Then
					listInv  = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE,DESCRIZIONE FROM IS_ANAGRAFICADEPOSITI WHERE DESCRIZIONE = '"& vDescDeposito & "'",Null,0)
					For Each arr_valore() As String In listInv
						ListCorsie.Add(arr_valore(0))
						ListCorsie.Add(arr_valore(1))
					Next
					vCodDeposito = ListCorsie.Get(0)
					vDescDeposito = ListCorsie.Get(1)
					Label1.Text = "SPOSTAMENTO DA " & vCodDeposito & " A CELLA/CORSIA"
					vTipoReadGiac="MAG"
					
				Else
					Select vDescDeposito
						Case "DA CELLA/CORSIA"							
							vCodDeposito = ""
							vCorsia = ""
							vCorsiaUbicaz = ""
							Label1.Text = "SPOSTAMENTO DA "
							vTipoReadGiac = ""
														
					End Select					
				End If
				B4XTable1.mBase.Visible=True
							
			Case Else
				vTipoDocNew =  List_TipoDoc.Get(Index)
				Label6.Text = vTipoDocNew
				
		End Select
		Label6.TextSize = 11dip
		EditText1.RequestFocus		
	End If
End Sub

Private Sub InsertRigaDoc(xNumPos As Int,xCodArt As String, xLotto As String, xCodDep As String, xCodDepColl As String, xCodUbic As String, xCodUbicColl As String, xUM1 As String, xQta1 As String, xUM2 As String, xQta2 As String, xUM3 As String, xQta3 As Double, xSvuotaCella As Int, xTipoReadGiac As String)
	
	Dim xDescArt As String = Label3.Text
	Dim xMaxPriority As Int = Leggi_MaxPriorita_Data
	Dim xCorsiaUbicaz As String = xCodDep & xCodUbic
	Dim xCorsiaUbicazColl As String = xCodDepColl & xCodUbicColl
	xCorsiaUbicaz = xCorsiaUbicaz.Trim
	xCorsiaUbicazColl = xCorsiaUbicazColl.Trim
	B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(xNumPos,xCodArt,xDescArt,xUM1,xQta1,xUM2,xQta2,xUM3,xQta3,xLotto,"","P",xMaxPriority,xQta1,xQta2,0,xCorsiaUbicaz,xCorsiaUbicazColl,xSvuotaCella,xTipoReadGiac))
				
End Sub

Private Sub LeggiArticolo (CorsiaUbicazione As String) As String
	Try
		Dim aCodart As String = ""
		Dim aCorsia As String = ""
		Dim aUbicazione As String = ""
		If(CorsiaUbicazione.Trim.SubString2(0,2)="CS") Then
			aCorsia=CorsiaUbicazione.SubString2(0,5)
			aUbicazione.Trim.SubString(5)
		End If	
		aCodart = SQLDataAccess.ExecQuerySingleResult("SELECT Codice FROM IS_ANAGRAFICAARTICOLI WHERE CORSIA ='" & aCorsia & "' AND UBICAZIONE ='" & aUbicazione & "'")
		Return aCodart	
	Catch
		Return ""
	End Try
End Sub

Private Sub Leggi_ParametriDoc(TipoCF As String)
	Dim ListDoc As List
	ListDoc.Initialize
	List_TipoDoc.Initialize
	List_TipoDoc_Desc.Initialize
	List_TipoDoc_TipoCliFor.Initialize
	Label3.Text = ""
	ComboBoxTipoDoc.cmbBox.Clear
	Select Case TipoCF
		Case "F"
			ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='" & TipoCF & "' AND TipoDoc<>'INV'",Null,0)
		Case "C"
			ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='" & TipoCF & "'",Null,0)
		Case "X"
			ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC WHERE TipoCliFor ='F' AND TipoDoc='INV'",Null,0)
		Case Else
			ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Codice, TipoDoc, Descrizione,TipoCliFor FROM IS_PARAMETRIDOC",Null,0)
	End Select
	ComboBoxTipoDoc.cmbBox.Add("")
	List_TipoDoc.Add("")
	List_TipoDoc_Desc.Add("")
	List_TipoDoc_TipoCliFor.Add("")
	For Each arr_TipoDoc() As String In ListDoc
		ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(1) & " - " & arr_TipoDoc(2))
		List_TipoDoc.Add(arr_TipoDoc(1))
		List_TipoDoc_Desc.Add( arr_TipoDoc(2))
		List_TipoDoc_TipoCliFor.Add(arr_TipoDoc(3))
	Next
	ComboBoxTipoDoc.SelectedIndex=0
End Sub

Private Sub Leggi_GiacenzeLotti(CodArt As String, vCodOrigine As String, vCodDestinaz As String,Tipo As String)
	Try
		Dim ListGL As List		
		Label43.Text = "LOTTI / GIACENZE : " & CodArt
		Select Tipo			
			Case "CORCOR"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=False
				Button17.Visible=True
				Button19.Visible=True
				
			Case "CELCEL"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=False
				Button17.Visible=True
				Button19.Visible=True
				
			Case "CELCOR"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=False
				Button17.Visible=True
				Button19.Visible=True
				
			Case "MAGCEL"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=True
				Button17.Visible=False
				Button19.Visible=False
			
			Case "MAGCOR"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=True
				Button17.Visible=False
				Button19.Visible=False

			Case "CORMAG"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=False
				Button17.Visible=True
				Button19.Visible=True
				
			Case "CELMAG"
				EditText10.Text=vCodOrigine
				EditText6.Text=vCodDestinaz
				Button18.Visible=False
				Button17.Visible=True
				Button19.Visible=True
				
			Case Else	
				
				
		End Select
		ListGL.Initialize

		Dim lgo1 As LottoGiacenzeType
		Dim lgo2 As LottoGiacenzeType
		Dim lgo3 As LottoGiacenzeType

		LottiGiacOrig.Clear	
			
		Select Tipo
			Case "MAGCOR"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodOrigine & "' ORDER BY LOTTO ASC"
			
			Case "MAGCEL"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodOrigine & "' ORDER BY LOTTO ASC"							
				
			Case "CORCOR"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodOrigine & "' ORDER BY LOTTO ASC"							
				
			Case "CELCEL"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodDeposito & "' AND CODUBICAZIONE = '" & vCorsiaUbicaz & "' ORDER BY LOTTO ASC"	
				
			Case "CELCOR"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodDeposito & "' AND CODUBICAZIONE = '" & vCorsiaUbicaz & "' ORDER BY LOTTO ASC"	
				
			Case "CELMAG"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodDeposito & "' AND CODUBICAZIONE = '" & vCorsiaUbicaz & "' ORDER BY LOTTO ASC"	
				
			Case "CORMAG"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodDeposito & "' ORDER BY LOTTO ASC"	
				
			Case "CELCOR"
				sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE GIACENZA1<>0 AND " _
				& "CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  vCodDeposito & "' AND CODUBICAZIONE = '" & vCorsiaUbicaz & "' ORDER BY LOTTO ASC"	
				
			Case Else
				MsgboxAsync("ERRORE NELLA PROCEDURA 'Leggi_GiacenzeLotti'","ERRORE")					
				
		End Select		
		ListGL = DBUtils.ExecuteMemoryTable(SQLDataAccess,sqlstr,Null,0)
		For Each arr_GL() As String In ListGL
			Dim lo As LottoGiacenzeType
			lo.Lotto = arr_GL(0)
			lo.Giac1 = arr_GL(1) & " " & arr_GL(2)			
			lo.Giac2 = arr_GL(3) & " " & arr_GL(4)
			lo.GiacPeso = arr_GL(5)			
			LottiGiacOrig.Add(lo)		
		Next	
		 					
		Dim vSize As Int = ListGL.size
		
		Select Case vSize
			Case 0
				Label44.Text = ""
				Label47.Text = ""
				Label49.Text = ""
				Label45.Text = ""
				Label46.Text = ""
				Label48.Text = ""
				Label50.Text = ""
				Label51.Text = ""
				Label52.Text = ""
				
			Case 1
				lgo1 = LottiGiacOrig.Get(0)
				Label44.Text = lgo1.Lotto
				Label47.Text = ""
				Label49.Text = ""
				Label45.Text = lgo1.Giac1
				Label46.Text = ""
				Label48.Text = ""
				Label50.Text = lgo1.Giac2
				Label51.Text = ""
				Label52.Text = ""
				
							
			Case 2
				lgo1 = LottiGiacOrig.Get(0)
				lgo2 = LottiGiacOrig.Get(1)
				Label44.Text = lgo1.Lotto
				Label47.Text = lgo2.Lotto
				Label49.Text = ""
				Label45.Text = lgo1.Giac1
				Label46.Text = lgo2.Giac1
				Label48.Text = ""
				Label50.Text = lgo1.Giac2
				Label51.Text = lgo2.Giac2
				Label52.Text = ""
				
			Case Else
				lgo1 = LottiGiacOrig.Get(0)
				lgo2 = LottiGiacOrig.Get(1)
				lgo3 = LottiGiacOrig.Get(2)
				Label44.Text = lgo1.Lotto
				Label47.Text = lgo2.Lotto
				Label49.Text = lgo3.Lotto
				Label45.Text = lgo1.Giac1
				Label46.Text = lgo2.Giac1
				Label48.Text = lgo3.Giac1
				Label50.Text = lgo1.Giac2
				Label51.Text = lgo2.Giac2
				Label52.Text = lgo3.Giac2
								
		End Select
					
		Dim CodDeposito2 As String = ""
		Dim Ubicazione2 As String = ""
		If(vCodDestinaz<>"") Then
			If (vCodDestinaz.SubString2(0,2)="CS") Then
				CodDeposito2 = vCodDestinaz.SubString2(0,5)
				Ubicazione2 = vCodDestinaz.SubString(5)
			End If
			Select Tipo
				Case "MAGCOR"				
					sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE " _
					& "GIACENZA1>0 AND GIACENZA2>0 AND CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  CodDeposito2 _
					& "' ORDER BY LOTTO ASC"
					
				Case "MAGCEL"
					sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE " _
					& "GIACENZA1>0 AND GIACENZA2>0 AND CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  CodDeposito2 _
					& "' AND CODUBICAZIONE ='" & Ubicazione2 & "' ORDER BY LOTTO ASC"					
		
				Case "CORCOR"
					sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE " _
					& "GIACENZA1>0 AND GIACENZA2>0 AND CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  CodDeposito2 _
					& "' AND CODUBICAZIONE ='" & Ubicazione2 & "' ORDER BY LOTTO ASC"	
								
				Case Else					
					sqlstr = "SELECT LOTTO,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO FROM VISTA_GIACENZA WHERE " _
					& "GIACENZA1>0 AND GIACENZA2>0 AND CodArt ='" & CodArt & "' AND CODDEPOSITO ='" &  CodDeposito2 _
					& "' AND CODUBICAZIONE ='" & Ubicazione2 & "' ORDER BY LOTTO ASC"
					
			End Select
			ListGL = DBUtils.ExecuteMemoryTable(SQLDataAccess,sqlstr,Null,0)
			For Each arr_GL() As String In ListGL
				Dim ld As LottoGiacenzeType
				ld.Lotto = arr_GL(0)
				ld.Giac1 = arr_GL(1) & " " & arr_GL(2)
				ld.Giac2 = arr_GL(3) & " " & arr_GL(4)
				ld.GiacPeso = arr_GL(5)			
				LottiGiacDest.Add(ld)
			Next
			Dim vSize As Int = ListGL.size
			
			Dim lgd1 As LottoGiacenzeType
			Dim lgd2 As LottoGiacenzeType
			Dim lgd3 As LottoGiacenzeType
			
			Select Case vSize
				Case 0
					Label54.Text = ""
					Label55.Text = ""
					Label56.Text = ""
					Label59.Text = ""
					Label58.Text = ""
					Label57.Text = ""
					Label60.Text = ""
					Label61.Text = ""
					Label62.Text = ""
					
				Case 1
					lgd1 = LottiGiacDest.Get(0)
					Label54.Text = lgd1.Lotto
					Label55.Text = ""
					Label56.Text = ""
					Label59.Text = lgd1.Giac1
					Label58.Text = ""
					Label57.Text = ""
					Label60.Text = lgd1.Giac2
					Label61.Text = ""
					Label62.Text = ""
								
				Case 2
					lgd1 = LottiGiacDest.Get(0)
					lgd2 = LottiGiacDest.Get(1)
					Label54.Text = lgd1.Lotto
					Label55.Text = lgd2.Lotto
					Label56.Text = ""
					Label59.Text = lgd1.Giac1
					Label58.Text = lgd2.Giac1
					Label57.Text = ""
					Label60.Text = lgd1.Giac2
					Label61.Text = lgd2.Giac2
					Label62.Text = ""
					
				Case Else
					lgd1 = LottiGiacDest.Get(0)
					lgd2 = LottiGiacDest.Get(1)
					lgd3 = LottiGiacDest.Get(2)
					Label54.Text = lgd1.Lotto
					Label55.Text = lgd2.Lotto
					Label56.Text = lgd3.Lotto
					Label59.Text = lgd1.Giac1
					Label58.Text = lgd2.Giac1					
					Label57.Text = lgd3.Giac1
					Label60.Text = lgd1.Giac2
					Label61.Text = lgd2.Giac2
					Label62.Text = lgd3.Giac2
					
			End Select
		End If
		If(Panel3.Visible=False) Then
			Panel4.Visible=True
		End If
		
	Catch
		Log(LastException)
		
	End Try
End Sub

Private Sub Leggi_NomeImpostazioni()
	Dim ListDoc As List
	ListDoc.Initialize
	List_TipoDoc_Desc.Initialize
	Label3.Text = ""
	ComboBoxTipoDoc.cmbBox.Clear
	ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT NOMEIMPOSTAZIONE,CODMAGAZZINO FROM IS_IMPOSTAZIONICTRLINV",Null,0)
	ComboBoxTipoDoc.cmbBox.Add("")
	List_TipoDoc_Desc.Add( "")
	For Each arr_TipoDoc() As String In ListDoc
		ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(0))
		List_TipoDoc_Desc.Add( arr_TipoDoc(0))		
	Next	
	ComboBoxTipoDoc.SelectedIndex=0
End Sub

Private Sub Leggi_Depositi()
	Dim ListDoc As List
	ListDoc.Initialize
	List_TipoDoc_Desc.Initialize
	Label3.Text = ""
	ComboBoxTipoDoc.cmbBox.Clear
	ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT DESCRIZIONE FROM IS_ANAGRAFICADEPOSITI WHERE IFNULL(TIPO_MAGAZZINO,'')='S'",Null,0)
	ComboBoxTipoDoc.cmbBox.Add("")
	List_TipoDoc_Desc.Add( "")
	For Each arr_TipoDoc() As String In ListDoc
		ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(0))
		List_TipoDoc_Desc.Add( arr_TipoDoc(0))		
	Next	
	ComboBoxTipoDoc.cmbBox.Add("DA CELLA/CORSIA")
	List_TipoDoc_Desc.Add( "DA CELLA/CORSIA")
	ComboBoxTipoDoc.SelectedIndex=0
End Sub

Private Sub Button10_Click
	' Aumenta valore (Calcolatrice)
	Dim txtold As String = txt
	Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
	If(Button16.Text<>"") Then
		If(EditText9.Text.Trim="") And (EditText7.Text.trim="") Then
			ExtraUtility.Play_Sound("error.wav")							
		Else if (EditText9.Text<>"") And (EditText7.Text.Trim="") And (EditText8.Text.trim="")  Then
			EditText7.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE IL NUMERO DI " & Button14.Text,True)			
		Else if (EditText9.Text.Trim="") And (EditText7.Text.Trim<>"") Then
			EditText9.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE IL PESO IN KG",True)			
		Else IF (Label41.Text<>"") And (EditText8.Text.Trim<>"") And (EditText7.Text.trim<>"") Then
			EditText8.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE " & Button14.Text & " OPPURE " & Button15.Text,True)			
		Else
			Dim valore1 As Int = 0
			Dim valore2 As Int = 0
			Dim valpeso As Double = 0
			If (EditText9.Text = "") Then
				valpeso = 0
			Else
				valpeso = EditText9.Text.Replace(",",".")
			End If
			If (EditText7.Text = "") Then
				valore1 = 0
			Else
				valore1 = EditText7.Text
				txt =  DataOra & " - " & "Man. + "  & valore1 & " " & UM1 & " - Kg " & valpeso & CRLF & txt
			End If
			If (EditText8.Text = "") Then
				valore2 = 0
			Else
				valore2 = EditText8.Text
				txt =  DataOra & " - " & "Man. + "  & valore2 & " " & UM2 & " - Kg " & valpeso & CRLF & txt
			End If
			If (Label39.Text<>"") Then				
				TotQtaUM1 = Label39.text
			Else
				TotQtaUM1 = 0
			End If
			If(Label41.Text<>"") Then
				TotQtaUM2 = Label41.text
			Else
				TotQtaUM2 = 0
			End If
			If(Label42.Text<>"") Then
				Dim ValStr As String = Label42.Text.Replace(",",".")	
				TotPesoArt = ValStr
			Else
				TotPesoArt = 0
			End If
			TotPesoArt = Round2(TotPesoArt + valpeso,3)
			TotQtaUM1 = TotQtaUM1 + valore1
			TotQtaUM2 = TotQtaUM2 + valore2
			If(UM2<>"") Then
				If(vCorsiaUbicaz="N") Then
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
				Else
					If(vCodArtCella<>"") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
					Else
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					End If
				End If
			Else
				TotQtaUMX = TotQtaUM1
			End If				
			EditText7.Text = ""
			EditText8.Text = ""
			EditText9.Text = ""
			If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3)And (vMaxQtaUM3<>0))  And (TipoOperazione="SPO")  Then
				txt = txtold
				TotPesoArt = Round2(TotPesoArt - valpeso,3)
				TotQtaUM1 = TotQtaUM1 - valore1
				TotQtaUM2 = TotQtaUM2 - valore2
				If(UM2<>"") Then
					If(vCorsiaUbicaz="N") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					Else
						If(vCodArtCella<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
						End If
					End If
					Label39.Text = TotQtaUM1
					Label41.Text = TotQtaUM2
					Label42.Text = TotPesoArt
					If(Button15.Text<>"") Then
						Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
					Else
						Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
					End If
				Else
					TotQtaUMX = TotQtaUM1
				End If
				ExtraUtility.Play_Sound("error.wav")
				If(vMaxQtaUM3<>0) Then
					MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM3 & " " & UM3 & "!","CONTROLLO ORDINE")
				Else
					MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM2 & " " & UM2 & "!","CONTROLLO ORDINE")
				End If
			Else
				UpdateTape
			End If	
			Label39.Text = TotQtaUM1
			Label41.Text = TotQtaUM2
			Label42.Text = TotPesoArt
			If(Button15.Text<>"") Then
				Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
			Else
				Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
			End If
		End If	
	Else
		Dim valore1 As Int = 0 
		Dim valore2 As Int = 0
		If (EditText7.Text = "") Then
			valore1 = 0
		Else
			valore1 = EditText7.Text
			txt =  DataOra & " - " & "Man. + "  & valore1 & " " & UM1 & CRLF & txt
		End If
		If (EditText8.Text = "") Then
			valore2 = 0
		Else
			valore2 = EditText8.Text		
			txt =  DataOra & " - " & "Man. + "  & valore2 & " " & UM2 & CRLF & txt
		End If
		If (Label39.Text<>"") Then
			TotQtaUM1 = Label39.text
		Else
			TotQtaUM1 = 0
		End If
		If(Label41.Text<>"") Then
			TotQtaUM2 = Label41.text
		Else
			TotQtaUM2 = 0
		End If
		TotQtaUM1 = TotQtaUM1 + valore1
		TotQtaUM2 = TotQtaUM2 + valore2
		If(UM2<>"") Then
			If(vCorsiaUbicaz="N") Then
				TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
			Else
				If(vCodArtCella<>"") Then
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
				Else
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
				End If
			End If				
		Else
			TotQtaUMX = TotQtaUM1
		End If
		EditText7.Text = ""
		EditText8.Text = ""
		If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3) And (vMaxQtaUM3<>0))  And (TipoOperazione="SPO") Then
			txt = txtold
			TotQtaUM1 = TotQtaUM1 - valore1
			TotQtaUM2 = TotQtaUM2 - valore2
			If(UM2<>"") Then
				If(vCorsiaUbicaz="N") Then
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
				Else
					If(vCodArtCella<>"") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
					Else
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					End If
				End If
			Else
				TotQtaUMX = TotQtaUM1
			End If
			ExtraUtility.Play_Sound("error.wav")
			If(vMaxQtaUM3<>0) Then
				MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM3 & " " & UM3 & "!","CONTROLLO ORDINE")
			Else
				MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM2 & " " & UM2 & "!","CONTROLLO ORDINE")
			End If
		Else
			UpdateTape
		End If
		Label39.Text = TotQtaUM1
		Label41.Text = TotQtaUM2
		If(Button15.Text<>"") Then
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
		Else
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
		End If
	End If
End Sub

Private Sub Button9_Click
	' Diminuisci valore (Calcolatrice)
	Dim txtold As String = txt
	Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
	If(Button16.Text<>"") Then ' articolo a bilancia
		If(EditText9.Text.Trim="") And (EditText7.Text.trim="") Then
			ExtraUtility.Play_Sound("error.wav")
		Else if (EditText9.Text<>"") And (EditText7.Text.Trim="") And (EditText8.Text.trim="") Then
			EditText7.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE IL NUMERO DI " & Button14.Text,True)
		Else if (EditText9.Text.Trim="") And (EditText7.Text.Trim<>"") Then
			EditText9.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE IL PESO IN KG",True)
		Else IF (Label41.Text<>"") And (EditText8.Text.Trim<>"") And (EditText7.Text.trim<>"") Then
			EditText8.RequestFocus
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ATTENZIONE, INSERIRE CORRETTAMENTE " & Button14.Text & " OPPURE " & Button15.Text,True)
		Else
			Dim valore1 As Int = 0
			Dim valore2 As Int = 0
			Dim valpeso As Double = 0
			If (EditText9.Text = "") Then
				valpeso = 0
			Else
				valpeso = EditText9.Text.Replace(",",".")
			End If
			If (EditText7.Text = "") Then
				valore1 = 0
			Else
				valore1 = EditText7.Text
				txt =  DataOra & " - " & "Man. - "  & valore1 & " " & UM1 & " - Kg " & valpeso & CRLF & txt
			End If
			If (EditText8.Text = "") Then
				valore2 = 0
			Else
				valore2 = EditText8.Text
				txt =  DataOra & " - " & "Man. - "  & valore2 & " " & UM2 & " - Kg " & valpeso & CRLF & txt
			End If
			If (Label39.Text<>"") Then
				TotQtaUM1 = Label39.text
			Else
				TotQtaUM1 = 0
			End If
			If(Label41.Text<>"") Then
				TotQtaUM2 = Label41.text
			Else
				TotQtaUM2 = 0
			End If
			If(Label42.Text<>"") Then
				Dim ValStr As String = Label42.Text.Replace(",",".")
				TotPesoArt = ValStr
			Else
				TotPesoArt = 0
			End If
			If ((TotQtaUM1-valore1)>=0) And ((TotQtaUM2-valore2)>=0) And ((TotPesoArt-valpeso)>=0) Then
				TotPesoArt = Round2(TotPesoArt - valpeso,3)
				TotQtaUM1 = TotQtaUM1 - valore1
				TotQtaUM2 = TotQtaUM2 - valore2
				If(UM2<>"") Then
					If(vCorsiaUbicaz="N") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					Else										
						If(vCodArtCella<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
						Else												
							If(vCodArtCella<>"") Then
								TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
							Else
								TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
							End If
						End If						
					End If
				Else
					TotQtaUMX = TotQtaUM1
				End If
			Else
				ExtraUtility.Play_Sound("error.wav")
				txt = txtold
			End If			
			EditText7.Text = ""
			EditText8.Text = ""
			EditText9.Text = ""
			If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3)And (vMaxQtaUM3<>0)) And (TipoOperazione="SPO") Then
				txt = txtold
				TotPesoArt = Round2(TotPesoArt + valpeso,3)
				TotQtaUM1 = TotQtaUM1 + valore1
				TotQtaUM2 = TotQtaUM2 + valore2
				If(UM2<>"") Then
					If(vCorsiaUbicaz="N") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					Else
						If(vCodArtCella<>"") Then
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
						Else
							TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
						End If
					End If
				Else
					TotQtaUMX = TotQtaUM1
				End If
				ExtraUtility.Play_Sound("error.wav")
				If(vMaxQtaUM3<>0) Then
					MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM3 & " " & UM3 & "!","CONTROLLO ORDINE")
				Else
					MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM2 & " " & UM2 & "!","CONTROLLO ORDINE")
				End If
			Else
				UpdateTape
			End If	
			Label39.Text = TotQtaUM1
			Label41.Text = TotQtaUM2
			Label42.Text = TotPesoArt
			If(Button15.Text<>"") Then
				Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
			Else
				Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
			End If
		End If
	Else
		Dim valore1 As Int = 0
		Dim valore2 As Int = 0
		If (EditText7.Text = "") Then
			valore1 = 0
		Else
			valore1 = EditText7.Text
			txt =  DataOra & " - " & "Man. - "  & valore1 & " " & UM1 & CRLF & txt
		End If
		If (EditText8.Text = "") Then
			valore2 = 0
		Else
			valore2 = EditText8.Text
			txt =  DataOra & " - " & "Man. - "  & valore2 & " " & UM2 & CRLF & txt
		End If
		If (Label39.Text<>"") Then
			TotQtaUM1 = Label39.text
		Else
			TotQtaUM1 = 0
		End If
		If(Label41.Text<>"") Then
			TotQtaUM2 = Label41.text
		Else
			TotQtaUM2 = 0
		End If
		If ((TotQtaUM1-valore1)>=0) And ((TotQtaUM2-valore2)>=0) Then
			TotQtaUM1 = TotQtaUM1 - valore1
			TotQtaUM2 = TotQtaUM2 - valore2
			If(UM2<>"") Then
				If(vCorsiaUbicaz="N") Then
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
				Else
					If(vCodArtCella<>"") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
					Else
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					End If
				End If
			Else
				TotQtaUMX = TotQtaUM1
			End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			txt = txtold
		End If
		If(Button15.Text<>"") Then
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
		Else
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
		End If
		EditText7.Text = ""
		EditText8.Text = ""
		If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3)And (vMaxQtaUM3<>0))  And (TipoOperazione="SPO") Then
			txt = txtold
			TotQtaUM1 = TotQtaUM1 + valore1
			TotQtaUM2 = TotQtaUM2 + valore2
			If(UM2<>"") Then
				If(vCorsiaUbicaz="N") Then
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
				Else
					If(vCodArtCella<>"") Then
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtCella,UM1,TotQtaUM1)+TotQtaUM2
					Else
						TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArtLotto,UM1,TotQtaUM1)+TotQtaUM2
					End If
				End If
			Else
				TotQtaUMX = TotQtaUM1
			End If
			ExtraUtility.Play_Sound("error.wav")
			If(vMaxQtaUM3<>0) Then
				MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM3 & " " & UM3 & "!","CONTROLLO ORDINE")
			Else
				MsgboxAsync("Quantità maggiore di quella disponibile " & vMaxQtaUM2 & " " & UM2 & "!","CONTROLLO ORDINE")
			End If
		Else
			UpdateTape
		End If
		Label39.Text = TotQtaUM1
		Label41.Text = TotQtaUM2
		If(Button15.Text<>"") Then
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM2
		Else
			Label36.Text = " Tot. " & TotQtaUMX & " " & UM1
		End If
	End If
End Sub

Private Sub EditText6_EnterPressed
	
End Sub

Private Sub Button3_Click
'	TimerLongClick.Enabled = True
	If (vTipoReadGiac.Length>0) And (vTipoReadGiac.SubString2(0,3)="MAG") Then
		vTipoReadGiac = "MAG" 
		Label1.Text = "SPOSTAMENTO DA MAG. " & vCodDeposito & " A "		
	Else
		vTipoReadGiac = ""
		vCorsiaOrig = ""
		vCorsiaDest = ""
		vTipoReadGiac = ""
		Select Case  TipoOperazione
			Case "SPO"
				Label1.Text = "SPOSTAMENTO"
			
			Case "INV"
				Label1.Text = "INVENTARIO"
		End Select
	End If
	Label3.Text = ""
	vCodArtCella=""
	vCodArtLotto=""
	vTipoLettura =0
End Sub

Private Sub Button12_Click
	txt = ""
	UpdateTape
	Button3.TextSize=16
	Button3.Typeface=Typeface.DEFAULT_BOLD
	Panel3.Visible=False
	Button1.Enabled=True
	Phone.HideKeyboard	
	If(vLottoCompleto<>"") Then
		' verifico se devo cancellare il record senza qtà (es. lotto errato!)
		Dim NRecs As Int = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c9=? and c14=0"$, Array As String(vLottoCompleto))
		If (NRecs>0) Then			
			B4XTable1.sql1.ExecNonQuery2($"DELETE FROM data WHERE c9=?"$, Array As String(vLottoCompleto))
			B4XTable1_DataUpdated
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
		End If
	End If	
	vCodArticolo=""
	vCodArtCella=""
	vCodArtLotto=""
	vTipoLettura =0
	PesoArt=0
	' vLottoCompleto	
End Sub

Private Sub Button11_Click
	txt = ""
	Button3.TextSize=16
	Button3.Typeface=Typeface.DEFAULT_BOLD
	UpdateTape
	If((TotQtaUMX>vMaxQtaUM2) And (vMaxQtaUM2<>0)) Or ((TotPesoArt>vMaxQtaUM3) And (vMaxQtaUM3<>0)) Then		
		ExtraUtility.Play_Sound("Sound3.wav")
		MsgboxAsync("Quantità maggiore di quella disponibile!","CONTROLLO ORDINE")
	Else
		Registra_Panel3("",Label34.Text)
		Panel3.Visible=False
		Button1.Enabled=True
		Phone.HideKeyboard
		If(vLottoCompleto<>"") Then
			' verifico se devo cancellare il record senza qtà (es. lotto errato!)
			Dim NRecs As Int = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c9=? and c14=0"$, Array As String(vLottoCompleto))
			If (NRecs>0) Then
				B4XTable1.sql1.ExecNonQuery2($"DELETE FROM data WHERE c9=?"$, Array As String(vLottoCompleto))
				B4XTable1_DataUpdated
				B4XTable1.UpdateTableCounters
				B4XTable1.Refresh
			End If
		End If
	End If
	If (vTipoReadGiac.Length>0) And (vTipoReadGiac.SubString2(0,3)="MAG") Then
		vTipoReadGiac = "MAG"
		Label1.Text = "SPOSTAMENTO DA MAG. " & vCodDeposito & " A "
	Else
		vTipoReadGiac = ""
		vCorsiaOrig = ""
		vCorsiaDest = ""
		vTipoReadGiac = ""
		Select Case  TipoOperazione
			Case "SPO"
				Label1.Text = "SPOSTAMENTO"
			
			Case "INV"
				Label1.Text = "INVENTARIO"
		End Select					
	End If
	Label3.Text = ""
	vCodArticolo=""
	vCodArtCella=""
	vCodArtLotto=""
	vTipoLettura =0
	PesoArt=0
End Sub

Private Sub Button13_Click
	If(Button3.Text<>"") Then	
		Azzera_Panel3
		Panel3.Visible=True
		Button1.Enabled=False
	End If
End Sub

Private Sub Button14_Click
	If(Button14.Text<>"") Then
		Button14.textColor=ExtraUtility.Color_DarkGreen
		Button15.textColor=xui.Color_Gray
		Button14.Tag="Pressed"
		Button15.Tag=""
	End If
End Sub

Private Sub Button15_Click
	If(Button15.Text<>"") Then
		Button14.textColor=xui.Color_Gray
		Button15.textColor=ExtraUtility.Color_DarkGreen
		Button14.Tag=""
		Button15.Tag="Pressed"
	End If
End Sub

Private Sub EditText9_FocusChanged (HasFocus As Boolean)
	If HasFocus=True Then
		EditText9.SelectAll
		Phone.SetCustomFilter(EditText9, EditText9.INPUT_TYPE_NUMBERS, "0123456789,")
	End If
End Sub

Private Sub Button18_Click
	If (vTipoReadGiac.Length>0) And (vTipoReadGiac.SubString2(0,3)="MAG") Then
		vTipoReadGiac = "MAG"
		Label1.Text = "SPOSTAMENTO DA MAG. " & vCodDeposito & " A "
	Else
		vTipoReadGiac = ""
		vCorsiaOrig = ""
		vCorsiaDest = ""
		vTipoReadGiac = ""
		Select Case  TipoOperazione
			Case "SPO"
				Label1.Text = "SPOSTAMENTO"
			
			Case "INV"
				Label1.Text = "INVENTARIO"
		End Select
	End If
	Label3.Text = ""
	vCodArtCella=""
	vCodArtLotto=""
	vCodArticolo=""
	vTipoLettura =0
	LottiGiacOrig.Clear
	LottiGiacDest.clear
	Panel4.Visible=False
End Sub

Private Sub Button17_Click
	' OK SULLA MASCHERA DELLE GIACENZE
	Panel4.Visible=False	
	RegistraPanel3	
End Sub

Private Sub RegistraPanel3
	Dim vNpos As Int = B4XTable1.Size
	Dim lo As LottoGiacenzeType
	lo.Initialize
	For x=0 To LottiGiacOrig.Size-1
		' MsgboxAsync("Lotto " & ListLottiOrig.Get(x),"")
		lo = LottiGiacOrig.Get(x)
		Dim NRecs As Int
		If(vCodArtCella<>"") Then
			NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtCella,lo.Lotto))
		Else
			NRecs = B4XTable1.sql1.ExecQuerySingleResult2($"SELECT count(*) from data where c1=? and c9=?"$, Array As String(vCodArtLotto,lo.lotto))
		End If
		If (NRecs=0) Then
			Dim xQta2 As Double = LeggiQta(lo.Giac1,Chr(32))
			Dim xQta1 As Double = LeggiQta(lo.Giac2,Chr(32))
			Dim xQta3 As Double = lo.GiacPeso
			Dim xUM2 As String = LeggiUM(lo.Giac1,Chr(32))
			Dim xUM1 As String = LeggiUM(lo.Giac2,Chr(32))
			If(xQta3<>0) Then
				Dim xUM3 As String = "KG"
			Else
				Dim xUM3 As String = ""
			End If
			vNpos = vNpos+1
			If(vCodArtCella<>"") Then			
				InsertRigaDoc(vNpos,vCodArtCella,lo.lotto,vCodDeposito,vCodDepositoColl,vCorsiaUbicaz,vCorsiaUbicazColl,xUM1,xQta1,xUM2,xQta2,xUM3,xQta3,1,vTipoReadGiac)
			Else if (vCodArtLotto<>"") Then
				InsertRigaDoc(vNpos,vCodArtLotto,lo.lotto,vCodDeposito,vCodDepositoColl,vCorsiaUbicaz,vCorsiaUbicazColl,xUM1,xQta1,xUM2,xQta2,xUM3,xQta3,1,vTipoReadGiac)
			End If			
		End If
	Next
	B4XTable1_DataUpdated
	B4XTable1.UpdateTableCounters
	Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
	column.InternalSortMode= "DESC"
	B4XTable1.Refresh
End Sub

Private Sub Button19_Click
	' ANNULLA SULLA MASCHERA DELLE GIACENZE
	Panel4.Visible=False
End Sub