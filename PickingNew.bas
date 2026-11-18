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
	Public vRagSoc As String
	Public vValuta As String
	Public vCodCliFor As String
	Public vNumListino As Int
	Public vNumListinoNew As Int
	Public vDescListino As String
	Public SelectedRows As B4XSet
	Private vTrasmesso As Int
	' Dim TimerLongClick As Timer
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	' codice fittizio del NESTI e BONSIGNORI
	Private Const CodCliForFittizio As String = "C 91012"
	Private rp As RuntimePermissions
	' -----------------  GESTIONE SPP ------------------
	Private ScannerMacAddress As String
	Private ScannerOnceConnected As Boolean
	' -----------------  FINE SPP ----------------------
	Private xColorUM As Int = Colors.Magenta
	Private xColorUMVBack As Int = Colors.RGB(255,228,155)	
	Private vBarcodeLetto As String = ""
	Private vBarcodeLettoOld As String = ""
	Private FolderPhp As String = "pocket_isa"
	Private Phone As IME
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private DataList As List
	Private DataList2 As List
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
	Private EditText2 As EditText
	Private EditText3 As EditText
	Private EditText4 As EditText
	Private Label13 As Label
	Private Label14 As Label
	Private Col1_Column As B4XTableColumn	'	N. Posizione
	Private Col2_Column As B4XTableColumn	'	Tipo Riga
	Private Col3_Column As B4XTableColumn	'	Cod. Art
	Private Col4_Column As B4XTableColumn 	' 	Descrizione Articolo
	Private Col5_Column As B4XTableColumn	' 	Ordinato
	Private Col6_Column As B4XTableColumn	' 	UM Ordinato
	Private Col7_Column As B4XTableColumn	'	Acquisito1
	Private Col8_Column As B4XTableColumn	'	UM1 Acq.
	Private Col9_Column As B4XTableColumn	'	Acquisito2
	Private Col10_Column As B4XTableColumn	'	UM2 Acq.
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
	'-----------------------------------------------------------
	Private Col0x_Column As B4XTableColumn  ' ---
	Private Col1x_Column As B4XTableColumn  ' Cod. Cli.
	Private Col2x_Column As B4XTableColumn	' Rag. Soc.
	Private Col3x_Column As B4XTableColumn	' Qtà
	'-----------------------------------------------------------	
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
	Private UMB As String = ""
	Private UMV As String = ""
	Private Priorita As Long = 0
	Private RowID_Riga As Long = 0
	Private SelectedColumn As B4XTableColumn
	Private TipoOperazione As String = ""
	Private XSelections As B4XTableSelections
	Private TotalSize As Int = 0
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
	Private vCodArticoloOld As String = ""
	Private vRigaDoc As String
	Private ScrollView1 As ScrollView
	Private EditText6 As EditText
	Private EditText7 As EditText 
	Private Panel3 As Panel
	'-----------------------------------------------------------
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private Button7 As Button
	Private Button8 As Button
	Private Button9 As Button
	Private Button10 As Button
	Private Button11 As Button
	Private Button12 As Button
	Private Button13 As Button
	Private Button14 As Button
	Private Button16 As Button
	Private Button17 As Button
	Private Button18 As Button
	Private Button19 As Button
	Private Button20 As Button
	Private Button21 As Button
	Private Button15 As Button
	'-----------------------------------------------------------
	Private lblpaperRoll As Label
	Private stu As StringUtils
	Private txt As String =""
	Private Label36 As Label
	Private Label37 As Label
	Private Label38 As Label
	Private Label39 As Label
	Private Label40 As Label
	Private Label41 As Label
	Private Label42 As Label
	Private vLottoCompleto As String = ""
	Private vLotto As String = ""
	Private vCodArtLotto As String = ""
	Private vCodArtCella As String = ""
	Private vTipoLettura2 As Int = 0
	Private ColumnColor As Int
	Private EditText8 As EditText
	Private EditText9 As EditText
	Private TotPesoArt As Double = 0
	Private TotQtaUM1 As Double = 0
	Private TotQtaUM2 As Double = 0
	Private TotQtaUM3 As Double = 0
	Private TotQtaUMX As Double = 0
	Private TotQtaUMBClienti As Double = 0
	Private TotQtaUMVClienti As Double = 0
	Private TotQtaUMVClientiAssegnati As Double = 0
	Private Label33 As Label
	Private Label34 As Label
	Private vFoglioInv As String = ""
	Private vStatoCorsia As Int = 0
	Private vCorsiaUbicaz As String = ""
	Private vCorsiaUbicazColl As String = ""
	Private vFlagSvuotaCella As Int = 0
	Private Label35 As Label
	Private vDescrizioneArt As String = ""
	Private vFattoreConv As Double = 0
	Private vQtaTotUMAConv As Double = 0
	Private vCodDeposito As String = ""
	Private vCodDepositoColl As String = ""
	Private vDescDeposito As String = ""
	Private LottiGiacOrig As List
	Private LottiGiacDest As List
	Private Label19 As Label
	Private Label20 As Label
	Private Label21 As Label
	Private Label22 As Label
	Private Label23 As Label
	Private Label24 As Label
	Private Label25 As Label
	Private Label26 As Label
	Private Label27 As Label
	Private Label61 As Label
	Private Label62 As Label
	Private Label63 As Label
	Private Label64 As Label
	Private vTipoReadGiac As String
	Private Label65 As Label
	Private vMaxQtaUM2 As Double
	Private vMaxQtaUM3 As Double
	Private SemaphoreGiroColumn As B4XTableColumn
	Private SemaphoreCorsiaColumn As B4XTableColumn
	Private MultiSelection As Boolean = True ' serve per gestire multiselezione
	Private SelectedRows2 As B4XSet
	Private SelectedRows3 As B4XSet
	Private XSelections2 As B4XTableSelections
	Private XSelections3 As B4XTableSelections
	'Private SelectionColor As Int = 0xFF009DFF	
	Private MultiSelection2 As Boolean = False ' serve per gestire multiselezione	
	Private MultiSelection3 As Boolean = False ' serve per gestire multiselezione
	Private vRifIdTesta As Long
	Private vCorsia As String = ""
	Type PartiteQtaType(Partita1 As String, Qta1 As Double, Partita2 As String, Qta2 As Double, Partita3 As String, Qta3 As Double, GiacenzaUM1 As Double, _
	GiacenzaUM2 As Double, UM1 As String, UM2 As String, Qta1_UM2 As Double, Qta2_UM2 As Double, Qta3_UM2 As Double, PesoReale1 As Double, PesoReale2 As Double, PesoReale3 As Double)
	Type QtaPrelevabileType(Qta1P As Double, UM1P As String, Qta2P As Double, UM2P As String, Qta3P As Double, UM3P As String, UMV As String, QtaTotUMB As Double, UMB As String)
	Private Panel4 As Panel
	Private B4XTable1 As B4XTable
	Private B4XTable2 As B4XTable
	Private B4XTable3 As B4XTable
	'---------------------------------------------------
	Private CurrentlyFocusedCell As FocusedCell
	Private B4XPlusMinus1 As B4XPlusMinus
	'Private IESupport As InlineEditing
	Private mTable As B4XTable
	Private mCallback As Object
	Private mEventName As String
	Private TextField1 As B4XView
	Private ColorsList As List
	Private Label43 As Label
	Private Label47 As Label
	Private Label48 As Label
	Private Label49 As Label
	Private Label50 As Label
	Private Label45 As Label
	Private Label46 As Label
	Private vCorsiaOld As String
	Private vUbicazione As String
	Private vStatoriga As String
	Private Label51 As Label
	Private Label52 As Label
	Private Label53 As Label
	Private Label54 As Label
	Private Button22 As Button
	Private Button23 As Button
	Private Label55 As Label
	Private Label56 As Label
	Private Label57 As Label
	Private QtaOrigPickBase As Double
	Private QtaStoryDisp As Double
	Private QtaStoryUMB As Double
	Private vCorsiaArticolo As String
	Private Button24 As Button
	Private Button25 As Button
	Private Label58 As Label
	Private Label59 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
'	IESupport.Initialize(B4XTable3, Me, "IESupport")
'	IESupport.TableResized : Sleep(200)
	btnDate2.Initialize("","")
	ListaDoc.vTrasmesso=0
	'Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		vNumDocNew = 0
		vEsercizioNew = 0
		vRifIdTesta = 0
		vCodCliFor = ""
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)	
	End If
	If(ListaDocTablet.vOperazione="NuovoDoc")Then
		vNumDocNew=0
	End If
	Activity.LoadLayout("PickingNew")
	'--------- Panel 2 --------------
	ListaRigheTablet2(True,0)
	'--------- Panel 4 --------------
	ListaRigheTablet3(True,0,0,False)
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
	Button13.Visible=False
	LottiGiacOrig.Initialize
	LottiGiacDest.Initialize
	'--------------------------------
	DateTime.DateFormat = "dd/MM/yyyy"
	vEsercizioNew =  ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
	Base = Activity	
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	Select Case ListaDocTablet.vOperazione
	 	Case "ApriDoc"
			Select Case Choose_Menu.vOperazioneMenu					
				Case "Picking"
					TipoOperazione = "PIK"  ' Picking
					ColumnColor = 13
					B4XTable1.mBase.Visible=True
					ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					B4XTable1.mBase.Visible=True
					EditText2.Enabled=True
					'CheckBox2.Visible=True   ' Chiusura manuale
						
				Case Else
					
			End Select
		
		Case "NuovoDoc"
			B4XTable1.Clear
			B4XTable1.Refresh
			Select Case Choose_Menu.vOperazioneMenu
				
				Case "Picking"
					TipoOperazione = "PIK"   ' Picking
					ColumnColor = 13
					ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					B4XTable1.mBase.Visible=True
					EditText2.Enabled=True
						
				Case Else				
					
			End Select			
			
	End Select	
	Label2.Text="BARCODE :"
	Label8.Text=""
	Label9.Text=""
	ListaDoc.vTrasmesso=0
	vTipoTab = 0
	EditText1.RequestFocus
	XSelections.Initialize(B4XTable1)
	XSelections.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)			
	Col1x_Column.InternalSortMode="ASC"
	Col1x_Column.Sortable = True	
	Panel2.Visible=False
	Button1.Enabled=True
	Button2.Enabled=True
	Button6.Enabled=True
	Button7.Enabled=True
	Button22.Text=""
	Button22.Tag=""
	Button22.Visible=False
	' ie.Initialize(B4XTable3,
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
	Dim h As Double
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
		res = InputList(l, "Seleziona lettore", -1) 'show list with paired devices		
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

Private Sub Azzera_Semafori_Local(aIdtesta As Long) As ResumableSub
	Try
		SQLDataAccess.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA=" & aIdtesta)
		SQLDataAccess.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE")
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub AStream_NewData (Buffer() As Byte)
' inserimento tramite pistola in modalità SPP
Try
		If(Main.SwitchMode_SPP=1) Then
			Log("Received: " & BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
			' 8056455939510
			Dim Phone As IME
			Phone.HideKeyboard
			' vBarcodeLetto = EditText1.Text				
			vBarcodeLetto = BytesToString(Buffer, 0, Buffer.Length, "UTF8")
			vBarcodeLetto=vBarcodeLetto.Replace(Chr(13),"")
			vBarcodeLetto=vBarcodeLetto.Replace(Chr(10),"")
			'-----------------------------------------------------------
			'	PRIMA FASE SELEZIONO LA CORSIA
			'-----------------------------------------------------------
			If(vBarcodeLetto.Length=5) And (vBarcodeLetto.StartsWith("CS"))	Then
				vCorsia=vBarcodeLetto
				Button8.text = vCorsia				
				Dim F_Error As Boolean = False
				If(Panel2.Visible=True) Then
					Dim RowData As Map
					' prova = B4XTable1.GetRow(0).GetValueAt(1).
					For v=1 To B4XTable2.size
						RowData = B4XTable2.GetRow(v)
						Dim UtenteLista As String = RowData.GetValueAt(3)
						Dim StatoGir As Int =  RowData.GetValueAt(0)
						Dim StatoCor As Int =  RowData.GetValueAt(4)
						Dim Corsia As String =  RowData.GetValueAt(1)
						If(vCorsia=Corsia) And (StatoGir<>4) And (StatoCor<>1) And (UtenteLista<>Main.Utente) And (UtenteLista<>"CHIUSO") Then
							' Log("Stato Giro " & StatoGir & " Utente " & UtenteLista & " Stato Corsia " & StatoCor & " Corsia " & Corsia)
							F_Error =True	
							ExtraUtility.Play_Sound("error.wav")
							MsgboxAsync("ERRORE LA CORSIA RISULTA OCCUPATA O ERRATA!","ERRORE CORSIA " & vCorsia)								
						End If
					Next				
				End If			
				If (F_Error=False) Then
					CallSubDelayed(Me, "OK_ListaCorsie")
				End If
			End If
			If (vCorsia="") Then
				If(ListaDocTablet.vOperazione="NuovoDoc") Then
					' Azzero la corsia sul server					
					Wait For(Azzera_Semafori_Local(vRifIdTesta)) complete (Success As Boolean)
					If(Success) Then
						wait for(Aggiorna_Semaforo_Server(vCorsia,Main.Utente,-1)) complete (Success2 As Boolean)
						If(Success2) Then						
							vRifIdTesta=vBarcodeLetto
							ListaRigheTablet2(False,vBarcodeLetto)
							Label6.Text = "GIR N. " & vRifIdTesta
						End If
					End If
				Else
					vRifIdTesta=vBarcodeLetto
					ListaRigheTablet2(False,vBarcodeLetto)
				End If
				' Visualizza le corsie
			Else
				'-----------------------------------------------------------
				'	SECONDA FASE LEGGO LE RIGHE DELLA CORSIA DEL GIR
				'-----------------------------------------------------------
				If (Panel3.Visible=False) And (vBarcodeLetto<>vCorsia) Then		
					ApriCalcolatrice(vBarcodeLetto,0)
				Else
					'-----------------------------------------------------------
					'	TERZA FASE LEGGO I CODICI SULLA CALCOLATRICE
					'-----------------------------------------------------------
					If (Panel3.Visible) Then
						'-----------------------------------------------------------
						'	DECODIFICO I CODICI CHE VENGONO SPARATI
						'-----------------------------------------------------------
						If(vBarcodeLetto="OK") Or (vBarcodeLetto="KO") Then
							' caso di conferma con pistola della spunta verde -> OK													
							' caso di conferma con pistola dell'annulla rosso -> KO
							If(vBarcodeLetto="OK") Then
								OK_Calcolatrice
							End If
							If(vBarcodeLetto="KO") Then
								CallSubDelayed(Me,Button12_Click)
							End If
						Else
							vCodArticoloOld=vCodArticolo
							Dim ResPik As List = Leggi_Barcode_Articolo(vBarcodeLetto)
							' Cerco l'articolo x cella e corsia
							If(ResPik.Size>0) Then
								If(ResPik.Size=4) Then
									Dim Codart As String = ResPik.Get(2)
								Else
									Dim Codart As String = ResPik.Get(0)
								End If							
								If(Codart=vCodArticoloOld) Then
									If(Button14.Tag="Pressed") Then
										EditText7.Text="1"
										EditText8.Text=""
									Else
										EditText7.Text=""
										EditText8.Text="1"									
									End If
									CallSubDelayed(Me,Button10_Click)
								Else
									vCodArticolo=vCodArticoloOld
									ExtraUtility.Play_Sound("error.wav")
									ToastMessageShow("*** CODICE ERRATO ***",False)								
								End If
							End If								
							TotQtaUMBClienti=TotQtaUMX-LeggiQta(Label47.Text,Chr(32))
							TotQtaUMVClienti=Converti_Qta_UMV(SQLDataAccess,vCodArticolo,UMB,TotQtaUMBClienti)
						End If		
												
					End If	
																		
				End If
			
			End If
			
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Sub ApriCalcolatrice (Codice As String, RifIdRiga As Int)
	Try 
		Button11.Enabled=True
		Button8.Enabled=False
		Button14.Text=""
		Button15.Text=""
		Button16.Text=""
		EditText7.Text=""
		EditText8.Text=""
		EditText9.Text=""
		TotQtaUMX=0
		Label39.Text="0"
		Label41.Text="0"		
		Label42.Text="0"
		Label37.Text=""
		Label38.Text=""
		Label40.Text=""
		Label47.Text=""
		Label45.Text=""
		Label57.Text=""
		Label53.Text=""
		Label54.Text=""
		vCorsiaArticolo=""
		If(Codice<>"") Then
			Dim Corsia As String = ""
			Dim Ubicaz As String = ""
			Dim res  As ResultSet
			If (Codice.Length=15) And (Codice.SubString2(0,2)="CS") Then  ' caso di corsia ubicazione 
				Corsia=Codice.SubString2(0,5)
				Ubicaz=Codice.SubString(5)
				res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26 from data where c11=? and c12=?"$, Array As String(Corsia,Ubicaz))
				If (res.RowCount=0) Then									
					Dim rs As ResultSet = SQLDataAccess.ExecQuery2("SELECT CODICE,DESCRIZIONE FROM IS_ANAGRAFICAARTICOLI WHERE CORSIA=? AND UBICAZIONE = ?", Array As  String(Corsia,Ubicaz))						
					If (rs.RowCount>0) Then
						Do While rs.NextRow
							vCodArticolo = rs.GetString("CODICE")
							vDescrizioneArt = rs.GetString("DESCRIZIONE")
							vUbicazione = Ubicaz
							vCorsiaArticolo=Corsia
							Label3.Text=vDescrizioneArt
						Loop
					End If
				End If
			Else
				' Decodifica Articolo...
				Dim ListArt As List = Leggi_Barcode_Articolo(Codice)
				If (ListArt.Size>0) Then
					If(ListArt.Size=4) Then
						vCodArticolo = ListArt.Get(2)
					Else
						vCodArticolo = ListArt.Get(0)
					End If					
					Corsia="" 
					Ubicaz=""
					res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26 from data where c2=?"$, Array As String(vCodArticolo))
				End If
			End If	
			'------------------------------------------------------
			' Controllo se l'articolo letto fa parte del giro
			'------------------------------------------------------
			Dim F_AggRiga As Boolean = False
			If (res.RowCount=0) Then				
				'------------------------------------------------------
				' ARTICOLO NON PRESENTE NEL GIRO VUOI AGGIUNGERLO
				'------------------------------------------------------				
				ExtraUtility.Play_Sound("error.wav")
				If(vCorsiaArticolo<>vCorsia) And (vCorsiaArticolo<>"") Then
					Msgbox2Async("ARTICOLO IN CORSIA " & vCorsiaArticolo & " NON COERENTE CON LA CORSIA SELEZIONATA","CONTROLLO CORSIA " & vCorsia,"","","Annulla",Null,True)
				Else
					Msgbox2Async("ARTICOLO NON PRESENTE NEL GIRO, VUOI AGGIUNGERLO","CONTROLLO ARTICOLO","Procedi","","Annulla",Null,True)
				End If
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Dim maxPos As Int
					If(B4XTable1.mCurrentCount=0) Then
						maxPos = 0
					Else
						maxPos = B4XTable1.sql1.ExecQuerySingleResult("SELECT max(c0) FROM data")
					End If
					maxPos = maxPos + 1
					B4XTable1.sql1.ExecNonQuery2("INSERT INTO data(c0,c1,c2,c3,c4,c5,c7,c9,c11,c12,c13,c16,c25) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", Array As Object(maxPos,"N",vCodArticolo,Label3.Text,"","","","",vCorsia,vUbicazione,"","",vRifIdTesta))
					B4XTable1.UpdateTableCounters
					B4XTable1.Refresh
					F_AggRiga = True
				End If
			End If								
			If (res.RowCount>0) Or (F_AggRiga) Then				
				If(F_AggRiga) Then		
					If (Codice.Length=15) And (Codice.SubString2(0,2)="CS") Then  ' caso di corsia ubicazione
						Corsia=Codice.SubString2(0,5)
						Ubicaz=Codice.SubString(5)
						res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26 from data where c11=? and c12=?"$, Array As String(Corsia,Ubicaz))
					Else
						' Decodifica Articolo...
						Dim ListArt As List = Leggi_Barcode_Articolo(Codice)
						If (ListArt.Size>0) Then
							vCodArticolo = ListArt.Get(0)
							Corsia=""
							Ubicaz=""
							res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26 from data where c2=?"$, Array As String(vCodArticolo))
						End If
					End If
				End If					
				Dim QtaUM_DaPrelevare As String = ""
				Dim Qta_DaPrelevare As Double = 0
				Dim UM_DaPrelevare As String = ""				
				Do While res.NextRow
										
					QtaUM_DaPrelevare = res.GetString("c4")
					Qta_DaPrelevare = LeggiQta(res.GetString("c4"),Chr(32))
					UM_DaPrelevare = LeggiUM(res.GetString("c4"),Chr(32))					
				
					TotQtaUM1 = res.GetDouble("c6")
					TotQtaUM2 = res.GetDouble("c8")
					TotQtaUM3 = res.GetDouble("c10")
					
					vUbicazione = res.GetString("c12")
					
					Dim ResPrel As QtaPrelevabileType =  Converti_QtaPrelevabile(SQLDataAccess,res.GetString("c2"),UM_DaPrelevare,Qta_DaPrelevare)
													
					UMV=ResPrel.UMV
					QtaOrigPickBase = ResPrel.QtaTotUMB

					Label11.Text = ResPrel.Qta1P & " " & ResPrel.UM1P

					If (ResPrel.UM1P=ResPrel.UM2P) Then						
						ResPrel.UM2P = ""
						ResPrel.Qta2P = 0
						Label14.Text = ""										
					Else
						Label14.Text = ResPrel.Qta2P & " " & ResPrel.UM2P
					End If				

					Button14.Text=ResPrel.UM1P
					Label37.Text=ResPrel.UM1P
					
					Button15.Text=ResPrel.UM2P
					Label38.Text=ResPrel.UM2P

					Label56.Text = ResPrel.QtaTotUMB & " " & ResPrel.UMB				

					UM1=ResPrel.UM1P
					UM2=ResPrel.UM2P
					UM3=ResPrel.UM3P

					If(Button15.Text.Trim="") Then
						EditText8.Enabled = False
					Else
						EditText8.Enabled = True
					End If					

					If(Button16.Text.Trim="") Then
						EditText9.Enabled = False
					Else
						EditText9.Enabled = True
					End If
					
					vCodArticolo=res.GetString("c2")
					vDescrizioneArt=res.GetString("c3")
					
					' ------------------------------------------------
					' Legge eventuali note aggiuntive sugli ordini
					' ------------------------------------------------
					Label58.Text = Leggi_AnnotazioniOrdini(SQLDataAccess,vCodArticolo,vRifIdTesta)
					
					'TotPesoArt=res.Getdouble("c9")
					'TotQtaUMX=res.GetInt("c14")					
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
					Label33.Text = vCodArticolo
					Label34.text = res.Getstring("c0")
					Label35.Text = vDescrizioneArt
					Label39.Text = TotQtaUM1
					Label41.Text = TotQtaUM2
					Label42.text = TotQtaUM3			
					Button14.textColor=xColorUM
					Button15.textColor=xui.Color_Gray
					Button16.textColor=xui.Color_Gray
					Button14.Tag="Pressed"
					Button15.Tag=""
					Button16.Tag=""
					' ----------------------------------------------------------------------
					' ------ Controllo se l'unità base è già presente nella maschera -------
					' ----------------------------------------------------------------------
					UMB = Leggi_UMBaseArticolo(vCodArticolo)		
					TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,TotQtaUM1)+Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM2,TotQtaUM2)+TotQtaUM3
					Label36.Text = " Tot. " & TotQtaUMX & " " & UMB						
					'---------------------------------------------------------
					' Visualizza Panel3
					'---------------------------------------------------------
					' Leggi valori qtà clienti aggiunti al giro
					'---------------------------------------------------------					
					'Dim Qta As Int = Leggi_QtaTotAggiunteClienti(vRifIdTesta,RifIdRiga,vCodArticolo)
					'If (Qta>0) Then
					'	Label45.Text = Qta & " " & UMV
					'	Dim QtaBase  As Int = Converti_Qta_UMBase(SQLDataAccess,Label33.Text,UMV,Qta)
					'	Label48.Text = QtaBase & " " & UMB
					'	'Button21.Enabled=True
					'Else
					'	Label45.Text = ""
					'	Label48.Text = ""
					'	'Button21.Enabled=False
					'End If														
					' -------------------------------------------------------------
					QtaStoryDisp=res.GetDouble("c26")
					QtaStoryUMB=res.GetDouble("c17")
					RicalcoloAutomaticoQtaDisponibile(vCodArticolo,UMB,QtaStoryDisp)
					Dim Diff As Double = ResPrel.QtaTotUMB-QtaStoryUMB
					RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,UMB,Diff)
					' -------------------------------------------------------------
						'ResPrel.QtaTotUMB & " " & ResPrel.UMB					
						'Dim QtaDaPrel As Int = 
						'RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,"PZ.",12)						
						'RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,"PZ.",12)
					' -------------------------------------------------------------
					Panel3.Visible=True					
					' -------------------------------------------------------------
					'	MaskedEditText1.Text = res.GetString("c10")
					' -------------------------------------------------------------																				
					' -------------------------------------------------------------
					'	Leggi TotQtaUMVClienti
					' -------------------------------------------------------------			
					Wait For(Leggi_QtaTotAggiunteClienti(vRifIdTesta,RifIdRiga,vCodArticolo)) complete  (Result1 As Boolean)
					If(Result1) Then
						' -------------------------------------------------------------
						'	Leggi Disponibilità in locale
						' -------------------------------------------------------------
						If(QtaStoryDisp=0) Then
							Label52.Text=""
							Label55.Text=""						
							wait for (Leggi_DisponibilitaCorsiaLocal(vCodArticolo,vCorsia,0)) complete (Result2  As PartiteQtaType)
							If (Result2 <> Null) Then
								Dim DispUM2 As String = Result2.GiacenzaUM2
								DispUM2=DispUM2.Replace(".",",")
								Dim DispUM1 As String = Result2.GiacenzaUM1
								DispUM1=DispUM1.Replace(".",",")
								Label52.Text=DispUM2 & " " & Result2.UM2
								Label55.Text=DispUM1 & " " & Result2.UM1
								QtaStoryDisp=Result2.GiacenzaUM1
								RicalcoloAutomaticoQtaDisponibile(vCodArticolo,Result2.UM1,QtaStoryDisp)
							End If
						End If
					End If
				Loop						
			End If
		End If

	Catch
		Log(LastException)
		
	End Try
		
