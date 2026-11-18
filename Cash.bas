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
	Private QtaIns As Double = 0
	Private TotaleCash As Double = 0
	Private vNRListino As Int = 0 
	Private vOrdinamento As Long = 0
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
	Private Col1_Column As B4XTableColumn	'	N. Posizione		(c0)
	Private Col2_Column As B4XTableColumn	'	Tipo Riga			(c1)
	Private Col3_Column As B4XTableColumn	'	Cod. Art			(c2)
	Private Col4_Column As B4XTableColumn 	' 	Descriz. Articolo	(c3)
	Private Col5_Column As B4XTableColumn	' 	Ordinato			(c4)
	Private Col6_Column As B4XTableColumn	' 	UM Ordinato			(c5)
	Private Col7_Column As B4XTableColumn	'	Acquisito1			(c6)
	Private Col8_Column As B4XTableColumn	'	UM1 Acq.			(c7)
	Private Col9_Column As B4XTableColumn	'	Acquisito2			(c8)
	Private Col10_Column As B4XTableColumn	'	UM2 Acq.			(c9)
	Private Col11_Column As B4XTableColumn	'	peso kg.			(c10)
	Private Col12_Column As B4XTableColumn	'	N. etichette		(c11)
	Private Col13_Column As B4XTableColumn	'	Data Scadenza		(c12)
	Private Col14_Column As B4XTableColumn	'	Status				(c13)
	Private Col15_Column As B4XTableColumn	'	Priorita			(c14)
	Private Col16_Column As B4XTableColumn	'	IDRiga				(c15)
	Private Col17_Column As B4XTableColumn	'	QtaTotUMAConv		(c16)
	Private Col18_Column As B4XTableColumn	'	QtaTotUM2			(c17)
	Private Col19_Column As B4XTableColumn	'	CoeffConvUMA		(c18)
	Private Col20_Column As B4XTableColumn	'	Partita1			(c19)
	Private Col21_Column As B4XTableColumn	'	Qta_Partita1		(c20)
	Private Col22_Column As B4XTableColumn	'	Partita2			(c21)
	Private Col23_Column As B4XTableColumn	'	Qta_Partita2		(c22)
	Private Col24_Column As B4XTableColumn	'	Partita3			(c23)
	Private Col25_Column As B4XTableColumn	'	Qta_partita3		(c24)
	Private Col26_Column As B4XTableColumn	'	RifIdTesta			(c25)
	Private Col27_Column As B4XTableColumn	'	DispUMBase			(c26)
	Private Col28_Column As B4XTableColumn	'	PrezzoUn			(c27)
	Private Col29_Column As B4XTableColumn	'	UMPrezzo			(c28)
	Private Col30_Column As B4XTableColumn	'	TotaleRiga			(c29)
	Private Col31_Column As B4XTableColumn	'	PesoReale			(c30)
	Private Col32_Column As B4XTableColumn	'	PesoReale2			(c31)
	Private Col33_Column As B4XTableColumn	'	Qta1_UM2			(c32)
	Private Col34_Column As B4XTableColumn	'	Qta2_UM2			(c33)
	'-----------------------------------------------------------
	Private Col1x_Column As B4XTableColumn  ' 	Cod. Cli.
	Private Col2x_Column As B4XTableColumn	' 	Rag. Soc.
	Private Col3x_Column As B4XTableColumn	' 	Qtà
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
	Private vCodArticolo As String = ""
	Private vCodArticoloOld As String = ""
	Private vDescrizioneArt As String = ""
	Private vDescrizioneArtOld As String = ""
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
	Private SemaphoreColumn As B4XTableColumn
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
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Type ArticoloType (Articolo As String, Corsia As String, Ubicazione As String, Ordinamento As Long, UMPrezzo As String, Errore As Boolean)
	Private BarcodeArticolo As ArticoloType
	Private PrezzoUnitario As Double
	Private UMPrezzo As String
	Private TotaleRiga As Double
	Private QtaTotaleUMBase As Double
	Private Button25 As Button
	Private vTotPesoReale As Double
	Private vTotPesoReale2 As Double
	Private vPesoReale As Double
	Private vPesoReale2 As Double
	Private Qta1_UM2 As Double = 0
	Private Qta2_UM2 As Double = 0
	Private ArticoloPartite_OLD As PartiteQtaType
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
		'	TimerLongClick.Initialize("TimerLongClick",50)	
		'	TimerLongClick.Enabled = False
	End If
	If(ListaDocTablet.vOperazione="NuovoDoc")Then
		vNumDocNew=0
		ListaDoc.vTrasmesso=0
	End If
	Activity.RemoveAllViews
	Activity.LoadLayout("Cash")
	'--------- Panel 2 --------------
	' Visualizza i clienti
	ListaRigheTablet2(True,0,0)
	'--------- Panel 4 --------------
	' Visualizza le corsie
	ListaRigheTablet3(True)
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
				Case "Cash"
					TipoOperazione = "CAS"  ' Cash
					ColumnColor = 13
					B4XTable1.mBase.Visible=True
					ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					B4XTable1.mBase.Visible=True
					EditText2.Enabled=True
						
				Case Else
					
			End Select
		
		Case "NuovoDoc"
			B4XTable1.Clear
			B4XTable1.Refresh
			Select Case Choose_Menu.vOperazioneMenu
				
				Case "Cash"
					TipoOperazione = "CAS"   ' Cash
					ColumnColor = 13
					ListaRigheTablet(ListaDocTablet.vTipoDoc,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio)
					B4XTable1.mBase.Visible=True
					EditText2.Enabled=True
					vCodCliFor = ""
					Phone.HideKeyboard
					ProgressDialogShow("LETTURA CLIENTI IN CORSO...")
					Wait For(ListaRigheTablet3(False)) complete  (Result As Boolean)
					If(Result) Then
						wait for (DB_SQLSERVER.Azzera_SemaforoCorsie_Local(SQLDataAccess,Main.Utente)) Complete (Success As Boolean)
						If(Success) Then
							Sleep(1)
							vCorsia=""
							Panel4.Visible=True
						End If
					End If
					ProgressDialogHide
								
				Case Else				
					
			End Select			
			
	End Select	
	Label2.Text="BARCODE :"
	Label8.Text=""
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
			Dim F_Errore As Boolean = False
			If(vBarcodeLetto.Length=5) And (vBarcodeLetto.StartsWith("CS"))Then
				vCorsia=vBarcodeLetto
				Button8.text = vCorsia
				CallSubDelayed(Me, "OK_ListaCorsie")
			End If
			If(vBarcodeLetto.Length=15) And (vBarcodeLetto.StartsWith("CS"))	Then
				Dim CorsiaCella As String = vBarcodeLetto.SubString2(0,5)
				If(vCorsia<>CorsiaCella) Then
					ExtraUtility.Play_Sound("Error.wav")
					MsgboxAsync("PRODOTTO NON COERENTE CON LA CORSIA SELEZIONATA!","ERRORE")
					F_Errore = True
				End If
			End If
			If (vCorsia="") Then
				' Visualizza le corsie
				vRifIdTesta=vBarcodeLetto
				ListaRigheTablet2(False,vBarcodeLetto,0)
			Else
			'-----------------------------------------------------------
			'	SECONDA FASE LEGGO LE RIGHE DELLA CORSIA DEL GIR
			'-----------------------------------------------------------
			If (Panel3.Visible=False) And (vBarcodeLetto<>vCorsia) And (F_Errore=False) Then
					ApriMiniCalcolatrice(vBarcodeLetto,0,0)
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
								If(Leggi_DisponibilitaArticolo(vCodArticolo,vCorsia,QtaIns)>0) Then								
									OK_MiniCalcolatrice
								End If
							End If
							If(vBarcodeLetto="KO") Then
								CallSubDelayed(Me,Button12_Click)
							End If
						Else
							vCodArticoloOld=vCodArticolo
							Leggi_Barcode_Articolo(vBarcodeLetto)
							' Cerco l'articolo x cella e corsia
							Dim Codart As String = BarcodeArticolo.Articolo
							If(Codart<>"") Then													
								If(Codart=vCodArticoloOld) Then
									If(Panel3.Visible=False) And (vPesoReale=0) Then
										CallSubDelayed(Me,SwiftButton2_Click)
									End If
								Else
									vCodArticolo=vCodArticoloOld
									vDescrizioneArt=vDescrizioneArtOld
									Label3.Text=vDescrizioneArt
									ExtraUtility.Play_Sound("error.wav")
									ToastMessageShow("*** CODICE ERRATO ***",False)					
									EditText1.RequestFocus			
								End If
							End If								
							'TotQtaUMBClienti=TotQtaUMX-LeggiQta(Label47.Text,Chr(32))
							'TotQtaUMVClienti=Converti_Qta_UMV(SQLDataAccess,vCodArticolo,UMB,TotQtaUMBClienti)	
						End If								
					End If														
				End If
			
			End If
			
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub CreaIDChiave As Long
	Try	
		DateTime.DateFormat="dd/MM/yyyy hh:mm:ss"
		Dim dataoggi As Long =  DateTime.Now
		Dim AA  As String = NumberFormat2(DateTime.GetYear(dataoggi),1,0,0,False).SubString(3)
		Dim GGAnno As Int = DateTime.GetDayOfYear(dataoggi)		
		Dim hh As String = NumberFormat2(DateTime.GetHour(dataoggi),2,0,0,False)
		Dim mm As String = NumberFormat2(DateTime.GetMinute(dataoggi),2,0,0,False)	
		Dim ss As String = NumberFormat2(DateTime.GetSecond(dataoggi),2,0,0,False)
		Dim IDkey As Long = AA & GGAnno & hh & mm & ss		
		Return IDkey
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub ApriMiniCalcolatrice (Codice As String, RifIdRiga As Int, PesoReal As Double)
	Try
		If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
			'	TABLET			
			EditText5.TextSize=40dip
			Label11.TextSize=30dip
		Else
			'------------------
			'	PALMARE			
			'------------------
			Panel3.Top=0
			Panel3.Left=0
			Panel3.Height=100%y
			Panel3.Width=100%x
			Label29.Width=100%x-10dip
			Label9.Width=100%x-10dip		
			SwiftButton2.mBase.Left=100%x-SwiftButton2.mBase.Width-10dip
			Label14.Width=50%x		
			Label4.Left=50%x-Label4.Width
			Label14.Top=Label9.Top+Label9.Height-10dip
			Label14.TextSize=32			
			Label14.Gravity = Bit.Or(Gravity.CENTER_VERTICAL,Gravity.CENTER_HORIZONTAL)
			Label14.Left=(100%x-Label14.Width)/2
			Label11.Width=Panel3.Width
			Label11.TextSize=32
			Label11.Gravity = Bit.Or(Gravity.CENTER_VERTICAL,Gravity.CENTER_HORIZONTAL)			
			Label11.Left=(100%x-Label11.Width)/2
			Label35.TextSize = 34
			Label35.left=Label11.left
			Label35.Top=Label11.Top+Label11.Height
			Label35.Width=Label11.Width
			Label35.Height=50dip
			Label36.TextSize = 30
			Label36.left=Label35.left
			Label36.Top=Label35.Top+Label35.Height
			Label36.Width=Label35.Width
			Label36.Height=45dip
			Label37.TextSize = 30
			Label37.left=Label36.left
			Label37.Top=Label36.Top+Label36.Height
			Label37.Width=Label36.Width
			Label37.Height=45dip
			Button10.Top=100%y-Button10.Height
			Button10.Left=100%x-Button10.Width
			Button9.Top=100%y-Button10.Height
			Button9.Left=0
			EditText5.Width=140dip
			EditText5.Left=(100%x-EditText5.Width)/2			
		End If
		' ---------------------------------------------------------------------------
		Dim rstory As ResultSet = SQLDataAccess.ExecQuery2("SELECT * FROM IS_RIGHEDOCUMENTI WHERE RIFIDTESTA = ? AND CODART=?", Array As  String(vRifIdTesta,vCodArticolo))
		If (rstory.RowCount>0) Then
			Do While rstory.NextRow
				ArticoloPartite_OLD.Partita1 = rstory.Getstring("Partita1")
				ArticoloPartite_OLD.Partita2 = rstory.Getstring("Partita2")
				ArticoloPartite_OLD.PesoReale1 = rstory.Getstring("PesoReale")
				ArticoloPartite_OLD.PesoReale2 = rstory.Getstring("PesoReale2")
				ArticoloPartite_OLD.Qta1 = rstory.GetDouble("QP1")
				ArticoloPartite_OLD.Qta2 = rstory.GetDouble("QP2")
				ArticoloPartite_OLD.Qta1_UM2 = rstory.GetDouble("Qta1_UM2")
				ArticoloPartite_OLD.Qta2_UM2 = rstory.GetDouble("Qta2_UM2")
				ArticoloPartite_OLD.UM1 = rstory.GetString("UMBase")
				ArticoloPartite_OLD.UM2 = rstory.GetString("UM")
			Loop			
		Else
			ArticoloPartite_OLD.Partita1 = ""
			ArticoloPartite_OLD.Partita2 = ""
			ArticoloPartite_OLD.PesoReale1 = 0
			ArticoloPartite_OLD.PesoReale2 = 0
			ArticoloPartite_OLD.Qta1 = 0
			ArticoloPartite_OLD.Qta2 = 0
			ArticoloPartite_OLD.Qta1_UM2 = 0
			ArticoloPartite_OLD.Qta2_UM2 = 0
			ArticoloPartite_OLD.UM1=""
			ArticoloPartite_OLD.UM2=""
		End If
		rstory.Close		
		' ---------------------------------------------------------------------------
		Button10.Enabled=True	
		Dim Corsia As String = ""
		Dim Ubicaz As String = ""
		Dim res  As ResultSet
		If(vPesoReale>0) Or (vTotPesoReale>0) Or (vTotPesoReale2>0) Then
			If(vPesoReale>0) Then
				Label35.Text = "KG " &  ExtraUtility.Formato_3dec_ITA_Num(vPesoReale)
			Else
				Label35.Text = "KG"
			End If
			If(vTotPesoReale>0) Then
				Label36.Text = "Tot. (L1) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
			Else
				Label36.Text = ""
			End If
			If(vTotPesoReale2>0) Then
				Label37.Text = "Tot. (L2) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
			Else
				Label37.Text = ""
			End If
		Else
			Label35.Text=""
			Label36.Text=""
			Label37.Text=""
		End If
		EditText5.Enabled=False
		If (Codice.Length=15) And (Codice.SubString2(0,2)="CS") Then  ' caso di corsia ubicazione
			Corsia=Codice.SubString2(0,5)
			Ubicaz=Codice.SubString(5)			
			If(vCorsia=Corsia) Then
				res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33 from data where c11=? AND c12=?"$, Array As String(Corsia,Ubicaz))
				If (res.RowCount=0) Then
					QtaIns = 0
					Dim rs As ResultSet = SQLDataAccess.ExecQuery2("SELECT CODICE,DESCRIZIONE,LI.PREZZOEURO,LI.UM AS UMPREZZO FROM IS_ANAGRAFICAARTICOLI AA	JOIN IS_LISTINIARTICOLI AS LI ON LI.CODART=AA.CODICE WHERE Corsia=? AND UBICAZIONE = ? AND LI.NRLISTINO = ?", Array As  String(Corsia,Ubicaz,vNRListino))
					If (rs.RowCount>0) Then
						Do While rs.NextRow
							vCodArticolo = rs.GetString("CODICE")
							vDescrizioneArt = rs.GetString("DESCRIZIONE")
							EditText5.Text = QtaIns
							vUbicazione = Ubicaz
							vCorsiaArticolo = Corsia
							Label3.Text=vDescrizioneArt
							Label9.Text=vDescrizioneArt
							Label29.Text=vCodArticolo
							Label14.Text = Leggi_UMVenditaArticolo(vCodArticolo)				
							PrezzoUnitario = rs.GetDouble("PREZZOEURO")
							UMPrezzo = rs.GetString("UMPREZZO")
							Label11.Text = "€ " & ExtraUtility.Formato_2dec_ITA_Num(PrezzoUnitario) & "/" & UMPrezzo	
							If(PesoReal=0) Then			
								If(vPesoReale>0) Then					
									Label35.Text = "KG " & vPesoReale
								Else
									Label35.Text = ""
									Label36.Text = ""
									Label37.Text = ""
								End If
							Else
								Label36.Text = "Tot. (L1) Kg. " & PesoReal
								Label37.Text = ""
							End If						
						Loop 
					End If
				Else
					Do While res.NextRow
						vCodArticolo = res.GetString("c2")
						vDescrizioneArt = res.GetString("c3")	
						QtaIns = res.GetInt("c6")		
						EditText5.Text = QtaIns			
						vCorsia = res.GetString("c11")
						vCorsiaArticolo = vCorsia
						vUbicazione = res.GetString("c12")					
						Label3.Text=vDescrizioneArt
						Label9.Text=vDescrizioneArt
						Label29.Text=vCodArticolo				
						Label14.Text = res.GetString("c5")
						PrezzoUnitario = res.GetDouble("c27")
						UMPrezzo = res.GetString("c28")
						TotaleRiga = res.GetDouble("c29")	
						vTotPesoReale = res.GetDouble("c30")
						vTotPesoReale2 = res.GetDouble("c31")
						Qta1_UM2 = res.GetDouble("c32")
						Qta2_UM2 = res.GetDouble("c33")
						Label11.Text = "€ " & ExtraUtility.Formato_2dec_ITA_Num(PrezzoUnitario) & " / " & UMPrezzo
						Label35.Text = "KG" 
						If(vTotPesoReale>0) Then
							Label36.Text = "Tot. Kg. (L1)" & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
						End If
						If(vTotPesoReale2>0) Then
							Label37.Text = "Tot. Kg. (L2)" & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
						End If
					Loop
				End If
				Panel3.Visible=True
			Else
				ExtraUtility.Play_Sound("Sound3.wav")
				MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ARTICOLO IN CORSIA '" & Corsia & "'")
			End If			
		Else
			' Decodifica Articolo...
			Leggi_Barcode_Articolo(Codice)
			If (BarcodeArticolo.Articolo<>"") Then
				vCodArticolo = BarcodeArticolo.Articolo
				Corsia = BarcodeArticolo.Corsia
				Ubicaz = BarcodeArticolo.Ubicazione
				vDescrizioneArt = Label3.Text
				Label9.Text = vDescrizioneArt
				Label29.Text = vCodArticolo
				Label14.Text = Leggi_UMVenditaArticolo(vCodArticolo)
				Dim Lista As List = Leggi_PrezzoVenditaArticolo(vCodArticolo,vNRListino)				
				If(Lista.Size>0) Then
					PrezzoUnitario = Lista.Get(0)
					UMPrezzo = Lista.Get(1)
					Label11.Text = "€ " & ExtraUtility.Formato_2dec_ITA_Num(Lista.Get(0)) & " / " & Lista.Get(1)
					If(PesoReal=0) Then
						If(vPesoReale>0) Or (vTotPesoReale>0) Or (vTotPesoReale2>0) Then
							If(vPesoReale>0) Then
								Label35.Text = "KG " & ExtraUtility.Formato_3dec_ITA_Num(vPesoReale)
							Else
								Label35.Text = "KG"
							End If
							If(vTotPesoReale>0) Then
								Label36.Text = "Tot. (L1) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
							End If
							If(vTotPesoReale2>0) Then
								Label37.Text = "Tot. (L2) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale2)
							End If
						Else
							Label35.Text = ""
							Label36.Text = ""
							Label37.Text = ""
						End If						
					Else
						If(PesoReal>0)  Or (vTotPesoReale>0) Or (vTotPesoReale2>0) Then
							If(PesoReal>0) Then
								Label35.Text = "KG " & ExtraUtility.Formato_3dec_ITA_Num(PesoReal)
							Else
								Label35.Text = "KG"
							End If																			
							If(vTotPesoReale>0) Then
								Label36.Text = "Tot. (L1) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
							End If
							If(vTotPesoReale2>0) Then
								Label37.Text = "Tot. (L2) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale2)
							End If							
						Else
							Label35.Text = ""
							Label36.Text = ""
							Label37.Text = ""
						End If
					End If
				Else
					PrezzoUnitario = 0	
				End If				
				res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1 from data where c2=?"$, Array As String(vCodArticolo))
				If (res.RowCount=0) Then
					QtaIns=0
					vTotPesoReale = 0 
					EditText5.Text=QtaIns
				End If
			End If
			If(vTrasmesso=1) Then
				Button10.Enabled=False
			End If
			Panel3.Visible=True
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
		Log(sqlstr)
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
		Log("Exec_Scrivi_DB(" &straction&" is_righedocumenti_cash.php)")
		straction = "insert_righedoc_cash"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDocCASH(Me, dbAction, straction, "is_righedocumenti_cash.php","",TipoDoc, NumDoc, RifIdTesta, Corsia, CodClifor, Main.Utente)) Complete (Result As Boolean)
		If( Result) Then
			' OK
			ToastMessageShow("Operazione salvataggio corsia server effettuato con successo!",True)
			Return True			
		Else
			' MsgboxAsync("Operazione errata, problema di sincronizzazione is_righedocumenti_giro!","Sincronizzazione " & Main.MessageBoxText)
			ToastMessageShow("Operazione errata, problema di sincronizzazione is_righedocumenti_cash!",False)
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Aggiorna_Semaforo_Server(Corsia As String, Utente As String, Occupata As Int) As ResumableSub
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		If(Occupata=-1) Then
			straction = "del_is_semaforocorsie"
			dbAction = CreateMap("action=": straction)
			wait for(Execute_EXEC_PHP_POST_SEMAFORO_NESTI(Me, dbAction, straction.ToLowerCase, "is_semaforocorsie.php", Corsia,Utente,0)) complete (Result2 As Boolean)
		Else
			straction = "upd_is_semaforocorsie"
			dbAction = CreateMap("action=": straction)
			' Wait For (Execute_Scrivi_DB_Semaforo(Me, dbAction, straction, "is_semaforocorsie.php","",Corsia,Utente,Occupata)) Complete (Result2 As Boolean)
			Wait For (Execute_EXEC_PHP_POST_SEMAFORO_NESTI(Me, dbAction, straction.ToLowerCase, "is_semaforocorsie.php", Corsia,Utente,Occupata)) Complete (Result2 As Boolean)
		End If		
		Log("Aggiorna_Semaforo_Server(" & straction &" is_semaforocorsie.php)")
		If( Result2) Then
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