End Sub

Sub Converti_QtaPrelevabile (SQLData As SQL, Codart As String, UMVen As String, Qta As Double) As QtaPrelevabileType
	Try
		Dim Qta_UMB As Double
		Dim Qta_UML As Double		
		Dim Qta_UMV As Double
		Dim Res As QtaPrelevabileType
		If(Codart<>"") Then
			Dim rs As ResultSet = SQLData.ExecQuery2("SELECT UMB,UMV,UML,FCLB,FCVB FROM IS_VISTA_UMPREF WHERE CODICE = ?", Array As String (Codart))
			If(rs.RowCount>0) Then
				Dim row(5) As Object
				Do While rs.NextRow
					row(0) = rs.GetDouble("FCVB")
					row(1) = rs.GetDouble("FCLB")
					row(2) = rs.GetString("UMB")
					row(3) = rs.GetString("UMV")
					row(4) = rs.GetString("UML")
				Loop
				Qta_UMB = Qta * row(0)
				Qta_UML = Round2(Qta_UMB/row(1),1)
				Qta_UMV = (Qta_UMB Mod row(1)) / row(0)
				Res.Qta1P = Round2(Qta_UML,3)
				Res.UM1P = row(4)
				Res.Qta2P = Round2(Qta_UMV,3)
				Res.UM2P = row(3)				
				Res.Qta3P = Round2(Qta_UMB,3)
				Res.UM3P = row(2)
				Res.UMV = row(3)
				Res.UMB = row(2)
				Res.QtaTotUMB = Round2(Qta_UMB,3)
				Return Res
			Else
				Return Null				
			End If
		Else
			Return Null
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return Null
	End Try
End Sub

Sub Converti_QtaBaseInPrelevabile (SQLData As SQL, Codart As String, UMBase As String, Qta As Double) As QtaPrelevabileType
	Try
		Dim Qta_UMB As Double
		Dim Qta_UML As Double		
		Dim Qta_UMV As Double
		Dim Res As QtaPrelevabileType
		If(Codart<>"") Then
			Dim rs As ResultSet = SQLData.ExecQuery2("SELECT UMB,UMV,UML,FCLB,FCVB FROM IS_VISTA_UMPREF WHERE CODICE=? AND UMB=?", Array As String (Codart,UMBase))
			If(rs.RowCount>0) Then
				Dim row(5) As Object
				Do While rs.NextRow
					row(0) = rs.GetDouble("FCVB")
					row(1) = rs.GetDouble("FCLB")
					row(2) = rs.GetString("UMB")
					row(3) = rs.GetString("UMV")
					row(4) = rs.GetString("UML")
				Loop
				If(row(3)=row(4)) Then
					' Qta_UML = CInt(Round2(Qta/row(0),1))
					Qta_UML = CInt(Qta/row(0))
					Qta_UMV = 0
					Qta_UMB = Qta - (Qta_UML*row(1)) 			
					Res.UM1P = row(4)
					Res.UM2P = row(2)					
					Res.UM3P = row(2)
				Else
					'Qta_UML = CInt(Round2(Qta/row(1),1))
					'Qta_UMV = CInt(Round2((Qta Mod row(1)) / row(0),1))					
					Qta_UML = CInt(Qta/row(1))
					Qta_UMV = CInt((Qta Mod row(1)) / row(0))
					Qta_UMB = Qta - (Qta_UML*row(1)) - (Qta_UMV*row(0))
					Res.UM1P = row(4)
					Res.UM2P = row(3)
					Res.UM3P = row(2)
				End If						
				Res.Qta1P = Round2(Qta_UML,3)
				Res.Qta2P = Round2(Qta_UMV,3)
				Res.Qta3P = Round2(Qta_UMB,3)
				Res.QtaTotUMB = Round2(Qta,3)
				Res.UMV = row(3)
				Res.UMB = row(2)
				Return Res
			Else
				Return Null				
			End If
		Else
			Return Null
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return Null
	End Try
End Sub

Sub Aggiorna_Semaforo_Local(IdTestaDoc As Long, CorsiaDoc As String, Stato As Int) As ResumableSub
	Try		
		sqlstr = "UPDATE IS_SEMAFOROCORSIE_local SET OCCUPATA = ?  WHERE IDTESTA = ? AND CORSIA = ?"
		SQLDataAccess.ExecNonQuery2(sqlstr,Array As String(Stato, IdTestaDoc, CorsiaDoc))
		Log("Success1: " & sqlstr)
		Return True		
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

Sub Aggiorna_Corsia_Server( TipoDoc As String, NumDoc As Long, RifIdTesta As Long, Corsia As String,CodClifor As String) As ResumableSub
	' SCRITTURA TABELLE DAL SERVER
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		straction = "insert_righedocgiro"
		Log("Exec_Scrivi_DB(action: "&straction&" is_righedocumenti_giro.php)")
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDocGIRO(Me, dbAction, straction, "is_righedocumenti_giro.php","",TipoDoc, NumDoc, RifIdTesta, Corsia,CodClifor,Main.Utente)) Complete (Result As Boolean)
		If( Result) Then
			' OK
			Log ("Success2: " & "Operazione salvataggio corsia server effettuato con successo!")
			ToastMessageShow("Operazione salvataggio corsia server effettuato con successo!",True)			
			Return True			
		Else
			' MsgboxAsync("Operazione errata, problema di sincronizzazione is_righedocumenti_giro!","Sincronizzazione " & Main.MessageBoxText)
			ToastMessageShow("Operazione errata, problema di sincronizzazione is_righedocumenti_giro!",False)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Execute_EXEC_PHP_POST_SEMAFORO_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, Corsia As String, Utente As String,Occupata As Int) As ResumableSub
	Sleep(0)
	Dim Path_Php  As String = ""
	Dim job As HttpJob
	job.Initialize(JobName, frm)
	Try
		Dim mAction As String =  JobName.ToLowerCase
		If (Main.PortaPhp <> "") Then
			Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
		Else
			Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
		End If
		job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
			& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&corsia=" & Corsia & "&utente=" & Utente & "&stato=" & Occupata)

		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			Dim jobResult As String = job.GetString
			Log("JobResult: " & jobResult)
			job.release
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
			End If
			Select job.JobName.ToLowerCase
				Case "get_is_semaforocorsie"
					Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
								
				Case "del_is_semaforocorsie"
					Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
					
				Case Else
					Log("Errore nella procedura: Cash Execute_EXEC_Tab_PHP_POST_SEMAFORO_NESTI")
								
			End Select
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
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

Sub Aggiorna_Semaforo_Server(Corsia As String, Utente As String, Occupata As Int) As ResumableSub
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB_Semaforo(" &straction&" is_semaforocorsie.php)")		
		If(Occupata=-1) Then
			straction = "del_is_semaforocorsie"
			dbAction = CreateMap("action=": straction)
			wait for(Execute_EXEC_PHP_POST_SEMAFORO_NESTI(Me, dbAction, straction.ToLowerCase, "is_semaforocorsie.php", Corsia,Utente,0)) complete (Result2 As Boolean)		
		Else
			straction = "upd_is_semaforocorsie"
			dbAction = CreateMap("action=": straction)
			Select Occupata
				Case 4 
					Occupata = 1
				Case 2
					Occupata = 1
			End Select	
			Wait For (Execute_Scrivi_DB_Semaforo(Me, dbAction, straction.ToLowerCase, "is_semaforocorsie.php","",Corsia,Utente,Occupata)) Complete (Result2 As Boolean)
		End If
		If( Result2) Then
			Log("Success4: " & "upd_is_semaforocorsie")
			Return True
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione is_semaforocorsie!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Azzera_Semaforo_Corsie(RifIdTesta As Long, Corsia As String, Utente As String, TipoCorsia As String) As ResumableSub
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim occupata As Int
		Dim dbAction As Map
		occupata = 0
		Log("Exec_Azzera_SemaforoCorsieGiro(" &straction&" is_semaforocorsie_giro.php)")
		straction = "azz_is_semaforocorsie_giro"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_SemaforoGIRO(Me, dbAction, straction, "is_semaforocorsie_giro.php","",RifIdTesta,Corsia,Utente,occupata,TipoCorsia)) Complete (Result2 As Boolean)
		If( Result2) Then
			Log("Success3: " & " Sincronizzazione is_semaforocorsie_giro")
			Return True
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione is_semaforocorsie_giro!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Aggiorna_Semaforo_Giro_Server(RifIdTesta As Long, Corsia As String, Utente As String, Occupata As Int, Tipocorsia As String) As ResumableSub
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB_SemaforoGiro(" &straction&" is_semaforocorsie_giro.php)")
		straction = "upd_is_semaforocorsie_giro"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_SemaforoGIRO(Me, dbAction, straction, "is_semaforocorsie_giro.php","",RifIdTesta,Corsia,Utente,Occupata,Tipocorsia)) Complete (Result2 As Boolean)
		If( Result2) Then		
			Log("Success3: " & " Sincronizzazione is_semaforocorsie_giro")
			Return True
		Else
			MsgboxAsync("Operazione errata, problema di sincronizzazione is_semaforocorsie_giro!","Sincronizzazione " & Main.MessageBoxText)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Aggiorna_Partita_Server(routine As String, rifidtesta As Long, codart As String, partita As String, datamov As String, qta As Double, utentepalmare As String, codclifor As String) As ResumableSub
	' LEGGI TABELLE DAL SERVER
	Try
		If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
			Label2.Visible = True
			DateTime.DateFormat = "yyyyMMdd HHmmss"
			Dim F_Device As Boolean = True
			Dim nt As Int = 0
			If (F_Device) Then
				nt = nt + 1
				Dim straction As String = routine
				Dim dbAction As Map = CreateMap("action=": straction)
				WAIT FOR(Execute_EXEC_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, routine & ".php","", Main.Utente, rifidtesta, codart, partita, datamov, qta, utentepalmare, codclifor)) complete (Success As Boolean)
			End If
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

Sub ListaRigheTabletGIR(IdTestaDoc As Long, CorsiaDoc As String)
	Try	
		Dim F_Errore As Boolean
		If (IdTestaDoc <> 0 ) Then
			If(Label59.Text="GIRO CHIUSO")Then
				Button2.Enabled=False
				Button25.Enabled=False						
			End If
			If (TipoOperazione="PIK") Then
				sqlstr =$"SELECT COUNT(*) FROM IS_RIGHEDOCUMENTI WHERE TIPODOC='GIR' AND RIFIDTESTA=? AND CORSIA=?"$
				Dim Nrecs As Int = SQLDataAccess.ExecQuerySingleResult2(sqlstr,Array As String(IdTestaDoc,CorsiaDoc))
				If(Nrecs>0) Then
					sqlstr = $"SELECT RD.IDRIGA AS POSIZIONE, ifnull(RD.TipoRiga,'') AS TIPORIGA, RD.CodArt AS CODART, RD.DESCRIZIONE AS DESCRIZIONEART, ifnull(RD.Ordinato,'') AS ORDINATO, RD.QTA AS QTAGEST, 
						RD.UM AS UMGEST, RD.TIPODOC, RD.NUMERODOC, ifnull(RD.Corsia,'') AS CORSIA, ifnull(RD.Ubicazione,'') AS UBICAZIONE, AA.FLAG_BILANCIA, RD.CodCliFor AS CODCLIFOR, RD.Idriga AS IDRIGA, 
						RD.Ordinamento AS ORDINAMENTO,RD.rifidtesta AS RIFIDTESTA, RD.QtaTotUMBaseDisp, RD.Qta2, RD.UM2, RD.Peso, ifnull(RD.Status,'') as Status, RD.UMBase, RD.UM3, RD.QtaTotUMBase, 
						RD.CoeffConvUMA, ifnull(RD.Partita1,'') as Partita1, ifnull(RD.Partita2,'') as Partita2, ifnull(RD.Partita3,'') as Partita3, RD.QP1, RD.QP2, RD.QP3 
						FROM IS_RIGHEDOCUMENTI AS RD LEFT OUTER JOIN IS_ANAGRAFICAARTICOLI As AA ON AA.CODICE=RD.CODART WHERE RD.RIFIDTESTA=? AND RD.CORSIA =? AND 
						TIPODOC='GIR' ORDER BY POSIZIONE"$
				Else
					' serve per cancellare eventuali TV inseriti e non confermati
					sqlstr = $"DELETE FROM IS_RIGHEDOCUMENTI WHERE TIPODOC='TV' AND RIFIDTESTA=? AND CORSIA=?"$
					SQLDataAccess.ExecNonQuery2(sqlstr,Array As String(IdTestaDoc,CorsiaDoc))
					sqlstr = $"SELECT VI.rowid, VI.POSIZIONE, ifnull(VI.TIPORIGA,'') as TIPORIGA, VI.CODART, VI.DESCRIZIONEART, VI.QTAGEST, ifnull(VI.UMGEST,'') as UMGEST, 
						ifnull(VI.UMA,'') as UMA, ifnull(VI.UMP,'') as UMP, ifnull(VI.UMV,'') as UMV, ifnull(VI.TIPODOC,'') as TIPODOC, VI.NUMERODOC, VI.DATADOC, VI.DSCCONTO1, ifnull(VI.CORSIA,'') as CORSIA,
						VI.UBICAZIONE, VI.FLAG_BILANCIA, VI.CODCLIFOR, VI.IDRIGA, VI.ORDINAMENTO, VI.IDTESTA AS RIFIDTESTA, 0 AS QtaTotUMBaseDisp FROM IS_VISTADOCPALM 
						AS VI LEFT OUTER JOIN IS_ANAGRAFICAARTICOLI As AA ON AA.CODICE=VI.CODART WHERE VI.IDTESTA=? AND VI.CORSIA =? ORDER BY POSIZIONE"$
				End If	
				' Log(sqlstr)
				Dim rs As ResultSet = SQLDataAccess.ExecQuery2(sqlstr,Array As String(IdTestaDoc,CorsiaDoc))
				Dim DataListGIR As List
				DataListGIR.Initialize
				Do While rs.NextRow
					Dim rowx(27) As Object
					If rs.GetDouble("QTAGEST") Mod 1=0 Then 	' fa le stesse veci della funzione int() se intero elimno eventuali decimali
						Ordinatoum = NumberFormat2(rs.GetDouble("QTAGEST"),0,0,0,False)
					Else
						Ordinatoum = rs.GetDouble("QTAGEST")
					End If
					If(Nrecs>0) Then
						'----------------------------------
						' RIGHEDOCUMENTI
						'----------------------------------
						rowx(0) = rs.GetInt("POSIZIONE")				' Posizione
						rowx(1) = rs.Getstring("TIPORIGA")				' TipoRiga
						rowx(2) = rs.Getstring("CODART")				' Codart
						rowx(3) = rs.Getstring("DESCRIZIONEART")		' Descrizione Art.
						rowx(4) = rs.GetString("ORDINATO")				' Ordinato + UM
						rowx(5) = rs.GetString("UMGEST")				' UM Ordinato
						rowx(6) = rs.Getdouble("QTAGEST")				' Acquisito UM1
						rowx(7) = rs.GetString("UM2")					' UM2
						rowx(8) = rs.Getdouble("Qta2")					' Acquisito UM2					
						rowx(9) = rs.GetString("UM3")					' UM3						
						rowx(10) = rs.Getdouble("Peso")					' Peso in KG										
						rowx(11) = rs.GetString("CORSIA") 				' Corsia
						rowx(12) = rs.GetString("UBICAZIONE")			' Ubicazione
						rowx(13) = rs.GetString("Status")      			' status colore
						rowx(14) = rs.GetInt("ORDINAMENTO")     		' prorità variabile
						rowx(15) = rs.GetInt("IDRIGA")     				' IDriga
						rowx(16) = rs.GetString("UMBase")				' UMBase
						rowx(17) = rs.GetDouble("QtaTotUMBase")			' QtaTotUMBase
						rowx(18) = rs.GetDouble("CoeffConvUMA")			' CoeffConvUMA
						rowx(19) = rs.GetString("Partita1")				' Partita1
						rowx(20) = rs.GetDouble("QP1")					' QtaP1
						rowx(21) = rs.GetString("Partita2")				' Partita2
						rowx(22) = rs.GetDouble("QP2")					' QtaP2
						rowx(23) = rs.GetString("Partita3")				' Partita3
						rowx(24) = rs.Getdouble("QP3")					' QtaP3
						rowx(25) = rs.GetLong("RIFIDTESTA")				' RifIdTesta
						rowx(26) = rs.GetDouble("QtaTotUMBaseDisp")		' DispUMBase
					Else				
						'----------------------------------
						' VISTADOCPALM
						'----------------------------------
						rowx(0) = rs.GetInt("POSIZIONE")					' Posizione
						rowx(1) = rs.Getstring("TIPORIGA")					' TipoRiga
						rowx(2) = rs.Getstring("CODART")					' Codart
						rowx(3) = rs.Getstring("DESCRIZIONEART")			' Descrizioone
						rowx(4) = Ordinatoum & " " & rs.GetString("UMGEST") ' ORdinato + UM
						rowx(5) = rs.GetString("UMGEST")					' UM Ordinato
						rowx(6) = 0 ' Acquisito + UMGest					' Acquisito UM1
						rowx(7) = Leggi_UMBase(rowx(2),rowx(5))				' UM2
						rowx(8) = 0	'Acquisito UM2							' Acquisito UM2
						rowx(9) = ""   '									' UM3
						rowx(10) = 0 										' Acq. UM3 - Peso in KG
						rowx(11) = rs.GetString("CORSIA") 					' Corsia
						rowx(12) = rs.GetString("UBICAZIONE")				' Ubicazione
						rowx(13) = ""                          				' status colore
						rowx(14) = rs.GetInt("ORDINAMENTO")     			' prorità variabile
						rowx(15) = rs.GetInt("IDRIGA")     					' IDriga
						rowx(16) = ""										' UMBase
						rowx(17) = 0										' QtaTotUMBase
						rowx(18) = 0										' CoeffConvUMA
						rowx(19) = ""										' Partita1
						rowx(20) = 0										' QtaP1
						rowx(21) = ""										' Partita2
						rowx(22) = 0										' QtaP2
						rowx(23) = ""										' Partita3
						rowx(24) = 0										' QtaP3
						rowx(25) = rs.GetLong("RIFIDTESTA")					' RifIdTesta
						rowx(26) = rs.Getdouble("QtaTotUMBaseDisp")			' DispUMBase
					End If
					DataListGIR.Add(rowx)
				Loop
				If(rs.RowCount>0) And (Nrecs=0) Then
					If (Label1.Text.Trim="") Then
						Dim DataDoc As String = ExtraUtility.ConvertDateTimeTo_ITA_Format(rs.GetString("DATADOC"),False)
						Label1.Text = " " & rs.GetString("TIPODOC") & " N. " & rs.GetString("NUMERODOC") & " DEL " & DataDoc & " - " & rs.GetString("DSCCONTO1") '  & rs.GetString("DATADOC")
						TipoDocOrig = rs.GetString("TIPODOC")
						NumDocOrig = rs.GetInt("NUMERODOC")
						DataDocOrig = DataDoc
						vCodCliFor = rs.GetString("CODCLIFOR")
						Priorita = 0
						Col1_Column.InternalSortMode="ASC"
						Col1_Column.Sortable = True
						vTipoDocNew = "GIR"
					End If
				Else
					If(Nrecs=0) Then
						If(CorsiaDoc<>1000) Then						
							ExtraUtility.Play_Sound("error.wav")	
							If(Label59.Text="GIRO CHIUSO") Then
								Msgbox2Async("CORSIA NON TROVATA NEL DOCUMENTO GIR?","CONTROLLO CORSIA '" & vCorsia & "'","","","ANNULLA",Null,True)
							Else
								Msgbox2Async("CORSIA NON TROVATA NEL DOCUMENTO GIR?","CONTROLLO CORSIA '" & vCorsia & "'","AGGIUNGI CORSIA","","ANNULLA",Null,True)
							End If							
							Wait For MsgBox_Result (Result As Int)
							If Result = DialogResponse.NEGATIVE Then						
								F_Errore = True					
								CallSubDelayed(Me,Button8_Click)
							End If					
						Else
							If(CorsiaDoc=1000) Then
								Button8.Text="CS000"
							End If
						End If
					End If
				End If
				rs.Close
				B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)		
				B4XTable1.SetData(DataListGIR)
				If(DataListGIR.Size>0) Then
					Dim column As B4XTableColumn = B4XTable1.GetColumn("Ord.")
					column.InternalSortMode= "ASC"					
					TotalSize = B4XTable1.Size					
				Else
					TotalSize = 0
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
	Label36.Text=""
	' Label37.Text = ""
	Label38.Text=""
	Label39.Text=""
	' Label40.Text = ""
	Label41.Text=""
	Label42.Text=""
	'---------------------
	Label11.Text=""
	Label14.Text=""
	Label47.Text=""
	Label45.Text=""
	Label46.Text=""
	Label48.Text=""
	UpdateTape
End Sub

Sub NewData_PICKING(CodiceLettoPIK As String, F_Errore As Boolean)
	If (CodiceLettoPIK.Length=13) And (CodiceLettoPIK.SubString2(0,1)="2") And (vCodArticolo="") Then
		' Decodifico articolo a peso, in realtà solo l'articolo
		CodiceLettoPIK = ExtraUtility.LeggiArticoloConPeso(CodiceLettoPIK,1)	' estrae l'articolo dalla stringa letta
	End If
	sqlstr = "SELECT AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLettoPIK & "'"
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
								& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & CodiceLettoPIK & "'"
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
			UM3 = RowData.GetValueAt(9)
			ordinato = RowData.GetValueAt(4)
			OrdinatoNum = ExtraUtility.ConvertToNumber(RowData.GetValueAt(4))
			ordinato = ordinato.Replace(" ",CRLF)
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
			' Label32.Text = "TOTALE " & (acquisitoum1+acquisitoum2) & UM2
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

Sub Registra_Panel4(RifIdTesta As Long, RifIdRiga As Int, CodArt As String, TipoDoc As String, Esercizio As Int, Corsia As String, NumDoc As Int, Ubicazione As String)
	Dim res As ResultSet
	Dim ncount As Int
	If(B4XTable3.Size>0) Then
		res = B4XTable3.sql1.ExecQuery($"SELECT c0,c2 FROM data"$)
		ncount = res.RowCount
	Else
		ncount = 0
	End If
	If(ncount>0) Then
		sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND RifIdTesta='" & RifIdTesta & "' AND Codart = '" _
		& CodArt & "' AND RifIdRiga = '" & RifIdRiga & "'"
		SQLDataAccess.ExecNonQuery(sqlstr)
		Dim k As Int = 0
		Do While res.NextRow				
			k = k+1
			Dim Qta As Double = res.GetString("c2")
			Dim CodCliFor As String = res.GetString("c0")					
			Dim QtaTotBase As Double = Converti_Qta_UMBase(SQLDataAccess,CodArt,UMV,Qta)
			sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,RifIdTesta,RifIdRiga,CodClifor,Codart,Qta,Corsia,Numerodoc,Esercizio,idriga,UtenteModifica," _
			& "UM,UMBase,QtaTotUMBase,Ubicazione,TipoRiga,Descrizione,QtaTotUMBaseDisp) VALUES ('" _
			& TipoDoc & "','" & NumDoc & "','" & RifIdTesta & "','" & RifIdRiga & "','" & CodCliFor & "','" 	& CodArt & "','" & Qta &"','" & Corsia & "','" _
			& RifIdTesta & "','" & Esercizio & "','" & k & "','" & Main.Utente & "','" & UMV & "','" & UMB & "','" & QtaTotBase & "','" & Ubicazione & "','N','" _
			& Label35.text & "','" &  Label55.text  &"')"
			Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)			
		Loop
	End If
	B4XTable1_DataUpdated
	B4XTable1.UpdateTableCounters
	B4XTable1.Refresh
End Sub

Sub Registra_Panel3(msg As String,npos As Int,StatoRiga As String)As ResumableSub
	Try	
		Sleep(0)
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
				vFattoreConv  = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
				vQtaTotUMAConv = Round2(vFattoreConv*TotQtaUMX,4)
				If (TipoOperazione="PIK") Then
					vCorsiaUbicazColl = EditText6.Text
					B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c3=?,c4=?,c5=?,c6=?,c7=?,c8=?,c14=?,c13=?,c15=?,c16=?,c17=?,c18=?,c20=?,c26=? WHERE c0=?"$, Array As Object(Label37.Text,Label39.Text,Label38.Text,Label41.Text,Label40.Text,TotPesoArt,TotQtaUMX,vQtaTotUMAConv,vFattoreConv,vCorsiaUbicaz,vCorsiaUbicazColl,vFlagSvuotaCella,StatoRiga,Label55.Text,npos))
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
			Dim coddeposito As String = Button8.Text
			Dim Qta As Double = CDbl(TotQtaUMX)	
			wait for (Leggi_DisponibilitaArticoloServer(vCodArticolo,coddeposito,Qta)) complete (Result  As PartiteQtaType)
			If (Result <> Null) Then
				If(Label42.Visible=False) Then
					Label40.Text=""
					Label42.Text=""
				End If		
				vFattoreConv  = 1
				If (TipoOperazione="PIK") Then		
					B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c5=?, c6=?, c7=?, c8=?, c9=?, c10=?, c16=?, c17=?, c18=?, c19=?, C20=?, c21=?, C22=?, c23=?, c24=?, c13=?, c26=? WHERE c0=?"$, Array As _
					Object(UM1, TotQtaUM1, UM2, TotQtaUM2, UM3, TotQtaUM3,UMB,TotQtaUMX,vFattoreConv,Result.Partita1,Result.Qta1,Result.Partita2,Result.Qta2,Result.Partita3,Result.Qta3,StatoRiga,Label55.Text,npos))
				End If
				B4XTable1_DataUpdated
				B4XTable1.UpdateTableCounters
				B4XTable1.Refresh
			End If
		End If
		Button3.Text=Label37.Text
		Button4.Text=Label38.Text
		EditText2.Text=Label39.Text
		EditText3.Text=Label41.text
		EditText4.Text=Label42.Text
		Return(True)
	Catch
		Return(False)
		Log(LastException)
	End Try
End Sub

Sub Leggi_Barcode_Articolo(CodiceLetto As String) As List
	Dim Result As List
	Dim F_Errore As Boolean = False
	Dim Corsia As String = ""
	Dim PesoArt As Double = 0
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
		sqlstr = "SELECT AA.CORSIA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLetto & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label3.Text = rs.GetString("DESCRIZIONE")
				vCodArticolo = rs.GetString("CODICE")
				Corsia=rs.GetString("CORSIA")
				Result.Add(vCodArticolo)							
				If(Corsia<>vCorsia) Then	
					Result.Add(Corsia)
					ExtraUtility.Play_Sound("Sound3.wav")
					MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ATTENZIONE CORSIA " & Corsia)										
				End If
			Loop
			rs.close
		Else
			sqlstr = "SELECT AA.CORSIA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
				& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE ='" & CodiceLetto & "'"  '" & vCodArtLotto & "'" 
			Log (sqlstr)
			Dim vDescArticolo As String = ""
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If (rs.RowCount>0)  Then
				Do While rs.NextRow
					vDescArticolo = rs.GetString("DESCRIZIONE")
					vCodArticolo = rs.GetString("ARTICOLO")
					Corsia=rs.GetString("CORSIA")
					Result.Add(vCodArticolo)					
					If(Corsia<>vCorsia) Then
						Result.Add(Corsia)
						ExtraUtility.Play_Sound("Sound3.wav")
						MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ATTENZIONE CORSIA " & Corsia)						
					End If					
				Loop
				Label3.Text = vDescArticolo
				rs.close
			Else
				'--------------------------------------------------------------------------------
				' nel caso non venga decodificato il codice si applica funzione Decodifica_EAN
				'--------------------------------------------------------------------------------
				Dim vRes As tRec_EANCODE = DBUtilsExtra.Decodifica_CodiceEAN(SQLDataAccess,vBarcodeLetto)
				If (vRes.IsInitialized) Then					
					vCodArticolo = vRes.Codart
					vCorsiaArticolo = vRes.Corsia
					PesoArt = Round2(vRes.Qta,3)
					Result.Add(vCodArticolo)
					If (vCodArticolo<>"") Then
						Label3.Text = vRes.Descrizione
					Else
						If(vTipoReadGiac<>"CELCEL") And (vTipoReadGiac<>"CORMAG") Then
							ExtraUtility.Play_Sound("error.wav")
							Label3.Text = "*** CODICE ERRATO ***"
							F_Errore = True
						End If
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

Sub Decodifica_Articolo_Picking(Codice As String) As List
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
		If (Idx>0) Then
			Check.Add("T=2")    ' Tipo Lettura Codice Lotto
			Check.Add(Codice.SubString(Idx+3))
			Check.Add(Codice.SubString2(0,Idx))				
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
	'---------------------------------------------
	' leggi la righe ANDROID_GIRO sul server
	'---------------------------------------------
	Leggi_RigheDocumentiGIRO_Server(vRifIdTesta,vCorsia)
End Sub

Sub Aggiorna_ColoriListaTablet
	Try
		XSelections.Clear
		XSelections.SelectedLines.Clear
		XSelections.Refresh(ColumnColor)
		B4XTable1.ClearDataView
		B4XTable1.UpdateTableCounters
		B4XTable1.Refresh
		B4XTable1_DataUpdated
	Catch
		Log(LastException)
	End Try
End Sub

Sub Visulizza_Corsie
	Try
		'--------------------------------
		' Leggi il Semaforo Corsie
		'--------------------------------
		Sleep(200)
		Button22.Tag=""
		Button22.Visible=False
		Dim nrecs As Int = B4XTable1.sql1.ExecQuerySingleResult("SELECT count(*) FROM data WHERE c13<>''")
		If(nrecs=0) Then
			vCorsiaOld = Button8.Text
			ListaRigheTablet2(False,vRifIdTesta)
			Button8.Enabled=False
			Button1.Enabled=False
			Button2.Enabled=False
			Button6.Enabled=False
			Button7.Enabled=False
			Panel2.Visible=True
		Else
			ListaRigheTablet2(False,vRifIdTesta)
			XSelections.SelectedLines.Clear
			XSelections.Refresh(ColumnColor)
			B4XTable1.ClearDataView
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
			B4XTable1_DataUpdated
			XSelections.SelectedLines.Clear
			XSelections.Refresh(ColumnColor)
			B4XTable1.Refresh
			If(Panel2.Visible=False) Then
				ToastMessageShow("NON PUOI CAMBIARE CORSIA SENZA CONFERMARE O SOSPENDERE",True)
				ExtraUtility.Play_Sound("error.wav")
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button8_Click
	Visulizza_Corsie
End Sub