Sub Aggiorna_Semaforo_Giro_Server(RifIdTesta As Long, Corsia As String, Utente As String, Occupata As Int, Tipocorsia As String) As ResumableSub
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		straction = "upd_is_semaforocorsie_giro"
		Log("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA Exec_Scrivi_DB_SemaforoGiro(" &straction&" is_semaforocorsie_giro.php)")
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_SemaforoGIRO_Server(Me, dbAction, straction, "is_semaforocorsie_giro.php","",RifIdTesta,Corsia,Utente,Occupata,Tipocorsia)) Complete (Result2 As Boolean)
		If( Result2) Then			
			Return True
		Else
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return False
	End Try
End Sub

Sub Aggiorna_Partita_Server(routine As String, rifidtesta As Long, codart As String, partita As String, datamov As String, qta1 As Double, qta2 As Double, utentepalmare As String, codclifor As String, corsia As String) As ResumableSub
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
				WAIT FOR(Execute_EXEC_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, routine & ".php","", Main.Utente, rifidtesta, codart, partita, datamov, qta1, qta2, utentepalmare, codclifor, corsia)) complete (Success As Boolean)
				If(Success) Then
					Return True
				Else
					Return False
				End If
			Else
				Return False
			End If
		Else
			MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
			Return False
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Azzera_Panel3
	TotQtaUM1=0
	TotQtaUM2=0
	TotQtaUMX=0
	txt=""
	Label36.Text=""
	Label37.Text=""
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
End Sub

Sub NewData_CASH(CodiceLettoPIK As String, F_Errore As Boolean)
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
					' Label3.Text = "*** CODICE ERRATO ***"
					F_Errore = True
				End If
				' MsgboxAsync	("OK trovato -> " & vRes.Descrizione,"TEST EAN")
			Else
				ExtraUtility.Play_Sound("error.wav")
				' Label3.Text = "*** CODICE ERRATO ***"
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
		sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND RifIdTesta='" & RifIdTesta & "'"
		SQLDataAccess.ExecNonQuery(sqlstr)
		'sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = " & RifIdTesta
		'SQLDataAccess.ExecNonQuery(sqlstr)
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

Sub Registra_Panel3(msg As String,npos As Int,StatoRiga As String, Qta As Double)As ResumableSub
	' ------------------------
	' Registra Panel3
	' ------------------------
	Try	
		Sleep(0)
		Dim coddeposito As String = Button8.Text	
		Qta=Qta-(ArticoloPartite_OLD.Qta1+ArticoloPartite_OLD.Qta2)
		wait for (Leggi_DisponibilitaArticoloLocal(vCodArticolo,coddeposito,Qta)) complete (Result  As PartiteQtaType)
		If (Result <> Null) Then
			vFattoreConv  = 1
			If (TipoOperazione="CAS") Then						
				If(Qta=0) Then
					B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c7=?, c8=?, c9=?, c10=?, c16=?, c17=?, c18=?, C20=?, C22=?, c24=?, c13=?, c30=?, c31=?, c32=?, c33=? WHERE c0=?"$, Array As Object _
					(UM2,TotQtaUM2,UM3,TotQtaUM3,UMPrezzo,QtaTotaleUMBase,vFattoreConv,Result.Qta1,Result.Qta2,Result.Qta3,StatoRiga,Result.PesoReale1,Result.PesoReale2,Result.Qta1_UM2,Result.Qta2_UM2,npos))
					'B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c7=?, c8=?, c9=?, c10=?, c16=?, c17=?, c18=?, c19=?, C20=?, c21=?, C22=?, c23=?, c24=?, c13=?, c30=?, c31=?, c32=?, c33=? WHERE c0=?"$, _
					'Array As Object (UM2,TotQtaUM2,UM3,TotQtaUM3,UMPrezzo,QtaTotaleUMBase,vFattoreConv,Result.Partita1,Result.Qta1,Result.Partita2,Result.Qta2,Result.Partita3,Result.Qta3,StatoRiga, _
					'Result.PesoReale1,Result.PesoReale2,Result.Qta1_UM2,Result.Qta2_UM2,npos))
				Else
					B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c7=?, c8=?, c9=?, c10=?, c16=?, c17=?, c18=?, c19=?, C20=?, c21=?, C22=?, c23=?, c24=?, c13=?, c30=?, c31=?, c32=?, c33=? WHERE c0=?"$, _
					Array As Object (UM2,TotQtaUM2,UM3,TotQtaUM3,UMPrezzo,QtaTotaleUMBase,vFattoreConv,Result.Partita1,Result.Qta1,Result.Partita2,Result.Qta2,Result.Partita3,Result.Qta3,StatoRiga, _
					Result.PesoReale1,Result.PesoReale2,Result.Qta1_UM2,Result.Qta2_UM2,npos))
				End If
			End If
			B4XTable1_DataUpdated
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
		End If
		Return(True)
	Catch
		Return(False)
		Log(LastException)
	End Try
End Sub

Sub Leggi_Barcode_Articolo(CodiceLetto As String)
	Dim Result As List
	Dim F_Errore As Boolean = False
	Dim Corsia As String = ""
	Dim PesoArt As Double = 0
	BarcodeArticolo.Initialize
	Result.Initialize
	Try	
		Button10.Enabled=True
		PesoArt = 0	
		CodiceLetto = CodiceLetto.Trim
		If (CodiceLetto.Length=13) And (CodiceLetto.SubString2(0,1)="2") Then 'And (vCodArticolo="") Then
			' Decodifico articolo a peso, in realtà solo l'articolo			
			Result = ExtraUtility.LeggiArticoloConPeso(CodiceLetto,2)	' estrae l'articolo dalla stringa letta
			CodiceLetto = Result.Get(0)
			PesoArt	 = Result.Get(1)
		End If
		sqlstr = "SELECT AA.CORSIA,AA.CODICE,AA.DESCRIZIONE,AA.UBICAZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO,AA.ORDINAMENTO from IS_ANAGRAFICAARTICOLI AA WHERE AA.CODICE = '" & CodiceLetto & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label3.Text = rs.GetString("DESCRIZIONE")
				vCodArticolo = rs.GetString("CODICE")
				Corsia=rs.GetString("CORSIA")
				vUbicazione=rs.GetString("UBICAZIONE")
				vOrdinamento = rs.GetLong("ORDINAMENTO")
				BarcodeArticolo.Articolo = vCodArticolo
				BarcodeArticolo.Ubicazione = vUbicazione
				BarcodeArticolo.Ordinamento = vOrdinamento
				If(Corsia<>vCorsia) And (vTrasmesso<>1) Then	
					BarcodeArticolo.Corsia = Corsia
					ExtraUtility.Play_Sound("Sound3.wav")
					Button10.Enabled=False
					MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ARTICOLO IN CORSIA '" & Corsia & "'")		
				End If
			Loop
			rs.close
		Else
			sqlstr = "SELECT AA.CORSIA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UBICAZIONE,AA.UMV,AA.UMA,AA.UM,AA.ESAURITO,AA.ORDINAMENTO FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
				& " ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE ='" & CodiceLetto & "'"  '" & vCodArtLotto & "'" 
			Log (sqlstr)
			Dim vDescArticolo As String = ""
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			If (rs.RowCount>0)  Then
				Do While rs.NextRow
					vDescArticolo = rs.GetString("DESCRIZIONE")
					vCodArticolo = rs.GetString("ARTICOLO")
					Corsia = rs.GetString("CORSIA")
					vUbicazione = rs.Getstring("UBICAZIONE")					
					vOrdinamento = rs.GetLong("ORDINAMENTO")
					BarcodeArticolo.Ordinamento = vOrdinamento
					BarcodeArticolo.Articolo = vCodArticolo					
					BarcodeArticolo.Ubicazione = vUbicazione
					BarcodeArticolo.Ordinamento = vOrdinamento
					If(Corsia<>vCorsia) Then
						BarcodeArticolo.Corsia = Corsia						
						ExtraUtility.Play_Sound("Sound3.wav")
						MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ATTENZIONE CORSIA " & Corsia)		
						Button10.Enabled=False				
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
					If(vRes.Codart<>"") Then
						vCodArticolo = vRes.Codart
						vCorsiaArticolo = vRes.Corsia
						PesoArt = Round2(vRes.Qta,3)
						BarcodeArticolo.Articolo = vCodArticolo
						If (vCodArticolo<>"") And (vCorsia=vCorsiaArticolo) Then
							Label3.Text = vRes.Descrizione
						Else					
							Button10.Enabled = False
							ExtraUtility.Play_Sound("error.wav")
							If(vCorsia<>vCorsiaArticolo) Then
								Label3.Text = vRes.Descrizione
								MsgboxAsync("ARTICOLO NON COERENTE CON LA CORSIA SELEZIONATA.","ARTICOLO IN CORSIA '" & vCorsiaArticolo & "'")
							End If
							' Label3.Text = "*** CODICE ERRATO ***"							
							F_Errore = True
						End If
					End If
				Else
					ExtraUtility.Play_Sound("error.wav")
					' Label3.Text = "*** CODICE ERRATO ***"
					F_Errore = True
					vCodArticolo = ""
				End If
			End If
		End If	
		If(PesoArt>0) Then
			EditText5.Enabled=False
			EditText1.RequestFocus
		End If
		vPesoReale = PesoArt
		BarcodeArticolo.Errore = F_Errore
	Catch
		Log(LastException)
		BarcodeArticolo.Errore = True
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

Sub Decodifica_Articolo_Cash(Codice As String) As List
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