Sub Button7_Click
	' Registra Documento
	Try				
		XSelections.Clear
		Sleep(0)
		Select TipoOperazione
			Case "PIK"  ' PICKING
				RegistraDocumento(vTipoDocNew,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia)
				IDkey = Leggi_IDkey(SQLDataAccess,vTipoDocNew,vNumDocNew,vEsercizioNew)
				Msgbox2Async("Vuoi chiudere il GIRO sincronizzando il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
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
		End Select
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button1_Click
	'----------------------
	' Conferma Corsia
	'----------------------
	Sleep(0)
	XSelections.SelectedLines.Clear
	XSelections.Refresh(ColumnColor)
	If(Label59.Text="GIRO CHIUSO") Then
		ListaRigheTablet2(False,vRifIdTesta)
	Else	
		Dim nrecs As Int = B4XTable1.sql1.ExecQuerySingleResult("SELECT count(*) FROM data WHERE c13<>'G' and c13<>'Y'")
		If(Button22.Visible=False) Then
			Button22.Tag=""
		End If
		If(nrecs>0) And (Button22.Tag<>"Pressed") And (Button22.Visible=False) Then
			ExtraUtility.Play_Sound("error.wav")
			Button22.textColor=Colors.Red
			Button22.Color=Colors.LightGray
			Button22.Tag=""
			Button22.Text="ATTENZIONE!! CONFERMARE LE VARIAZIONI"
			Button22.Visible=True
			Button22.BringToFront
			XSelections.SelectedLines.Clear
			XSelections.Refresh(ColumnColor)
			B4XTable1.CreateDataView($"c13<>'G' and c13<>'Y'"$)
			B4XTable1.UpdateTableCounters
			B4XTable1_DataUpdated
			B4XTable1.Refresh
			XSelections.SelectedLines.Clear
			XSelections.Refresh(0)
			B4XTable1.Refresh
		Else
			Button22.Text=""
			Button22.Visible=False
			If(ListaDocTablet.vOperazione="NuovoDoc")  Then
				RegistraCorsia("GIR",vNumDocNew,vEsercizioNew,vDataDocNew,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,4)
			Else
				RegistraCorsia("GIR",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,4)
			End If
		End If
	End If
End Sub

Sub Button2_Click
	'----------------------
	' Sospendi Corsia
	'----------------------
	Sleep(0)
	Button22.Tag=""
	Button22.Text=""
	Button22.Visible=False
	XSelections.SelectedLines.Clear
	XSelections.Refresh(ColumnColor)
	If(ListaDocTablet.vOperazione="NuovoDoc")  Then
		RegistraCorsia("GIR",vNumDocNew,vEsercizioNew,vDataDocNew,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,2)
	Else
		RegistraCorsia("GIR",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,2)
	End If
End Sub

private Sub ListaRigheTablet(TipoDoc As String, NumDoc As Int, Esercizio As Int)
	Sleep(0) 'this is required as the table layout is not immediately created.'	
	B4XTable1.SearchVisible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update
	B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(14)
	B4XTable1.LabelsFont = xui.CreateDefaultFont(20)
	B4XTable1.MaximumRowsPerPage = 15
	B4XTable1.RowHeight = DipToCurrent(Main.AltRiga)
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet
	Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			' Posizione (c0)
	Col1_Column.Width=1
	Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_TEXT) 					' Tipo Riga (c1)
	Col2_Column.Width=1
	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo (c2)
	Col3_Column.Width=130dip ' 85dip
	Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione (c3)
	Col4_Column.Width=360dip ' 350dip  per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
	Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Ordinato", B4XTable1.COLUMN_TYPE_TEXT)			' Ordinato + UM Ordinato (c4)
	Col5_Column.Width=100dip ' TEXT
	Dim Col6_Column As B4XTableColumn =  B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM1 Ordinato (c5)
	Col6_Column.Width=50dip '1 TEXT
	Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Qta1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acquisito UM1 (c6)
	Col7_Column.Width=100dip ' 80dip TEXT
	Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2 (c7)
	Col8_Column.Width=50dip ' 1 '140 TEXT
	Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Qta2", B4XTable1.COLUMN_TYPE_NUMBERS)		     	' Acquisito UM2 (c8)
	Col9_Column.Width=90dip '140 TEXT
	Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3 (c9)
	Col10_Column.Width=50dip ' 1  TEXT
	Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Qta3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acq. UM3 | Peso Kg (c10)	
	Col11_Column.Width=90dip ' TEXT 95dip
	Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Corsia", B4XTable1.COLUMN_TYPE_TEXT)				' Corsia (c11)
	Col12_Column.Width=80dip ' TEXT 40dip
	Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Ubicazione",B4XTable1.COLUMN_TYPE_TEXT)			' Ubicazione (c12)
	Col13_Column.Width=150dip ' TEXT per SAMSUNG NESTI = 86dip, per HUAWEI = 90dip
	Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c13)
	Col14_Column.Width=1 ' 50dip 
	Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("Ord.", B4XTable1.COLUMN_TYPE_NUMBERS)				' priorità variabile
	Col15_Column.Width=75dip '  1
	Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdriga", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIDriga
	Col16_Column.Width=100dip '  1
	Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("UMB", B4XTable1.COLUMN_TYPE_TEXT)	    			' QtaTotUMB	 (c16)
	Col17_Column.Width=100dip '  1
	Dim Col18_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMB", B4XTable1.COLUMN_TYPE_NUMBERS)		' QtaTotUMB	(c17)
	Col18_Column.Width=100dip '  1
	Dim Col19_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c18)
	Col19_Column.Width=1 '  1
	Dim Col20_Column As B4XTableColumn = B4XTable1.AddColumn("Partita1", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 1 (c19)
	Col20_Column.Width=140dip '  1
	Dim Col21_Column As B4XTableColumn = B4XTable1.AddColumn("QP1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 1 (c20)
	Col21_Column.Width=50dip '  1		
	Dim Col22_Column As B4XTableColumn = B4XTable1.AddColumn("Partita2", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 2 (c21)
	Col22_Column.Width=140dip '  1
	Dim Col23_Column As B4XTableColumn = B4XTable1.AddColumn("QP2", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 2 (c22)
	Col23_Column.Width=50dip '  1	
	Dim Col24_Column As B4XTableColumn = B4XTable1.AddColumn("Partita3", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 3 (c23)
	Col24_Column.Width=140dip '  1
	Dim Col25_Column As B4XTableColumn = B4XTable1.AddColumn("QP3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 3 (c24)
	Col25_Column.Width=50dip '  1
	Dim Col26_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdTesta", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIdTesta (c25)
	Col26_Column.Width=90dip '  1
	Dim Col27_Column As B4XTableColumn = B4XTable1.AddColumn("DispUMBase", B4XTable1.COLUMN_TYPE_NUMBERS)		' DispUMBase (c26)
	Col27_Column.Width=90dip '  1
	If(ListaDocTablet.vOperazione="ApriDoc") Then
		Label1.Text=ListaDocTablet.vTitle.Replace(CRLF," - ")
		TipoDocOrig = ""		
		NumDocOrig = 0
		DataDocOrig = ""		
		sqlstr = "select * from IS_TESTEDOCUMENTI WHERE TipoDoc = '" & TipoDoc _
		 & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rst.NextRow
			TipoDocOrig = rst.GetString("TipoDocOrig")
			NumDocOrig = rst.GetInt("NumDocOrig")
			DataDocOrig = rst.GetString("DataDocOrig")
			vRifIdTesta = rst.GetLong("rifidtesta")			
			vTrasmesso = rst.GetInt("Trasmesso")	
			vDataRifDoc= rst.GetInt("DataRifDoc")
		Loop
		rst.Close
		If (vTrasmesso=1) Then
			Button1.Enabled = False
			Button2.Enabled = False
			Button7.Enabled = False
			Label1.Color = Colors.Red
		End If
		If (vRifIdTesta > 0) Then
			Label6.Text = "GIR N. " & vRifIdTesta
		Else
			Label6.Text="ERRORE"
		End If		
     	vTipoDocNew = TipoDoc
		vNumDocNew = NumDoc
		vEsercizioNew = Esercizio
		Log(sqlstr)
	End If
	DataList.Initialize	
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		sqlstr = "select Idriga,TipoRiga,Codart,Descrizione,ifnull(Ordinato,'') as Ordinato,UM,Qta,ifnull(UM2,'') as UM2,Qta2,ifnull(UM3,'') as UM3," _
		& "Qta3,Corsia,Ubicazione,Status,ordinamento,RifIdriga,UMBase,QtaTotUMBase,CoeffConvUMA,ifnull(Partita1,'') as Partita1,QP1," _
		& "ifnull(Partita2,'') as Partita2,QP2,ifnull(Partita3,'') as Partita3,QP3,rifidtesta," _
		& "QtaTotUMBaseDisp from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & vTipoDocNew _
		& "' AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "select Idriga,TipoRiga,Codart,Descrizione,ifnull(Ordinato,'') as Ordinato,UM,Qta,ifnull(UM2,'') as UM2,Qta2,ifnull(UM3,'') as UM3," _
		& "Qta3,Corsia,Ubicazione,Status,ordinamento,RifIdriga,UMBase,QtaTotUMBase,CoeffConvUMA,ifnull(Partita1,'') as Partita1,QP1," _
		& "ifnull(Partita2,'') as Partita2,QP2,ifnull(Partita3,'') as Partita3,QP3,rifidtesta," _
		& "QtaTotUMBaseDisp from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio _
		& "' AND CORSIA ='CSXXX'"
	End If
	Log(sqlstr)			
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(27) As Object
	'	If rs.Getdouble("QTAGEST") Mod 1=0 Then 	' fa le stesse veci della funzione int() se intero elimno eventuali decimali
	'		Ordinatoum = NumberFormat(rs.Getdouble("QTAGEST"),0,0)
	'	Else
	'		Ordinatoum = rs.Getdouble("QTAGEST")
	'	End If
		rowx(0) = rs.GetInt("Idriga")
		If (rs.Getstring("TipoRiga")="N") Then		
			rowx(1) = ""														' TipoRiga
		Else
			rowx(1) = rs.Getstring("TipoRiga")									' TipoRiga
		End If
		rowx(2) = rs.Getstring("Codart")										' Codart
		rowx(3) = rs.Getstring("Descrizione")									' Descrizione
		rowx(4) = rs.GetString("Ordinato") 										' Ordinato (UM + Qta)
		rowx(5) = rs.GetString("UM")											' UM1 (Acquistato)
		If(rs.Getint("Qta")>0) Then
			rowx(6) = rs.GetDouble("Qta")											' Acquisito + UMGest
		Else
			rowx(6) = 0
		End If
		rowx(7) = rs.GetString("UM2")											' UM2
		If(rs.GetInt("Qta2")>0) Then
			rowx(8) = rs.GetDouble("Qta2")											' Acquisito UM2
		Else
			rowx(8) = 0
		End If
		rowx(9) = rs.Getstring("UM3")											' UM3
		If(rs.GetInt("Qta3")>0) Then
			rowx(10) = rs.GetDouble("Qta3")										' Acquisito UM3 / Peso
		Else
			rowx(10) = 0  
		End If	   												
		rowx(11) = rs.Getstring("Corsia") 										' Corsia
		rowx(12) = rs.GetString("Ubicazione")       							' Ubicazione
		rowx(13) = rs.GetString("Status") 			                            ' status colore
		rowx(14) = rs.GetString("Ordinamento")  								' prorità variabile
		rowx(15) = rs.GetInt("RifIdriga")     									' RifIDriga
		rowx(16) = rs.GetDouble ("UMBase")     									' UMB
		rowx(17) = rs.GetDouble ("QtaTotUMBase")        						' QtaTotUMB
		rowx(18) = rs.GetDouble ("CoeffConvUMA")     							' CoeffConvUMA
		rowx(19) = rs.Getstring ("Partita1")     								' Partita1
		rowx(20) = rs.GetDouble ("QP1")      									' Qta Partita1
		rowx(21) = rs.GetString ("Partita2")     								' Partita2
		rowx(22) = rs.GetDouble ("QP2")     									' Qta Partita2
		rowx(23) = rs.GetString ("Partita2")     								' Partita3
		rowx(24) = rs.GetDouble ("QP3")     									' Qta Partita3
		rowx(25) = rs.GetLong ("rifidtesta")     								' RifIdTesta
		rowx(26) = rs.GetDouble ("QtaTotUMBaseDisp")							' QtaTotUMBaseDisp
		vCorsia = rowx(11)
		DataList.Add(rowx)		
	Loop	
	rs.Close
	Button8.Text=vCorsia
	vCorsiaOld=vCorsia	
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)	
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	EditText1.RequestFocus		
	If(ListaDocTablet.vOperazione="ApriDoc") Then			
		Visulizza_Corsie
	End If
End Sub

private Sub ListaRigheTablet2(FirstTime As Boolean, IDtesta As Long)
	'----------------------------
	' Visualizza corsie
	'----------------------------
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'	
		If(FirstTime) Then
			'B4XTable2.SearchField.HintText = "Cerca"
			'B4XTable2.SearchField.HintColor = Colors.Green
			'B4XTable2.SearchField.Update
			'Panel2.Visible=False
			XSelections2.Initialize(B4XTable2)
			XSelections2.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)
			B4XTable2.SearchVisible=False
			' B4XTable2.pnlHeader.Visible=True
			B4XTable2.RowHeight = 50dip
			B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
			SelectedRows2 = B4XCollections.CreateSet
			SemaphoreGiroColumn = B4XTable2.AddColumn("Stato Giro",B4XTable2.COLUMN_TYPE_TEXT)		' Stato Giro			
			SemaphoreGiroColumn.Width = 175dip
			SemaphoreGiroColumn.Searchable = False
			SemaphoreGiroColumn.Sortable = True
			Col1x_Column =  B4XTable2.AddColumn("Corsia", B4XTable2.COLUMN_TYPE_TEXT) 				' Corsia
			Col1x_Column.Width=108dip			
			Col2x_Column =  B4XTable2.AddColumn("T", B4XTable2.COLUMN_TYPE_TEXT) 					' TipoCorsia
			Col2x_Column.Width=40dip			
			Col3x_Column =  B4XTable2.AddColumn("Utente", B4XTable2.COLUMN_TYPE_TEXT) 				' Utente
			Col3x_Column.Width=0dip
			'Dim Col3x_Column As B4XTableColumn =  B4XTable2.AddColumn("Occupata", B4XTable2.COLUMN_TYPE_NUMBERS) 	        ' Occupata
			'Col3x_Column.Width=25dip ' 85dip
			SemaphoreCorsiaColumn = B4XTable2.AddColumn("Stato Corsia",B4XTable2.COLUMN_TYPE_TEXT)		' Stato Corsia
			SemaphoreCorsiaColumn.Width = 100dip
			SemaphoreCorsiaColumn.Searchable = False
			SemaphoreCorsiaColumn.Sortable = True
			B4XTable2.BuildLayoutsCache(15)
			Label59.Text=""
			For i=0 To SemaphoreCorsiaColumn.CellsLayouts.Size-1
				' colonna 0 Semaphore Giro
				Dim pnl0 As B4XView = SemaphoreGiroColumn.CellsLayouts.Get(i)
				Dim lbl0 As Label = pnl0.GetView(0)
				lbl0.TextSize = 20
				lbl0.Typeface = Typeface.DEFAULT_BOLD
				lbl0.TextColor = Colors.Black
				lbl0.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				Dim ivS1 As ImageView
				ivS1.Initialize("")
				pnl0.AddView(ivS1,5dip,5dip,SemaphoreGiroColumn.Width - 10dip, B4XTable2.RowHeight-10dip)
				' colonna 1
				Dim pnl1 As B4XView = Col1x_Column.CellsLayouts.Get(i)
				Dim lbl1 As Label = pnl1.GetView(0)
				lbl1.TextSize = 20
				lbl1.Typeface = Typeface.DEFAULT_BOLD
				lbl1.TextColor = Colors.Black
				lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				' colonna 2
				Dim pnl2 As B4XView = Col2x_Column.CellsLayouts.Get(i)
				Dim lbl2 As Label = pnl2.GetView(0)
				lbl2.TextSize = 20
				lbl2.Typeface = Typeface.DEFAULT_BOLD
				lbl2.TextColor = Colors.Black
				lbl2.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				' colonna 3
				Dim pnl3 As B4XView = Col3x_Column.CellsLayouts.Get(i)
				Dim lbl3 As Label = pnl3.GetView(0)
				lbl3.TextSize = 20
				lbl3.Typeface = Typeface.DEFAULT_BOLD
				lbl3.TextColor = Colors.Black
				lbl3.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				' colonna 4 Semaphore Corsia
				Dim pnl4 As B4XView = SemaphoreCorsiaColumn.CellsLayouts.Get(i)
				Dim lbl4 As Label = pnl4.GetView(0)
				lbl4.TextSize = 20
				lbl4.Typeface = Typeface.DEFAULT_BOLD
				lbl4.TextColor = Colors.Black
				lbl4.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				Dim ivS2 As ImageView			
				ivS2.Initialize("")
				pnl4.AddView(ivS2,5dip,5dip,SemaphoreCorsiaColumn.Width - 10dip, B4XTable2.RowHeight-10dip)
			Next
			B4XTable2.Refresh
		Else		
			If(IDtesta<>0) And (Label59.Text<>"GIRO CHIUSO") Then
				wait for (Update_IS_SEMAFOROCORSIE_LOCAL(IDtesta)) complete (Success As Boolean)
				If (Success=True) Then
					Dim Tbs(2) As String					
					Tbs(0)="IS_SEMAFOROCORSIE"
					Tbs(1)="IS_SEMAFOROCORSIE_GIRO"
					wait for (Leggi_Metodo_Tabelle(Tbs,vRifIdTesta,"")) complete (Success As Boolean)
					If (Success) Then
						'-------------------------------------------
						' LETTURA IS_SEMAFOROCORSIE SUL SERVER		
						'-------------------------------------------													
						Dim DataList2 As List
						DataList2.Initialize
						Label59.Text=""
						sqlstr = "SELECT STATOGIRO,CORSIA,TIPOCORSIA,UTENTE,STATOCORSIA FROM Vista_IS_SEMAFOROCORSIE WHERE IDtesta = '" _
						& IDtesta & "' ORDER BY TIPOCORSIA DESC,STATOGIRO ASC, CORSIA"
						Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
						If(rst.RowCount>0) Then
							Do While rst.NextRow
								Dim rowx(5) As Object
								rowx(0) = rst.Getint("STATOGIRO")					' STATO GIRO
								rowx(1) = rst.GetString("CORSIA")					' CORSIA
								rowx(2) = rst.GetString("TIPOCORSIA")				' TIPOCORSIA
								If (rst.Getstring("UTENTE")=Main.Utente) Then
									rowx(3) = ""									' UTENTE
								Else
									rowx(3) = rst.GetString("UTENTE")			  	' UTENTE
								End If
								If(rowx(3) ="CHIUSO") Then
									Label59.Text="GIRO CHIUSO"
								End If
								rowx(4) = rst.Getint("STATOCORSIA")	  			    ' OCCUPATA
								DataList2.Add(rowx)
							Loop
							rst.Close
							B4XTable2.MaximumRowsPerPage = 15						
							B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
							B4XTable2.SetData(DataList2)							
							Panel2.Visible=True
							Button8.Enabled=False
							Button1.Enabled=False
							Button2.Enabled=False
							Button6.Enabled=False
							Button7.Enabled=False							
							RegistraTestaNewDoc("GIR",IDtesta,"","NuovoDoc",vDataRifDoc,CodCliForFittizio)
						Else
							MsgboxAsync("ERRORE IDTESTA " & IDtesta,"ERRORE SEMAFOROCORSIE")
						End If
					End If
				End If
			Else				
				'---------------------------
				' Caso di GIRO CHIUSO
				'---------------------------
				Panel2.Visible=True
				' MsgboxAsync("TEST","TEST")
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_RigheDocumentiGIRO_Server(idtesta As Int, corsia As String) As ResumableSub
	Try
		Dim Tbs(1) As String
		Tbs(0)="IS_RIGHEDOCUMENTI_GIRO"
		wait for (Leggi_Metodo_Tabelle(Tbs,idtesta,corsia)) complete (Success As Boolean)
		If (Success) Then
			' LETTURA VISTA_DISPONIBILITA_CORSIA LOCAL
			sqlstr = "SELECT * FROM IS_RIGHEDOCUMENTI_GIRO WHERE RIFIDTESTA=" & idtesta & " AND CORSIA ='" &  corsia & "'"		
			Button11.Enabled=True
			Button12.Enabled=True
			Return True
		Else
			MsgboxAsync("ERRORE LETTURA_METODO","ERRORE")
			Return False
		End If
	Catch
		Return False
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_DisponibilitaCorsiaServer(corsia As String) As ResumableSub
	Try
		Dim Tbs(1) As String
		Tbs(0)="VISTA_DISPONIBILITA_CORSIA"
		wait for (Leggi_Metodo_Tabelle(Tbs,"",corsia)) complete (Success As Boolean)
		If (Success) Then
			' LETTURA VISTA_DISPONIBILITA_CORSIA
			sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM " _
			& "VISTA_DISPONIBILITA_CORSIA WHERE GIACENZA1>0 AND GIACENZA2>0 And CODDEPOSITO ='" &  corsia & "'"		
			Button11.Enabled=True
			Button12.Enabled=True
			Return True
		Else
			MsgboxAsync("ERRORE LETTURA_METODO","ERRORE")
			Return False
		End If
	Catch
		Return False
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_DisponibilitaCorsiaLocal(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try
		Dim Tbs(1) As String
		Dim Result As PartiteQtaType
		' LETTURA IS_VISTA_GIACENZA_ARTICOLO LOCAL
		sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_DISPONIBILITA_CORSIA WHERE " _
		& "GIACENZA1>0 And GIACENZA2>0 And CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
		Log (sqlstr)
		Dim GiacenzaUMG1 As Double = 0
		Dim GiacenzaUMG2 As Double = 0
		Dim UMG1 As String = ""
		Dim UMG2 As String = ""
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rst.RowCount>0) Then
			Dim QtaRes As Double = Qta
			Dim np As Int = 0
			Do While rst.NextRow
				np = np + 1
				Dim rowx(3) As Object
				rowx(0) = rst.GetString("NRIFPARTITA")
				If(rst.getstring("FLAG_BILANCIA")="S") Then  ' se articolo a bilancia prende giacenza peso teorico
					rowx(1) = rst.GetDouble("GIACENZAPESOTEORICO")
				Else
					rowx(1) = rst.GetDouble("GIACENZA1")
				End If
				GiacenzaUMG1 = GiacenzaUMG1 + rowx(1)
				GiacenzaUMG2 = GiacenzaUMG2 + rst.GetDouble("GIACENZA2")
				UMG1 = rst.GetString("UM1")
				UMG2 = rst.GetString("UM2")
				If(QtaRes>0) Then
					Select np
						Case 1
							If (rowx(1)>QtaRes) Then
								Result.Partita1 = rowx(0)
								Result.Qta1 = QtaRes
								QtaRes=0
							Else
								Result.Partita1 = rowx(0)
								Result.Qta1 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If

						Case 2
							If (rowx(1)>QtaRes) Then
								Result.Partita2 = rowx(0)
								Result.Qta2 = QtaRes
								QtaRes=0
							Else
								Result.Partita2 = rowx(0)
								Result.Qta2 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
						Case 3
							If (rowx(1)>QtaRes) Then
								Result.Partita3 = rowx(0)
								Result.Qta3 = QtaRes
								QtaRes=0
							Else
								Result.Partita3 = rowx(0)
								Result.Qta3 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
					End Select
				End If
			Loop
			rst.Close
			Log(sqlstr)
			Result.GiacenzaUM1=GiacenzaUMG1
			Result.GiacenzaUM2=GiacenzaUMG2
			Result.UM1=UMG1
			Result.UM2=UMG2
			Button11.Enabled=True
			Button12.Enabled=True
			Return Result
		Else
			Button11.Enabled=False
			Button12.Enabled=True
			MsgboxAsync("NESSUN LOTTO TROVATO PER QUESTO ARTICOLO '" & articolo & "'","ERRORE")
			Return Null
		End If
	Catch
		Return Null
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_DisponibilitaArticoloServer(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try
		Dim Result As PartiteQtaType
		' LETTURA IS_VISTA_GIACENZA_ARTICOLO LOCAL
		sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_DISPONIBILITA_CORSIA WHERE " _
		& "GIACENZA1>0 AND GIACENZA2>0 AND CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
		Log (sqlstr)		
		Dim GiacenzaUMG1 As Double = 0
		Dim GiacenzaUMG2 As Double = 0
		Dim UMG1 As String = ""
		Dim UMG2 As String = ""
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rst.RowCount>0) Then
			Dim QtaRes As Double = Qta
			Dim np As Int = 0
			Do While rst.NextRow
				np = np + 1
				Dim rowx(3) As Object
				rowx(0) = rst.GetString("NRIFPARTITA")
				If(rst.getstring("FLAG_BILANCIA")="S") Then  ' se articolo a bilancia prende giacenza peso teorico
					rowx(1) = rst.GetDouble("GIACENZAPESOTEORICO")
				Else
					rowx(1) = rst.GetDouble("GIACENZA1")
				End If
				GiacenzaUMG1 = GiacenzaUMG1 + rowx(1)
				GiacenzaUMG2 = GiacenzaUMG2 + rst.GetDouble("GIACENZA2")
				UMG1 = rst.GetString("UM1")
				UMG2 = rst.GetString("UM2")
				If(QtaRes>0) Then
					Select np
						Case 1
							If (rowx(1)>QtaRes) Then
								Result.Partita1 = rowx(0)
								Result.Qta1 = QtaRes
								QtaRes=0
							Else
								Result.Partita1 = rowx(0)
								Result.Qta1 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If

						Case 2
							If (rowx(1)>QtaRes) Then
								Result.Partita2 = rowx(0)
								Result.Qta2 = QtaRes
								QtaRes=0
							Else
								Result.Partita2 = rowx(0)
								Result.Qta2 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
						Case 3
							If (rowx(1)>QtaRes) Then
								Result.Partita3 = rowx(0)
								Result.Qta3 = QtaRes
								QtaRes=0
							Else
								Result.Partita3 = rowx(0)
								Result.Qta3 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
					End Select
				End If
			Loop
			rst.Close
			' Log(sqlstr)
			Result.GiacenzaUM1=GiacenzaUMG1
			Result.GiacenzaUM2=GiacenzaUMG2
			Result.UM1=UMG1
			Result.UM2=UMG2
			Button11.Enabled=True
			Button12.Enabled=True
			Return Result
		Else
			Button11.Enabled=False
			Button12.Enabled=True
			MsgboxAsync("NESSUN LOTTO TROVATO PER QUESTO ARTICOLO '" & articolo & "'","ERRORE")
			Return Null
		End If
	Catch
		Return Null
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_GiacenzeArticoloServer(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try 
		Dim Result As PartiteQtaType
		' LETTURA IS_VISTA_GIACENZA_ARTICOLO LOCAL
		sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_GIACENZA_ARTICOLO WHERE GIACENZA1>0 AND " _
				& "GIACENZA2>0 AND CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
		Log (sqlstr)
		Dim GiacenzaUMG1 As Double = 0
		Dim GiacenzaUMG2 As Double = 0
		Dim UMG1 As String = ""
		Dim UMG2 As String = ""
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rst.RowCount>0) Then				
			Dim QtaRes As Double = Qta
			Dim np As Int = 0
			Do While rst.NextRow				
				np = np + 1
				Dim rowx(3) As Object
				rowx(0) = rst.GetString("NRIFPARTITA")
				If(rst.getstring("FLAG_BILANCIA")="S") Then  ' se articolo a bilancia prende giacenza peso teorico
					rowx(1) = rst.GetDouble("GIACENZAPESOTEORICO")
				Else
					rowx(1) = rst.GetDouble("GIACENZA1")
				End If			
				GiacenzaUMG1 = GiacenzaUMG1 + rowx(1)
				GiacenzaUMG2 = GiacenzaUMG2 + rst.GetDouble("GIACENZA2")
				UMG1 = rst.GetString("UM1")
				UMG2 = rst.GetString("UM2")
				If(QtaRes>0) Then						
					Select np							
						Case 1				' Partita 1	
							If (rowx(1)>QtaRes) Then
								Result.Partita1 = rowx(0)
								Result.Qta1 = QtaRes
								QtaRes=0
							Else
								Result.Partita1 = rowx(0)
								Result.Qta1 = rowx(1)
								QtaRes = QtaRes - rowx(1)							
							End If

						Case 2				' Partita 2
							If (rowx(1)>QtaRes) Then
								Result.Partita2 = rowx(0)
								Result.Qta2 = QtaRes
								QtaRes=0
							Else
								Result.Partita2 = rowx(0)
								Result.Qta2 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
						Case 3				' Partita 3
							If (rowx(1)>QtaRes) Then
								Result.Partita3 = rowx(0)
								Result.Qta3 = QtaRes
								QtaRes=0
							Else
								Result.Partita3 = rowx(0)
								Result.Qta3 = rowx(1)
								QtaRes = QtaRes - rowx(1)
							End If
							
					End Select
				End If
			Loop
			rst.Close
			Log(sqlstr)
			Result.GiacenzaUM1=GiacenzaUMG1
			Result.GiacenzaUM2=GiacenzaUMG2
			Result.UM1=UMG1
			Result.UM2=UMG2
			Button11.Enabled=True
			Button12.Enabled=True
			Return Result				
		Else				
			Button11.Enabled=False
			Button12.Enabled=True
			MsgboxAsync("NESSUN LOTTO TROVATO PER QUESTO ARTICOLO '" & articolo & "'","ERRORE")
			Return Null
		End If
	Catch
		Return Null
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_GiacenzeCorsiaServer(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try 
		Dim Tbs(1) As String
		Dim Result As PartiteQtaType
		Tbs(0)="VISTA_GIACENZA_CORSIA"
		wait for (Leggi_Metodo_Tabelle(Tbs,articolo,coddeposito)) complete (Success As Boolean)
		If (Success) Then
			' LETTURA IS_VISTA_GIACENZA_ARTICOLO LOCAL
			sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_GIACENZA_ARTICOLO WHERE GIACENZA1>0 AND " _
					& "GIACENZA2>0 AND CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
			Log (sqlstr)
			Dim GiacenzaUMG1 As Double = 0
			Dim GiacenzaUMG2 As Double = 0
			Dim UMG1 As String = ""
			Dim UMG2 As String = ""
			Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If(rst.RowCount>0) Then				
				Dim QtaRes As Double = Qta
				Dim np As Int = 0
				Do While rst.NextRow				
					np = np + 1
					Dim rowx(3) As Object
					rowx(0) = rst.GetString("NRIFPARTITA")
					If(rst.getstring("FLAG_BILANCIA")="S") Then  ' se articolo a bilancia prende giacenza peso teorico
						rowx(1) = rst.GetDouble("GIACENZAPESOTEORICO")
					Else
						rowx(1) = rst.GetDouble("GIACENZA1")
					End If			
					GiacenzaUMG1 = GiacenzaUMG1 + rowx(1)
					GiacenzaUMG2 = GiacenzaUMG2 + rst.GetDouble("GIACENZA2")
					UMG1 = rst.GetString("UM1")
					UMG2 = rst.GetString("UM2")
					If(QtaRes>0) Then						
						Select np							
							Case 1				' Partita 1	
								If (rowx(1)>QtaRes) Then
									Result.Partita1 = rowx(0)
									Result.Qta1 = QtaRes
									QtaRes=0
								Else
									Result.Partita1 = rowx(0)
									Result.Qta1 = rowx(1)
									QtaRes = QtaRes - rowx(1)							
								End If

							Case 2				' Partita 2
								If (rowx(1)>QtaRes) Then
									Result.Partita2 = rowx(0)
									Result.Qta2 = QtaRes
									QtaRes=0
								Else
									Result.Partita2 = rowx(0)
									Result.Qta2 = rowx(1)
									QtaRes = QtaRes - rowx(1)
								End If
								
							Case 3				' Partita 3
								If (rowx(1)>QtaRes) Then
									Result.Partita3 = rowx(0)
									Result.Qta3 = QtaRes
									QtaRes=0
								Else
									Result.Partita3 = rowx(0)
									Result.Qta3 = rowx(1)
									QtaRes = QtaRes - rowx(1)
								End If
								
						End Select
					End If
				Loop
				rst.Close
				Log(sqlstr)
				Result.GiacenzaUM1=GiacenzaUMG1
				Result.GiacenzaUM2=GiacenzaUMG2
				Result.UM1=UMG1
				Result.UM2=UMG2
				Button11.Enabled=True
				Button12.Enabled=True
				Return Result				
			Else				
				Button11.Enabled=False
				Button12.Enabled=True
				MsgboxAsync("NESSUN LOTTO TROVATO PER QUESTO ARTICOLO '" & articolo & "'","ERRORE")
				Return Null
			End If
		Else
			MsgboxAsync("ERRORE LETTURA_METODO","ERRORE")
			Return Null
		End If
	Catch
		Return Null
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

private Sub ListaRigheTablet3(FirstTime As Boolean, IDtesta As Long, IDRiga As Int, Panel_Visible As Boolean) As ResumableSub
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'	
		If(FirstTime) Then
			'B4XTable3.SearchVisible=True
			'B4XTable3.SearchField.HintText = "Cerca"
			'B4XTable3.SearchField.HintColor = Colors.Green
			'B4XTable3.SearchField.Update
			Panel4.Visible=False
			XSelections3.Initialize(B4XTable3)
			XSelections3.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)
			'B4XTable3.SearchVisible=False
			'B4XTable2.pnlHeader.Visible=True
			B4XTable3.RowHeight = 35dip
			B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
			SelectedRows3 = B4XCollections.CreateSet
			Dim Col1x_Column As B4XTableColumn =  B4XTable3.AddColumn("Cod. Cli.", B4XTable3.COLUMN_TYPE_TEXT) 				' Cod. Cliente
			Col1x_Column.Width=120dip
			Dim Col2x_Column As B4XTableColumn =  B4XTable3.AddColumn("Rag. Soc.", B4XTable3.COLUMN_TYPE_TEXT) 				' Ragione Sociale
			Col2x_Column.Width=650dip  ' 800
			Dim Col3x_Column As B4XTableColumn =  B4XTable3.AddColumn("Qta", B4XTable3.COLUMN_TYPE_NUMBERS) 				' Qta
			Col3x_Column.Width=150dip  ' 150
			B4XTable3.BuildLayoutsCache(15)
			B4XTable3.Refresh
			Return(True)
		Else
			If(IDtesta<>0) Then
				B4XTable3.SearchField.Text=""
				'B4XTable3.SearchVisible=True
				'B4XTable3.SearchField.HintText = "Cerca"
				'B4XTable3.SearchField.HintColor = Colors.Green
				'B4XTable3.SearchField.Update
				Dim DataList3 As List
				DataList3.Initialize
				Dim sqlstr2 As String = "SELECT IDT_GIRO, RIFIDRIGA, CODCLIFOR, RAGSOC, SUM(QTA) As QTA, IFNULL(CODART,'') AS CODART, IFNULL(TIPODOC,'') AS TIPODOC " _
    			& "FROM VISTA_VARIAZIONI_CLIENTI_GIRO WHERE IDT_GIRO= '" & IDtesta & "' AND ((RifIDRiga =" & IDRiga & " AND CODART='" & vCodArticolo & "' AND TIPODOC='TV') " _
				& "OR  (IFNULL(CODART,'')='' AND IFNULL(TIPODOC,'')='' AND RIFIDRIGA=0)) GROUP BY IDT_GIRO,CODCLIFOR,RAGSOC ORDER BY QTA DESC, RAGSOC ASC"							
				Log(sqlstr2)		
				Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr2)
				If(rst.RowCount>0) Then
					Do While rst.NextRow
						Dim rowx(3) As Object
						rowx(0) = rst.GetString("CODCLIFOR")		' CODCLIFOR
						rowx(1) = rst.GetString("RAGSOC")		  	' RAGSOC
						rowx(2) = rst.GetDouble("QTA")				' QTA
						DataList3.Add(rowx)
						' Log(rowx(1) & " - " & rowx(2))
					Loop
					rst.Close
					B4XTable3.MaximumRowsPerPage = 15
					B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
					B4XTable3.SetData(DataList3)
					Panel4.Visible=Panel_Visible
					'-------------------------------------------------------------------------------------
					' serve per fare la somma delle righe
					'-------------------------------------------------------------------------------------
					Dim o() As Object = B4XTable3.BuildQuery(False) 'no page limit
					Dim total As Double = 0
					Dim rs As ResultSet = B4XTable3.sql1.ExecQuery2(o(0), o(1))
					Dim totalriga As Double = 0
					Do While rs.NextRow
						totalriga = Round(rs.GetDouble("c2")) 'c2 = Qta
						total = total + totalriga
					Loop
					rs.Close
					Label43.Text = ExtraUtility.NumberFormat_ITA(total,1,0)
					TotQtaUMVClientiAssegnati=total				
					'-------------------------------------------------------------------------------------					
					Col3x_Column.InternalSortMode="DESC"
					Col3x_Column.Sortable = True
					Log(sqlstr)
				Else
					MsgboxAsync("ERRORE IDTESTA " & IDtesta,"ERRORE IS_VISTA_CLIENTI_GIRO")
				End If				
			End If
			B4XTable3.Refresh
			Return(True)
		End If

	Catch
		Return(False)
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean, SelectionColor As Long)
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

Sub SetRowColor3(RowIndex As Int, Selected As Boolean, SelectionColor As Long)
	Dim clr As Long = 0
	Try
		If Selected Then
			clr = SelectionColor
		Else If RowIndex Mod 2 = 0 Then
			clr = B4XTable3.EvenRowColor
		Else
			clr = B4XTable3.OddRowColor
		End If
		For Each c As B4XTableColumn In B4XTable3.VisibleColumns
			Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
			pnl.Color = clr
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetRowColor2(RowIndex As Int, Selected As Boolean, SelectionColor As Long)
	Dim clr As Long = 0
	Try
		If Selected Then
			clr = SelectionColor
		Else If RowIndex Mod 2 = 0 Then
			clr = B4XTable2.EvenRowColor
		Else
			clr = B4XTable2.OddRowColor
		End If
		For Each c As B4XTableColumn In B4XTable2.VisibleColumns
			Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
			pnl.Color = clr
		Next
	Catch
		Log(LastException)
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
			Log(sqlstr)	
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL, _
			DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				MsgboxAsync("Nessun Documento da inviare!","SCRIVI METODO")
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
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare" & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore IS_RIGHEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_RIGHEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub RegistraSulServer(ID_key As Long) As ResumableSub
	' SCRITTURA TABELLE DAL SERVER
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" &straction&" is_testedocumenti_gir.php e is_righedocumenti.php)")
		straction = "insert_righedoc"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDoc(Me, dbAction, straction, "is_testedocumenti_gir.php","",ID_key)) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_testedoc"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_TesteDoc(Me, dbAction, straction, "is_testedocumenti_gir.php","",ID_key))  complete (Result3 As Boolean)
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

Sub RegistraCorsia(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String, Corsia As String, Stato As Int)
	Try
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		' B4XTable1.CreateDataView($"c0 >0"$)
		If (CodCliFor.Trim="") Then
			' codice fittizio del NESTI e BONSIGNORI
			CodCliFor="C 91012"
		End If
		vCorsiaOld=vCorsia
		B4XTable1.Refresh
		If(Operazione="NuovoDoc") And (vNumDocNew=0) Then
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			'DataDoc = DateTime.DateParse(vDataDocNew)
			Esercizio = ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
			sqlstr = "SELECT max(numerodoc) as maxnumdoc FROM IS_TESTEDOCUMENTI where tipodoc='" & TipoDoc & "'"
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If(rs.RowCount>0) Then
				Do While rs.NextRow
					NumDoc =  rs.GetInt("maxnumdoc")+1
				Loop
			End If
			rs.close
			vNumDocNew = NumDoc
			vEsercizioNew = Esercizio
			sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,flag_stp,rifidtesta,NumRifDoc,TipoDocOrig,NumDocOrig,DataDocOrig) VALUES "
			sqlstr = sqlstr & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDoc & "','" & Stp_Etich & "','" & RifIDTesta & "','" _
			& NumRifDoc & "','" & TipoDocOrig & "','" & NumDocOrig & "','" & DataDocOrig & "')"
			SQLDataAccess.ExecNonQuery(sqlstr)
		Else
			DataDoc = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'" & " AND Corsia='" & Corsia & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)				
				Dim Ordinato As String = rowdata.Get("Ordinato")
				Dim Qta1 As Double = rowdata.Get("Qta1")
				Dim Qta2 As Double = rowdata.Get("Qta2")
				Dim Qta3 As Double = rowdata.Get("Qta3")
				Dim Sconto As String = ""
				Dim Note As String = ""
				Dim NumEtichette As Int  = 0
				UM1 = rowdata.Get("UM1")
				UM2 = rowdata.Get("UM2")
				UM3 = rowdata.Get("UM3")
				Dim Ordinamento As Int  = rowdata.Get("Ord.")
				Dim UMBase As String = rowdata.Get("UMB")
				Dim QtaTotUMBase As Double = rowdata.Get("QtaTotUMB")
				Dim Status As String = rowdata.Get("Status")
				Dim DataConsegna As String = ""
				Dim DataScadenza As String = rowdata.Get("Scad.")
				RowID_Riga =  rowdata.Get("Pos.") ' rowdata.GetValueAt(0)
				Dim TipoRiga As String = rowdata.Get("T")
				If TipoRiga.Trim = "" Then
					TipoRiga ="N"
				End If
				Dim Partita1 As String = ""
				If(rowdata.Get("Partita1") <> Null) Then
					Partita1=rowdata.Get("Partita1")
				End If
				Dim Partita2 As String = ""
				If(rowdata.Get("Partita2") <> Null) Then
					Partita2=rowdata.Get("Partita2")
				End If
				Dim Partita3 As String = ""
				If(rowdata.Get("Partita3") <> Null) Then
					Partita3=rowdata.Get("Partita3")
				End If
				Dim NrRifPartita As String = ""
				sqlstr  = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,UM,DataConsegna," _
				 & "RifIdriga,Descrizione,Rifidtesta,TipoRiga,DataScadenza,NrRifPartita,UM2,Qta2,Peso,NumEtichette,Status,Sconto,Note,Ordinato,UM3," _
				 & "QtaTotUMAConv,QtaTotUM2,CoeffConvUMA,Partita1,Partita2,Partita3,QP1,QP2,QP3,Corsia,Ubicazione,CodCliFor,Ordinamento,UMBase,QtaTotUMBase) VALUES " _
				 & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente & "','" & rowdata.Get("Cod. Art.") & "','" & Qta1 & "','" _
				 & UM1 & "','" & DataConsegna & "','" & rowdata.Get("RifIdriga") & "','" & rowdata.Get("Descrizione Art.") & "','" & RifIDTesta & "','" & TipoRiga & "','" & DataScadenza & "','" _
				 & NrRifPartita & "','" & UM2 & "','" & Qta2 & "','" & Qta3 & "','" & NumEtichette & "','" & Status & "','" & Sconto & "','" & Note & "','" & Ordinato & "','" & UM3 _
				 & "','" & rowdata.Get("QtaTotUMAConv") & "','" & rowdata.Get("QtaTotUM2")  & "','" & rowdata.Get("CoeffConvUMA")  & "','" & Partita1 & "','" _
				 & Partita2 & "','" & Partita3 & "','" & rowdata.Get("QP1") & "','" & rowdata.Get("QP2") & "','" & rowdata.Get("QP3") & "','" _
				 & rowdata.Get("Corsia") & "','" &  rowdata.Get("Ubicazione") & "','" & CodCliFor & "','" & Ordinamento & "','" & UMBase &"','" &  QtaTotUMBase & "')"
				SQLDataAccess.ExecNonQuery(sqlstr)
				
				Dim routine As String ="exec_agg_implottopalm"
				' Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy","it","")
				'Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "yyyy-MM-dd","en","")
				Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "yyyyMMdd","en","")
				Dim	codart As String = rowdata.Get("Cod. Art.")
				'---------------------------
				' Aggiorna Partita1
				'---------------------------
				Dim Part1 As String = rowdata.Get("Partita1")
				Dim Qta1 As Double =  rowdata.Get("QP1")
				If(Part1.Trim<>"") And (Part1.Length>5) Then
					Aggiorna_Partita_Server(routine, vRifIdTesta, codart, Part1 , DataOggi, Qta1, Main.Utente, "")
				End If				
				'---------------------------
				' Aggiorna Partita2
				'---------------------------
				Dim Part2 As String = rowdata.Get("Partita2")
				Dim Qta2 As Double =  rowdata.Get("QP2")
				If(Part2.Trim<>"") And (Part2.Length>5) Then
					Aggiorna_Partita_Server(routine, vRifIdTesta, codart, Part2 , DataOggi, Qta2, Main.Utente, "")
				End If
															
			End If
		Next
		'------------------------------
		' Aggiorna Corsia sul server
		'------------------------------		
		Sleep(0)
		wait for (Aggiorna_Semaforo_Local(RifIDTesta,Corsia,Stato)) complete (Success1 As Boolean)
		If (Success1) Then
			wait for (Aggiorna_Corsia_Server(TipoDoc, NumDoc, RifIDTesta,Corsia,CodCliFor)) complete (Success2 As Boolean)
			If (Success2) Then
				wait for (Aggiorna_Semaforo_Giro_Server(RifIDTesta,Corsia,Main.Utente,Stato,"")) complete (Success3 As Boolean)
				If (Success3) Then
					wait for(Aggiorna_Semaforo_Server(Corsia,Main.Utente,-1)) complete (Success4 As Boolean)
					If (Success4) Then
						Sleep(10)
						ListaRigheTablet2(False,vRifIdTesta)						
						Panel2.Visible=True
						Button8.Enabled=False
						Button1.Enabled=False
						Button2.Enabled=False
						Button6.Enabled=False
						Button7.Enabled=False
					End If
				End If
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraDocumento(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String, Corsia As String)
	Try		
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		B4XTable1.CreateDataView($"c0 >0"$)
		B4XTable1.Refresh	
		If(Operazione="NuovoDoc") Then
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
			If(TipoDoc="GIR")Then				
				sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc IN ('GIR','TV') AND Numerodoc='" & NumDoc & "'"		
				SQLDataAccess.ExecNonQuery(sqlstr)
				sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc IN ('GIR','TV') AND Numerodoc='" & NumDoc & "' AND Corsia ='" & Corsia & "'"
				SQLDataAccess.ExecNonQuery(sqlstr)
			Else
				sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
				SQLDataAccess.ExecNonQuery(sqlstr)
				sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "' AND Corsia ='" & Corsia & "'"
				SQLDataAccess.ExecNonQuery(sqlstr)
			End If
		End If
		sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,flag_stp,rifidtesta,NumRifDoc,TipoDocOrig,NumDocOrig,DataDocOrig) VALUES "
		sqlstr = sqlstr & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDoc & "','" & Stp_Etich & "','" & RifIDTesta & "','" _
		& NumRifDoc & "','" & TipoDocOrig & "','" & NumDocOrig & "','" & DataDocOrig & "')"
		Log(sqlstr)
		SQLDataAccess.ExecNonQuery(sqlstr)
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)		
				RowID_Riga =  rowdata.Get("Pos.") ' rowdata.GetValueAt(0)
				Dim TipoRiga As String = rowdata.Get("T")
				If TipoRiga.Trim = "" Then
					TipoRiga ="N"
				End If
				Dim CodArt As String = rowdata.Get("Cod. Art.")
				Dim DescArt As String = rowdata.Get("Descrizione Art.")
				Dim Ordinato As String = rowdata.Get("Ordinato")			
				Dim UM1X As String = rowdata.Get("UM1")
				Dim Qta1 As Double = rowdata.Get("Qta1")
				Dim UM2X As String = rowdata.Get("UM2")
				Dim Qta2 As Double = rowdata.Get("Qta2")
				Dim UM3X As String= rowdata.Get("UM3")				
				Dim Qta3 As Double = rowdata.Get("Qta3") 
				Dim Corsia As String = rowdata.Get("Corsia")
				Dim Ubicazione As String = rowdata.Get("Ubicazione")
				Dim Ordinamento As Int = rowdata.Get("Ord.")
				Dim RifIdRiga As Long = rowdata.Get("RifIdriga")
				Dim UMBX As String = rowdata.Get("UMBase")
				Dim QtaTotUMB As Double = rowdata.Get("QtaTotUMBase")
				Dim Partita1 As String = rowdata.Get("Partita1")
				Dim QtaP1 As Double = rowdata.Get("QP1")
				Dim Partita2 As String = rowdata.Get("Partita2")
				Dim QtaP2 As Double = rowdata.Get("QP2")
				Dim Partita3 As String = rowdata.Get("Partita3")
				Dim QtaP3 As Double = rowdata.Get("QP3")
				Dim Status As String = ""
			 	sqlstr  = "INSERT INTO IS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,RifIdriga,Descrizione,rifidtesta,UM,TipoRiga," _			
				& "UM2,Qta2,UM3,Qta3,Status,Ordinato,QtaTotUMBase,UMBase,Ubicazione,QP1,Partita1,QP2,Partita2,QP3,Partita3,Magazzino,CodCliFor,Ordinamento) VALUES " _
				& "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente & "','" & CodArt & "','" _
				& RifIdRiga & "','" & DescArt & "','" & RifIDTesta & "','" & UM1X & "','" & TipoRiga & "','" & UM2X & "','" & Qta2 & "','" & UM3X & "','" _
				& Qta3 & "','" & Status & "','" & Ordinato & "','" & QtaTotUMB & "','" & UMBX & "','" & Ubicazione & "','" & QtaP1 & "','" & Partita1 & "','" _ 
				& QtaP2 & "','" & Partita2 & "','" & QtaP3 & "','" & Partita3 & "','" & Corsia	& "','" & CodCliFor & "','" & Ordinamento & "')"
				Log(sqlstr)
				SQLDataAccess.ExecNonQuery(sqlstr)
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub RegistraTestaNewDoc(TipoDoc As String, RifIDTesta As Long, NumRifDoc As String, Operazione As String, DataRifDoc As String, CodCliFor As String)
	Try		
		If(Operazione="NuovoDoc") And (vNumDocNew=0) Then
			Dim DataDoc As String= ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			Dim Esercizio As Int = ExtraUtility.DateToFormat(DateTime.Now,  "yyyy","it","")
			Dim NumDoc As Long = 0
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
			sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,rifidtesta,NumRifDoc,DataRifDoc) VALUES " _
			& "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDoc & "','" & RifIDTesta & "','" _
			& NumRifDoc & "','" & DataRifDoc & "')"
			' Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Execute_EXEC_PHP_POST_CREAGIRO_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Rifidtesta As Int, Utente As String) As ResumableSub
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
		job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
			& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & Rifidtesta)

		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			Dim jobResult As String = job.GetString
			Log("JobResult: " & jobResult)
			job.release
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
			End If
			Select job.JobName.ToLowerCase
				Case "exec_creagirodefinitivo"
					Log(Path_Php & "exec_creagirodefinitivo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
											
				Case Else
					Log("Errore nella procedura: Picking Execute_EXEC_Tab_PHP_POST_CREAGIRO_NESTI")
								
			End Select
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
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

Sub Execute_EXEC_PHP_POST_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, Par1 As String, Par2 As String, Par3 As String, Par4 As String, Par5N As Double, Par6 As String, Par7 As String) As ResumableSub
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
		#If DEBUG
			Log("Azione Inizio: " & job.JobName.ToLowerCase)
		#End If				
		job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
			& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & Par1 & "&codart=" & Par2  & "&partita=" & Par3 _
			& "&datamov=" & Par4 & "&qta=" & Par5N & "&utentepalmare=" & Par6 & "&codclifor=" & Par7)
		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			#If DEBUG
				Log("Azione Fine: " & job.JobName.ToLowerCase)
			#End If
			Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
			If job.Success = True Then
				Dim jobResult As String = job.GetString
				job.release
				Select job.JobName.ToLowerCase
					Case "exec_agg_implottopalm"
						Log(Path_Php & "exec_agg_implottopalm.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)												
						
					Case Else
						Log("Errore nella procedura: Picking Execute_EXEC_Tab_PHP_POST_NESTI")
									
				End Select
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

Sub Execute_LeggiTab_PHP_POST_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int, wherePar1 As String, wherePar2 As String) As ResumableSub
	' Sleep(0)
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
		#IF DEBUG
			Log("Action: " & mAction)
		#End If
		Select JobName
			Case "get_is_righedocumenti_giro"	
				phpFile="leggi_is_righedocumenti_giro.php"
				job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
				& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&idtesta=" & wherePar1 & "&corsia=" & wherePar2)						

			Case "get_is_semaforocorsie_giro"
				phpFile="is_semaforocorsie_giro.php"
				job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
				& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & wherePar1 & "&corsia=" & wherePar2)		
			
			Case Else		
				' MsgboxAsync("ERRORE jobname:" & JobName,"ERRORE")		
				job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
				& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&codart=" & wherePar1 & "&coddeposito=" & wherePar2)						
			
		End Select	
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
											
					Case "get_is_semaforocorsie"
						Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_Semaforo_Corsie(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

					Case "get_is_semaforocorsie_giro"
						Log(Path_Php & "is_semaforocorsie_giro.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_Semaforo_Corsie_Giro(jobResult, SQLDataAccess, vRifIdTesta, NumTable,PassoTable)) Complete (Success As Boolean)
						
					Case "get_vista_giacenza_articolo"
						Log(Path_Php & "vista_giacenza_articolo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&codart=" & wherePar1 _
						& "&coddeposito=" & wherePar2 & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_Vista_Giacenze_Articolo	(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)										
										
					Case "get_vista_disponibilita_articolo"
						Log(Path_Php & "vista_disponibilita_articolo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&codart=" & wherePar1 _
						& "&coddeposito=" & wherePar2 & "&action="&job.JobName.ToLowerCase)
						Wait For(DB_SQLSERVER.Leggi_Vista_Disponibilita_Articolo (jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

					Case "get_vista_disponibilita_corsia"
						Log(Path_Php & "vista_disponibilita_corsia.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&coddeposito=" & wherePar1 _
						& "&action="&job.JobName.ToLowerCase)
						DB_SQLite.Create_Table_VISTA_DISPONIBILITA_CORSIA(SQLDataAccess)				
						Wait For(DB_SQLSERVER.Leggi_Vista_Disponibilita_Corsia (jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
					Case "get_is_righedocumenti_giro"
						Log(Path_Php & "get_righedocumentigiro.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&idtesta=" & wherePar1 _
						& "&corsia=" & wherePar2 & "&action="&job.JobName.ToLowerCase)
						DB_SQLite.Create_Table_IS_RIGHEDOCUMENTI_GIRO(SQLDataAccess)
						Wait For(DB_SQLSERVER.Leggi_RighedocumentiGiro_Server(jobResult, SQLDataAccess, NumTable, PassoTable,vRifIdTesta,vCorsia,vEsercizioNew,vNumDocNew)) Complete (Success As Boolean)
												
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

Sub Leggi_Metodo_Tabelle(Tables() As String, whereParam1 As String, whereParam2 As String) As ResumableSub
	' LEGGI TABELLE DAL SERVER
		Try
			If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
				Label2.Visible = True
				DateTime.DateFormat = "yyyyMMdd HHmmss"
				Dim nt As Int = 0
				Dim Passo As Int = 100 / Tables.Length
				For Each Table In Tables
					Log($"INIZIO IMPORTAZIONE ${Table} ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
					nt = nt + 1
					Dim straction As String = "get_" & Table
					Dim dbAction As Map = CreateMap("action=": straction)
					WAIT FOR(Execute_LeggiTab_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, Table & ".php","", Main.Utente, nt, Passo, whereParam1, whereParam2)) complete (Success As Boolean)				
					If(Success) Then
						Log($"FINE IMPORTAZIONE ${Table} ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
					Else
						Log($"ERRORE NELLA IMPORTAZIONE ${Table} ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
					End If
				Next																
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

Sub Execute_Scrivi_DB_Semaforo(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Corsia As String, UtentePalmare As String, Occupata As Int) As ResumableSub
	' SCRIVE AGGIORNAMENTO SEMAFORO CORSIA SUL SERVER
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
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
		sqlstr = "SELECT CORSIA,UTENTE,OCCUPATA FROM IS_SEMAFOROCORSIE WHERE CORSIA='" & Corsia & "'"
		Log(sqlstr)
		m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER))
		json = DBPhp.Map2Json(m)
		json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
		json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
		Log(json)
		Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
		If (json = RootEmpty) Then
			Return False
		Else
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE inizio"$) 'Current time is 11:17:45
			job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" _
			& Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&corsia=" & Corsia & "&utente=" & UtentePalmare & "&stato=" & Occupata )
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log("response: " & job.GetString)
				Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE fine"$) 'Current time is 11:17:45
				Return True
			Else
				Log("Error: " & job.ErrorMessage)
				Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE fine"$) 'Current time is 11:17:45
				MsgboxAsync("Errore IS_SEMAFOROCORSIE " & job.errorMessage,"Errore")
				Return False
			End If
		End If
	Catch
		MsgboxAsync("Errore IS_SEMAFOROCORSIE " & LastException.Message,"Errore")
		Log("IS_SEMAFOROCORSIE " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_SemaforoGIRO(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, RifIdTesta As Long, Corsia As String, UtentePalmare As String, Occupata As Int, tipocorsia As String) As ResumableSub	
	' SCRIVE AGGIORNAMENTO SEMAFORO CORSIA SUL SERVER
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
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
		sqlstr = "SELECT IDTESTA,CORSIA,TIPOCORSIA,UTENTE,OCCUPATA FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA='" & RifIdTesta & "' AND CORSIA='" & Corsia & "'"
		Log(sqlstr)
		m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object ( _
			DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER))
		json = DBPhp.Map2Json(m)
		json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
		json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
		Log(json)
		Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
		If (json = RootEmpty) Then
			Return False
		Else
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE_GIRO inizio"$) 'Current time is 11:17:45
			' Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
			job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" _
			& Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&rifidtesta=" & RifIdTesta & "&corsia=" & Corsia & "&utente=" & UtentePalmare & "&occupata=" & Occupata & "&tipocorsia=" & tipocorsia  )
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				' Log("response: " & job.GetString)
				Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE_GIRO fine"$) 'Current time is 11:17:45
				Return True
			Else
				Log("Error: " & job.ErrorMessage)
				Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE_GIRO fine"$) 'Current time is 11:17:45
				MsgboxAsync("Errore IS_SEMAFOROCORSIE_GIRO " & job.errorMessage,"Errore")
				Return False
			End If
		End If
	Catch
		MsgboxAsync("Errore IS_SEMAFOROCORSIE_GIRO " & LastException.Message,"Errore")
		Log("IS_SEMAFOROCORSIE_GIRO " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_RigheDocGIRO(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, TipoDoc As String, NumDoc As Long, RifIdTesta As Long, Corsia As String, CodCliFor As String, Utente As String) As ResumableSub
	' SCRIVE LA CORSIA SU RIGHEDOCUMENTI_GIRO SUL SERVER SQL
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
			sqlstr = "SELECT RD.TipoDoc, RD.rifidtesta as RifIdTesta, ifnull(RD.RifIdRiga,0) as RifIdRiga, RD.Corsia, AA.UBICAZIONE AS Ubicazione, RD.TipoRiga, RD.Codart, RD.Descrizione," _
			& "RD.Ordinato, RD.UM As UM1, RD.Qta As Acq_UM1, RD.UM2, RD.Qta2 As Acq_UM2, RD.UM3, RD.Peso As Acq_UM3, RD.Ordinamento, RD.QtaTotUMBASE, RD.UMBase, RD.Partita1, " _
			& "RD.QP1 As QtaP1, RD.Partita2, RD.QP2 As QtaP2, RD.Partita3, RD.QP3 As QtaP3, RD.Status As StatoRiga,'" & Utente & "' As UtenteModifica, DateTime('now','localtime') " _
			& "As DataModifica, RD.CodCliFor FROM IS_RIGHEDOCUMENTI As RD JOIN IS_ANAGRAFICAARTICOLI As AA ON AA.CODICE=RD.CODART WHERE TipoDoc IN ('" & TipoDoc & "','TV') " _
			& " AND RD.Numerodoc = " & NumDoc & " And RD.RifIdTesta = " & RifIdTesta & " And RD.Corsia = '" & Corsia & "'"
			' Log(sqlstr)
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object ( _
			DBUtils.DB_TEXT,DBUtils.DB_INTEGER,	DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT, DBUtils.DB_INTEGER,DBUtils.DB_TEXT, DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Log(json)
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				MsgboxAsync("Nessun Documento da inviare!","AGGIORNA SERVER")
				Return False
			Else
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO inizio"$) 'Current time is 11:17:45
				Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore IS_RIGHEDOCUMENTI_GIRO " & job.errorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore IS_RIGHEDOCUMENTI_GIRO " & LastException.Message,"Errore")
		Log("IS_RIGHEDOCUMENTI_GIRO " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Update_IS_SEMAFOROCORSIE_LOCAL(idtesta As Long) As ResumableSub
	Try
		Sleep(0)
		If (idtesta<>0) Then
			Dim sqlstr As String 
			Dim nrecs As Long = SQLDataAccess.ExecQuerySingleResult2("SELECT COUNT(*) FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA = ?", Array As String(idtesta))
			If (nrecs=0) Then			
				sqlstr = "INSERT OR REPLACE INTO IS_SEMAFOROCORSIE_local SELECT " &  idtesta & " AS IDTESTA,LS.CORSIA, " _
				& "(CASE WHEN SUM(LS.IDTESTA)>0 THEN '*' ELSE '' END) AS TIPOCORSIA, " _
				& "(SELECT ifnull(group_concat(utente),'') from is_semaforocorsie where corsia=LS.corsia) AS UTENTE, " _				
				& "(CASE WHEN SUM(LS.IDTESTA)>0 THEN  ifnull(SC.OCCUPATA,1) ELSE ifnull(SC.OCCUPATA,0) END) AS OCCUPATA FROM Vista_CORSIE_GIRO As LS  left outer join IS_SEMAFOROCORSIE As sc on sc.corsia=ls.corsia " _
				& "WHERE (LS.CORSIA<>'' AND LS.IDTESTA=0) OR LS.IDTESTA='" & idtesta & "' GROUP BY LS.CORSIA ORDER BY LS.IDTESTA DESC,LS.CORSIA ASC"
				SQLDataAccess.ExecNonQuery(sqlstr)	
			End If
		Else
			Log("errore idtesta " & idtesta)
		End If
		Return True
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
	Case "PIK"
		XSelections.CellClicked(ColumnId,RowID,xui.Color_cyan)
		Dim Corsia As String = ""
		Dim Ubicazione As String = ""
'		Dim acquisito As double = 0
'		Dim ordinato As String = ""
'		Dim OrdinatoNum As double = 0
		Sleep(0)
		If(Panel3.Visible=False) Then
			Dim RowData As Map
			RowData = B4XTable1.GetRow(RowID)
			RowID_Riga = RowData.GetValueAt(0)
			TotQtaUM1 = RowData.GetValueAt(6)
			TotQtaUM2 = RowData.GetValueAt(8)
			TotQtaUM3 = RowData.GetValueAt(10)
			If(RowData.Get("Ubicazione")<>"") Then			
				Dim SelectBarcode As String = RowData.Get("Corsia") & RowData.Get("Ubicazione")
				If (SelectBarcode.SubString2(0,2)="CS") And (Panel3.Visible=False) Then
					ApriCalcolatrice(SelectBarcode,RowID_Riga)
				End If
			Else
				ApriCalcolatrice(RowData.Get("Cod. Art."),RowID_Riga)
			End If			
		End If	
						
	End Select
	XSelections.Refresh(ColumnColor)
'	B4XTable1.Refresh
	
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

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Descrizione Art.",Gravity.LEFT)
	'If (B4XTable1.mCurrentCount>=1) Then
	'	For i = 0 To B4XTable1.VisibleRowIds.Size-1 'B4XTable1.VisibleRowIds.size-1
	'		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
	'		SetRowColor(i, SelectedRows.Contains(RowId),Main.SelectionColor_Cyan)
	'	Next
	'End If
	For i=1 To Col1_Column.CellsLayouts.Size-1
		' colonna c0 (Posizione)
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 16 '16
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.Black
		lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		' colonna c1 (Tipo Riga)
		Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 20
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.Black
		lbl2.Padding = Array As Int (10dip, 0dip, 0dip, 0dip)
		' colonna c2 (Cod. Art.)
		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 20
		lbl3.Typeface = Typeface.DEFAULT_BOLD
		lbl3.TextColor = Colors.Black
		lbl3.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
		' colonna c3 (Descrizione Art.)		
		Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 24
		lbl4.Typeface = Typeface.DEFAULT_BOLD
		lbl4.TextColor = Colors.Black
		lbl4.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
		' colonna c4 (Ordinato)
		Dim pnl5 As B4XView = Col5_Column.CellsLayouts.Get(i)
		Dim lbl5 As Label = pnl5.GetView(0)
		lbl5.TextSize = 20
		lbl5.Typeface = Typeface.DEFAULT
		lbl5.TextColor = Colors.Black
		lbl5.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
		' colonna c4 (Ord)
		Dim pnl6 As B4XView = Col15_Column.CellsLayouts.Get(i)
		Dim lbl6 As Label = pnl6.GetView(0)
		lbl6.TextSize = 14
		lbl6.Typeface = Typeface.DEFAULT
		lbl6.TextColor = Colors.Black
		lbl6.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
	Next
	XSelections.Refresh(ColumnColor)
End Sub

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
		Dim Qta1 As double = 0
		Dim QtaStr As String =  Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,EditText2.text)
		If(QtaStr="") Then
			Qta1 = 0
		Else
			Qta1 = QtaStr
		End If
		Dim Qta2 As double = CDbl(EditText3.Text)
		QtaStr =  Qta1 + Qta2
		If(Button4.Text<>"") Then
			Dim FattoreC As double = Leggi_FattoreC(SQLDataAccess,vCodArticolo,UM1)
			Dim QtaTotUMA As double = Round2(FattoreC*QtaStr,4)
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
					Button8.Enabled=False
					Button1.Enabled=False
					Button2.Enabled=False
					Button6.Enabled=False
					Button7.Enabled=False
					Leggi_ParametriDoc("F")	
				Else
					Label6.Text = ""
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
				UM3 = RowData.GetValueAt(9)
				Button3.Text = UM1
				Button4.Text = UM2
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
	Try
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
				Dim Qta2 As Double = CDbl(EditText3.Text)
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
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_UMDaPrelevare() As String
	Try
		Dim UMDAP As String	= ""
		Dim pos As Int  = Label11.Text.IndexOf(" ")
		If (pos>=0) Then
			UMDAP = Label11.Text.SubString(pos+1)
		Else
			pos = Label14.Text.IndexOf(" ")
			If (pos>=0) Then
				UMDAP = Label14.Text.SubString(pos+1)
			End If
		End If		
		Return UMDAP
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Leggi_UMBaseArticolo(Codart As String) As String
	Try	
		Dim List_UM As List
		Dim UMBASE As List
		UMBASE.Initialize
		List_UM.Initialize
		UMBASE = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT UMB FROM IS_VISTA_UMPREF WHERE CODICE='" & Codart & "'",Null,1)
		For Each arr_umbase() As String In UMBASE
			List_UM.Add(arr_umbase(0))
		Next
		If List_UM.Size>0 Then
			Dim UM As String = arr_umbase(0)
			Return UM
		Else
			Return ""
		End If
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Leggi_QtaTotAggiunteClienti(RifIdtesta As Long, RifIdRiga As Int, Codart As String) As ResumableSub	
	Try
		TotQtaUMVClientiAssegnati = SQLDataAccess.ExecQuerySingleResult2("SELECT IFNULL(SUM(Qta),0) AS QTA FROM IS_RIGHEDOCUMENTI WHERE RifIdTesta = ?" _
		& " And RifIdRiga =? And TipoDoc='TV' And Codart =?", Array As String(RifIdtesta,RifIdRiga,Codart))
		TotQtaUMVClienti=TotQtaUMVClientiAssegnati
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub

Sub Leggi_UMBase(Codart As String, UMA As String) As String
	Try
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
	Catch
		Log(LastException)
		Return ""
	End Try
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

Sub Leggi_AnnotazioniOrdini(SQLData As SQL,Codart As String, RifIdTesta As Long) As String
	Try
		Dim Note As String
		Dim rs As ResultSet = SQLData.ExecQuery2("SELECT QTAGEST,UMGEST,ANNOTAZIONI FROM IS_VISTA_NOTE_ORDINI WHERE CODART = ? AND IDT_GIRO = ?", Array As String (Codart,RifIdTesta))
		Dim row(1) As Object
		row(0) = 0
		Do While rs.NextRow
			Note  = Note & rs.GetInt("QTAGEST") &  " " & rs.GetString("UMGEST") & " " & rs.GetString("ANNOTAZIONI").ToUpperCase & ", "
		Loop
		Return Note
	Catch
		Log("ERRORE Leggi_AnnotazioniOrdini!: " & LastException)
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

Sub Converti_Qta_UMBase(SQLData As SQL, Codart As String, UM As String, Qta As String) As Double
	Try	
		Dim QtaVal As Double
		Dim FattoreFC As Double
		If(Codart<>"") Then
			Dim rs As ResultSet
			rs = SQLData.ExecQuery2("SELECT FCLB FROM IS_VISTA_UMPREF WHERE CODICE = ? AND UML = ?", Array As String (Codart,UM))
			Dim row(1) As Object
			row(0) = 0
			Do While rs.NextRow
				row(0) = rs.GetDouble("FCLB")
			Loop		
			FattoreFC = row(0)
			If(FattoreFC=0) Then
				rs = SQLData.ExecQuery2("SELECT FCVB FROM IS_VISTA_UMPREF WHERE CODICE = ? AND UMV = ?", Array As String (Codart,UM))
				Dim row(1) As Object
				row(0) = 0
				Do While rs.NextRow
					row(0) = rs.GetDouble("FCVB")
				Loop			
				FattoreFC = row(0)
			End If
			If FattoreFC<>0 Then			
				Dim fx As Double = 0
				If(FattoreFC<>0) Then
					Dim QtaNum As Double = CDbl(Qta)
					fx = (QtaNum*FattoreFC)
					QtaVal = Round2(fx,2)
				End If			
				Return QtaVal
			Else
				Return Qta
			End If
		Else
			Return 0
		End If
	Catch 
		Log("ERRORE!: " & LastException)
		Return 0
	End Try
End Sub

Sub Converti_Qta_UMV(SQLData As SQL, Codart As String, UM As String, Qta As String) As Double
	Try	
		Dim QtaStr As String
		Dim FattoreFC As Double 
		If(Codart<>"") Then
			Dim rs As ResultSet
			rs = SQLData.ExecQuery2("SELECT FCVB FROM IS_VISTA_UMPREF WHERE CODICE = ? AND UMB = ?", Array As String (Codart,UM))
			Dim row(1) As Object
			row(0) = 0
			Do While rs.NextRow
				row(0) = rs.GetDouble("FCVB")
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
	Try			
		' Estrae la quantità dalla stringa 10 CT
		Dim Pos As Int = stringa.IndexOf(separator)
		If Pos>=0 Then
			Return stringa.SubString(Pos+1)
		Else
			Return ""
		End If
	Catch
		Log(LastException)
		Return ""
	End Try
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


Private Sub InsertRigaDoc(xNumPos As Int,xCodArt As String, xLotto As String, xCodDep As String, xCodDepColl As String, xCodUbic As String, xCodUbicColl As String, xUM1 As String, xQta1 As String, xUM2 As String, xQta2 As String, xUM3 As String, xQta3 As Double, xSvuotaCella As Int, xTipoReadGiac As String)
	
	Dim xDescArt As String = Label3.Text
	Dim xMaxPriority As Int = Leggi_MaxPriorita_Data
	Dim xCorsiaUbicaz As String = xCodDep & xCodUbic
	Dim xCorsiaUbicazColl As String = xCodDepColl & xCodUbicColl
	xCorsiaUbicaz = xCorsiaUbicaz.Trim
	xCorsiaUbicazColl = xCorsiaUbicazColl.Trim
	B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(xNumPos,xCodArt,xDescArt,xUM1,xQta1,xUM2,"",xUM3,xQta3,xLotto,"","P",xMaxPriority,xQta1,0,0,xCorsiaUbicaz,xCorsiaUbicazColl,xSvuotaCella,xTipoReadGiac))
				
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
	'---------------------------------------------
	' Aumenta valore (Calcolatrice) tasto +
	'---------------------------------------------
	Dim Barcode As String
	Barcode = vBarcodeLetto
	Barcode = Barcode.Replace(Chr(13),"")
	Barcode = Barcode.Replace(Chr(10),"")
	Barcode = " -> " & Barcode
	Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
	Dim valore1 As Int = 0
	Dim valore2 As Int = 0
	Dim valore3 As Int = 0
	Dim txt_temp As String = ""
	If (EditText7.Text = "") Then
		valore1 = 0
	Else
		valore1 = EditText7.Text
		txt_temp =  DataOra & " - " & "Man. + "  & valore1 & " " & UM1 & Barcode & CRLF & txt_temp
	End If
	If (EditText8.Text = "") Then
		valore2 = 0
	Else
		valore2 = EditText8.Text		
		txt_temp =  DataOra & " - " & "Man. + "  & valore2 & " " & UM2 & Barcode & CRLF & txt_temp
	End If
	If (EditText9.Text = "") Then
		valore3 = 0
	Else
		valore3 = EditText9.Text
		txt_temp =  DataOra & " - " & "Man. + "  & valore3 & " " & UM3 & Barcode & CRLF & txt_temp
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
		TotQtaUM3 = Label42.text
	Else
		TotQtaUM3 = 0
	End If
	TotQtaUM1 = TotQtaUM1 + valore1
	TotQtaUM2 = TotQtaUM2 + valore2
	TotQtaUM3 = TotQtaUM3 + valore3		
	TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,TotQtaUM1)+Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM2,TotQtaUM2)+TotQtaUM3
	Dim vDiff1 As Double = QtaStoryDisp-TotQtaUMX+QtaStoryUMB
	If(vDiff1<0) Then
		ToastMessageShow("QUANTITA' INSERITA MAGGIORE DI QUELLA DISPONIBILE!",False)
		ExtraUtility.Play_Sound("Error.wav")
		TotQtaUM1 = TotQtaUM1 - valore1
		TotQtaUM2 = TotQtaUM2 - valore2
		TotQtaUM3 = TotQtaUM3 - valore3
		TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,TotQtaUM1)+Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM2,TotQtaUM2)+TotQtaUM3
	Else
		RicalcoloAutomaticoQtaDisponibile(vCodArticolo,UMB,vDiff1)
		Dim vDiff2 As Double = QtaOrigPickBase-TotQtaUMX
		RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,UMB,vDiff2)	
		txt = txt_temp & txt
		UpdateTape
		Label39.Text = TotQtaUM1
		Label41.Text = TotQtaUM2
		Label42.Text = TotQtaUM3
		Label36.Text = " Tot. " & TotQtaUMX & " " & UMB
	End If
	EditText7.Text = ""
	EditText8.Text = ""
	EditText9.Text = ""
End Sub

Private Sub Button9_Click
	' Diminuisci valore (Calcolatrice)
	Dim Barcode As String
	Barcode = vBarcodeLetto
	Barcode = Barcode.Replace(Chr(13),"")
	Barcode = Barcode.Replace(Chr(10),"")
	Barcode = " -> " & Barcode
	Dim DataOra As String = DateTime.Date(DateTime.Now) & " " &  DateTime.Time(DateTime.Now)
	Dim valore1 As Int = 0
	Dim valore2 As Int = 0
	Dim valore3 As Int = 0
	Dim txt_temp As String = ""
	If (EditText7.Text = "") Then
		valore1 = 0
	Else
		valore1 = EditText7.Text
		txt_temp =  DataOra & " - " & "Man. - "  & valore1 & " " & UM1 & Barcode & CRLF 
	End If
	If (EditText8.Text = "") Then
		valore2 = 0
	Else
		valore2 = EditText8.Text
		txt_temp =  DataOra & " - " & "Man. - "  & valore2 & " " & UM2 & Barcode & CRLF 
	End If
	If (EditText9.Text = "") Then
		valore3 = 0
	Else
		valore3 = EditText9.Text
		txt_temp =  DataOra & " - " & "Man. - "  & valore3 & " " & UM3 & Barcode & CRLF 
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
		TotQtaUM3 = Label42.text
	Else
		TotQtaUM3 = 0
	End If
	TotQtaUM1 = TotQtaUM1 - valore1
	TotQtaUM2 = TotQtaUM2 - valore2
	TotQtaUM3 = TotQtaUM3 - valore3
	TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,TotQtaUM1)+Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM2,TotQtaUM2)+TotQtaUM3
	EditText7.Text = ""
	EditText8.Text = ""
	EditText9.Text = ""
	If(TotQtaUM1<0) Or (TotQtaUM2<0) Or (TotQtaUM3<0) Or (TotQtaUMX<0) Then
		TotQtaUM1 = TotQtaUM1 + valore1
		TotQtaUM2 = TotQtaUM2 + valore2
		TotQtaUM3 = TotQtaUM3 + valore3
		TotQtaUMX = Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM1,TotQtaUM1)+Converti_Qta_UMBase(SQLDataAccess,vCodArticolo,UM2,TotQtaUM2)+TotQtaUM3
		ToastMessageShow("INSERIMENTO ERRATO!",False)
		ExtraUtility.Play_Sound("Error.wav")
	Else
		txt = txt_temp & txt
		UpdateTape
		Label39.Text = TotQtaUM1
		Label41.Text = TotQtaUM2
		Label42.Text = TotQtaUM3
		Label36.Text = " Tot. " & TotQtaUMX & " " & UMB
		Dim vDiff1 As Double = QtaOrigPickBase-TotQtaUMX
		RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,UMB,vDiff1)
		Dim vDiff2 As Double =  QtaStoryDisp-TotQtaUMX+QtaStoryUMB
		RicalcoloAutomaticoQtaDisponibile(vCodArticolo,UMB,vDiff2)
	End If