Private Sub agg_GiroCash(codclifor As String)
	Try	
		' Dim routine As String ="exec_agg_girocash"
		' ----------------------------------------------
		' CreaIDChiave 
		' ----------------------------------------------
		vRifIdTesta = CreaIDChiave
		vCodCliFor = codclifor
		Azzera_Semafori_Local(vRifIdTesta)
		Sleep(100)
		wait for (Aggiorna_Semaforo_Server(vCorsia, Main.Utente, -1)) complete (Success As Boolean) ' 3 = occupata rosso
		If(Success) Then
			Log("Azzeramento semafori server concluso con successo!")
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Button6_Click	
	Try	
		Label33.Visible=True
		Label34.Visible=True
		'vCodCliFor = ""
		'Phone.HideKeyboard
		'ProgressDialogShow("LETTURA CLIENTI IN CORSO...")
		'Wait For(ListaRigheTablet3(False)) complete  (Result As Boolean)
		'If(Result) Then
		'	Panel4.Visible=True
		'End If
		'ProgressDialogHide
		'Label29.Text="035309"
		'Label9.Text="FUNGHI PORCINI DI PRUNETTA AL NATURALE AFFETTATI KG.2,5"
		'Label14.Text = "X12"
		'Label11.Text = "€ 123,45"
		'Label34.Text = "€ 125.750,25"
		'Panel3.Visible=True
		
	Catch
		Log(LastException)
	End Try
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
		Sleep(0)
		Dim nrecs As Int = B4XTable1.sql1.ExecQuerySingleResult("SELECT count(*) FROM data WHERE c13<>''")
		If(nrecs=0) Then
			vCorsiaOld = Button8.Text
			ListaRigheTablet2(False,vRifIdTesta,0)
			Button8.Enabled=False
			Button1.Enabled=False
			Button2.Enabled=False
			Button6.Enabled=False
			Button7.Enabled=False
			Panel2.Visible=True
		Else
			XSelections.SelectedLines.Clear
			XSelections.Refresh(ColumnColor)
			B4XTable1.ClearDataView
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
			B4XTable1_DataUpdated
			XSelections.SelectedLines.Clear
			XSelections.Refresh(ColumnColor)
			B4XTable1.Refresh
			ToastMessageShow("NON PUOI CAMBIARE CORSIA SENZA CONFERMARE O SOSPENDERE",True)
			ExtraUtility.Play_Sound("error.wav")
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
			Case "CAS"  ' Cash
				RegistraDocumento(vTipoDocNew,ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,ListaDocTablet.vCodCliFor,1,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia)
				IDkey = Leggi_IDkey(SQLDataAccess,vTipoDocNew,vNumDocNew,vEsercizioNew)
				Msgbox2Async("Vuoi cocludere la SPESA sincronizzando il server?", "SINCRONIZZA", "SI", "NO", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Sleep(0)
					wait for (RegistraSulServer(IDkey)) Complete (Success As Boolean)
					If (Success) Then
						vTipoTab = 1
						Activity.Finish
						Sleep(0)
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					End If
				Else
					vTipoTab = 1
					Activity.Finish
					Sleep(0)					
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
	Button22.Text=""
	Button22.Visible=False
	If(vTrasmesso=1) Then
		Activity.Finish
	Else
		If(ListaDocTablet.vOperazione="NuovoDoc")  Then
			RegistraCorsia("CAS",vNumDocNew,vEsercizioNew,vDataDocNew,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,4)
		Else
			RegistraCorsia("CAS",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,4)
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
		RegistraCorsia("CAS",vNumDocNew,vEsercizioNew,vDataDocNew,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,2)
	Else
		RegistraCorsia("CAS",ListaDocTablet.vNumerodoc,ListaDocTablet.vEsercizio,ListaDocTablet.vDataDoc,vCodCliFor,0,vRifIdTesta,"",False,ListaDocTablet.vOperazione,vCorsia,2)
	End If
End Sub

private Sub ListaRigheTablet(TipoDoc As String, NumDoc As Int, Esercizio As Int)
	Sleep(0) 'this is required as the table layout is not immediately created.'	
	B4XTable1.SearchVisible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update
	If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
		'-----------------------------------
		' Tablet
		'-----------------------------------
		B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(14)
		B4XTable1.LabelsFont = xui.CreateDefaultFont(20)
		B4XTable1.MaximumRowsPerPage = 15
		B4XTable1.RowHeight = DipToCurrent(Main.AltRiga)
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			' Posizione (c0)
		Col1_Column.Width=75dip
		Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_TEXT) 					' Tipo Riga (c1)
		Col2_Column.Width=1
		Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo (c2)
		Col3_Column.Width=130dip ' 85dip
		Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione (c3)
		Col4_Column.Width=0 ' 690dip  per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
		Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Ordinato", B4XTable1.COLUMN_TYPE_TEXT)			' Ordinato + UM Ordinato (c4)
		Col5_Column.Width=-1 ' 100dip ' TEXT
		Dim Col6_Column As B4XTableColumn =  B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM1 Ordinato (c5)
		Col6_Column.Width=60dip ' 50 1 TEXT
		Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Qta1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acquisito UM1 (c6)
		Col7_Column.Width=130dip ' 100dip TEXT
		Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2 (c7)
		Col8_Column.Width=-1 ' 50dip ' 1 '140 TEXT
		Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Qta2", B4XTable1.COLUMN_TYPE_NUMBERS)		     	' Acquisito UM2 (c8)
		Col9_Column.Width=-1 ' 90dip '140 TEXT
		Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3 (c9)
		Col10_Column.Width=-1 ' 50dip ' 1  TEXT
		Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Qta3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acq. UM3 | Peso Kg (c10)	
		Col11_Column.Width=-1 ' 90dip ' TEXT 95dip
		Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Corsia", B4XTable1.COLUMN_TYPE_TEXT)				' Corsia (c11)
		Col12_Column.Width=1  ' 80dip ' TEXT 40dip
		Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Ubicazione",B4XTable1.COLUMN_TYPE_TEXT)			' Ubicazione (c12)
		Col13_Column.Width=-1  ' 150dip ' TEXT per SAMSUNG NESTI = 86dip, per HUAWEI = 90dip
		Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c13)
		Col14_Column.Width=-1 ' 50dip 
		Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("Ord.", B4XTable1.COLUMN_TYPE_NUMBERS)				' priorità ordinamneto variabile (c14)
		Col15_Column.Width=-1 '80dip  1
		Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdriga", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIDriga (c15)
		Col16_Column.Width=-1 ' 100dip  1
		Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("UMB", B4XTable1.COLUMN_TYPE_TEXT)	    			' UMB	 (c16)
		Col17_Column.Width=-1 ' 100dip  1
		Dim Col18_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMB", B4XTable1.COLUMN_TYPE_NUMBERS)		' QtaTotUMB	(c17)
		Col18_Column.Width=-1 ' 100dip  1
		Dim Col19_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c18)
		Col19_Column.Width=-1 '  1
		Dim Col20_Column As B4XTableColumn = B4XTable1.AddColumn("Partita1", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 1 (c19)
		Col20_Column.Width=-1 '  140dip  1
		Dim Col21_Column As B4XTableColumn = B4XTable1.AddColumn("QP1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 1 (c20)
		Col21_Column.Width=-1 '  50dip   1		
		Dim Col22_Column As B4XTableColumn = B4XTable1.AddColumn("Partita2", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 2 (c21)
		Col22_Column.Width=-1 '  140dip  1
		Dim Col23_Column As B4XTableColumn = B4XTable1.AddColumn("QP2", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 2 (c22)
		Col23_Column.Width=-1 '  50dip   1	
		Dim Col24_Column As B4XTableColumn = B4XTable1.AddColumn("Partita3", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 3 (c23)
		Col24_Column.Width=-1 '  140dip  1
		Dim Col25_Column As B4XTableColumn = B4XTable1.AddColumn("QP3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 3 (c24)
		Col25_Column.Width=1 '  50dip   1
		Dim Col26_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdTesta", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIdTesta (c25)
		Col26_Column.Width=-1 ' 90dip   1
		Dim Col27_Column As B4XTableColumn = B4XTable1.AddColumn("DispUMBase", B4XTable1.COLUMN_TYPE_NUMBERS)		' DispUMBase (c26)
		Col27_Column.Width=-1 ' 90dip   1
		Dim Col28_Column As B4XTableColumn = B4XTable1.AddColumn("PrezzoUn", B4XTable1.COLUMN_TYPE_NUMBERS)			' PrezzoUn (c27)
		Col28_Column.Width=-1 ' 90dip '  1
		Dim Col29_Column As B4XTableColumn = B4XTable1.AddColumn("UMPrezzo", B4XTable1.COLUMN_TYPE_TEXT)			' UMPrezzo (c28)
		Col29_Column.Width=-1 ' 50dip '  1
		Dim Col30_Column As B4XTableColumn = B4XTable1.AddColumn("Tot. Riga", B4XTable1.COLUMN_TYPE_NUMBERS)		' TotaleRiga (c29)
		Col30_Column.Width=100dip '  1
		Dim Col31_Column As B4XTableColumn = B4XTable1.AddColumn("PesoReale", B4XTable1.COLUMN_TYPE_NUMBERS)		' PesoReale (c30)
		Col31_Column.Width=-1
		Dim Col32_Column As B4XTableColumn = B4XTable1.AddColumn("PesoReale2", B4XTable1.COLUMN_TYPE_NUMBERS)		' PesoReale2 (c31)		
		Col32_Column.Width=-1
		Dim Col33_Column As B4XTableColumn = B4XTable1.AddColumn("Qta1_UM2", B4XTable1.COLUMN_TYPE_NUMBERS)			' Qta1_UM2 (c31)
		Col33_Column.Width=-1 '  -1
		Dim Col34_Column As B4XTableColumn = B4XTable1.AddColumn("Qta2_UM2", B4XTable1.COLUMN_TYPE_NUMBERS)			' Qta2_UM2 (c32)
		Col34_Column.Width=-1
	Else
		'-----------------------------------
		' Palmare
		'-----------------------------------
		B4XTable1.mBase.Visible=True
		B4XTable1.HeaderFont = xui.CreateDefaultBoldFont(12)
		B4XTable1.LabelsFont = xui.CreateDefaultFont(12)
		B4XTable1.MaximumRowsPerPage = 10
		B4XTable1.RowHeight = 40dip
		B4XTable1.mBase.Height=400dip
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		Label1.Width=62%x		
		Button6.Text="CONCLUDI SPESA"
		Label1.Height=80dip
		Label1.TextSize=7dip
		Label1.Color=Colors.LightGray
		Label2.Top=85dip
		Label2.Width=120dip
		Label15.Visible=False
		Label16.Visible=False
		Label15.Top=75dip
		Label16.Top=75dip		
		Button11.Visible=False  ' Freccia Su e Giu		
		Button8.Width=65dip
		Button8.TextColor=Colors.Red
		Button8.Left=100%x-Button8.Width		
		Label6.Left=Label1.Left+Label1.Width+2dip
		Label6.Width=65dip
		EditText1.Left=80dip
		EditText1.Top=75dip
		EditText1.Width=75%x
		EditText1.textColor=Colors.Yellow
		EditText1.TextSize=20
		Label33.Visible=True
		Label34.Visible=True
		Label33.Width=Label6.Width+Button8.Width+2dip
		Label33.Left=Label1.Width+5dip
		Label33.Height=24dip
		Label33.TextSize=8dip
		Label33.Top=Label6.Height
		Label34.Width=Label33.Width
		Label34.Left=Label33.Left					
		Label34.Top=50dip
		Label34.Height=30dip
		Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Pos.", B4XTable1.COLUMN_TYPE_NUMBERS) 			' Posizione (c0)
		Col1_Column.Width=35dip
		Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("T", B4XTable1.COLUMN_TYPE_TEXT) 					' Tipo Riga (c1)
		Col2_Column.Width=1
		Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Cod. Art.", B4XTable1.COLUMN_TYPE_TEXT) 			' Cod. Articolo (c2)
		Col3_Column.Width=70dip ' 85dip
		Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione Art.", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione (c3)
		Col4_Column.Width=0 ' 690dip  per SAMSUNG NESTI = 600dip, per HUAWEI = 350dip
		Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Ordinato", B4XTable1.COLUMN_TYPE_TEXT)			' Ordinato + UM Ordinato (c4)
		Col5_Column.Width=-1 ' 100dip ' TEXT
		Dim Col6_Column As B4XTableColumn =  B4XTable1.AddColumn("UM1", B4XTable1.COLUMN_TYPE_TEXT)					' UM1 Ordinato (c5)
		Col6_Column.Width=45dip ' 50 1 TEXT
		Dim Col7_Column As B4XTableColumn = B4XTable1.AddColumn("Qta1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acquisito UM1 (c6)
		Col7_Column.Width=75dip ' 100dip TEXT
		Dim Col8_Column As B4XTableColumn = B4XTable1.AddColumn("UM2", B4XTable1.COLUMN_TYPE_TEXT)					' UM2 (c7)
		Col8_Column.Width=-1 ' 50dip ' 1 '140 TEXT
		Dim Col9_Column As B4XTableColumn = B4XTable1.AddColumn("Qta2", B4XTable1.COLUMN_TYPE_NUMBERS)		     	' Acquisito UM2 (c8)
		Col9_Column.Width=-1 ' 90dip '140 TEXT
		Dim Col10_Column As B4XTableColumn = B4XTable1.AddColumn("UM3", B4XTable1.COLUMN_TYPE_TEXT)					' UM3 (c9)
		Col10_Column.Width=-1 ' 50dip ' 1  TEXT
		Dim Col11_Column As B4XTableColumn = B4XTable1.AddColumn("Qta3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Acq. UM3 | Peso Kg (c10)
		Col11_Column.Width=-1 ' 90dip ' TEXT 95dip
		Dim Col12_Column As B4XTableColumn = B4XTable1.AddColumn("Corsia", B4XTable1.COLUMN_TYPE_TEXT)				' Corsia (c11)
		Col12_Column.Width=1  ' 80dip ' TEXT 40dip
		Dim Col13_Column As B4XTableColumn = B4XTable1.AddColumn("Ubicazione",B4XTable1.COLUMN_TYPE_TEXT)			' Ubicazione (c12)
		Col13_Column.Width=-1  ' 150dip ' TEXT per SAMSUNG NESTI = 86dip, per HUAWEI = 90dip
		Dim Col14_Column As B4XTableColumn = B4XTable1.AddColumn("Status", B4XTable1.COLUMN_TYPE_TEXT)			    ' status x il colore (c13)
		Col14_Column.Width=-1 ' 50dip
		Dim Col15_Column As B4XTableColumn = B4XTable1.AddColumn("Ord.", B4XTable1.COLUMN_TYPE_NUMBERS)				' priorità ordinamneto variabile (c14)
		Col15_Column.Width=-1 '80dip  1
		Dim Col16_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdriga", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIDriga (c15)
		Col16_Column.Width=-1 ' 100dip  1
		Dim Col17_Column As B4XTableColumn = B4XTable1.AddColumn("UMB", B4XTable1.COLUMN_TYPE_TEXT)	    			' UMB	 (c16)
		Col17_Column.Width=-1 ' 100dip  1
		Dim Col18_Column As B4XTableColumn = B4XTable1.AddColumn("QtaTotUMB", B4XTable1.COLUMN_TYPE_NUMBERS)		' QtaTotUMB	(c17)
		Col18_Column.Width=-1 ' 100dip  1
		Dim Col19_Column As B4XTableColumn = B4XTable1.AddColumn("CoeffConvUMA", B4XTable1.COLUMN_TYPE_NUMBERS)		' CoeffConvUMA (c18)
		Col19_Column.Width=-1 '  1
		Dim Col20_Column As B4XTableColumn = B4XTable1.AddColumn("Partita1", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 1 (c19)
		Col20_Column.Width=140 '  140dip  1
		Dim Col21_Column As B4XTableColumn = B4XTable1.AddColumn("QP1", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 1 (c20)
		Col21_Column.Width=40dip ' -1 '  50dip   1
		Dim Col22_Column As B4XTableColumn = B4XTable1.AddColumn("Partita2", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 2 (c21)
		Col22_Column.Width=140 '  140dip  1
		Dim Col23_Column As B4XTableColumn = B4XTable1.AddColumn("QP2", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 2 (c22)
		Col23_Column.Width=40dip '  50dip   1
		Dim Col24_Column As B4XTableColumn = B4XTable1.AddColumn("Partita3", B4XTable1.COLUMN_TYPE_TEXT)			' Partita 3 (c23)
		Col24_Column.Width=-1 '  140dip  1
		Dim Col25_Column As B4XTableColumn = B4XTable1.AddColumn("QP3", B4XTable1.COLUMN_TYPE_NUMBERS)				' Qta Partita 3 (c24)
		Col25_Column.Width=1 '  50dip   1
		Dim Col26_Column As B4XTableColumn = B4XTable1.AddColumn("RifIdTesta", B4XTable1.COLUMN_TYPE_NUMBERS)		' RifIdTesta (c25)
		Col26_Column.Width=-1 ' 90dip   1
		Dim Col27_Column As B4XTableColumn = B4XTable1.AddColumn("DispUMBase", B4XTable1.COLUMN_TYPE_NUMBERS)		' DispUMBase (c26)
		Col27_Column.Width=-1 ' 90dip   1
		Dim Col28_Column As B4XTableColumn = B4XTable1.AddColumn("PrezzoUn", B4XTable1.COLUMN_TYPE_NUMBERS)			' PrezzoUn (c27)
		Col28_Column.Width=-1 ' 60dip '  1
		Dim Col29_Column As B4XTableColumn = B4XTable1.AddColumn("UMPrezzo", B4XTable1.COLUMN_TYPE_TEXT)			' UMPrezzo (c28)
		Col29_Column.Width=-1 ' 1 ' 50dip '  1
		Dim Col30_Column As B4XTableColumn = B4XTable1.AddColumn("Tot. Riga", B4XTable1.COLUMN_TYPE_NUMBERS)		' TotaleRiga (c29)
		Col30_Column.Width=75dip ' -1 ' 60dip 
		Dim Col31_Column As B4XTableColumn = B4XTable1.AddColumn("PesoReale", B4XTable1.COLUMN_TYPE_NUMBERS)		' PesoReale (c30)
		Col31_Column.Width=150dip '  -1
		Dim Col32_Column As B4XTableColumn = B4XTable1.AddColumn("PesoReale2", B4XTable1.COLUMN_TYPE_NUMBERS)		' PesoReale2 (c31)
		Col32_Column.Width=150dip '  -1
		Dim Col33_Column As B4XTableColumn = B4XTable1.AddColumn("Qta1_UM2", B4XTable1.COLUMN_TYPE_NUMBERS)			' Qta1_UM2 (c32)
		Col33_Column.Width=150dip '  -1
		Dim Col34_Column As B4XTableColumn = B4XTable1.AddColumn("Qta2_UM2", B4XTable1.COLUMN_TYPE_NUMBERS)			' Qta2_UM2 (c33)
		Col34_Column.Width=150dip '  -1
	End If
	' ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)	
	' ExtraUtility.CreateCustomFormat(Col7_Column,B4XTable1)
	If(ListaDocTablet.vOperazione="ApriDoc") Then
			Label1.Text=ListaDocTablet.vTitle.Replace(CRLF," - ")
		TipoDocOrig = ""		
		NumDocOrig = 0
		DataDocOrig = ""	
		vTrasmesso = 0
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
			vNRListino = rst.GetInt("NrListino")
		Loop
		rst.Close
		If (vTrasmesso=1) Then
			Button1.Enabled = True
			Button2.Enabled = False
			Button7.Enabled = False
			Label1.Color = Colors.Red
			Button2.Visible=False
			Button1.Text="ESCI DAL DOCUMENTO"
		Else
			Button2.Visible=True
			Button1.Text="CONFERMA CORSIA"
		End If
		If (vRifIdTesta > 0) Then
			Label6.Text = "CAS N. " & vRifIdTesta
		End If		
     	vTipoDocNew = "CAS"
		vNumDocNew = NumDoc
		vEsercizioNew = Esercizio
		Log(sqlstr)
	End If
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		vTrasmesso=0 
	End If
	DataList.Initialize	
	If(ListaDocTablet.vOperazione="NuovoDoc") Then
		vTipoDocNew ="CAS"
		sqlstr = "SELECT * FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & vTipoDocNew
		sqlstr = sqlstr & "' AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
	Else
		sqlstr = "SELECT * FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc
		sqlstr = sqlstr & "' AND Numerodoc = '" & NumDoc  & "' AND Esercizio = '" & Esercizio & "'"
	End If
	Log(sqlstr)			
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	Do While rs.NextRow
		Dim rowx(34) As Object
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
		rowx(4) = rs.GetString("Ordinato") 										' Ordinato (UM + Qta)
		rowx(5) = rs.GetString("UM")											' UM1 (Acquistato)
		If(rs.Getint("Qta")>0) Then
			rowx(6) = rs.GetDouble("Qta")											' Acquisito + UMGest
		Else
			rowx(6) = 0
		End If
		rowx(7) = rs.GetString("UM2")											' UM2
		If(rs.GetInt("Qta2")>0) Then
			rowx(8) = rs.GetDouble("Qta2")										' Acquisito UM2
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
		rowx(16) = rs.GetString ("UMBase")     									' UMB
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
		rowx(27) = rs.GetDouble ("PrezzoUn")									' PrezzoUn
		rowx(28) = rs.GetString ("UMPrezzo")									' UMPrezzo
		rowx(29) = rs.GetDouble ("TotaleRiga")									' Totale Riga
		rowx(30) = rs.GetDouble ("PesoReale")								    ' TotPesoReale
		rowx(31) = rs.GetDouble ("PesoReale2")								    ' TotPesoReale2
		rowx(32) = rs.GetDouble ("Qta1_UM2")								    ' Qta1_UM2
		rowx(33) = rs.GetDouble ("Qta2_UM2")								    ' Qta2_UM2
		vCorsia = rowx(11)
		DataList.Add(rowx)		
	Loop	
	rs.Close
	vCorsiaOld=vCorsia	
	Button8.Text=vCorsia
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)	
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	'-----------------------------------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-----------------------------------------------------------------------------------------------------------------
	Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	Dim total As Double = 0
	Dim rs2 As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
	Do While rs2.NextRow
		total = total + rs2.GetDouble("c29")
	Loop
	rs2.Close
	Label34.Text = ExtraUtility.Formato_2dec_ITA_Num(total)
	'-------------------------------------------------------------------------------------------------------------------
	EditText1.RequestFocus		
'	If(ListaDocTablet.vOperazione="ApriDoc") Then			
'		Visulizza_Corsie
'	End If
End Sub

private Sub ListaRigheTablet2(FirstTime As Boolean, IDtesta As Long, Stato As Int)
	Try
		' ---------------------
		' Visualizza Corsie
		' ---------------------			
		Sleep(0) 'this is required as the table layout is not immediately created.'	
		If(FirstTime) Then
			XSelections2.Initialize(B4XTable2)
			XSelections2.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)
			B4XTable2.SearchVisible=False
			' B4XTable2.pnlHeader.Visible=True			
			If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then			
				' TABLET
				B4XTable2.RowHeight = 50dip
				B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
				SelectedRows2 = B4XCollections.CreateSet			
				Dim Col1x_Column As B4XTableColumn =  B4XTable2.AddColumn("Corsia", B4XTable2.COLUMN_TYPE_TEXT) 				' Corsia
				Col1x_Column.Width=108dip			
				Dim Col2x_Column As B4XTableColumn =  B4XTable2.AddColumn("T", B4XTable2.COLUMN_TYPE_TEXT) 						' TipoCorsia
				Col2x_Column.Width=40dip			
				Dim Col3x_Column As B4XTableColumn =  B4XTable2.AddColumn("Utente", B4XTable2.COLUMN_TYPE_TEXT) 				' Utente
				Col3x_Column.Width=0dip
				'Dim Col3x_Column As B4XTableColumn =  B4XTable2.AddColumn("Occupata", B4XTable2.COLUMN_TYPE_NUMBERS) 	        ' Occupata
				'Col3x_Column.Width=25dip ' 85dip
				SemaphoreColumn = B4XTable2.AddColumn("Stato",B4XTable2.COLUMN_TYPE_TEXT)
				SemaphoreColumn.Width = 175dip
				SemaphoreColumn.Searchable = False
				SemaphoreColumn.Sortable = True
				B4XTable2.BuildLayoutsCache(15)
			Else
				' PALMARE
				Panel2.Left=0
				Panel2.Top=0
				Panel2.Width=100%x
				Panel2.Height=100%y
				Label5.Width=100%x
				B4XTable2.mbase.Left=5dip
				B4XTable2.mBase.WIdth=Panel2.Width-10dip
				B4XTable2.mBase.Height=80%y
				B4XTable2.RowHeight = 40dip
				Button17.Left=100%x-Button17.Width-5dip
				Button5.Left=(100%x-Button5.Width)/2
				Button17.Top=B4XTable2.mBase.Height+Button17.Height-5dip
				Button5.Top=Button17.top
				Button18.Top=Button17.top
				B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
				SelectedRows2 = B4XCollections.CreateSet
				Dim Col1x_Column As B4XTableColumn =  B4XTable2.AddColumn("Corsia", B4XTable2.COLUMN_TYPE_TEXT) 				' Corsia
				Col1x_Column.Width=75dip
				Dim Col2x_Column As B4XTableColumn =  B4XTable2.AddColumn("T", B4XTable2.COLUMN_TYPE_TEXT) 						' TipoCorsia
				Col2x_Column.Width=-1
				Dim Col3x_Column As B4XTableColumn =  B4XTable2.AddColumn("Utente", B4XTable2.COLUMN_TYPE_TEXT) 				' Utente
				Col3x_Column.Width=0dip
				'Dim Col3x_Column As B4XTableColumn =  B4XTable2.AddColumn("Occupata", B4XTable2.COLUMN_TYPE_NUMBERS) 	        ' Occupata
				'Col3x_Column.Width=25dip ' 85dip
				SemaphoreColumn = B4XTable2.AddColumn("Stato",B4XTable2.COLUMN_TYPE_TEXT)
				SemaphoreColumn.Width = 130dip
				SemaphoreColumn.Searchable = False
				SemaphoreColumn.Sortable = True
				B4XTable2.BuildLayoutsCache(15)
			End If
			For i=1 To SemaphoreColumn.CellsLayouts.Size-1
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
				' colonna 3 Utente
				Dim pnl3 As B4XView = Col3x_Column.CellsLayouts.Get(i)
				Dim lbl3 As Label = pnl3.GetView(0)
				If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
					lbl3.TextSize = 20
					lbl3.Typeface = Typeface.DEFAULT_BOLD
					lbl3.TextColor = Colors.Black
					lbl3.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				Else
					lbl3.TextSize = 14
					lbl3.Typeface = Typeface.DEFAULT_BOLD
					lbl3.TextColor = Colors.red
					lbl3.Padding = Array As Int (10dip, 5dip, 5dip, 5dip)
				End If
				' colonna 4
				Dim pnl4 As B4XView = SemaphoreColumn.CellsLayouts.Get(i)
				Dim lbl4 As Label = pnl4.GetView(0)
				lbl4.TextSize = 20
				lbl4.Typeface = Typeface.DEFAULT_BOLD
				lbl4.TextColor = Colors.Black
				lbl4.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
				Dim iv As ImageView			
				iv.Initialize("")
				pnl4.AddView(iv,5dip,5dip,SemaphoreColumn.Width - 10dip, B4XTable2.RowHeight-10dip)
			Next
			B4XTable2.Refresh
		End If	
		If(IDtesta<>0) Then
			Dim Tbs(1) As String
			Tbs(0)="IS_SEMAFOROCORSIE"
			wait for (Leggi_Metodo_Tabelle(Tbs,"","")) complete (Success As Boolean)
			If (Success) Then
				wait for (Update_IS_SEMAFOROCORSIE_LOCAL(IDtesta)) complete (Success As Boolean)
				If (Success=True) Then
					' LETTURA IS_SEMAFOROCORSIE SUL SERVER
					Dim DataList2 As List
					DataList2.Initialize
					sqlstr = "SELECT CORSIA,TIPOCORSIA,UTENTE,STATOCORSIA,IDTESTA FROM Vista_IS_SEMAFOROCORSIE WHERE IDTESTA = " _
					& IDtesta & " ORDER BY CORSIA"
					Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)										
					If(rst.RowCount>0) Then
						Do While rst.NextRow
							Dim rowx(4) As Object
							rowx(0) = rst.GetString("CORSIA")					' CORSIA
							rowx(1) = rst.GetString("TIPOCORSIA")				' TIPOCORSIA								
							If (rst.Getstring("UTENTE")=Main.Utente) Then
								rowx(2) = ""
								If( rst.Getint("STATOCORSIA")=3) Then
									rowx(3) = 4
								Else
									rowx(3) = rst.Getint("STATOCORSIA")				' STATOCORSIA
								End If
								If( rst.GetString("STATOCORSIA")=vCorsia) And (Stato<>0) Then
									rowx(3) = Stato
								End If
							Else									
								rowx(2) = rst.GetString("UTENTE")			  	' UTENTE
								rowx(3) = rst.Getint("STATOCORSIA")  		    ' STATOCORSIA
							End If								
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
					Else
						MsgboxAsync("ERRORE IDTESTA " & IDtesta,"ERRORE SEMAFOROCORSIE")
					End If
				End If
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
			' LETTURA VISTA_DISPONIBILITA_CORSIA LOCAL
			sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM " _
			& "VISTA_DISPONIBILITA_CORSIA WHERE GIACENZA1>0 AND GIACENZA2>0 AND CODDEPOSITO ='" &  corsia & "'"		
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
			Log(sqlstr)
			Result.GiacenzaUM1=GiacenzaUMG1
			Result.GiacenzaUM2=GiacenzaUMG2
			Result.UM1=UMG1
			Result.UM2=UMG2
			Button11.Enabled=True
			'Button12.Enabled=True
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

Sub Leggi_DisponibilitaArticoloServer_OLD(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try
		Dim Tbs(1) As String
		Dim Result As PartiteQtaType
		Tbs(0)="VISTA_DISPONIBILITA_ARTICOLO"
		wait for (Leggi_Metodo_Tabelle(Tbs,articolo,coddeposito)) complete (Success As Boolean)
		If (Success) Then
			' LETTURA IS_VISTA_GIACENZA_ARTICOLO LOCAL
			sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_DISPONIBILITA_ARTICOLO WHERE " _
			& "GIACENZA1>0 AND GIACENZA2>0 CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
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
		Else
			MsgboxAsync("ERRORE LETTURA_METODO","ERRORE")
			Return Null
		End If
	Catch
		Return Null
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_Somma_PesoReale_Articolo(idtesta As Long, articolo As String, QtaP1_UM1 As Double, QtaP2_UM1 As Double, npartita As Int) As Double
	Try
		sqlstr = "SELECT PESOREALE FROM IS_ARTICOLI_PESOREALE_CASH WHERE idtesta = ? AND CODART = ? AND IFNULL(DA_CANC,0)=0 ORDER BY POS ASC"
		Dim rst As ResultSet = SQLDataAccess.ExecQuery2(sqlstr, Array As String(idtesta, articolo))		
		If(rst.RowCount>0) Then
			Dim k As Int = 0
			Dim PesoTotaleArt As Double = 0
			Dim PesoTotaleArtP1 As Double = 0
			Dim PesoTotaleArtP2 As Double = 0
			Do While rst.NextRow
				k = k + 1
				If (k <= QtaP1_UM1) Then
					PesoTotaleArtP1 = PesoTotaleArtP1 + rst.GetDouble("PESOREALE")
				Else
					PesoTotaleArtP2 = PesoTotaleArtP2 + rst.GetDouble("PESOREALE")
				End If
			Loop
			Select npartita
				Case 1
					PesoTotaleArt = PesoTotaleArtP1
				Case 2
					PesoTotaleArt = PesoTotaleArtP2
			End Select
			Return PesoTotaleArt
		Else
			Return 0
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

Sub Leggi_DisponibilitaArticoloLocal(articolo As String, coddeposito As String, Qta As Double) As ResumableSub
	Try 
		Dim Result As PartiteQtaType
		' LETTURA IS_VISTA_DISPONIBILITA_ARTICOLO LOCAL
		sqlstr = "SELECT NRIFPARTITA,GIACENZA1,UM1,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA FROM VISTA_DISPONIBILITA_CORSIA WHERE GIACENZA1>0 AND " _
				& "GIACENZA2>0 AND CODART ='" & articolo & "' AND CODDEPOSITO ='" &  coddeposito & "' ORDER BY LOTTO ASC"	
		Log (sqlstr)
		Dim GiacenzaUMG1 As Double = 0
		Dim GiacenzaUMG2 As Double = 0
		Dim UMG1 As String = ""
		Dim UMG2 As String = ""
		Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If(rst.RowCount>0) And (Qta>0) Then				
			Dim QtaRes As Double = Qta
			Dim np As Int = 0
			If(ArticoloPartite_OLD.IsInitialized=False) Then
				ArticoloPartite_OLD.Initialize
			End If
			If(ArticoloPartite_OLD.Partita1<>"") And (ArticoloPartite_OLD.Partita2="") Then
				Result.Partita1 = ArticoloPartite_OLD.Partita1
				Result.Qta1 = ArticoloPartite_OLD.Qta1
				Result.Qta1_UM2 = ArticoloPartite_OLD.Qta1_UM2
				Result.PesoReale1 = ArticoloPartite_OLD.PesoReale1
				Result.UM1=ArticoloPartite_OLD.UM1
				Result.UM2=ArticoloPartite_OLD.UM2				
				np = 0				
			End If			
			If(ArticoloPartite_OLD.Partita1<>"") And (ArticoloPartite_OLD.Partita2<>"") Then
				Result.Partita1 = ArticoloPartite_OLD.Partita1				
				Result.Qta1 = ArticoloPartite_OLD.Qta1
				Result.Qta1_UM2 = ArticoloPartite_OLD.Qta1_UM2
				Result.PesoReale1 = ArticoloPartite_OLD.PesoReale1
				Result.Qta2 = ArticoloPartite_OLD.Qta2
				Result.Qta2_UM2 = ArticoloPartite_OLD.Qta2_UM2
				Result.PesoReale2 = ArticoloPartite_OLD.PesoReale2
				Result.UM1=ArticoloPartite_OLD.UM1
				Result.UM2=ArticoloPartite_OLD.UM2
				np = 1
			End If
			If(Qta>0) Then			
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
					If(Result.Partita1<>Null) Then						
						If(np=1) And (Result.Partita1<>rowx(0)) Then
							np=np+1
						End If
					End If
					Dim FC As Double = Leggi_FattoreCVB(SQLDataAccess,articolo,UMG1)
					If(FC=0) Then
						FC=1
					End If
					If(QtaRes>0) Then						
						Select np							
							Case 1				' Partita 1
								If(ArticoloPartite_OLD.Partita1<>Null) Then
									If(ArticoloPartite_OLD.Partita1<>"") Then
										Result.Partita1 = ArticoloPartite_OLD.Partita1
									Else
										Result.Partita1 = rowx(0)
									End If
								Else
									Result.Partita1 = rowx(0)
								End If
								If (rowx(1)>QtaRes) Then
									Result.Qta1 = Result.Qta1+QtaRes
									Result.Qta1_UM2	= Round2(Result.Qta1/FC,3)
									Result.PesoReale1 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,0,1)
									QtaRes=0									
								Else
									Result.Qta1 = Result.Qta1+rowx(1)
									Result.Qta1_UM2	= Round2(Result.Qta1/FC,3)
									Result.PesoReale1 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,0,1)
									QtaRes = QtaRes - rowx(1)														
								End If

							Case 2				' Partita 2
								If(ArticoloPartite_OLD.Partita2<>Null) Then
									If(ArticoloPartite_OLD.Partita2<>"") Then
										Result.Partita2 = ArticoloPartite_OLD.Partita2
									Else
										Result.Partita2 = rowx(0)
									End If
								Else
									Result.Partita2 = rowx(0)
								End If
								If (rowx(1)>QtaRes) Then
									Result.Qta2 = Result.Qta2+QtaRes
									Result.Qta2_UM2	= Round2(Result.Qta2/FC,3)
									Result.PesoReale2 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,Result.Qta2_UM2,2)
									QtaRes=0
								Else
									Result.Qta2 = Result.Qta2+rowx(1)
									Result.Qta2_UM2	= Round2(Result.Qta2/FC,3)
									Result.PesoReale2 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,Result.Qta2_UM2,2)
									QtaRes = QtaRes - rowx(1)
								End If
								
'							Case 3				' Partita 3
'								If (rowx(1)>QtaRes) Then
'									Result.Partita3 = rowx(0)
'									Result.Qta3 = Result.Qta3+QtaRes
'									Result.Qta3_UM2	= Round2(Result.Qta3/FC,3)
'									Result.PesoReale3 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,Result.Qta2_UM2,3)
'									QtaRes=0
'								Else
'									Result.Partita3 = rowx(0)
'									Result.Qta3 = Result.Qta3+rowx(1)
'									Result.Qta3_UM2	= Round2(Result.Qta3/FC,3)
'									Result.PesoReale3 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,Result.Qta2_UM2,3)
'									QtaRes = QtaRes - rowx(1)
'								End If
								
						End Select
					End If
				Loop
				rst.Close
			End If			
			Log(sqlstr)
			Result.GiacenzaUM1=GiacenzaUMG1
			Result.GiacenzaUM2=GiacenzaUMG2
			Result.UM1=UMG1
			Result.UM2=UMG2
			Return Result				
		Else
			If(Qta<0) Then				
				Dim FC As Double = Leggi_FattoreCVB(SQLDataAccess,articolo,ArticoloPartite_OLD.UM1)
				If(FC=0) Then
					FC=1
				End If				
				If(ArticoloPartite_OLD.Partita1<>"") And (ArticoloPartite_OLD.Partita2="") Then
					Result.Partita1 = ArticoloPartite_OLD.Partita1
					Result.Qta1 = ArticoloPartite_OLD.Qta1+Qta									
					Result.Qta1_UM2	= Round2(Result.Qta1/FC,3)					
					Result.PesoReale1 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,0,1)
					Result.UM1=ArticoloPartite_OLD.UM1
					Result.UM2=ArticoloPartite_OLD.UM2
					np = 0
				End If
				If(ArticoloPartite_OLD.Partita1<>"") And (ArticoloPartite_OLD.Partita2<>"") Then
					Result.Partita1 = ArticoloPartite_OLD.Partita1
					Result.Qta1 = ArticoloPartite_OLD.Qta1
					Result.Qta1_UM2 = ArticoloPartite_OLD.Qta1_UM2
					Result.PesoReale1 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,0,1)
					Result.Qta2 = ArticoloPartite_OLD.Qta2+Qta
					Result.Qta2_UM2	= Round2(Result.Qta2/FC,3)									
					Result.PesoReale2 = Leggi_Somma_PesoReale_Articolo(vRifIdTesta, articolo, Result.Qta1_UM2,Result.Qta2_UM2,2)
					Result.UM1=ArticoloPartite_OLD.UM1
					Result.UM2=ArticoloPartite_OLD.UM2
					np = 1
				End If			
				Return Result
			Else
				If(Qta<>0) Then
					Button10.Enabled=False
					MsgboxAsync("NESSUN LOTTO TROVATO PER QUESTO ARTICOLO '" & articolo & "'","ERRORE")
					Return Null			
				Else
					Return Null	
				End If
			End If
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
		Return Null
	End Try
End Sub

private Sub ListaRigheTablet3(FirstTime As Boolean) As ResumableSub
	'------------------------------
	' Visualizza tutti i clienti
	'------------------------------
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'	
		If(FirstTime) Then
			Panel4.Visible=False
			XSelections3.Initialize(B4XTable3)
			XSelections3.Mode = 3 ' 5 = MODE_MULTIPLE_LINES (vedi B4XTableSelections)
			If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
					' Versione Tablet
					B4XTable3.RowHeight = 35dip
					B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
					SelectedRows3 = B4XCollections.CreateSet
					Dim Col1x_Column As B4XTableColumn =  B4XTable3.AddColumn("Cod. Cli.", B4XTable3.COLUMN_TYPE_TEXT) 				' Cod. Cliente
					Col1x_Column.Width=120dip
					Dim Col2x_Column As B4XTableColumn =  B4XTable3.AddColumn("Rag. Soc.", B4XTable3.COLUMN_TYPE_TEXT) 				' Ragione Sociale
					Col2x_Column.Width=0  ' 800
					Dim Col3x_Column As B4XTableColumn =  B4XTable3.AddColumn("Listino", B4XTable3.COLUMN_TYPE_NUMBERS) 			' Listino
					Col3x_Column.Width=100 ' 800
			Else
					' Versione Palmare
					Panel4.Left=0
					Panel4.Top=0
					Panel4.Width=100%x
					Panel4.Height=100%y
					B4XTable3.mBase.Left=5dip
					B4XTable3.mBase.Width=Panel4.Width-10dip
					B4XTable3.RowHeight = 30dip
					B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
					SelectedRows3 = B4XCollections.CreateSet
					Dim Col1x_Column As B4XTableColumn =  B4XTable3.AddColumn("Cod. Cli.", B4XTable3.COLUMN_TYPE_TEXT) 				' Cod. Cliente
					Col1x_Column.Width=70dip
					Dim Col2x_Column As B4XTableColumn =  B4XTable3.AddColumn("Rag. Soc.", B4XTable3.COLUMN_TYPE_TEXT) 				' Ragione Sociale
					Col2x_Column.Width=0  ' 800
					Dim Col3x_Column As B4XTableColumn =  B4XTable3.AddColumn("Listino", B4XTable3.COLUMN_TYPE_NUMBERS) 			' Listino
					Col3x_Column.Width=-1 ' 800			
					Button19.Left=Panel4.Width-Button19.Width
					Button20.Left=Panel4.Width-(Button19.Width+Button20.Width+10dip)
					Button19.Top=Panel4.Height-Button19.Height
					Button20.Top=Panel4.Height-Button20.Height
					 '  panel4.bo
			End If				
			B4XTable3.BuildLayoutsCache(15)
			B4XTable3.Refresh
			Return(True)
		Else
			XSelections3.Clear
			SelectedRows3.Clear
			B4XTable3.SearchField.Text=""
			Dim DataList3 As List
			DataList3.Initialize
			Dim sqlstr2 As String = "SELECT CODCLIFOR, DSCCONTO1 AS RAGSOC, LISTINO FROM IS_ANAGRAFICACF WHERE TIPOCONTO='C' ORDER BY RAGSOC"							
			Log(sqlstr2)		
			Dim rst As ResultSet = SQLDataAccess.ExecQuery(sqlstr2)
			If(rst.RowCount>0) Then
				Do While rst.NextRow
					Dim rowx(3) As Object
					rowx(0) = rst.GetString("CODCLIFOR")		' CODCLIFOR
					rowx(1) = rst.GetString("RAGSOC")		  	' RAGSOC
					rowx(2) = rst.GetString("LISTINO")		  	' LISTINO
					DataList3.Add(rowx)
					' Log(rowx(0) & " - " & rowx(1))
				Loop
				rst.Close
				B4XTable3.MaximumRowsPerPage = 15
				B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
				B4XTable3.SetData(DataList3)
				'-------------------------------------------------------------------------------------
				' serve per fare la somma delle righe
				'-------------------------------------------------------------------------------------
'				Dim o() As Object = B4XTable3.BuildQuery(False) 'no page limit
'				Dim total As Double = 0
'				Dim rs As ResultSet = B4XTable3.sql1.ExecQuery2(o(0), o(1))
'				Dim totalriga As Double = 0
'				Do While rs.NextRow
'					totalriga = Round(rs.GetDouble("c2")) 'c2 = Qta
'					total = total + totalriga
'				Loop
'				rs.Close
'				Label43.Text = ExtraUtility.NumberFormat_ITA(total,1,0)
'				TotQtaUMVClientiAssegnati=total				
				'-------------------------------------------------------------------------------------					
				Col2x_Column.InternalSortMode="ASC"
				Col2x_Column.Sortable = True
				Log(sqlstr)			
			End If
			B4XTable3.Refresh
			Return(True)
		End If

	Catch
		Log(LastException.Message) 'no changes will be made
		Return(False)
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
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare" & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
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
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
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

Sub RegistraCorsia(TipoDoc As String,NumDoc As Int, Esercizio As  Int, DataDoc As String, CodCliFor As String, Stp_Etich As Int, RifIDTesta As Long, NumRifDoc As String, Sync As Boolean, Operazione As String, Corsia As String, Stato As Int)
	Try
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		If (CodCliFor.Trim="") Then
			' codice fittizio del NESTI e BONSIGNORI
			CodCliFor="C 91012"
		End If
		vCorsiaOld=vCorsia
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
			sqlstr = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND rifidtesta='" & RifIDTesta & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
			'sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = " & RifIDTesta
			'SQLDataAccess.ExecNonQuery(sqlstr)			
		End If
		B4XTable1.Refresh
		' --------------------------------------------------------------
		' Ricerca le partirte a zero dei prodotti eliminati dalla lista 
		' --------------------------------------------------------------
		Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "yyyyMMdd","en","")
		Dim routine As String ="exec_agg_implottopalm_cash"
		Dim	codart As String
		Dim Part1 As String		
		Dim Part2 As String
		Dim QtaP1_UMB As Double
		Dim QtaP1_UM2 As Double
		Dim QtaP2_UMB As Double
		Dim QtaP2_UM2 As Double
		Dim QtaP3_UMB As Double
		' Dim QtaP3_UM2 As Double
		Dim res As ResultSet
		res = B4XTable1.sql1.ExecQuery("SELECT * FROM data WHERE c6=0")
		Dim k As Int = 0
		Do While res.NextRow		
			codart = res.GetString("c2")
			'---------------------------
			' Annulla Partita1
			'---------------------------
			Part1 = res.GetString("c19")
			QtaP1_UMB = 0
			QtaP1_UM2 = 0
			If(Part1<>Null) Then
				If(Part1.Trim<>"") And (Part1.Length>5) Then				
					wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part1 , DataOggi, QtaP1_UMB, QtaP1_UM2, Main.Utente, "", Corsia)) complete (Success1 As Boolean)
					If(Success1) Then
						' tutto ok
						Log("Annulla Partita Server partita1A " & Part1)
					Else	
						MsgboxAsync("ERRORE Aggiorna Partita Server " & Part1,"ERRORE")
					End If
				End If
			End If
			'---------------------------
			' Annulla Partita2
			'---------------------------
			Part2 = res.GetString("c21")
			QtaP2_UMB = 0
			QtaP2_UM2 = 0
			If( Part2<>Null) Then
				If(Part2.Trim<>"") And (Part2.Length>5) Then					
					wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part2 , DataOggi, QtaP2_UMB, QtaP2_UM2, Main.Utente, "", Corsia)) complete (Success2 As Boolean)
					If(Success2) Then
						' tutto ok
						Log("Annulla Partita Server partita2 " & Part2)
					Else
						MsgboxAsync("ERRORE Aggiorna Partita Server " & Part2,"ERRORE")
					End If								
				End If
			End If
		Loop		
		' --------------------------------------------------------------
		B4XTable1.sql1.ExecNonQuery("DELETE FROM data WHERE c6=0")
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
		Sleep(0)
		' Log("Table Size " & B4XTable1.Size)
		RowID_Riga = 0
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			' Log("prima "  & rowdata.Get("Cod. Art.") & " - " & rowdata.Get("Corsia"))
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)						
				' Log("dopo "  & rowdata.Get("Cod. Art.") & " - " & rowdata.Get("Corsia"))					
				Dim Ordinato As String = rowdata.Get("Ordinato")
				QtaP1_UMB = rowdata.Get("Qta1")			
				QtaP1_UM2 = rowdata.Get("Qta1_UM2")
				QtaP2_UMB = rowdata.Get("Qta2")
				QtaP2_UM2 = rowdata.Get("Qta2_UM2")
				QtaP3_UMB = rowdata.Get("Qta3")
				' QtaP3_UM1 = rowdata.Get("Qta3_UM1")
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
				Dim PrezzoUnit As Double = rowdata.Get("PrezzoUn")		
				Dim TotRiga As Double = rowdata.Get("Tot. Riga")
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
				Dim PesoReal As Double = rowdata.Get("PesoReale")
				Dim PesoReal2 As Double = rowdata.Get("PesoReale2")
				Dim QtaP1_UM2 As Double = rowdata.Get("Qta1_UM2")
				Dim QtaP2_UM2 As Double = rowdata.Get("Qta2_UM2")
				Dim NrRifPartita As String = ""
				If(QtaP1_UMB>0) Then
					sqlstr  = "INSERT OR REPLACE INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,UM,DataConsegna," _
					 & "RifIdriga,Descrizione,Rifidtesta,TipoRiga,DataScadenza,NrRifPartita,UM2,Qta2,Peso,NumEtichette,Status,Sconto,Note,Ordinato,UM3," _
					 & "QtaTotUMAConv,QtaTotUM2,CoeffConvUMA,Partita1,Partita2,Partita3,QP1,QP2,QP3,Corsia,Ubicazione,CodCliFor,Ordinamento,UMBase,QtaTotUMBase," _
					 & "PrezzoUn,TotaleRiga,PesoReale,PesoReale2,Qta1_UM2,Qta2_UM2) VALUES " _
					 & "('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & RowID_Riga & "','" & Main.Utente & "','" & rowdata.Get("Cod. Art.") & "','" & QtaP1_UMB & "','" _
					 & UM1 & "','" & DataConsegna & "','" & rowdata.Get("RifIdriga") & "','" & rowdata.Get("Descrizione Art.") & "','" & RifIDTesta & "','" & TipoRiga & "','" & DataScadenza & "','" _
					 & NrRifPartita & "','" & UM2 & "','" & QtaP2_UMB & "','" & QtaP3_UMB & "','" & NumEtichette & "','" & Status & "','" & Sconto & "','" & Note & "','" & Ordinato & "','" & UM3 _
					 & "','" & rowdata.Get("QtaTotUMAConv") & "','" & rowdata.Get("QtaTotUM2")  & "','" & rowdata.Get("CoeffConvUMA")  & "','" & Partita1 & "','" _
					 & Partita2 & "','" & Partita3 & "','" & rowdata.Get("QP1") & "','" & rowdata.Get("QP2") & "','" & rowdata.Get("QP3") & "','" & rowdata.Get("Corsia") & "','" _
					 &  rowdata.Get("Ubicazione") & "','" & CodCliFor & "','" & Ordinamento & "','" & UMBase &"','" &  QtaTotUMBase & "'," & PrezzoUnit & "," & TotRiga & "," & PesoReal _
					 & "," & PesoReal2 & "," & QtaP1_UM2 & "," & QtaP2_UM2 & ")"
					SQLDataAccess.ExecNonQuery(sqlstr)				
				End If				
				' Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy","it","")
				' Dim DataOggi As String= ExtraUtility.DateToFormat(DateTime.Now,  "yyyy-MM-dd","en","")	
				codart = rowdata.Get("Cod. Art.")
				'---------------------------
				' Aggiorna Partita1
				'---------------------------
				Part1 = rowdata.Get("Partita1")
				QtaP1_UMB = rowdata.Get("QP1")
				If(Part1.Trim<>"") And (Part1.Length>5) Then
					If(PesoReal>0) And (QtaP1_UM2>0) Then						
						wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part1 , DataOggi, PesoReal, QtaP1_UM2, Main.Utente, "", Corsia)) complete (Success3 As Boolean)
						If(Success3) Then
							' tutto OK
							Log("Aggiorna Partita Server partita1A " & Part1)
						Else
							MsgboxAsync("ERRORE Aggiorna Partita Server " & Part1,"ERRORE")
						End If
					Else
						wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part1 , DataOggi, QtaP1_UMB, QtaP1_UM2, Main.Utente, "", Corsia)) complete (Success3 As Boolean)
						If(Success3) Then
							' tutto OK
							Log("Aggiorna Partita Server partita1B " & Part1)
						Else
							MsgboxAsync("ERRORE Aggiorna Partita Server " & Part1,"ERRORE")
						End If						
					End If								
				End If
				'---------------------------
				' Aggiorna Partita2
				'---------------------------
				Part2 = rowdata.Get("Partita2")
				QtaP2_UMB = rowdata.Get("QP2")
				If(Part2.Trim<>"") And (Part2.Length>5) Then					
					If(PesoReal2>0) And (QtaP2_UM2>0) Then
						wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part2 , DataOggi, PesoReal2, QtaP2_UM2, Main.Utente, "", Corsia)) complete (Success4 As Boolean)
						If(Success4) Then
							' tutto OK
							Log("Aggiorna Partita Server partita2A " & Part2)
						Else
							MsgboxAsync("ERRORE Aggiorna Partita Server " & Part2,"ERRORE")
						End If
					Else
						wait for(Aggiorna_Partita_Server(routine, RifIDTesta, codart, Part2 , DataOggi, QtaP2_UMB, QtaP2_UM2, Main.Utente, "", Corsia)) complete (Success4 As Boolean)
						If(Success4) Then
							' tutto OK
							Log("Aggiorna Partita Server partita2B " & Part2)
						Else
							MsgboxAsync("ERRORE Aggiorna Partita Server " & Part2,"ERRORE")
						End If
					End If					
				End If
			End If											
		Next
		'------------------------------
		' Aggiorna Corsia sul server
		'------------------------------
		B4XTable1.Refresh
		B4XTable1.UpdateTableCounters
		'B4XTable1.Refresh
		Sleep(0)
		wait for (Aggiorna_Semaforo_Local(RifIDTesta,Corsia,Stato)) complete (Success5 As Boolean)
		If(Success5) Then
			wait for(Aggiorna_Corsia_Server(TipoDoc, NumDoc, RifIDTesta,Corsia,CodCliFor)) complete (Success6 As Boolean)
			If(Success6) Then
				wait for(Aggiorna_Semaforo_Giro_Server(RifIDTesta,Corsia,Main.Utente,Stato,"")) complete (Success7 As Boolean)
				If(Success7) Then
					wait for(Aggiorna_Semaforo_Server(Corsia,Main.Utente,-1)) complete (Success8 As Boolean)
					If(Success8) Then					
						Sleep(10)
						ListaRigheTablet2(False,vRifIdTesta,Stato)
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
			sqlstr = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
			sqlstr = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumDoc & "' AND Corsia ='" & Corsia & "'"				
			SQLDataAccess.ExecNonQuery(sqlstr)
			'sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = " & RifIDTesta
			'SQLDataAccess.ExecNonQuery(sqlstr)
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
			 	sqlstr  = "INSERT OR REPLACE INTO IS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,RifIdriga,Descrizione,rifidtesta,UM,TipoRiga," _			
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
		If(Operazione="NuovoDoc")  Then
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
			sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc,rifidtesta,NumRifDoc,DataRifDoc,NrListino) " _
			& "VALUES ('" & TipoDoc & "','" & NumDoc & "','" & Esercizio & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDoc & "','" & RifIDTesta & "','" _
			& NumRifDoc & "','" & DataRifDoc & "'," & vNRListino & ")"
			' Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub AnnullaPartitaArticolo(IDTesta As Long, articolo As String, partita As String) As ResumableSub
	Try
		Sleep(0)
		If (IDTesta<>0) Then
			sqlstr = "INSERT OR REPLACE INTO IS_PARTITE_ANNULLATE(RifIDTesta,codart,partita) VALUES (?,?,?)"
			SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(IDTesta,articolo,partita))
			Log(sqlstr & " - " & partita )
		End If
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try	
End Sub