End Sub

Private Sub Button3_Click
'	TimerLongClick.Enabled = True
	Label3.Text = ""
	vCodArtCella=""
	vCodArtLotto=""
End Sub

Private Sub Button12_Click
	' NO su Calcolatrice
	Try
		Button8.Enabled=True
		txt = ""
		UpdateTape
		Button3.TextSize=16
		Button3.Typeface=Typeface.DEFAULT_BOLD
		Panel3.Visible=False
		Button1.Enabled=True
		Phone.HideKeyboard	
		vCodArtLotto=""
		vCodArtCella=""
		' vLottoCompleto
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub OK_Calcolatrice
	Try
		Dim F_OK As Int = 1
		Dim QtaAggiunteCli As Double = LeggiQta(Label45.Text," ")
		Dim QtaUM1 As Double = Label39.Text
		Dim QtaUM2 As Double = Label41.Text
		Dim QtaUM3 As Double = Label42.Text
		If(QtaUM1<0) Or (QtaUM2<0) Or (QtaUM3<0) Then
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("NON PUOI CONFERMARE QUANTITA' NEGATIVE",True)
			F_OK=0
		Else
			If(TotQtaUMVClientiAssegnati<QtaAggiunteCli) Then
				ExtraUtility.Play_Sound("error.wav")
				ToastMessageShow("DEVI ASSEGNARE CORRETTAMENTE LE QUANTITA' SUI CLIENTI",True)
				F_OK=0
			End If
		End If
		If(F_OK<>0) Then
			Button8.Enabled=True
			txt = ""
			Button3.TextSize=16
			Button3.Typeface=Typeface.DEFAULT_BOLD
			UpdateTape
			Dim TotDaPrel As Double = 0
			Dim TotAgg As Double = 0
			TotDaPrel = LeggiQta(Label56.Text,Chr(32))
			TotAgg = LeggiQta(Label57.Text,Chr(32))
			If(TotDaPrel=0) And (TotAgg=0) Then
				vStatoriga = "G"
			Else
				If(TotDaPrel>0) Then
					vStatoriga="R"
				Else
					If(TotAgg>0) Then
						vStatoriga="Y"
					End If
				End If
			End If
			Registra_Panel3("",Label34.Text,vStatoriga)
			Dim numpos As Int = Label34.Text
			wait for (Registra_Panel3("",numpos,vStatoriga)) complete (Result As Boolean)
			If(Result) Then
				Panel3.Visible=False
				Button1.Enabled=True
				Phone.HideKeyboard
				Label3.Text = ""
				vCodArtCella=""
				vCodArtLotto=""
				XSelections.Clear
				B4XTable1_DataUpdated						
				If(B4XTable1.Size>0) Then
					Dim column As B4XTableColumn = B4XTable1.GetColumn("Ord.")
					If(Button24.Tag="SU") Then
						B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c14=c14+? WHERE c0=? AND abs(c14)<100000"$, Array As Object(100000,numpos))
						column.InternalSortMode= "ASC"
					Else
						B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c14=c14+? WHERE c0=? AND abs(c14)<100000"$, Array As Object(-100000,numpos))
						column.InternalSortMode= "DESC"
					End If							
				End If				
			End If
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button11_Click
	' OK su Calcolatrice
	OK_Calcolatrice
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
		Button14.textColor=xColorUM
		Button15.textColor=xui.Color_Gray
		Button14.Tag="Pressed"
		Button15.Tag=""
		Button16.Tag=""
		EditText7.RequestFocus
	End If