Sub RegistraPesoRealeArticolo(IDTesta As Long, articolo As String, PesoRealeArt As Double, barcode As String) As ResumableSub		
	Try
		Sleep(0)
		If (IDTesta<>0) And (PesoRealeArt>0) Then
			Dim nrecs As Long = SQLDataAccess.ExecQuerySingleResult2("SELECT COUNT(*) FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA = ? AND CODART = ?", Array As String(IDTesta,articolo))
			nrecs = nrecs + 1
			sqlstr = "INSERT INTO IS_ARTICOLI_PESOREALE_CASH(IDTesta,codart,PesoReale,Barcode,Pos) VALUES (?,?,?,?,?)"
			SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(IDTesta,articolo,PesoRealeArt,barcode,nrecs))				
			Log(sqlstr)
		End If
		If (IDTesta<>0) And (PesoRealeArt<0) Then
			' sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTesta=? AND codart=? AND Barcode=?"
			sqlstr = "UPDATE IS_ARTICOLI_PESOREALE_CASH SET DA_CANC=1 WHERE rowid = (SELECT rowid FROM IS_ARTICOLI_PESOREALE_CASH WHERE IDTESTA=? AND CODART=? " _
			& "AND BARCODE=? ORDER BY rowid DESC LIMIT 1)"
			SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(IDTesta,articolo,barcode))
			Log(sqlstr)
		End If
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
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
				Case "del_is_semaforocorsie"
					Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" _
						& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&corsia=" & Corsia & "&stato=" & Occupata)
				
				Case "upd_is_semaforocorsie"
					Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" _
						& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&corsia=" & Corsia & "&stato=" & Occupata)
									
				Case Else
					Log("Errore nella procedura: Cash Execute_EXEC_Tab_PHP_POST_SEMAFORO_NESTI")
								
			End Select
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
			End If
			Return True
		Else
			MsgboxAsync("Errore " & job.JobName.ToLowerCase & " " & job.ErrorMessage,"ERRORE")
			Log("Error: " & job.ErrorMessage)
			Return False
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
	
End Sub

Sub Execute_EXEC_PHP_POST_CREAGIROCASH_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, Rifidtesta As Long, Utente As String, CodCliente As String) As ResumableSub
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
			& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & Rifidtesta & "&codcliente=" & CodCliente)

		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			Dim jobResult As String = job.GetString
			Log("JobResult: " & jobResult)
			job.release
			If (Main.DEBUG=1) Then
				MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
			End If
			Select job.JobName.ToLowerCase
				
				Case "del_is_semaforocorsie"
					Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
				
				Case "upd_is_girocash"
					Log(Path_Php & "is_girocash.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
				
				Case "exec_creagirodefinitivo"
					Log(Path_Php & "exec_creagirodefinitivo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
				
				Case "exec_creacasandroid"
					Log(Path_Php & "exec_CreaCASAndroid.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&codcliente" & CodCliente)
					
				Case "azz_is_semaforocorsie"
					Log(Path_Php & "Azzeramento Semafori di Emergenza!")
					
				Case Else
					Log("Errore nella procedura: Cash Execute_EXEC_Tab_PHP_POST_CREAGIRO_NESTI")
								
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

Sub Execute_EXEC_PHP_POST_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, Par1 As String, Par2 As String, Par3 As String, Par4 As String, Par5N As Double, Par6N As Double, Par6 As String, Par7 As String, Par8 As String) As ResumableSub
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
			& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & Par1 & "&codart=" & Par2  & "&partita=" & Par3 _
			& "&datamov=" & Par4 & "&qta1=" & Par5N & "&qta2=" & Par6N & "&utentepalmare=" & Par6 & "&codclifor=" & Par7 & "&corsia=" & Par8)
		Log("&action=" & mAction & "&utentepalmare=" & Utente & "&rifidtesta=" & Par1 & "&codart=" & Par2  & "&partita=" & Par3 _
			& "&datamov=" & Par4 & "&qta1=" & Par5N & "&qta2=" & Par6N & "&utentepalmare=" & Par6 & "&codclifor=" & Par7 & "&corsia=" & Par8)
		wait for(job) JobDone(job As HttpJob)
		If job.Success Then			
			If job.Success = True Then
				Dim jobResult As String = job.GetString
				Log("TEST " & job.JobName.ToLowerCase & " partita " & Par3 & " response: "  & jobResult)
				job.release
				If (Main.DEBUG=1) Then
					MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
				End If
				Select job.JobName.ToLowerCase
					Case "exec_agg_implottopalm_cash"
						Log(Path_Php & "exec_agg_implottopalm_cash.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
							
					Case "exec_agg_girocash"
						Log("ATTENZIONE!!!!!!!!" & Path_Php & "exec_agg_girocash.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL)
												
					Case Else
						Log("Errore nella procedura: Cash Execute_EXEC_Tab_PHP_POST_NESTI")
									
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
		Select JobName
			Case "get_is_righedocumenti_giro"	
				phpFile="leggi_is_righedocumenti_giro.php"
				job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
				& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente & "&idtesta=" & wherePar1 & "&corsia=" & wherePar2)						
			
			Case Else				
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
						Log("Errore nella procedura: Cash Execute_LeggiTab_PHP_POST_NESTI")
									
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
			Return True
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

Sub Execute_Scrivi_DB_SemaforoGIRO_Server(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, RifIdTesta As Long, Corsia As String, UtentePalmare As String, Occupata As Int, tipocorsia As String) As ResumableSub	
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
			Return True
		Else
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_SEMAFOROCORSIE_GIRO inizio"$) 'Current time is 11:17:45
			' Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
			job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" _
			& Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&rifidtesta=" & RifIdTesta & "&corsia=" & Corsia & "&utente=" & UtentePalmare & "&occupata=" & Occupata & "&tipocorsia=" & tipocorsia  )
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log("response: " & job.GetString)
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

Sub Execute_Scrivi_DB_RigheDocCASH(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, TipoDoc As String, NumDoc As Long, RifIdTesta As Long, Corsia As String, CodCliFor As String, Utente As String) As ResumableSub
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
			If(Corsia="") Then
				sqlstr = "SELECT TipoDoc, rifidtesta as RifIdTesta, Idriga As RifIdRiga, Corsia, Ubicazione, TipoRiga, Codart, Descrizione, Ordinato, UM As UM1, Qta As Acq_UM1, UM2, Qta2 As Acq_UM2," _
				& " UM3, Peso as Acq_UM3, Ordinamento, QtaTotUMBASE, UMBase, Partita1, QP1 as QtaP1, Partita2, QP2 as QtaP2, Partita3, QP3 as QtaP3, Status as StatoRiga,'" _
				& Utente & "' As UtenteModifica, DateTime('now','localtime') as DataModifica, CodCliFor, PrezzoUn, PesoReale,PesoReale2,Qta1_UM2,Qta2_UM2 FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
				& " AND Numerodoc = " & NumDoc & " AND RifIdTesta = " & RifIdTesta
			Else
				sqlstr = "SELECT TipoDoc, rifidtesta as RifIdTesta, Idriga As RifIdRiga, Corsia, Ubicazione, TipoRiga, Codart, Descrizione, Ordinato, UM As UM1, Qta As Acq_UM1, UM2, Qta2 As Acq_UM2," _
				& " UM3, Peso as Acq_UM3, Ordinamento, QtaTotUMBASE, UMBase, Partita1, QP1 as QtaP1, Partita2, QP2 as QtaP2, Partita3, QP3 as QtaP3, Status as StatoRiga,'" _
				& Utente & "' As UtenteModifica, DateTime('now','localtime') as DataModifica, CodCliFor, PrezzoUn, PesoReale,PesoReale2,Qta1_UM2,Qta2_UM2 FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & TipoDoc & "'" _
				& " AND Numerodoc = " & NumDoc & " AND RifIdTesta = " & RifIdTesta & " AND Corsia = '" & Corsia & "'"
			End If
			Log(sqlstr)
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object ( _
			DBUtils.DB_TEXT,DBUtils.DB_INTEGER,	DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT, DBUtils.DB_INTEGER,DBUtils.DB_TEXT, DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL, _
			DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_REAL,DBUtils.DB_REAL,DBUtils.DB_REAL,DBUtils.DB_REAL))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Log(json)
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json <> RootEmpty) Then
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO inizio - Corsia ${Corsia}"$) 'Current time is 11:17:45
				Log(PathPHP & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(PathPHP & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL _
				& "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&rifidtesta="& RifIdTesta & "&corsia=" & Corsia & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log(mAction & " response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} IS_RIGHEDOCUMENTI_GIRO fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore IS_RIGHEDOCUMENTI_GIRO " & job.errorMessage,"Errore")
					Return False
				End If
			Else
				Return True
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

Sub Leggi_IS_SEMAFOROCORSIE(corsia As String) As ResumableSub
	Try
		Sleep(0)		
		If (corsia<>"") Then
			Dim sqlstr As String
			Dim rs As ResultSet
			rs = SQLDataAccess.ExecQuery2("SELECT count(*) AS NRECS,ifnull(UTENTE,'') as UTENTE FROM IS_SEMAFOROCORSIE WHERE CORSIA = ?", Array As String(corsia))
			Dim row(1) As Object
			row(0) = 0
			Do While rs.NextRow
				row(0) = rs.GetString("UTENTE")
			Loop
			Dim UtenteCorsia As String = row(0)
			If (UtenteCorsia=Main.Utente) Or (UtenteCorsia=Null) Or (UtenteCorsia="") Then
				Return True
			Else
				ExtraUtility.Play_Sound("error.wav")				
				Msgbox2Async("CORSIA OCCUPATA DA '" & UtenteCorsia &"'," & Chr(13) & "vuoi entrare lo stesso?","*** ERRORE CORSIA ***", "SI", "NO", "", Null, False)
				Wait For MsgBox_Result (Result As Int)
				If Result = DialogResponse.POSITIVE Then
					Return True
				Else
					Return False
				End If				
			End If
		Else
			Log("errore corsia " & corsia)
			Return False
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
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
				sqlstr = "INSERT OR REPLACE INTO IS_SEMAFOROCORSIE_local SELECT " &  idtesta & " AS IDTESTA,LS.CORSIA,'' AS TIPOCORSIA, " _
				& "(SELECT ifnull(group_concat(utente),'') from is_semaforocorsie where corsia=LS.corsia) AS UTENTE, " _				
				& "(CASE WHEN SUM(LS.IDTESTA)>0 THEN  ifnull(SC.OCCUPATA,1) ELSE ifnull(SC.OCCUPATA,0) END) AS OCCUPATA FROM Vista_CORSIE_GIRO As LS " _
				& " left outer join IS_SEMAFOROCORSIE As sc on sc.corsia=ls.corsia WHERE (LS.CORSIA<>'' AND LS.IDTESTA=0) OR LS.IDTESTA='" & idtesta _
				& "' GROUP BY LS.CORSIA ORDER BY LS.IDTESTA DESC,LS.CORSIA ASC"
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
	Try	
		' Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowID)
		' SetRowColor(Index, Selected, Main.SelectionColor_Green)
		' RowID_Riga = RowID			
		' B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c13 = ? WHERE rowid = ?", Array ("C",RowID))
		' XSelections.Mode = 5
		Select TipoOperazione
		Case "CAS"
			XSelections.CellClicked(ColumnId,RowID,xui.Color_cyan)
			Sleep(0)
			If(Panel3.Visible=False) Then
				Dim RowData As Map
				RowData = B4XTable1.GetRow(RowID)
				RowID_Riga = RowData.GetValueAt(0)
				vCodArticolo = RowData.GetValueAt(2)
				vDescrizioneArt = RowData.GetValueAt(3)
				UM1 = RowData.GetValueAt(5)
				QtaIns = RowData.GetValueAt(6)
				EditText5.Text = QtaIns
				Label29.Text = vCodArticolo
				Label9.Text = vDescrizioneArt
				Label14.Text = UM1
				PrezzoUnitario = RowData.GetValueAt(27)
				UMPrezzo = RowData.GetValueAt(16)
				vTotPesoReale = RowData.GetValueAt(30)
				vTotPesoReale2 = RowData.GetValueAt(31)
				Qta1_UM2 = RowData.GetValueAt(32)
				Qta2_UM2 = RowData.GetValueAt(33)
				vPesoReale = 0
				vPesoReale2 = 0
				ApriMiniCalcolatrice(vCodArticolo,RowID_Riga,vPesoReale)
			End If							
		End Select
		XSelections.Refresh(ColumnColor)
	Catch
		Log(LastException)
	End Try
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
	SetColumnAlignment(B4XTable1,"Tot. Riga",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"PesoReale",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"PesoReale2",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"Qta1_UM2",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"Qta2_UM2",Gravity.RIGHT)
		If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
		For i=1 To Col1_Column.CellsLayouts.Size-1
			' colonna c0 (Posizione)
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			lbl1.TextSize = 20
			lbl1.Typeface = Typeface.DEFAULT
			lbl1.TextColor = Colors.DarkGray
			lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' colonna c1 (Tipo Riga)
			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			lbl2.TextSize = 20
			lbl2.Typeface = Typeface.DEFAULT
			lbl2.TextColor = Colors.LightGray
			lbl2.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
			' colonna c2 (Cod. Art.)
			Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
			Dim lbl3 As Label = pnl3.GetView(0)
			lbl3.TextSize = 20
			lbl3.Typeface = Typeface.DEFAULT_BOLD
			lbl3.TextColor = xui.Color_DarkGray
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
			lbl5.TextSize = 12
			lbl5.Typeface = Typeface.DEFAULT
			lbl5.TextColor = Colors.Black
			lbl5.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			' colonna c28 (Prezzo un.)
			Dim pnl6 As B4XView = Col28_Column.CellsLayouts.Get(i)
			Dim lbl29 As Label = pnl6.GetView(0)
			lbl29.TextSize = 22
			lbl29.Typeface = Typeface.DEFAULT_BOLD
			lbl29.TextColor = Colors.Blue
			lbl29.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl29.Text<>"") Then
				lbl29.Text = ExtraUtility.Formato_2dec_ITA_Str(lbl29.Text)
			End If
			' colonna c29 (Tot. Riga)
			Dim pnl7 As B4XView = Col30_Column.CellsLayouts.Get(i)
			Dim lbl30 As Label = pnl7.GetView(0)
			lbl30.TextSize = 22
			lbl30.Typeface = Typeface.DEFAULT_BOLD
			lbl30.TextColor = Colors.Blue
			lbl30.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl30.Text<>"") Then
				lbl30.Text = ExtraUtility.Formato_2dec_ITA_Str(lbl30.Text)
			End If
			
		Next
	Else
		' PALMARE
		For i=1 To Col1_Column.CellsLayouts.Size-1
			' colonna c0 (Posizione)
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			lbl1.TextSize = 16
			lbl1.Typeface = Typeface.DEFAULT_BOLD
			lbl1.TextColor = Colors.Gray
			lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' colonna c1 (Tipo Riga)
			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			lbl2.TextSize = 10
			lbl2.Typeface = Typeface.DEFAULT
			lbl2.TextColor = Colors.LightGray
			lbl2.Padding = Array As Int (10dip, 0dip, 0dip, 0dip)
			' colonna c2 (Cod. Art.)
			Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
			Dim lbl3 As Label = pnl3.GetView(0)
			lbl3.TextSize = 12
			lbl3.Typeface = Typeface.DEFAULT
			lbl3.TextColor = xui.Color_DarkGray
			lbl3.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			' colonna c3 (Descrizione Art.)
			Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
			Dim lbl4 As Label = pnl4.GetView(0)
			lbl4.TextSize = 12
			lbl4.Typeface = Typeface.DEFAULT_BOLD
			lbl4.TextColor = Colors.Black
			lbl4.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			' colonna c4 (UM1)
			Dim pnl5 As B4XView = Col6_Column.CellsLayouts.Get(i)
			Dim lbl5 As Label = pnl5.GetView(0)
			lbl5.TextSize = 14
			lbl5.Typeface = Typeface.DEFAULT
			lbl5.TextColor = Colors.Black
			lbl5.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			' colonna c4 (Qta)
			Dim pnl6 As B4XView = Col7_Column.CellsLayouts.Get(i)
			Dim lbl6 As Label = pnl6.GetView(0)
			lbl6.TextSize = 18
			lbl6.Typeface = Typeface.DEFAULT_BOLD
			lbl6.TextColor = Colors.Blue
			lbl6.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			' colonna c29 (Tot. Riga)
			Dim pnl7 As B4XView = Col30_Column.CellsLayouts.Get(i)
			Dim lbl30 As Label = pnl7.GetView(0)
			lbl30.TextSize = 12
			lbl30.Typeface = Typeface.DEFAULT_BOLD
			lbl30.TextColor = Colors.Blue
			lbl30.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl30.Text<>"") Then
				lbl30.Text = ExtraUtility.Formato_2dec_ITA_Str(lbl30.Text)
			End If
			' colonna c29 (Prezzo un.)
			Dim pnl8 As B4XView = Col28_Column.CellsLayouts.Get(i)
			Dim lbl28 As Label = pnl8.GetView(0)
			lbl28.TextSize = 14
			lbl28.Typeface = Typeface.DEFAULT_BOLD
			lbl28.TextColor = Colors.Blue
			lbl28.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl28.Text<>"") Then
				lbl28.Text = ExtraUtility.Formato_2dec_ITA_Str(lbl28.Text)
			End If
			' colonna c30 (Tot. Riga)
			Dim pnl9 As B4XView = Col30_Column.CellsLayouts.Get(i)
			Dim lbl30 As Label = pnl9.GetView(0)
			lbl30.TextSize = 14
			lbl30.Typeface = Typeface.DEFAULT_BOLD
			lbl30.TextColor = Colors.Blue
			lbl30.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl30.Text<>"") Then
				lbl30.Text = ExtraUtility.Formato_2dec_ITA_Str(lbl30.Text)
			End If
			' colonna c31 (PesoReale Riga)
			Dim pnl10 As B4XView = Col31_Column.CellsLayouts.Get(i)
			Dim lbl31 As Label = pnl10.GetView(0)
			lbl31.TextSize = 14
			lbl31.Typeface = Typeface.DEFAULT_BOLD
			lbl31.TextColor = Colors.Red
			lbl31.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl31.Text<>"") Then
				lbl31.Text = ExtraUtility.Formato_3dec_ITA_Str(lbl31.Text)
			End If
			' colonna c32 (PesoReale2 Riga)
			Dim pnl11 As B4XView = Col32_Column.CellsLayouts.Get(i)
			Dim lbl32 As Label = pnl11.GetView(0)
			lbl32.TextSize = 14
			lbl32.Typeface = Typeface.DEFAULT_BOLD
			lbl32.TextColor = Colors.Red
			lbl32.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl32.Text<>"") Then
				lbl32.Text = ExtraUtility.Formato_3dec_ITA_Str(lbl32.Text)
			End If
			' colonna c33 (Qta1_UM2)
			Dim pnl12 As B4XView = Col33_Column.CellsLayouts.Get(i)
			Dim lbl33 As Label = pnl12.GetView(0)
			lbl33.TextSize = 14
			lbl33.Typeface = Typeface.DEFAULT_BOLD
			lbl33.TextColor = Colors.Red
			lbl33.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl33.Text<>"") Then
				lbl33.Text = ExtraUtility.Formato_3dec_ITA_Str(lbl33.Text)
			End If
			' colonna c34 (Qta2_UM2)
			Dim pnl13 As B4XView = Col34_Column.CellsLayouts.Get(i)
			Dim lbl34 As Label = pnl13.GetView(0)
			lbl34.TextSize = 14
			lbl34.Typeface = Typeface.DEFAULT_BOLD
			lbl34.TextColor = Colors.Red
			lbl34.Padding = Array As Int (5dip, 5dip, 12dip, 5dip)
			If(lbl34.Text<>"") Then
				lbl34.Text = ExtraUtility.Formato_3dec_ITA_Str(lbl34.Text)
			End If
		Next
	End If
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
			' -----------------------------
			' reset corsia
			' -----------------------------
			'------------------------------
			' Aggiorna Semaforo sul server
			'------------------------------	
			Azzera_Semafori_Local(vRifIdTesta)			
			If(vCorsia<>"") Then 
				wait for (Aggiorna_Semaforo_Server(vCorsia, Main.Utente, -1)) complete (Success As Boolean) ' 3 = occupata rosso
				If(Success) Then			
					Activity.Finish					
				End If				
			Else
				Activity.Finish
			End If
			
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