End Sub

Private Sub Button15_Click
	If(Button15.Text<>"") Then
		Button14.textColor=xui.Color_Gray		
		Button15.textColor=xColorUM
		Button16.textColor=xui.Color_Gray
		Button14.Tag=""
		Button15.Tag="Pressed"
		Button16.Tag=""
		EditText8.RequestFocus
	End If
End Sub

Private Sub Button16_Click
	If(Button16.Text<>"") Then
		Button14.textColor=xui.Color_Gray
		Button15.textColor=xui.Color_Gray
		Button16.textColor=xColorUM
		Button14.Tag=""
		Button15.Tag=""
		Button16.Tag="Pressed"
		EditText9.RequestFocus
	End If
End Sub

Private Sub EditText9_FocusChanged (HasFocus As Boolean)
	If HasFocus=True Then
		EditText9.SelectAll
		Phone.SetCustomFilter(EditText9, EditText9.INPUT_TYPE_NUMBERS, "0123456789,")
	End If
End Sub

Private Sub B4XTable2_DataUpdated
	Try	
		SetColumnAlignment(B4XTable2,"Utente",Gravity.LEFT)
		For i=0 To B4XTable2.VisibleRowIds.Size-1
			Dim RowId As Long = B4XTable2.VisibleRowIds.Get(i)
			Dim pnlS1 As B4XView = SemaphoreGiroColumn.CellsLayouts.Get(i+1)
			Dim ivS1 As B4XView = pnlS1.GetView(1)
			Dim pnlS2 As B4XView = SemaphoreCorsiaColumn.CellsLayouts.Get(i+1)
			Dim ivS2 As B4XView = pnlS2.GetView(1)
			Dim FileName As String = ""
			SetRowColor2(i, SelectedRows2.Contains(RowId), Main.SelectionColor_Green )
			If(RowId>0) Then
				Dim row As Map = B4XTable2.GetRow(RowId)
				FileName = "Semaphore" & row.Get("Stato Giro") & ".png"  ' "Semaphore1" & row.Get("Occupata") & ".png"
				ivS1.SetBitmap(xui.LoadBitmapResize(File.DirDefaultExternal & "/icons", FileName,ivS1.Width,ivS1.Height,False))
				FileName = "Semaphore" & row.Get("Stato Corsia") & "_corsia.png"  ' "Semaphore1" & row.Get("Occupata") & ".png"
				ivS2.SetBitmap(xui.LoadBitmapResize(File.DirDefaultExternal & "/icons", FileName,ivS2.Width,ivS2.Height,False))
			Else
				' empty row
				ivS1.SetBitmap(Null)
				ivS2.SetBitmap(Null)
			End If				
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button18_Click
	' Bottone Annulla Corsia
	Try
		vCorsia=vCorsiaOld
		Button8.Text=vCorsia		
		Button5.Tag=""
		Panel2.Visible=False
		If(B4XTable1.IsInitialized) Then
			B4XTable2.ClearDataView
		End If
		wait for (Leggi_RigheDocumentiGIRO_Server(vRifIdTesta,"1000")) complete (Success As Boolean)
		If (Success) Then
			B4XTable1.ClearDataView
			ListaRigheTabletGIR(vRifIdTesta,"1000")
			Button8.Enabled=True
			Button1.Enabled=True
			Button2.Enabled=True
			Button6.Enabled=True
			Button7.Enabled=True			
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button17_Click
	OK_ListaCorsie
End Sub

private Sub OK_ListaCorsie
	'---------------------------
	' OK su lista corsie
	'---------------------------
	Try
		Sleep(0)
		Button22.Tag=""
		Button22.Visible=False
		XSelections.Clear
		Aggiorna_ColoriListaTablet
		' Log($"Numero of rows selected: ${SelectedRows2.Size}"$)
		If((SelectedRows2.Size>0)) And (vCorsia<>"CS000")  Then
			Button5.Tag=""
		'	If(vCorsia<>"") Then
				B4XTable2.ClearDataView				
				wait for (Leggi_RigheDocumentiGIRO_Server(vRifIdTesta,vCorsia)) complete (Success As Boolean)
				If (Success) Then					
					ProgressDialogShow2("RILETTURA DISPONIBILITA' CORSIA DAL SERVER IN CORSO...",False)
					wait for (Leggi_DisponibilitaCorsiaServer(vCorsia)) complete (Success2 As Boolean)
					If (Success2) Then
						Panel2.Visible=False
						Button8.Enabled=True
						Button1.Enabled=True
						Button2.Enabled=True
						Button6.Enabled=True
						Button7.Enabled=True
						XSelections.SelectedLines.Clear
						XSelections.Refresh(ColumnColor)
						B4XTable1.Refresh		
						If(Label59.Text="GIRO CHIUSO") Then
							ListaRigheTabletGIR(vRifIdTesta,vCorsia)
						Else
							'-----------------------------------
							' Aggiorna il semaforo
							'-----------------------------------
							sqlstr = "INSERT OR REPLACE INTO IS_SEMAFOROCORSIE (Corsia, Utente, Occupata) values (?,?,?)"
							SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(vCorsia,Main.Utente,3))
							wait for (Aggiorna_Semaforo_Server(vCorsia, Main.Utente, 3)) complete (Success3 As Boolean) ' 3 = occupata rosso
							If(Success3) Then
								ListaRigheTabletGIR(vRifIdTesta,vCorsia)
							End If
						End If
					End If
					ProgressDialogHide					
				End If				
			'End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Selezionare la corsia","ERRORE")
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub B4XTable2_CellClicked (ColumnId As String, RowId As Long)
	Try		
		If(MultiSelection2=False) Then
			SelectedRows2.Clear
			B4XTable2.Refresh
		End If
		Dim Selected2 As Boolean
		If SelectedRows2.Contains(RowId) Then
			SelectedRows2.Remove(RowId)
			Selected2 = False
		Else
			SelectedRows2.Add(RowId)
			Selected2 = True
		End If
		Dim Index As Int = B4XTable2.VisibleRowIds.IndexOf(RowId)
		SetRowColor2(Index, Selected2, Main.SelectionColor_Green)
		'Log($"Number of rows selected: ${SelectedRows2.Size}"$)
		'Log($"Row selected: ${RowId}"$)
		Dim RowData As Map
		RowData = B4XTable2.GetRow(RowId)
		'Log($"Value of Corsia selected: ${RowData.GetValueAt(0)}"$)
		'Log($"Value of Stato selected: ${RowData.GetValueAt(2)}"$)
		vCorsia=RowData.GetValueAt(1)
		vStatoCorsia=RowData.GetValueAt(4)	
		Dim UtenteCorsia As String = RowData.GetValueAt(3)
		Button8.Text=vCorsia
		If ((vStatoCorsia=3) And (UtenteCorsia<>"")) And (UtenteCorsia<>"CHIUSO") Then
			Button18.Enabled=True
			Button17.Enabled=False
		Else
			Button18.Enabled=True
			Button17.Enabled=True
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub AddEmptyColumnToData(Data As List) As List
	Dim res As List
	res.Initialize
	For Each row() As Object In Data
		Dim NewRow(row.Length+1) As Object
		NewRow(0) = ""
		For i=0 To row.Length-1
			NewRow(i+1) = row(i)
		Next
		res.Add(NewRow)
	Next
	Return res
End Sub

Sub LeggiListaClientiVariazioni(IdtestaDoc As Long, IdrigaDoc As Int)
	sqlstr = "SELECT CODCLIFOR,RAGSOC FROM [IS_VISTA_CLIENTI_GIRO] WHERE IDT_GIRO='" & IdtestaDoc &"'"
	Log(sqlstr)
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Dim DataList3 As List
	DataList3.Initialize
	Do While rs.NextRow
		Dim rowx(2) As Object
		rowx(0) = rs.GetString("CODCLIFOR")
		rowx(1) = rs.Getstring("RAGSOC")				
		DataList3.Add(rowx)
	Loop
	rs.Close
	B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
	B4XTable3.SetData(DataList)
	If(DataList3.Size>0) Then
		B4XTable3.UpdateTableCounters
		Dim column As B4XTableColumn = B4XTable3.GetColumn("Rag. Soc.")
		column.InternalSortMode= "ASC"
		TotalSize = B4XTable3.Size
	Else
		TotalSize = 0
	End If
End Sub

Private Sub Button21_Click
	' ------------------------------------------
	' ---- VISUALIZZA I CLIENTI DEL GIRO -------
	' ------------------------------------------
	If(LeggiQta(Label57.Text," ")>0) Then		
		Phone.HideKeyboard
		TotQtaUMBClienti=LeggiQta(Label57.Text,Chr(32))
		TotQtaUMVClienti=LeggiQta(Label45.Text,Chr(32))
		Label50.Text=""
		Button19.Enabled=True
		Wait For(ListaRigheTablet3(False,vRifIdTesta,Label34.text,True)) complete  (Result As Boolean)
		If(Result) Then
			Label49.Text="Da Assegnare " & (TotQtaUMVClienti-TotQtaUMVClientiAssegnati) & " " &  UMV
			Panel4.Visible=True
			Button12.Enabled=False
			Button11.Enabled=False
		End If
	Else
		ExtraUtility.Play_Sound("Error.wav")
		ToastMessageShow("PRELEVARE LA MERCE PRIMA DELL'ASSEGNAZIONE!",False)
	End If