Sub label14_longclick
	EditText5.Enabled=True
	EditText5.RequestFocus
	EditText5.SelectAll
	Phone.SetCustomFilter(EditText5, EditText5.INPUT_TYPE_NUMBERS, "0123456789,")
	Phone.ShowKeyboard(EditText5)
End Sub

Sub EditText5_FocusChanged (HasFocus As Boolean)   ' QtaIns
	If(HasFocus=False) Then	
		EditText5.Enabled=False
		EditText1.RequestFocus
	End If
End Sub

Sub EditText5_EnterPressed ' QtaIns
	If(EditText5.Text.Length>0) Then				
		QtaIns = EditText5.Text
		If(QtaIns>1000) Then
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Quantità maggiore di 1000 ripetere l'inserimento!","ERRORE QUANTITA'!")
			EditText5.Text = 1
			QtaIns = 1
			EditText5.Enabled=False
			EditText1.RequestFocus
		End If		
	Else
		QtaIns = 0
	End If
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
	Try	
		' 8056455939510
		Dim Phone As IME
		Phone.HideKeyboard
		vBarcodeLetto = EditText1.Text
		vBarcodeLetto=vBarcodeLetto.Replace(Chr(13),"")
		vBarcodeLetto=vBarcodeLetto.Replace(Chr(10),"")
		'-----------------------------------------------------------
		'	PRIMA FASE SELEZIONO LA CORSIA
		'-----------------------------------------------------------
		Dim F_Exit As Boolean = False
		If(vBarcodeLetto.Length=5) And (vBarcodeLetto.StartsWith("CS")) Then
			If(Panel2.Visible=False) Then
				F_Exit = True				
				If(B4XTable1.Size>0) Then				
					ExtraUtility.Play_Sound("error.wav")
					ToastMessageShow("*** CONFERMARE LA CORSIA ***",False)				
				Else
					F_Exit = False
					vCorsia = ""
				End If
			Else
				vCorsia=vBarcodeLetto														
				wait for (Leggi_IS_SEMAFOROCORSIE(vCorsia)) complete (Success As Boolean)  ' 3 = occupata rosso				
				If (Success) Then			
					Sleep(0)
					Button8.text = vCorsia				
					F_Exit = False
					CallSubDelayed(Me, "OK_ListaCorsie")					
				Else
					wait for (DB_SQLSERVER.Azzera_SemaforoCorsie_Local(SQLDataAccess,Main.Utente)) Complete (Success As Boolean)
					If(Success) Then
						Sleep(1)
						vCorsia=""
						F_Exit = True						
						ListaRigheTablet2(False,vRifIdTesta,0)						
					End If
				End If
			End If
		End If
		If(F_Exit=False) Then
			If (vCorsia="") Then
				' Visualizza le corsie
				ListaRigheTablet2(False,vRifIdTesta,0)
			Else
				'-----------------------------------------------------------
				'	SECONDA FASE LEGGO LE RIGHE DELLA CORSIA DEL CAS
				'-----------------------------------------------------------
				If (Panel3.Visible=False) And (vBarcodeLetto<>vCorsia) Then				
					Leggi_Barcode_Articolo(vBarcodeLetto)
					Dim Codart As String = BarcodeArticolo.Articolo
					Dim res As ResultSet
					Dim RowID As Long = 0
					res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1 from data where c2=?"$, Array As String(Codart))
					If (res.RowCount>0) Then
						Do While res.NextRow
							RowID=res.GetLong("c0")
							vTotPesoReale = 0
							vTotPesoReale2 = 0
							EditText5.Text=QtaIns				
						Loop
					End If
					If(Panel3.Visible=False) And (RowID>0) Then
						Dim RowData As Map
						RowData = B4XTable1.GetRow(RowID)
						RowID_Riga = RowData.GetValueAt(0)
						vCodArticolo = RowData.GetValueAt(2)
						vDescrizioneArt = RowData.GetValueAt(3)
						UM1 = RowData.GetValueAt(5)
						QtaIns = RowData.GetValueAt(6)
						EditText5.Text = QtaIns
						Label29.Text = vCodArticolo
						Label9.Text = vDescrizioneArt
						Label14.Text = UM1
						PrezzoUnitario = RowData.GetValueAt(27)
						UMPrezzo = RowData.GetValueAt(16)
						vTotPesoReale = RowData.GetValueAt(30)
						vTotPesoReale2 = RowData.GetValueAt(31)
						ApriMiniCalcolatrice(vBarcodeLetto,RowID_Riga,vPesoReale)
					Else
						ApriMiniCalcolatrice(vBarcodeLetto,0,vPesoReale)
					End If
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
								If(Leggi_DisponibilitaArticolo(vCodArticolo,vCorsia,QtaIns)>0) Then
									OK_MiniCalcolatrice
								End If
							End If
							If(vBarcodeLetto="KO") Then
								CallSubDelayed(Me,Button12_Click)
							End If
						Else
							vCodArticoloOld=vCodArticolo
							vDescrizioneArtOld=vDescrizioneArt
							Leggi_Barcode_Articolo(vBarcodeLetto)
							' Cerco l'articolo x cella e corsia
							Dim Codart As String = BarcodeArticolo.Articolo
							If(Codart<>"") Then
								If(Codart=vCodArticoloOld) Then
									If(Panel3.Visible=False) And (vPesoReale=0) Then
										CallSubDelayed(Me,SwiftButton2_Click)
									Else
										If(vPesoReale>0) Or (vTotPesoReale>0) Or (vTotPesoReale2>0) Then
											Label35.Text="KG " & ExtraUtility.Formato_3dec_ITA_Num(vPesoReale)
											If(vTotPesoReale>0) Then
												Label36.Text = "tot. Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
											Else
												Label36.Text = ""
											End If
										Else
											Label35.Text = ""
											Label36.Text = ""
										End If
									End If
								Else
									vCodArticolo=vCodArticoloOld
									vDescrizioneArt=vDescrizioneArtOld
									Label3.Text=vDescrizioneArt
									ExtraUtility.Play_Sound("error.wav")
									ToastMessageShow("*** CODICE ERRATO ***",False)
									EditText1.RequestFocus
								End If
							End If
						End If
					End If
				End If
			End If
		End If
		EditText1.Text=""
		EditText1.RequestFocus
			
	Catch
		Log(LastException)
	End Try
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

Sub Leggi_PrezzoVenditaArticolo(codart As String, listino As Int) As List
	Try
		Dim Lista As List
		Dim rs As ResultSet = SQLDataAccess.ExecQuery2("SELECT ifnull(PREZZOEURO,0) AS PREZZO,UM FROM IS_LISTINIARTICOLI WHERE CODART = ? AND NRLISTINO = ?", Array As String(codart,listino))
		Lista.Initialize
		If(rs.RowCount>0) Then
			Do While rs.NextRow
				Lista.Add(rs.GetDouble("PREZZO"))
				Lista.Add(rs.GetString("UM"))
			Loop
		End If
		Return Lista
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub Leggi_UMVenditaArticolo(Codart As String) As String
	Try
		Dim List_UM As List
		Dim UMVendita As List
		UMVendita.Initialize
		List_UM.Initialize
		UMVendita = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT UMV FROM IS_VISTA_UMPREF WHERE CODICE='" & Codart & "'",Null,1)
		For Each arr_umvendita() As String In UMVendita	
			List_UM.Add(arr_umvendita(0))
		Next
		If List_UM.Size>0 Then
			Dim um As String = arr_umvendita(0)
			Return um
		Else
			Return ""
		End If
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

Sub Leggi_FattoreCVB(SQLData As SQL,Codart As String, UMBase As String) As Double
	Try
		Dim FattoreFC As Double
		Dim rs As ResultSet = SQLData.ExecQuery2("SELECT FCVB FROM IS_VISTA_UMPREF WHERE CODICE = ? AND UMB = ?", Array As String (Codart,UMBase))
		Dim row(1) As Object
		row(0) = 0
		Do While rs.NextRow
			row(0) = rs.GetDouble("FCVB")
		Loop
		FattoreFC = row(0)
		Return FattoreFC
			Catch
		Log("ERRORE!: " & LastException)
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

'Sub EditText5_FocusChanged (HasFocus As Boolean)  ' numero etichette
'	If HasFocus=False Then
'		If(EditText5.Text <> "")  Then			
'			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6 = ? WHERE rowid = ?", Array (EditText5.Text, RowID_Riga))
'			B4XTable1.Refresh
'			Phone.HideKeyboard
'			EditText1.RequestFocus
'		End If
'	Else
'		EditText5.SelectAll		
'	End If
'End Sub


Private Sub InsertRigaDoc(xNumPos As Int,xCodArt As String, xLotto As String, xCodDep As String, xCodDepColl As String, xCodUbic As String, xCodUbicColl As String, xUM1 As String, xQta1 As String, xUM2 As String, xQta2 As String, xUM3 As String, xQta3 As Double, xSvuotaCella As Int, xTipoReadGiac As String)
	Dim xDescArt As String = Label3.Text
	Dim xMaxPriority As Int = Leggi_MaxPriorita_Data
	Dim xCorsiaUbicaz As String = xCodDep & xCodUbic
	Dim xCorsiaUbicazColl As String = xCodDepColl & xCodUbicColl
	xCorsiaUbicaz = xCorsiaUbicaz.Trim
	xCorsiaUbicazColl = xCorsiaUbicazColl.Trim
	B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"$, Array As Object(xNumPos,xCodArt,xDescArt,xUM1,xQta1,xUM2,"",xUM3,xQta3,xLotto,"","P",xMaxPriority,xQta1,0,0,xCorsiaUbicaz,xCorsiaUbicazColl,xSvuotaCella,xTipoReadGiac))
End Sub

Private Sub Azzera_Semafori_Local(aIdtesta As Long)
	Try
		SQLDataAccess.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE")
		SQLDataAccess.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA=" & aIdtesta)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Leggi_DisponibilitaArticolo (aArticolo As String, aCorsia As String, aQta As Int) As Double
	Try		
		Dim F_Bilancia As String = SQLDataAccess.ExecQuerySingleResult("SELECT IFNULL(FLAG_BILANCIA,'') AS FLAG_BILANCIA FROM IS_ANAGRAFICAARTICOLI WHERE CODICE ='" & aArticolo & "'")
		If(F_Bilancia.ToUpperCase="S") Then
			' se articolo a bilancia deve considerare la seconda unità
			Dim Disp As Double = SQLDataAccess.ExecQuerySingleResult("SELECT ifnull(SUM(GIACENZA2),0) as DISP FROM VISTA_DISPONIBILITA_CORSIA WHERE CODDEPOSITO ='" & aCorsia & "' AND CODART ='" & aArticolo & "' AND GIACENZA2>0")
		Else
			Dim Disp As Double = SQLDataAccess.ExecQuerySingleResult("SELECT ifnull(SUM(GIACENZA1),0) as DISP FROM VISTA_DISPONIBILITA_CORSIA WHERE CODDEPOSITO ='" & aCorsia & "' AND CODART ='" & aArticolo & "' AND GIACENZA1>0")
		End If		
		If(Disp>0) Then
			Dim NumLotti As Int = SQLDataAccess.ExecQuerySingleResult("SELECT COUNT(*) FROM VISTA_DISPONIBILITA_CORSIA WHERE CODDEPOSITO ='" & aCorsia & "' AND CODART ='" & aArticolo & "' AND GIACENZA1>0")
			If(NumLotti>2) Then
				ExtraUtility.Play_Sound("Error.wav")
				MsgboxAsync("NUMERO LOTTI SUPERIORE A 2!","VERIFICA MAGAZZINO")
				Return -1
			Else
				If(Disp>=aQta) Then
					Return aQta
				Else
					ExtraUtility.Play_Sound("Error.wav")
					MsgboxAsync("QUANTITA' MASSIMA PRELEVABILE " & Disp & " " & UMV,"VERIFICA MAGAZZINO")
					Return -1
				End If
			End If
		Else
			ExtraUtility.Play_Sound("Error.wav")
			MsgboxAsync("NESSUN LOTTO DISPONIBILE","VERIFICA MAGAZZINO")
			Return -1
		End If		
	Catch
		Log("ERRORE NEL Leggi_DisponibilitaArticolo")
		Return -1
	End Try
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
	'-------------------------------
	' Conferma su mini-calcolatrice
	'--------------------------------------------
	' Cancellazione IS_ARTICOLI_PESOREALE_CASH
	'--------------------------------------------
	sqlstr = "DELETE FROM IS_ARTICOLI_PESOREALE_CASH WHERE DA_CANC=1 AND IDTESTA=? AND CODART=?"
	SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(vRifIdTesta,vCodArticolo))
	If(QtaIns>0) Then
		If(Leggi_DisponibilitaArticolo(vCodArticolo,vCorsia,QtaIns)>0) Then
			' Leggi_DisponibilitaCorsiaLocal(vCodArticolo,vCorsia,QtaIns)
			OK_MiniCalcolatrice
			Panel3.Visible=False
			EditText1.RequestFocus
		End If		
	Else
		vTotPesoReale=0
		vTotPesoReale2=0
		OK_MiniCalcolatrice
		Panel3.Visible=False
		EditText1.RequestFocus
	End If
	vTotPesoReale=0
	vTotPesoReale2=0
End Sub

Private Sub Button9_Click
	' Annulla su mini-calcolatrice
	Panel3.Visible=False
	EditText1.RequestFocus
	vTotPesoReale=0
	vTotPesoReale2=0
	sqlstr = "UPDATE IS_ARTICOLI_PESOREALE_CASH SET DA_CANC=0 WHERE IDTESTA=? AND CODART=?"
	SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(vRifIdTesta,vCodArticolo))
	Log(sqlstr)
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

Private Sub OK_MiniCalcolatrice
	Try
		Dim Pos As Int = 0
		'--------------------------------------
		' Controllo se l'articolo se prsente
		'--------------------------------------
		Dim F_AggRiga As Boolean = False
		Dim res  As ResultSet
		res = B4XTable1.sql1.ExecQuery2($"SELECT c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33 from data where c2=?"$, Array As String(vCodArticolo))
		If (res.RowCount=0) And (QtaIns>0) Then
			'------------------------------------------------------
			' ARTICOLO NON PRESENTE VUOI AGGIUNGERLO
			'------------------------------------------------------
			Dim maxPos As Int
			If(B4XTable1.mCurrentCount=0) Then
				maxPos = 0
			Else
				maxPos = B4XTable1.sql1.ExecQuerySingleResult("SELECT max(c0) FROM data")
			End If
			maxPos = maxPos + 1		
			Dim FC As Double = Leggi_FattoreCVB(SQLDataAccess,vCodArticolo,UMPrezzo)
			If(UMPrezzo="KG") And (vTotPesoReale>0) Then
				TotaleRiga = Round2(vTotPesoReale*PrezzoUnitario,2)
				If(vTotPesoReale2>0) Then
					TotaleRiga = TotaleRiga + Round2(vTotPesoReale2*PrezzoUnitario,2)
				End If
			Else				
				TotaleRiga = Round2(FC*QtaIns*PrezzoUnitario,2)			
			End If			
			QtaTotaleUMBase = Round2(FC*QtaIns,2)
			B4XTable1.sql1.ExecNonQuery2("INSERT INTO data(c0,c1,c2,c3,c4,c5,c6,c7,c9,c11,c12,c13,c14,c16,c25,c27,c28,c29,c17,c30,C31,c32,c33) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", _
			 Array As Object(maxPos,"N",vCodArticolo,Label3.Text,"",Label14.text,QtaIns,"","",vCorsia,vUbicazione,"",vOrdinamento,"",vRifIdTesta,PrezzoUnitario,UMPrezzo,TotaleRiga, _
			 QtaTotaleUMBase,vTotPesoReale,vTotPesoReale2,Qta1_UM2,Qta2_UM2))			
			B4XTable1.UpdateTableCounters
			B4XTable1.Refresh
			F_AggRiga = True
			Pos = maxPos
		Else
			If (res.RowCount>0) Then								
				Do While res.NextRow
					 Pos = res.GetInt("c0")
				Loop
				If(QtaIns=0) Then
					If(Pos>0) Then
						vTotPesoReale=0
						vTotPesoReale2=0						
						TotaleRiga=0
						Qta1_UM2=0
						Qta2_UM2=0
						QtaTotaleUMBase = Round2(QtaIns,2)						
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6=?,c17=?,c29=?,c30=?,c31=?,c32=?,c33=? WHERE c0=?", _
							Array As Object(QtaIns,QtaTotaleUMBase,TotaleRiga,vTotPesoReale,vTotPesoReale2,Qta1_UM2,Qta2_UM2,Pos))
						B4XTable1.UpdateTableCounters						
						vPesoReale=0
						vPesoReale2=0
					End If
				Else
					If(Pos>0) Then						
						Dim FC As Double = Leggi_FattoreCVB(SQLDataAccess,vCodArticolo,UMPrezzo)
						If(UMPrezzo="KG") And (vTotPesoReale>0) Then
							TotaleRiga = Round2(vTotPesoReale*PrezzoUnitario,2)
							If(vTotPesoReale2>0) Then
								TotaleRiga = TotaleRiga + Round2(vTotPesoReale2*PrezzoUnitario,2)
							End If
						Else							
							TotaleRiga = Round2(FC*QtaIns*PrezzoUnitario,2)
						End If
						QtaTotaleUMBase = Round2(FC*QtaIns,2)
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c6=?,c17=?,c29=?,c30=?,c31=?,c32=?,c33=? WHERE c0=?", Array As Object(QtaIns,QtaTotaleUMBase,TotaleRiga,vTotPesoReale,vTotPesoReale2,Qta1_UM2,Qta2_UM2,Pos))
						B4XTable1.UpdateTableCounters
						B4XTable1.Refresh
					End If
				End If
			End If
		End If
		vStatoriga=""					
		wait for (Registra_Panel3("",Pos,vStatoriga,QtaTotaleUMBase)) complete (Result As Boolean)
		If(Result) Then
			Panel3.Visible=False
			Button1.Enabled=True
			Phone.HideKeyboard
			Label3.Text = ""
			vCodArtCella=""
			vCodArtLotto=""
			XSelections.Clear
			B4XTable1_DataUpdated
		End If
		'-----------------------------------------------------------------------------------------------------------------
		' serve per fare la somma delle colonne
		'-----------------------------------------------------------------------------------------------------------------
		Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
		Dim total As Double = 0
		Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
		Do While rs.NextRow
			total = total + rs.GetDouble("c29")
		Loop
		rs.Close
		Label34.Text = ExtraUtility.Formato_2dec_ITA_Num(total)
		'-------------------------------------------------------------------------------------------------------------------		
		Label33.Visible=True
		Label34.Visible=True
		Dim column As B4XTableColumn = B4XTable1.GetColumn("Pos.")
		column.InternalSortMode= "DESC"
		B4XTable1.Refresh
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button11_Click
	If(Button11.Tag="SU") Then
		Button11.Tag="GIU"
		Button11.Text=Chr(0xF063)
		Button11.TextColor=xui.Color_Red
	Else
		Button11.Tag="SU"
		Button11.Text=Chr(0xF062)
		Button11.TextColor=xui.Color_Blue
	End If
	Dim column As B4XTableColumn = B4XTable1.GetColumn("Ord.")
	If(Button11.Tag="SU") Then
		column.InternalSortMode= "ASC"
	Else
		column.InternalSortMode= "DESC"
	End If
	B4XTable1.Refresh	
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
			Dim pnl As B4XView = SemaphoreColumn.CellsLayouts.Get(i+1)
			Dim iv As B4XView = pnl.GetView(1)
			Dim FileName As String = ""
			SetRowColor2(i, SelectedRows2.Contains(RowId), Main.SelectionColor_Green )
			If(RowId>0) Then
				Dim row As Map = B4XTable2.GetRow(RowId)
				FileName = "Semaphore" & row.Get("Stato") & ".png"  ' "Semaphore1" & row.Get("Occupata") & ".png"
				iv.SetBitmap(xui.LoadBitmapResize(File.DirDefaultExternal & "/icons", FileName,iv.Width,iv.Height,False))
			Else
				' empty row
				iv.SetBitmap(Null)
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
		Button8.Enabled=True
		Button1.Enabled=True
		Button2.Enabled=True
		Button6.Enabled=True
		Button7.Enabled=True
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
		XSelections.Clear
		Aggiorna_ColoriListaTablet
		' Log($"Numero of rows selected: ${SelectedRows2.Size}"$)
		If(SelectedRows2.Size>0) Or (vCorsia<>"") Then
			Button5.Tag=""
			If(vCorsia<>"") Then
				B4XTable2.ClearDataView
				ProgressDialogShow2("RILETTURA DISPONIBILITA' CORSIA DAL SERVER IN CORSO...",False)
				wait for (Leggi_DisponibilitaCorsiaServer(vCorsia)) complete (Success As Boolean)
				If (Success) Then
					Panel2.Visible=False
					Button8.Enabled=True
					Button1.Enabled=True
					Button2.Enabled=True
					Button6.Enabled=True
					Button7.Enabled=True
					XSelections.SelectedLines.Clear
					XSelections.Refresh(ColumnColor)
					B4XTable1.Refresh		
					sqlstr = "INSERT OR REPLACE INTO IS_SEMAFOROCORSIE (Corsia, Utente, Occupata) values (?,?,?)"
					SQLDataAccess.ExecNonQuery2(sqlstr, Array As String(vCorsia,Main.Utente,4))
					wait for (Aggiorna_Semaforo_Server(vCorsia, Main.Utente, 3)) complete (Success2 As Boolean) ' 3 = occupata rosso				
					If(Success2=False) Then
						MsgboxAsync("Problema aggiornamneto semafori server!","ERRORE SERVER")
					End If					
				End If
				ProgressDialogHide
			End If
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
		vCorsia=RowData.GetValueAt(0)
		vStatoCorsia=RowData.GetValueAt(3)	
		Dim UtenteCorsia As String = RowData.GetValueAt(2)
		Button8.Text=vCorsia
		If (vStatoCorsia=3) And (UtenteCorsia<>"") Then
			Button18.Enabled=False
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

Sub LeggiListaClienti
	Try		
		sqlstr = "SELECT CODCLIFOR,DSCCONTO1 AS RAGSOC FROM IS_ANAGRAFICACF" '  WHERE TIPOCONTO='C'"
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
		Panel4.Visible=True
		B4XTable3.MaximumRowsPerPage=15
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
	Catch
		Log(LastException)
	End Try
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
		Wait For(ListaRigheTablet3(False)) complete  (Result As Boolean)
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
	' Imposta Cliente e visulizza le corsie
	Try	
		If(vCodCliFor<>"") Then
			agg_GiroCash(vCodCliFor)		
			vDataDocNew = ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy","it","")
			Dim maxDoc As Int = 0
			If(B4XTable1.size>0) Then
				maxDoc = B4XTable1.sql1.ExecQuerySingleResult("SELECT MAX(c2) FROM data")
			End If
			vNumDocNew = maxDoc + 1
			Label1.Text = "CASH n. " & vNumDocNew & " del " & vDataDocNew & " - " & vRagSoc
			Label6.Text = "ID: " & vRifIdTesta	
			Panel4.Visible=False
			If(ListaDocTablet.vOperazione="NuovoDoc") Then
				RegistraTestaNewDoc("CAS",vRifIdTesta,"","NuovoDoc",vDataDocNew,vCodCliFor)
			End If		
			EditText1.RequestFocus
			Visulizza_Corsie		
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("NON HAI SELEZIONATO IL CLIENTE!",True)			
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Button20_Click
	' Annulla Cliente
	Try	
		vCodCliFor = ""
		Panel4.Visible=False
		Activity.Finish
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub B4XTable3_CellClicked (ColumnId As String, RowId As Long)
	' Lista dei Clienti
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
	'Log($"Number of rows selected: ${SelectedRows3.Size}"$)
	'Log($"Row selected: ${RowId}"$)
	Dim RowData As Map
	RowData = B4XTable3.GetRow(RowId)
	'Log($"Value1 of selected: ${RowData.GetValueAt(0)}"$)
	'Log($"Value2 of selected: ${RowData.GetValueAt(1)}"$)
	vCodCliFor = RowData.GetValueAt(0)
	vRagSoc = RowData.GetValueAt(1)
	vNRListino = RowData.GetValueAt(2)
	' Log(vCodCliFor)
	' ie.CellClicked(ColumnId, RowId)	
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
			B4XTable2.CreateDataView($"c3>=0"$)
			B4XTable2.Refresh
			Button5.Tag=""
			SelectedRows2.Clear
			Button18.Enabled=True
			Button17.Enabled=True
		Else
			B4XTable2.CreateDataView($"c3=2"$)
			B4XTable2.Refresh
			If(B4XTable2.Size=0) Or (B4XTable2.Size=1) Then
				If (B4XTable2.Size=1) Then
					Dim Rowdata As Map
					Rowdata = B4XTable2.GetRow(1)
					Dim Corsia As String = Rowdata.Get("Corsia")
					If(Corsia<>vCorsia) Then
						ChiusuraGiroCash(vRifIdTesta)
					End If
				End If
				If (B4XTable2.Size=0) Then
					ChiusuraGiroCash(vRifIdTesta)
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

Sub ChiusuraGiroCash(RifIdTesta As Long)
	Try
		ExtraUtility.Play_Sound("error.wav")
		Msgbox2Async("VUOI CONCLUDERE LA SPESA?","CHIUSURA DEFINITIVA CASH N. " & RifIdTesta,"Procedi","","Annulla",Null,True)
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
				Dim routine As String
				Dim straction As String 
				Dim dbAction As Map 
				If (F_Device) Then
					nt = nt + 1
					routine = "exec_creacasandroid"
					straction = routine
					dbAction = CreateMap("action=": straction)
					Wait For(Execute_EXEC_PHP_POST_CREAGIROCASH_NESTI(Me, dbAction, straction.ToLowerCase, routine&".php", RifIdTesta, Main.Utente, vCodCliFor)) complete (Success As Boolean)
					If(Success) Then
						SQLDataAccess.BeginTransaction
						sqlstr = "UPDATE IS_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0 AND rifidtesta = '" & RifIdTesta & "'"
						SQLDataAccess.ExecNonQuery(sqlstr)
						SQLDataAccess.TransactionSuccessful
						SQLDataAccess.EndTransaction
						ExtraUtility.Play_Sound("Sound3.wav")
						MsgboxAsync("CREATO GIRO DEFINITIVO!","SINCRONIZZAZIONE")
						Activity.Finish
						CallSubDelayed(ListaDocTablet, "ListaDocChkNew")
					Else
						ExtraUtility.Play_Sound("Error.wav")
						MsgboxAsync("PROBLEMI NELLA CREAZIONE DEL GIRO CASH DEFINITIVO!","SINCRONIZZAZIONE")
					End If
				End If
			Else
				MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
			End If
		Else
			B4XTable2.CreateDataView($"c3>=0"$)
			B4XTable2.Refresh
			SelectedRows2.Clear
			Button5.Tag=""
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

Private Sub SwiftButton1_Click
	' Tasto - minicalcolatrice
	If(Label35.Text="") Then
		QtaIns = QtaIns - 1
		If (QtaIns<0) Then
			QtaIns = 0
			ExtraUtility.Play_Sound("error.wav")
		End If
		EditText5.Text = QtaIns
	Else
		If(QtaIns>=0) And (vPesoReale=0) Then
			ToastMessageShow("LEGGERE IL PESO DEL PRODOTTO!",False)
			ExtraUtility.Play_Sound("error.wav")
		Else
			QtaIns = QtaIns - 1
			If(QtaIns>=0) Then
				EditText5.Text = QtaIns
				If(QtaIns=0) Then
					If(vPesoReale>0) Then
						Label35.Text = "KG"
						Label36.Text = "Tot. Kg. "
						Label37.Text = ""
						If(vPesoReale>0) Then
							RegistraPesoRealeArticolo(vRifIdTesta,vCodArticolo,-vPesoReale,vBarcodeLetto)
						End If
						vPesoReale=0
						vTotPesoReale=0
						vTotPesoReale2=0
					Else
						Label35.Text = ""
						Label36.Text = ""
						Label37.Text = ""
						vPesoReale=0
						vTotPesoReale=0
						vTotPesoReale2=0
					End If
				Else
					If(vPesoReale>0) Then						
						If(vTotPesoReale2>0) Then
							vTotPesoReale2 = vTotPesoReale2-vPesoReale
							Label36.Text = "Tot. (L1) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
							Label37.Text = "Tot. (L2) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale2)
						Else
							vTotPesoReale = vTotPesoReale-vPesoReale
							Label36.Text = "Tot. Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
						End If
						If(vPesoReale>0) Then
							RegistraPesoRealeArticolo(vRifIdTesta,vCodArticolo,-vPesoReale,vBarcodeLetto)
						End If
						vPesoReale = 0
						Label35.Text ="KG"
					End If
				End If
			Else
				QtaIns = 0
				ExtraUtility.Play_Sound("error.wav")
			End If
		End If
	End If
	Phone.HideKeyboard
End Sub

Private Sub SwiftButton2_Click
	' Tasto + minicalcolatrice
	If(vPesoReale>0) Then
		QtaIns = QtaIns + 1
		If(vTotPesoReale2>0) Then
			vTotPesoReale2 = vTotPesoReale2+vPesoReale
			Label36.Text = "Tot. (L1) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
			Label37.Text = "Tot. (L2) Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale2)			
		Else
			vTotPesoReale = vTotPesoReale+vPesoReale
			Label36.Text = "Tot. Kg. " & ExtraUtility.Formato_3dec_ITA_Num(vTotPesoReale)
		End If		
		If(vPesoReale>0) Then
			RegistraPesoRealeArticolo(vRifIdTesta,vCodArticolo,vPesoReale,vBarcodeLetto)
		End If
		vPesoReale = 0
		Label35.Text ="KG"
	Else
		Label36.Text =""
		Label37.Text =""
		If(vPesoReale=0) And (vTotPesoReale=0) And (Label35.Text<>"KG") Then
			QtaIns = QtaIns + 1
		Else
			ToastMessageShow("LEGGERE IL PESO DEL PRODOTTO!",False)
			ExtraUtility.Play_Sound("error.wav")
		End If
	End If
	EditText5.Text = QtaIns
	Phone.HideKeyboard
End Sub

Private Sub Button25_Click
	Try
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
					Wait For (Execute_EXEC_PHP_POST_CREAGIROCASH_NESTI(Me, dbAction, straction.ToLowerCase, routine & ".php",vRifIdTesta,Main.Utente,vCodCliFor)) complete (Success As Boolean)
					If(Success) Then
						ExtraUtility.Play_Sound("Sound3.wav")
						MsgboxAsync("AZZERAMENTO SEMAFORI EFFETTUATO!","SINCRONIZZAZIONE")
						Visulizza_Corsie
					Else
						ExtraUtility.Play_Sound("Error.wav")
						MsgboxAsync("PROBLEMI NELL'AZZERAMENTO SEMAFORI!","SINCRONIZZAZIONE")
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