End Sub

Private Sub Button19_Click
	' Registra Variazioni Clienti
	Dim total As Int = Label43.text
	If(total<TotQtaUMVClienti) Then
		ExtraUtility.Play_Sound("error.wav")
		ToastMessageShow("ASSEGNARE CORRETTAMENTE LE QUANTITA' SUI CLIENTI",True)
	Else
		Registra_Panel4(vRifIdTesta,Label34.text,vCodArticolo,"TV",vEsercizioNew,vCorsia,vNumDocNew,vUbicazione)
		Panel4.Visible=False
		Button12.Enabled=True
		Button11.Enabled=True
	End If
End Sub

Private Sub Button20_Click
	' Annulla Variazioni Clienti
	Panel4.Visible=False
	Button12.Enabled=True
	Button11.Enabled=True
End Sub

Private Sub B4XTable3_CellClicked (ColumnId As String, RowId As Long)
	If(MultiSelection3=False) Then
		SelectedRows3.Clear
		B4XTable3.Refresh
	End If
	Dim Selected3 As Boolean
	If SelectedRows3.Contains(RowId) Then
		SelectedRows3.Remove(RowId)
		Selected3 = False
	Else
		SelectedRows3.Add(RowId)
		Selected3 = True
	End If
	Dim Index As Int = B4XTable3.VisibleRowIds.IndexOf(RowId)
	SetRowColor3(Index, Selected3, Main.SelectionColor_Green)
	Log($"Number of rows selected: ${SelectedRows3.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Dim RowData As Map
	RowData = B4XTable3.GetRow(RowId)
	Log($"Value1 of selected: ${RowData.GetValueAt(0)}"$)
	Log($"Value2 of selected: ${RowData.GetValueAt(1)}"$)
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = RowData.GetValueAt(1)
	input.ConfigureForNumbers(False, False) 'AllowDecimals, AllowNegative
	Wait For (Dialog.ShowTemplate(input, "OK", "", "NO")) Complete (Result As Int)	
	If(Result=xui.DialogResponse_Positive) Then
		If(input.Text.Length>0) Then
			Dim res As String = input.Text 'no need to check with IsNumber
			B4XTable3.sql1.ExecNonQuery2($"UPDATE data SET c2 = ? WHERE rowid = ?"$, Array As String(res, RowId))	' data è la tabella  a video
			'-------------------------------------------------------------------------------------
			' serve per fare la somma delle righe
			'-------------------------------------------------------------------------------------
			Dim o() As Object = B4XTable3.BuildQuery(False) 'no page limit
			Dim total As double = 0
			Dim rs As ResultSet = B4XTable3.sql1.ExecQuery2(o(0), o(1))
			Dim totalriga As double = 0
			Do While rs.NextRow
				totalriga = Round(rs.GetDouble("c2")) 'c2 = Qta
				total = total + totalriga
			Loop
			TotQtaUMVClientiAssegnati=total
			If(total>TotQtaUMVClienti) Then
				ExtraUtility.Play_Sound("error.wav")
				Label50.Text="*** NON PUOI ASSEGNARE QTA' MAGGIORI DI QUELLE PRELEVATE ***"
				Button19.Enabled=False
			Else
				Label50.Text=""
				Button19.Enabled=True
			End If
			rs.Close
			Label43.Text = ExtraUtility.NumberFormat_ITA(total,1,0)
			'-------------------------------------------------------------------------------------
			Label49.Text="Da Assegnare " & (TotQtaUMVClienti-total) & " " &  UMV
			B4XTable3.Refresh
		End If
	End If
	'	ie.CellClicked(ColumnId, RowId)	
End Sub

Public Sub getIsInEditingState As Boolean
	Return CurrentlyFocusedCell.RowId > 0
End Sub

Private Sub MakeCellEditable (ColumnId As String, RowId As Long)
	If getIsInEditingState And CurrentlyFocusedCell.ColumnId = ColumnId And CurrentlyFocusedCell.RowId = RowId Then Return
	If getIsInEditingState Then
		ExitEditMode
	End If
	CurrentlyFocusedCell = CreateFocusedCell(ColumnId, RowId, Null)
	CurrentlyFocusedCell.PrevValue = mTable.GetRow(RowId).Get(ColumnId)
	CallSub2(mCallback, mEventName & "_EnterEditMode", CurrentlyFocusedCell)
	SetEditableControlLayout(CurrentlyFocusedCell)
End Sub

Private Sub SetEditableControlLayout (SelectedControl As FocusedCell)
	Dim c As B4XTableColumn = mTable.GetColumn(SelectedControl.ColumnId)
	CurrentlyFocusedCell.VisibleIndex = mTable.VisibleRowIds.IndexOf(SelectedControl.RowId)
	Dim p As B4XView = c.CellsLayouts.Get(CurrentlyFocusedCell.VisibleIndex + 1) '+1 because of the header
	If SelectedControl.View.Parent <> p Then
		If p.GetView(p.NumberOfViews - 1).Tag = "TextFlow" Then
			p.GetView(p.NumberOfViews - 1).RemoveViewFromParent 'remove the special TextFlow control that is added to highlight search result
		End If
		p.AddView(SelectedControl.View, 0, 0, p.Width, p.Height)
		p.GetView(c.LabelIndex).Visible = False
		SelectedControl.View.BringToFront
		CurrentlyFocusedCell.View.RequestFocus
	Else
		SelectedControl.View.SetLayoutAnimated(0, 0, 0, p.Width, p.Height)
	End If
End Sub

Private Sub CreateFocusedCell (ColumnId As String, RowId As Long, View As B4XView) As FocusedCell
	Dim t1 As FocusedCell
	t1.Initialize
	t1.ColumnId = ColumnId
	t1.RowId = RowId
	t1.View = View
	Return t1
End Sub

Public Sub ExitEditMode
	If getIsInEditingState = False Then Return
	Dim c As B4XTableColumn = mTable.GetColumn(CurrentlyFocusedCell.ColumnId)
	Dim Value As Object = CallSub2(mCallback, mEventName & "_GetUpdatedValue", CurrentlyFocusedCell)
	Dim parent As B4XView = CurrentlyFocusedCell.View.Parent
	mTable.sql1.ExecNonQuery2($"UPDATE data SET ${c.SQLID} = ? WHERE rowid = ?"$, Array(Value, CurrentlyFocusedCell.RowId))
	CurrentlyFocusedCell.RowId = 0
	mTable.RefreshNow
	parent.GetView(c.LabelIndex).Visible = True
	CurrentlyFocusedCell.View.RemoveViewFromParent
End Sub

Public Sub CellClicked (ColumnId As String, RowId As Long)
	MakeCellEditable(ColumnId, RowId)
End Sub

Private Sub B4XTable3_DataUpdated
	Try
		SetColumnAlignment(B4XTable3,"Cod. Cli.",Gravity.CENTER_HORIZONTAL)
		SetColumnAlignment(B4XTable3,"Rag. Soc.",Gravity.LEFT)
		SetColumnAlignment(B4XTable3,"Qta",Gravity.RIGHT)
		XSelections3.Refresh(0)					
		For i=0 To B4XTable3.VisibleRowIds.Size-1
			Dim RowId As Long = B4XTable3.VisibleRowIds.Get(i)			
			SetRowColor3(i, SelectedRows3.Contains(RowId), Main.SelectionColor_Green )
		Next		
		B4XTable3.BuildLayoutsCache(15)
		For i=0 To Col1x_Column.CellsLayouts.Size-1
			' colonna 1
			Dim pnl1 As B4XView = Col1x_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			lbl1.TextSize = 16
			lbl1.Typeface = Typeface.DEFAULT
			lbl1.TextColor = Colors.Black
			lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' colonna 2
			Dim pnl2 As B4XView = Col2x_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			lbl2.TextSize = 20
			lbl2.Typeface = Typeface.DEFAULT
			lbl2.TextColor = Colors.Black
			lbl2.Padding = Array As Int (10dip, 0dip, 0dip, 0dip)
			' colonna 3
			Dim pnl3 As B4XView = Col3x_Column.CellsLayouts.Get(i)
			Dim lbl3 As Label = pnl3.GetView(0)
			lbl3.TextSize = 20
			lbl3.Typeface = Typeface.DEFAULT
			lbl3.TextColor = Colors.Blue
			lbl3.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
		Next
'		IESupport.DataUpdated
	Catch
		Log(LastException)
	End Try
End Sub

Sub TextField1_Action
'IESupport.ExitEditMode
End Sub

Private Sub SetTextField
	TextField1.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	Dim tf As EditText = TextField1
	Sleep(0)
	tf.SelectAll
End Sub

Private Sub IE_EnterEditMode (FC As FocusedCell)
	'FC.PrevValue holds the current value. It can also be used later to revert changes
	Select FC.ColumnId
		Case "Number"
			B4XPlusMinus1.SetNumericRange(0, 100, 1)
			B4XPlusMinus1.SelectedValue = FC.PrevValue
			FC.View = B4XPlusMinus1.mBase
		Case "String"
			SetTextField
			TextField1.Text = FC.PrevValue
			FC.View = TextField1
		Case "Color"
			B4XPlusMinus1.SetStringItems(ColorsList)
			B4XPlusMinus1.SelectedValue = FC.PrevValue
			FC.View = B4XPlusMinus1.mBase
		Case "Date"
			SetTextField
			TextField1.Text = DateTime.Date(FC.PrevValue)
			FC.View = TextField1
	End Select
End Sub

Private Sub Button5_Click
	' Occhiolino su Corsie
	Try
		If(Button5.Tag="Pressed") Then
			B4XTable2.CreateDataView($"c0>=0"$)
			B4XTable2.Refresh
			Button5.Tag=""
			SelectedRows2.Clear
			Button18.Enabled=True
			Button17.Enabled=True
			' ----------------------------------------------
			If(B4XTable2.IsInitialized) Then
				B4XTable2.ClearDataView
			End If
			Dim straction As String
			Dim dbAction As Map
			straction = "get_is_semaforocorsie"
			dbAction = CreateMap("action=": straction)
			wait for(Execute_EXEC_PHP_POST_SEMAFORO_NESTI(Me, dbAction, straction.ToLowerCase, "is_semaforocorsie.php", vCorsia,Main.Utente,0)) complete (Result As Boolean)
			If(Result) Then
				Sleep(100)
				Visulizza_Corsie
			End If
		Else
			If(B4XTable2.IsInitialized) Then
				B4XTable2.ClearDataView
			End If
			B4XTable2.CreateDataView($"c0<>4 AND c0<>0"$)
			B4XTable2.Refresh
			If(B4XTable2.Size=0) Or (B4XTable2.Size=1) Then
				If (B4XTable2.Size=1) Then
					Dim Rowdata As Map
					Rowdata = B4XTable2.GetRow(1)					
					Dim Corsia As String = Rowdata.Get("Corsia")
					Dim StatoGiro As Int = Rowdata.Get("Stato Giro")
					If(Corsia=vCorsia) And (StatoGiro=4) Then
						ChiusuraDefinitivaGiro(vRifIdTesta)
					End If								
				End If
				If (B4XTable2.Size=0) Then
					ChiusuraDefinitivaGiro(vRifIdTesta)
				End If
			End If
			Button5.Tag="Pressed"	
			SelectedRows2.Clear		
			Button18.Enabled=True
			Button17.Enabled=True
		End If			
	Catch
		Log(LastException)
	End Try
End Sub

Sub ChiusuraDefinitivaGiro(RifIdTesta As Long)
	Try
		ExtraUtility.Play_Sound("error.wav")
		Msgbox2Async("Vuoi chiudere il GIRO?","CHIUSURA DEFINITIVA GIRO N. " & RifIdTesta,"Procedi","","Annulla",Null,True)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then	
			'--------------------------
			' genera GIRO DEFINITIVO
			'--------------------------
			If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
				Label2.Visible = True
				DateTime.DateFormat = "yyyyMMdd HHmmss"
				Dim F_Device As Boolean = True
				Dim nt As Int = 0
				If (F_Device) Then
					nt = nt + 1
					Dim routine As String = "exec_creagirodefinitivo"
					Dim straction As String = routine
					Dim dbAction As Map = CreateMap("action=": straction)
					WAIT FOR(Execute_EXEC_PHP_POST_CREAGIRO_NESTI(Me, dbAction, straction.ToLowerCase, routine & ".php","",  RifIdTesta, Main.Utente)) complete (Success As Boolean)
					If(Success) Then
						ExtraUtility.Play_Sound("Sound3.wav")
						MsgboxAsync("CREATO GIRO DEFINITIVO!","SINCRONIZZAZIONE")
						Activity.Finish
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					Else
						ExtraUtility.Play_Sound("Error.wav")
						MsgboxAsync("PROBLEMI NELLA CREAZIONE DEL GIRO DEFINITIVO!","SINCRONIZZAZIONE")
					End If
				End If
			Else
				MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
			End If
		End If
	Catch
		Log(LastException)
	End Try	
End Sub


Private Sub Button22_Click
	Button22.Text="VARIAZIONI CONFERMATE!"
	Button22.Tag="Pressed"
	Button22.TextColOR=ExtraUtility.Color_DarkGreen
	Button1.Enabled=True
End Sub

Private Sub RicalcoloAutomaticoQtadaPrelevare(CodArt As String, UM_DaPrelevare As String,Qta_DaPrelevare As Double)
	Try
		Dim ResPrel As QtaPrelevabileType =  Converti_QtaBaseInPrelevabile(SQLDataAccess,CodArt,UM_DaPrelevare,Qta_DaPrelevare)
		Label11.Text = ResPrel.Qta1P & " " & ResPrel.UM1P
		If(ResPrel.Qta1P=0) Then
			Label11.Text=""
		End If
		If (ResPrel.UM1P=ResPrel.UM2P) Then
			ResPrel.UM2P = ""
			ResPrel.Qta2P = 0
			Label14.Text = ""
		Else
			Label14.Text = ResPrel.Qta2P & " " & ResPrel.UM2P
		End If
		If(ResPrel.Qta2P=0) Then
			Label14.Text=""
		End If
		Button14.Text=ResPrel.UM1P
		Label37.Text=ResPrel.UM1P
		Button15.Text=ResPrel.UM2P
		Label38.Text=ResPrel.UM2P
		Label47.Text = ResPrel.Qta3P & " " & ResPrel.UM3P
		If(ResPrel.Qta3P=0) Then
			Label47.Text=""
		End If
		Label56.Text = ResPrel.QtaTotUMB & " " & ResPrel.UMB
		If(ResPrel.QtaTotUMB=0)Then
			Label11.Text=""
			Label14.Text=""
			Label47.Text=""
			Label56.Text=""
			Label45.Text=""
			Label57.Text=""			
			If(B4XTable3.Size>0) Then
				B4XTable3.sql1.ExecNonQuery($"UPDATE data SET c2=0"$)
			End If
			Registra_Panel4(vRifIdTesta,Label34.text,vCodArticolo,"TV",vEsercizioNew,vCorsia,vNumDocNew,vUbicazione)
			TotQtaUMVClienti=0
			TotQtaUMBClienti=0
		End If
		If(ResPrel.QtaTotUMB<0)Then
			Dim QtaUMV As Double = Converti_Qta_UMV(SQLDataAccess,CodArt,UMB,Abs(ResPrel.QtaTotUMB))
			Label45.Text=QtaUMV & " " & UMV
			Label11.Text=""
			Label14.Text=""
			Label47.Text=""
			Label56.Text=""
			Label57.Text=CDbl(Converti_Qta_UMBase(SQLDataAccess,CodArt,UMB,Abs(ResPrel.QtaTotUMB))) & " " & UMB			
			If(TotQtaUMVClienti>QtaUMV) Then
				If(B4XTable3.Size>0) Then
					B4XTable3.sql1.ExecNonQuery($"UPDATE data SET c2=0"$)
				End If
				Registra_Panel4(vRifIdTesta,Label34.text,vCodArticolo,"TV",vEsercizioNew,vCorsia,vNumDocNew,vUbicazione)
				TotQtaUMVClienti=0
				TotQtaUMBClienti=0
			End If
		End If
		If(ResPrel.QtaTotUMB>0)Then
			Label45.Text=""
			Label57.Text=""			
			If(B4XTable3.Size>0) Then
				B4XTable3.sql1.ExecNonQuery($"UPDATE data SET c2=0"$)
			End If
			Registra_Panel4(vRifIdTesta,Label34.text,vCodArticolo,"TV",vEsercizioNew,vCorsia,vNumDocNew,vUbicazione)
			TotQtaUMVClienti=0
			TotQtaUMBClienti=0
		End If
		
		'-------------------------
		' Aggiunta del 01/08/22
		'-------------------------
		Dim UMDAP As String  = Leggi_UMDaPrelevare
		If(UMDAP=Button14.Text) Then
			Button14.Color=xColorUMVBack
			If(Button14.Text<>"") Then
				Button14.textColor=xColorUM
				Button15.textColor=xui.Color_Gray
				Button14.Tag="Pressed"
				Button15.Tag=""
				Button16.Tag=""
				EditText7.RequestFocus
			End If
			EditText7.RequestFocus
		Else
			Button14.Color=Colors.LightGray
		End If
		If(UMDAP=Button15.Text) Then
			Button15.Color=xColorUMVBack
			If(Button15.Text<>"") Then
				Button14.textColor=xui.Color_Gray
				Button15.textColor=xColorUM
				Button16.textColor=xui.Color_Gray
				Button14.Tag=""
				Button15.Tag="Pressed"
				Button16.Tag=""
			End If
			EditText8.RequestFocus
		Else
			Button15.Color=Colors.LightGray
		End If
		
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub RicalcoloAutomaticoQtaDisponibile(CodArt As String, UM_Disponibile As String,Qta_Disponibile As Double)
	Try
		Dim ResPrel As QtaPrelevabileType =  Converti_QtaBaseInPrelevabile(SQLDataAccess,CodArt,UM_Disponibile,Qta_Disponibile)
		Label52.Text = ResPrel.Qta1P & " " & ResPrel.UM1P
		If(ResPrel.Qta1P=0) Then
			Label52.Text=""
		End If
		If (ResPrel.UM1P=ResPrel.UM2P) Then
			ResPrel.UM2P = ""
			ResPrel.Qta2P = 0
			Label53.Text = ""
		Else
			Label53.Text = ResPrel.Qta2P & " " & ResPrel.UM2P
		End If
		If(ResPrel.Qta2P=0) Then
			Label53.Text=""
		End If				
		Label54.Text = ResPrel.Qta3P & " " & ResPrel.UM3P
		If(ResPrel.Qta3P=0) Then
			Label54.Text=""
		End If
		Label55.Text = ResPrel.QtaTotUMB & " " & ResPrel.UMB
		If(ResPrel.QtaTotUMB=0)Then
			Label52.Text=""
			Label53.Text=""
			Label54.Text=""
			Label55.Text=""
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button23_Click
	Try
		RicalcoloAutomaticoQtaDisponibile(vCodArticolo,"PZ.",660)		
		'RicalcoloAutomaticoQtadaPrelevare(vCodArticolo,"PZ.",-12)		
		Label48.Text="" ' CDbl("12.79")
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button24_Click
	Dim column As B4XTableColumn = B4XTable1.GetColumn("Ord.")
	If(Button24.Tag="SU") Then
		Button24.Tag="GIU"
		Button24.Text=Chr(0xF063)
		Button24.TextColor=xui.Color_Red	
	Else
		Button24.Tag="SU"
		Button24.Text=Chr(0xF062)
		Button24.TextColor=xui.Color_Blue
	End If
	If(Button24.Tag="SU") Then
		column.InternalSortMode= "ASC"
	Else
		column.InternalSortMode= "DESC"
	End If
	B4XTable1.Refresh
End Sub

Private Sub Button25_Click
	Try
		If(Panel3.Visible=False) And (Panel2.Visible=False) Then
			ExtraUtility.Play_Sound("error.wav")
			Msgbox2Async("Vuoi azzerare i semafori delle corsie?","ATTENZIONE!","Procedi","","Annulla",Null,True)
			Wait For MsgBox_Result (Result As Int)
			If Result = DialogResponse.POSITIVE Then
				'----------------------------------
				' AZZERARE I SEMAFORI DELLE CORSIE
				'----------------------------------
				If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
					Label2.Visible = True
					DateTime.DateFormat = "yyyyMMdd HHmmss"
					Dim F_Device As Boolean = True
					Dim nt As Int = 0
					If (F_Device) Then
						nt = nt + 1
						Dim routine As String = "is_semaforocorsie"
						Dim straction As String = "azz_is_semaforocorsie"
						Dim dbAction As Map = CreateMap("action=": straction)
						WAIT FOR(Execute_EXEC_PHP_POST_CREAGIRO_NESTI(Me, dbAction, straction.ToLowerCase, routine & ".php","",  vRifIdTesta, Main.Utente)) complete (Success As Boolean)
						If(Success) Then
							ExtraUtility.Play_Sound("Sound3.wav")
							MsgboxAsync("AZZERAMENTO SEMAFORI EFFETTUATO!","SINCRONIZZAZIONE")
						Else
							ExtraUtility.Play_Sound("Error.wav")
							MsgboxAsync("PROBLEMI NELL'AZZERAMENTO SEMAFORI!","SINCRONIZZAZIONE")
						End If
					End If
				Else
					MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
				End If
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub