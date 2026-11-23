B4A=true
Group=Default Group\General
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
	Private SQLDataAccess As SQL
End Sub

Sub Globals
	Private Storage As ExternalStorage
	Private FoldersStack As List
	Private UpItem As ExternalFile
	Private ListView1 As ListView
	Private Title1 As Label
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private Label8 As Label
	Private Label9 As Label
	Private Label10 As Label
	Private Label11 As Label
	Private Label12 As Label
	Private SwiftButton1 As SwiftButton
	Private Label13 As Label
	Private SwiftButton2 As SwiftButton
	Private SwiftButton3 As SwiftButton
	Private Panel1 As Panel
	Private Switch1 As Switch
	Private SwiftButton4 As SwiftButton
	Private Switch2 As Switch
	Private Switch3 As Switch
	Private Label16 As Label
	Private Panel2 As Panel
	Private Switch4 As Switch
	Private Label21 As Label
	Private SwiftButton5 As SwiftButton
	Private lblpath As Label
	Private lblTitolo As Label
	Private Scrollview1 As ScrollView
	Private CurrentEdit As EditText
	Private IME1 As IME
	Private values() As String
	Private values_mod() As String
	Private EditText13 As EditText
	Private EditText14 As EditText
	Private EditText15 As EditText
	Private EditText16 As EditText
	Private values_edt() As EditText
	Private pnlPathEdit As Panel
	Private pnlBoxPath As Panel
	Private edtPathBig As EditText
	Private lblPathEditTitle As Label
	Private btnPathOk As Button
	Private btnPathCancel As Button
	Private btnPathExplorer As Button
	Private pnlExplorer As Panel
	Private lvExplorer As ListView
	Private lblExplorerPath As Label
	Private btnExplorerUse As Button
	Private btnExplorerClose As Button
	Private ExplorerCurrentDir As String
	Private Const IDX_DBNAME As Int = 10
	Private Const IDX_PATH_DB As Int = 12
	Private Const IDX_PATH_SOUNDS As Int = 13
	Private Const IDX_SERIAL As Int = 14
	Private pathEditSounds As Boolean
	Private TitleH As Int
	Private FooterBarH As Int
	Private pnlGap1 As Panel
	Private pnlGap2 As Panel
	Private pnlFooter As Panel
	Private btnFooterHelp As Button
	Private btnFooterParam As Button
	Private btnFooterSalva As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	If FirstTime Then
		Storage.Initialize(Me, "Storage")
		FoldersStack.Initialize
		UpItem.Initialize
	End If
	' Riapre sempre il DB corrente (Path DB puo' essere cambiato) e aggiunge Path_DB se manca
	ExtraUtility.CopyDBIfNeeded(Main.DBName)
	SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	DB_SQLite.Alter_Table_IS_IMPOSTAZIONI(SQLDataAccess)

	Activity.LoadLayout("Impostazioni")
	IME1.Initialize("IME")
	IME1.AddHeightChangedEvent

	Activity.Color = Colors.White

	' Se il seriale non e' ancora valorizzato (o era vuoto per il bug di lettura),
	' lo rilegge qui cosi' la maschera lo mostra come nella vecchia versione.
	If Main.serialNo = Null Or Main.serialNo.Trim = "" Then
		If Main.Ditta = "Florenzi" Then
			Main.serialNo = ExtraUtility.GetAndroidID
		Else
			Main.serialNo = ExtraUtility.GetManufacturerSerialNumber
		End If
		Starter.SerialNumber = Main.serialNo
	End If

	Dim fontScale As Float = FontScaleSistema
	TitleH = Max(40dip, 22dip * fontScale + 14dip)
	lblTitolo.Initialize("")
	lblTitolo.Text = "IMPOSTAZIONI"
	lblTitolo.TextSize = 18
	lblTitolo.TextColor = Colors.White
	lblTitolo.Color = Colors.RGB(33, 150, 243)
	lblTitolo.Gravity = Gravity.CENTER
	lblTitolo.Padding = Array As Int(0, 0, 0, 0)
	Activity.AddView(lblTitolo, 0dip, 0dip, 100%x, TitleH)
	TestoSenzaPadding(lblTitolo)

	FooterBarH = Max(58dip, 30dip * fontScale + 12dip)
	Scrollview1.Initialize(0)
	Activity.AddView(Scrollview1, 0dip, TitleH, 100%x, Max(120dip, 100%y - TitleH - FooterBarH))

	' Path DB da file config (non dal SQLite)
	ExtraUtility.LoadPathDBConfig
	If ExtraUtility.DirExt = "" Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
	End If
	Dim pathDbShow As String = ExtraUtility.DirExt
	If pathDbShow = "" And Main.PathDB <> Null Then pathDbShow = Main.PathDB
	ExtraUtility.LoadPathSoundsConfig
	Dim pathSoundsShow As String = ExtraUtility.GetSoundsFolder

	values = Array As String( _
		Main.IP_ServerPHP, _
		Main.PortaPHP, _
		Main.IP_ServerSQL, _
		Main.Istanza_ServerSQL, _
		Main.DBName_ServerSQL, _
		Main.User_ServerSQL, _
		Main.Pwd_ServerSQL, _
		Main.DittaScelta, _
		Main.Utente, _
		Main.Pwd_DBName, _
		Main.DBName, _
		Main.DEBUG, _
		pathDbShow, _
		pathSoundsShow, _
		Main.serialNo _
	)

	Dim labels() As String = Array As String( _
		"IP Server (PHP)", _
		"Porta (PHP)", _
		"IP (Server SQL)", _
		"Istanza SQL", _
		"Nome DB (SQL)", _
		"Utente (SQL)", _
		"Password (SQL)", _
		"Ditta (palmare)", _
		"Utente (palmare)", _
		"Pwd (palmare)", _
		"Nome File (.db)", _
		"DEBUG", _
		"Path DB", _
		"Path sounds", _
		"Serial No." _
	)

	Dim i As Int
	' 14sp diventa piu' alto con la percentuale carattere: la riga deve crescere con lei
	Dim rowH As Int = 24dip * fontScale + 16dip
	If rowH < 48dip Then rowH = 48dip
	Dim gap As Int = rowH + 6dip
	Dim top0 As Int = 6dip

	values_edt = Array As EditText()
	Dim values_edt(labels.Length) As EditText

	Scrollview1.Panel.Color = Colors.White
	Scrollview1.Panel.Height = labels.Length * gap + 20dip

	For i = 0 To labels.Length - 1
		Dim lbl As Label
		Dim edt As EditText

		lbl.Initialize("")
		lbl.Text = labels(i)
		lbl.TextSize = 14
		lbl.Color = Colors.RGB(245, 245, 245)
		lbl.TextColor = Colors.Black
		lbl.Gravity = Gravity.CENTER_VERTICAL
		lbl.Padding = Array As Int(4dip, 0, 2dip, 0)
		lbl.SingleLine = True
		TestoSenzaPadding(lbl)

		edt.Initialize("edt")
		edt.Text = values(i)
		edt.TextSize = 14
		edt.Color = Colors.LightGray
		edt.TextColor = Colors.Blue
		edt.Tag = i
		edt.SingleLine = True
		edt.Padding = Array As Int(4dip, 0, 4dip, 0)
		edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
		TestoSenzaPadding(edt)

		Scrollview1.Panel.AddView(lbl, 2%x, top0 + i * gap, 44%x, rowH)
		Scrollview1.Panel.AddView(edt, 47%x, top0 + i * gap, 51%x, rowH)

		values_edt(i) = edt

		If labels(i) = "Password (SQL)" Or labels(i) = "Pwd (palmare)" Then
			edt.PasswordMode = True
			edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
		Else If labels(i) = "Serial No." Then
			' Stessa riga degli altri campi: numero centrato, senza riquadro piu' alto
			edt.Enabled = False
			edt.TextColor = Colors.Black
			edt.TextSize = 14
			edt.Gravity = Gravity.CENTER
			edt.SingleLine = True
			edt.Padding = Array As Int(4dip, 0, 4dip, 0)
		Else If labels(i) = "Path DB" Or labels(i) = "Path sounds" Then
			' Cliccabile: apre maschera grande per editare il percorso
			edt.Enabled = True
			edt.TextColor = Colors.Blue
			edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
			edt.SingleLine = True
			edt.TextSize = 11
			edt.InputType = 0 ' solo tap, non tastiera inline
		Else If labels(i).StartsWith("IP") Or labels(i).StartsWith("Porta") Then
			edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
		Else
			edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
		End If
	Next

	CreaMascheraPathDB
	StileBottoniImpostazioni
End Sub

' Scala carattere di Android (Impostazioni > Dimensione carattere). 1 = 100%.
Private Sub FontScaleSistema As Float
	Try
		Dim jo As JavaObject
		jo.InitializeContext
		Dim cfg As JavaObject = jo.RunMethodJO("getResources", Null).RunMethod("getConfiguration", Null)
		Dim scale As Float = cfg.GetField("fontScale")
		If scale < 1 Then scale = 1
		Return scale
	Catch
		Log("FontScaleSistema: " & LastException)
		Return 1
	End Try
End Sub

' Toglie il padding interno del font, che con la scala alta taglia le lettere nel bordo della riga.
Private Sub TestoSenzaPadding (v As View)
	Try
		Dim jo As JavaObject = v
		jo.RunMethod("setIncludeFontPadding", Array(False))
	Catch
		Log("TestoSenzaPadding: " & LastException)
	End Try
End Sub

' Barra in basso: Help | Parametri | Salva. Bottoni normali, non gli SwiftButton del layout.
Private Sub StileBottoniImpostazioni
	Try
		Dim margin As Int = 6dip
		Dim gap As Int = 6dip
		Dim barH As Int = FooterBarH
		If barH < 58dip Then barH = 58dip
		Dim topBtn As Int = 100%y - barH
		If topBtn < 0 Then topBtn = 0
		FooterBarH = barH

		If Scrollview1.IsInitialized Then
			Dim scrollTop As Int = TitleH
			If scrollTop < 30dip Then scrollTop = 30dip
			Dim scrollH As Int = topBtn - scrollTop
			If scrollH < 80dip Then scrollH = 80dip
			Scrollview1.SetLayout(0dip, scrollTop, 100%x, scrollH)
		End If

		If pnlFooter.IsInitialized = False Then
			pnlFooter.Initialize("")
			Activity.AddView(pnlFooter, 0, topBtn, 100%x, barH)
			btnFooterHelp.Initialize("btnFooterHelp")
			btnFooterParam.Initialize("btnFooterParam")
			btnFooterSalva.Initialize("btnFooterSalva")
			pnlFooter.AddView(btnFooterHelp, 0, 0, 10dip, 10dip)
			pnlFooter.AddView(btnFooterParam, 0, 0, 10dip, 10dip)
			pnlFooter.AddView(btnFooterSalva, 0, 0, 10dip, 10dip)
			PreparaBottoneFooter(btnFooterHelp, "Help", Colors.RGB(69, 90, 100))
			PreparaBottoneFooter(btnFooterParam, "Parametri", Colors.RGB(69, 90, 100))
			PreparaBottoneFooter(btnFooterSalva, "Salva", Colors.RGB(25, 118, 210))
		End If

		pnlFooter.SetLayout(0, topBtn, 100%x, barH)
		pnlFooter.Color = Colors.White
		pnlFooter.Visible = True

		Dim slotW As Int = (pnlFooter.Width - margin * 2 - gap * 2) / 3
		If slotW < 40dip Then slotW = 40dip
		Dim bh As Int = barH - 8dip
		btnFooterHelp.SetLayout(margin, 4dip, slotW, bh)
		btnFooterParam.SetLayout(margin + slotW + gap, 4dip, slotW, bh)
		btnFooterSalva.SetLayout(margin + (slotW + gap) * 2, 4dip, slotW, bh)
		btnFooterHelp.Visible = True
		btnFooterParam.Visible = True
		btnFooterSalva.Visible = True

		NascondiSwiftLayout
		pnlFooter.BringToFront

		If pnlExplorer.IsInitialized And pnlExplorer.Visible Then
			pnlExplorer.BringToFront
		Else If pnlPathEdit.IsInitialized And pnlPathEdit.Visible Then
			pnlPathEdit.BringToFront
		End If
		Log("Footer Impostazioni top=" & topBtn & " h=" & barH)
	Catch
		Log("StileBottoniImpostazioni: " & LastException)
	End Try
End Sub

Private Sub PreparaBottoneFooter (btn As Button, testo As String, colore As Int)
	btn.Text = testo
	btn.TextSize = 15
	btn.TextColor = Colors.White
	btn.Color = colore
	btn.Gravity = Gravity.CENTER
	btn.Padding = Array As Int(2dip, 0, 2dip, 0)
	TestoSenzaPadding(btn)
	btn.Enabled = True
	btn.Visible = True
End Sub

Private Sub NascondiSwiftLayout
	Try
		If SwiftButton1.IsInitialized Then
			If SwiftButton1.mBase.IsInitialized Then SwiftButton1.mBase.Visible = False
		End If
		If SwiftButton2.IsInitialized Then
			If SwiftButton2.mBase.IsInitialized Then SwiftButton2.mBase.Visible = False
		End If
		If SwiftButton3.IsInitialized Then
			If SwiftButton3.mBase.IsInitialized Then SwiftButton3.mBase.Visible = False
		End If
	Catch
		Log("NascondiSwiftLayout: " & LastException)
	End Try
End Sub

Sub btnFooterHelp_Click
	CallSubDelayed(Me, "SwiftButton2_Click")
End Sub

Sub btnFooterParam_Click
	CallSubDelayed(Me, "SwiftButton3_Click")
End Sub

Sub btnFooterSalva_Click
	CallSubDelayed(Me, "SwiftButton1_Click")
End Sub

Private Sub MettiGapBianco (qualegap As Int, left As Int, top As Int, gapW As Int, h As Int) As Int
	Try
		Dim pnl As Panel
		If qualegap = 1 Then
			If pnlGap1.IsInitialized = False Then
				pnlGap1.Initialize("")
				Activity.AddView(pnlGap1, left, top, gapW, h)
			End If
			pnl = pnlGap1
		Else
			If pnlGap2.IsInitialized = False Then
				pnlGap2.Initialize("")
				Activity.AddView(pnlGap2, left, top, gapW, h)
			End If
			pnl = pnlGap2
		End If
		pnl.SetLayoutAnimated(0, left, top, gapW, h)
		pnl.Color = Colors.White
		pnl.Visible = True
		pnl.BringToFront
	Catch
		Log("MettiGapBianco: " & LastException)
	End Try
	Return gapW
End Sub

Private Sub NascondiGapBottoni
	Try
		If pnlGap1.IsInitialized Then pnlGap1.Visible = False
		If pnlGap2.IsInitialized Then pnlGap2.Visible = False
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub CreaMascheraPathDB
	Dim boxW As Int = 92%x
	Dim boxH As Int = 84%y
	Dim pad As Int = 3%x
	Dim titleH As Int = 40dip

	pnlPathEdit.Initialize("")
	pnlPathEdit.Color = Colors.ARGB(220, 0, 0, 0)
	pnlPathEdit.Visible = False
	Activity.AddView(pnlPathEdit, 0, 0, 100%x, 100%y)

	pnlBoxPath.Initialize("")
	pnlBoxPath.Color = Colors.White
	pnlPathEdit.AddView(pnlBoxPath, 4%x, 8%y, boxW, boxH)

	lblPathEditTitle.Initialize("")
	lblPathEditTitle.Text = "Path DB"
	lblPathEditTitle.TextSize = 18
	lblPathEditTitle.TextColor = Colors.White
	lblPathEditTitle.Color = Colors.RGB(33, 150, 243)
	lblPathEditTitle.Gravity = Gravity.CENTER
	pnlBoxPath.AddView(lblPathEditTitle, 0, 0, boxW, titleH)

	edtPathBig.Initialize("edtPathBig")
	edtPathBig.SingleLine = False
	edtPathBig.Gravity = Bit.Or(Gravity.TOP, Gravity.LEFT)
	edtPathBig.TextSize = 15
	edtPathBig.TextColor = Colors.Black
	edtPathBig.Color = Colors.RGB(245, 245, 245)
	pnlBoxPath.AddView(edtPathBig, pad, titleH + 8dip, boxW - 2 * pad, 110dip)

	' Pulsanti in basso nella box (Explorer sempre cliccabile, non coperto)
	Dim btnW As Int = (boxW - 4 * pad) / 3
	Dim btnTop As Int = boxH - 55dip
	btnPathExplorer.Initialize("btnPathExplorer")
	btnPathExplorer.Text = "Explorer"
	btnPathExplorer.TextSize = 14
	btnPathExplorer.Color = Colors.RGB(76, 175, 80)
	btnPathExplorer.TextColor = Colors.White
	pnlBoxPath.AddView(btnPathExplorer, pad, btnTop, btnW, 45dip)

	btnPathOk.Initialize("btnPathOk")
	btnPathOk.Text = "OK"
	btnPathOk.TextSize = 16
	btnPathOk.Color = Colors.RGB(33, 150, 243)
	btnPathOk.TextColor = Colors.White
	pnlBoxPath.AddView(btnPathOk, pad + btnW + pad, btnTop, btnW, 45dip)

	btnPathCancel.Initialize("btnPathCancel")
	btnPathCancel.Text = "Annulla"
	btnPathCancel.TextSize = 16
	btnPathCancel.Color = Colors.RGB(158, 158, 158)
	btnPathCancel.TextColor = Colors.White
	pnlBoxPath.AddView(btnPathCancel, pad + 2 * (btnW + pad), btnTop, btnW, 45dip)

	' Explorer a livello Activity (sopra tutto), non dentro la box
	pnlExplorer.Initialize("")
	pnlExplorer.Color = Colors.White
	pnlExplorer.Visible = False
	Activity.AddView(pnlExplorer, 0, 0, 100%x, 100%y)

	lblExplorerPath.Initialize("")
	lblExplorerPath.TextSize = 13
	lblExplorerPath.TextColor = Colors.Black
	lblExplorerPath.Color = Colors.RGB(232, 245, 233)
	lblExplorerPath.Gravity = Gravity.CENTER_VERTICAL
	lblExplorerPath.SingleLine = False
	pnlExplorer.AddView(lblExplorerPath, 2%x, 2%y, 96%x, 48dip)

	lvExplorer.Initialize("lvExplorer")
	pnlExplorer.AddView(lvExplorer, 0, 2%y + 52dip, 100%x, 100%y - 2%y - 52dip - 60dip)
	lvExplorer.SingleLineLayout.Label.TextSize = 16
	lvExplorer.SingleLineLayout.ItemHeight = 48dip
	lvExplorer.SingleLineLayout.Label.Gravity = Gravity.CENTER_VERTICAL
	lvExplorer.SingleLineLayout.Label.TextColor = Colors.Black

	Dim expBtnW As Int = 46%x
	btnExplorerUse.Initialize("btnExplorerUse")
	btnExplorerUse.Text = "Usa cartella"
	btnExplorerUse.TextSize = 15
	btnExplorerUse.Color = Colors.RGB(33, 150, 243)
	btnExplorerUse.TextColor = Colors.White
	pnlExplorer.AddView(btnExplorerUse, 2%x, 100%y - 55dip, expBtnW, 48dip)

	btnExplorerClose.Initialize("btnExplorerClose")
	btnExplorerClose.Text = "Chiudi"
	btnExplorerClose.TextSize = 15
	btnExplorerClose.Color = Colors.RGB(158, 158, 158)
	btnExplorerClose.TextColor = Colors.White
	pnlExplorer.AddView(btnExplorerClose, 52%x, 100%y - 55dip, expBtnW, 48dip)
End Sub

Private Sub ApriMascheraPathDB
	pathEditSounds = False
	lblPathEditTitle.Text = "Path DB"
	IME1.HideKeyboard
	edtPathBig.Text = values(IDX_PATH_DB)
	pnlExplorer.Visible = False
	pnlPathEdit.Visible = True
	pnlPathEdit.BringToFront
End Sub

Private Sub ApriMascheraPathSounds
	pathEditSounds = True
	lblPathEditTitle.Text = "Path sounds"
	IME1.HideKeyboard
	edtPathBig.Text = values(IDX_PATH_SOUNDS)
	pnlExplorer.Visible = False
	pnlPathEdit.Visible = True
	pnlPathEdit.BringToFront
End Sub

Sub btnPathOk_Click
	ApplicaPathScelto(edtPathBig.Text.Trim, "")
	pnlExplorer.Visible = False
	pnlPathEdit.Visible = False
	IME1.HideKeyboard
End Sub

Sub btnPathCancel_Click
	pnlExplorer.Visible = False
	pnlPathEdit.Visible = False
	IME1.HideKeyboard
End Sub

Sub btnPathExplorer_Click
	Try
		IME1.HideKeyboard
		Log("Explorer: click")
		' Ripeti permesso storage (necessario per /storage/...)
		ExtraUtility.rp.CheckAndRequest(ExtraUtility.rp.PERMISSION_WRITE_EXTERNAL_STORAGE)
		Wait For Activity_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			MsgboxAsync("Serve il permesso memoria per navigare SD e cartelle.", "Explorer")
			Return
		End If

		' All'apertura: Path DB attuale se valido, altrimenti radice SD (fisica o emulated)
		Dim startDir As String = TrovaCartellaInizialeExplorer(edtPathBig.Text.Trim)
		ExplorerCurrentDir = startDir
		pnlExplorer.Visible = True
		pnlExplorer.BringToFront
		pnlExplorer.Enabled = True
		Sleep(0)
		CaricaExplorer(ExplorerCurrentDir)
	Catch
		Log(LastException)
		MsgboxAsync("Errore Explorer:" & CRLF & LastException.Message, "Explorer")
	End Try
End Sub

' Priorita': Path DB valido → SD fisica/.../Zelari/db → SD fisica → emulated/0/Zelari/db → DirRootExternal
Private Sub TrovaCartellaInizialeExplorer (pathAttuale As String) As String
	Try
		If FolderReadable(pathAttuale) Then Return pathAttuale.Trim

		Dim sdRoot As String = TrovaRadiceSdFisica
		If sdRoot <> "" Then
			Dim sdZelari As String = File.Combine(sdRoot, "Zelari/db")
			If FolderReadable(sdZelari) Then Return sdZelari
			If FolderReadable(File.Combine(sdRoot, "db")) Then Return File.Combine(sdRoot, "db")
			If FolderReadable(sdRoot) Then Return sdRoot
		End If

		Dim emuZelari As String = File.Combine(File.DirRootExternal, "Zelari/db")
		If FolderReadable(emuZelari) Then Return emuZelari
		If FolderReadable(File.Combine(File.DirRootExternal, "db")) Then Return File.Combine(File.DirRootExternal, "db")
		If FolderReadable(File.DirRootExternal) Then Return File.DirRootExternal
		If FolderReadable("/storage") Then Return "/storage"
		Return ExtraUtility.GetDBFolder
	Catch
		Return File.DirRootExternal
	End Try
End Sub

' Cerca volume tipo /storage/XXXX-XXXX (microSD). Vuoto se assente.
Private Sub TrovaRadiceSdFisica As String
	Try
		Dim vols As List = File.ListFiles("/storage")
		If vols.IsInitialized = False Then Return ""
		For Each name As String In vols
			If name = "emulated" Or name = "self" Or name = ".." Then Continue
			' UUID tipico SD: contiene trattino (es. 1A2B-3C4D)
			If name.Contains("-") Then
				Dim root As String = File.Combine("/storage", name)
				If FolderReadable(root) Then Return root
			End If
		Next
	Catch
		Log(LastException)
	End Try
	Return ""
End Sub

Sub btnExplorerClose_Click
	pnlExplorer.Visible = False
End Sub

Sub btnExplorerUse_Click
	edtPathBig.Text = ExplorerCurrentDir
	ApplicaPathScelto(ExplorerCurrentDir, "")
	pnlExplorer.Visible = False
	pnlPathEdit.BringToFront
End Sub

Private Sub ApplicaPathScelto (folder As String, dbFile As String)
	folder = ExtraUtility.NormalizzaPathDb(folder)
	If ExtraUtility.IsUsableDbFolder(folder) = False Then
		Dim titolo As String = "Path DB"
		If pathEditSounds Then titolo = "Path sounds"
		MsgboxAsync("Percorso non valido. Usa Explorer oppure un path completo sotto /storage/.", titolo)
		Return
	End If
	If pathEditSounds Then
		values(IDX_PATH_SOUNDS) = folder
		values_edt(IDX_PATH_SOUNDS).Text = folder
		edtPathBig.Text = folder
		ExtraUtility.SavePathSoundsConfig(folder)
		Return
	End If
	values(IDX_PATH_DB) = folder
	values_edt(IDX_PATH_DB).Text = folder
	edtPathBig.Text = folder
	If dbFile <> "" Then
		values(IDX_DBNAME) = dbFile
		values_edt(IDX_DBNAME).Text = dbFile
		Main.DBName = dbFile
	End If
	ExtraUtility.SavePathDBConfig(folder, Main.DBName)
End Sub

' File.IsDirectory in B4A vuole (parent, name), non un path intero.
Private Sub PathFolderExists (fullPath As String) As Boolean
	Try
		If fullPath = Null Or fullPath.Trim = "" Then Return False
		fullPath = fullPath.Trim
		If fullPath = "/" Or fullPath = "/storage" Or fullPath = File.DirRootExternal Then Return True
		Dim slash As Int = fullPath.LastIndexOf("/")
		If slash < 0 Then Return False
		Dim parent As String = fullPath.SubString2(0, slash)
		If parent = "" Then parent = "/"
		Return File.IsDirectory(parent, fullPath.SubString(slash + 1))
	Catch
		Return False
	End Try
End Sub

' Una cartella e' usabile se ListFiles non fallisce (piu' affidabile di IsDirectory su alcuni path).
Private Sub FolderReadable (fullPath As String) As Boolean
	Try
		If fullPath = Null Or fullPath.Trim = "" Then Return False
		Dim files As List = File.ListFiles(fullPath.Trim)
		Return files.IsInitialized
	Catch
		Return False
	End Try
End Sub

Private Sub CaricaExplorer (dir As String)
	Try
		If dir = Null Or dir.Trim = "" Then dir = "/storage"
		dir = dir.Trim
		Do While dir.EndsWith("/") And dir.Length > 1
			dir = dir.SubString2(0, dir.Length - 1)
		Loop
		ExplorerCurrentDir = dir
		lblExplorerPath.Text = dir
		lvExplorer.Clear
		Log("Explorer: carico " & dir)

		' Scorciatoie fisse in cima
		lvExplorer.AddSingleLine2(">> /storage (volumi / SD)", "DIR|/storage")
		lvExplorer.AddSingleLine2(">> Memoria interna " & File.DirRootExternal, "DIR|" & File.DirRootExternal)
		lvExplorer.AddSingleLine2(">> App/db " & ExtraUtility.GetDBFolder, "DIR|" & ExtraUtility.GetDBFolder)
		Dim zelariDb As String = File.Combine(File.DirRootExternal, "Zelari/db")
		If PathFolderExists(zelariDb) Or FolderReadable(zelariDb) Then
			lvExplorer.AddSingleLine2(">> Zelari/db " & zelariDb, "DIR|" & zelariDb)
		End If

		If dir <> "/" Then
			Dim parent As String
			If dir.Contains("/") Then
				parent = dir.SubString2(0, dir.LastIndexOf("/"))
				If parent = "" Then parent = "/"
			Else
				parent = "/"
			End If
			lvExplorer.AddSingleLine2(".. (cartella superiore)", "DIR|" & parent)
		End If

		Dim files As List = File.ListFiles(dir)
		If files.IsInitialized = False Then
			lvExplorer.AddSingleLine2("(cartella non leggibile - manca permesso?)", "NONE|")
			Return
		End If

		files.SortCaseInsensitive(True)
		Dim nDir As Int = 0
		Dim nDb As Int = 0
		For Each fname As String In files
			' Nasconde voci di sistema inutili in /storage
			If dir = "/storage" Then
				If fname = "self" Or fname = "emulated" Then
					' emulated lo mostriamo come memoria interna
					If fname = "emulated" Then
						lvExplorer.AddSingleLine2("[emulated/0 = memoria interna]", "DIR|" & File.Combine(File.Combine(dir, "emulated"), "0"))
					End If
					Continue
				End If
			End If
			If File.IsDirectory(dir, fname) Then
				nDir = nDir + 1
				Dim label As String = "[" & fname & "]"
				' UUID tipo 1A2B-3C4D = SD fisica tipica
				If dir = "/storage" And fname.Contains("-") Then
					label = "[SD FISICA] " & fname
				End If
				lvExplorer.AddSingleLine2(label, "DIR|" & File.Combine(dir, fname))
			End If
		Next
		For Each fname As String In files
			If File.IsDirectory(dir, fname) = False Then
				If fname.ToLowerCase.EndsWith(".db") Then
					nDb = nDb + 1
					lvExplorer.AddSingleLine2(fname, "DB|" & File.Combine(dir, fname))
				End If
			End If
		Next
		If nDir = 0 And nDb = 0 Then
			lvExplorer.AddSingleLine2("(nessuna sottocartella / .db qui)", "NONE|")
		End If
	Catch
		Log(LastException)
		MsgboxAsync("Impossibile leggere:" & CRLF & dir & CRLF & LastException.Message, "Explorer")
	End Try
End Sub

Sub lvExplorer_ItemClick (Position As Int, Value As Object)
	Try
		Dim s As String = "" & Value
		Log("Explorer click: " & s)
		If s.StartsWith("DIR|") Then
			Dim folder As String = s.SubString(4)
			' Prova sempre ad entrare: FolderReadable e' il vero test
			If FolderReadable(folder) Or PathFolderExists(folder) Or folder = "/storage" Or folder = "/" Then
				CaricaExplorer(folder)
			Else
				MsgboxAsync("Cartella non accessibile:" & CRLF & folder, "Explorer")
			End If
		Else If s.StartsWith("DB|") Then
			Dim full As String = s.SubString(3)
			Dim slash2 As Int = full.LastIndexOf("/")
			If slash2 > 0 Then
				Dim folder2 As String = full.SubString2(0, slash2)
				Dim dbName As String = full.SubString(slash2 + 1)
				ApplicaPathScelto(folder2, dbName)
				pnlExplorer.Visible = False
				pnlPathEdit.BringToFront
				MsgboxAsync("Selezionato:" & CRLF & folder2 & CRLF & dbName, "Explorer")
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_Resume
	StileBottoniImpostazioni
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub SwiftButton1_Click
	Wait For (SalvaImpostazioni) Complete (Result As Boolean)
	Activity.Finish
End Sub

'Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
'	If NewHeight > 0 And CurrentEdit.IsInitialized Then
'		Dim spazioVisibile As Int = Scrollview1.Height - NewHeight
'		Dim bordoInferioreCampo As Int = CurrentEdit.Top + CurrentEdit.Height
'		If bordoInferioreCampo > Scrollview1.ScrollPosition + spazioVisibile Then
'			Scrollview1.ScrollPosition = bordoInferioreCampo - spazioVisibile + 20dip
'		End If
'	End If	
'End Sub

Sub SalvaImpostazioni As ResumableSub
	Dim sqlstr As String

	Main.PathDB = values(IDX_PATH_DB).Trim
	Do While Main.PathDB.EndsWith("/") And Main.PathDB.Length > 1
		Main.PathDB = Main.PathDB.SubString2(0, Main.PathDB.Length - 1)
	Loop
	values(IDX_PATH_DB) = Main.PathDB
	Main.DBName = values(IDX_DBNAME).Trim
	ExtraUtility.SavePathDBConfig(Main.PathDB, Main.DBName)
	Dim pathSounds As String = values(IDX_PATH_SOUNDS).Trim
	Do While pathSounds.EndsWith("/") And pathSounds.Length > 1
		pathSounds = pathSounds.SubString2(0, pathSounds.Length - 1)
	Loop
	values(IDX_PATH_SOUNDS) = pathSounds
	ExtraUtility.SavePathSoundsConfig(pathSounds)
	' Assicura che la colonna esista sul DB effettivamente in uso
	SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	DB_SQLite.Alter_Table_IS_IMPOSTAZIONI(SQLDataAccess)

	sqlstr = "UPDATE IMPOSTAZIONI SET " & _
		"IP_SERVERPHP = '" & values(0) & "', " & _
		"PORTAPHP = '" & values(1) & "', " & _
		"IP_SERVERSQL = '" & values(2) & "', " & _
		"DITTA = '" & values(7) & "', " & _
		"UTENTE = '" & values(8) & "', " & _
		"ISTANZA_SERVERSQL = '" & values(3) & "', " & _
		"DBNAME_SERVERSQL = '" & values(4) & "', " & _
		"USER_SERVERSQL = '" & values(5) & "', " & _
		"PWD_SERVERSQL = '" & values(6) & "', " & _
		"DBNAME_PALMARE = '" & values(10) & "', " & _
		"PWD_PALMARE = '" & values(9) & "', " & _
		"DEBUG = '" & values(11) & "', " & _
		"REPEAT_ADD = '" & Main.SwitchRepeatAdd & "', " & _
		"IMAGES = '" & Main.SwitchImages & "', " & _
		"QTA_DEFAULT = '" & Main.SwitchQtaDefault & "', " & _
		"AltRiga = '" & Main.AltRiga & "', " & _
		"LargDescRiga = '" & Main.LargDescRiga & "', " & _
		"Mode_SPP = '" & Main.SwitchMode_SPP & "', " & _
		"Path_Images = '" & Main.PathImages & "', " & _
		"Path_DB = '" & Main.PathDB & "' " & _
		"WHERE RowId = " & Main.RowID_Impostazioni

	Log(sqlstr)
	SQLDataAccess.ExecNonQuery(sqlstr)

	Sleep(0)

	Dim rs As ResultSet
	rs = SQLDataAccess.ExecQuery("SELECT IP_SERVERPHP,PORTAPHP,IP_SERVERSQL,DITTA,UTENTE,ISTANZA_SERVERSQL,DBNAME_SERVERSQL," & _
		"USER_SERVERSQL,PWD_SERVERSQL,DBNAME_PALMARE,PWD_PALMARE,DEBUG,REPEAT_ADD,IMAGES,QTA_DEFAULT,AltRiga,LargDescRiga,Mode_SPP,Path_Images,Path_DB FROM IMPOSTAZIONI")

	Do While rs.NextRow
		Main.IP_ServerPHP = rs.GetString("IP_SERVERPHP")
		Main.PortaPHP = rs.GetString("PORTAPHP")
		Main.IP_ServerSQL = rs.GetString("IP_SERVERSQL")
		Main.DittaScelta = rs.GetString("DITTA")
		Main.Utente = rs.GetString("UTENTE")
		Main.Istanza_ServerSQL = rs.GetString("ISTANZA_SERVERSQL")
		Main.DBName_ServerSQL = rs.GetString("DBNAME_SERVERSQL")
		Main.User_ServerSQL = rs.GetString("USER_SERVERSQL")
		Main.Pwd_ServerSQL = rs.GetString("PWD_SERVERSQL")
		Main.DBName = rs.GetString("DBNAME_PALMARE")
		Main.Pwd_DBName = rs.GetString("PWD_PALMARE")
		Main.DEBUG = rs.GetInt("DEBUG")
		Main.SwitchRepeatAdd = rs.GetInt("REPEAT_ADD")
		Main.SwitchImages = rs.GetInt("IMAGES")
		Main.SwitchQtaDefault = rs.GetInt("QTA_DEFAULT")
		Main.AltRiga = rs.GetString("AltRiga")
		Main.LargDescRiga = rs.GetInt("LargDescRiga")
		Main.SwitchMode_SPP = rs.GetInt("Mode_SPP")
		Main.PathImages = rs.GetString("Path_Images")
		Main.PathDB = rs.GetString("Path_DB")
		If Main.PathDB <> Null And Main.PathDB.Trim <> "" Then
			ExtraUtility.DirExt = Main.PathDB.Trim
		End If
	Loop
	rs.Close

	Return True
End Sub

Sub SwiftButton2_Click	
	Msgbox2Async("Vuoi procedere con l'invio del DB a " & Main.MessageNomeDitta, "EMERGENZA DB", "SI", "NO", "", Null, False)
	Wait For MsgBox_Result (Result As Int)
	If Result = DialogResponse.POSITIVE Then
		'ftp was previously initialized and its event name was set to ftp:
		Dim ftp As FTP
		ftp.Initialize("ftp", "www.ideasistemi.net", 21, "ideasistemi", "sistemiidea")
		' ftp.Initialize("ftp", "ftp.greensoft.biz", 21, "286129@aruba.it", "dc46484d93")
		ftp.PassiveMode = True
		' ftp.SendCommand("MKD", "/www.greensoft.biz/AreaFTP/Test/Zelari")
		' Dim sf As Object = ftp.UploadFile(File.DirDefaultExternal, "/db/Zelari.db", False, "/www.greensoft.biz/AreaFTP/Test/Zelari/" & Main.DBName)
		Dim sf As Object = ftp.UploadFile(ExtraUtility.GetDBFolder, Main.DBName, False, "/Pocket_ISA_SOS/" & Main.DBName)
		Wait For (sf) ftp_UploadCompleted (ServerPath As String, Success As Boolean)
		If Success Then
			MsgboxAsync("Invio del DB via FTP concluso con successo!","INVIO FTP")
		Else
			MsgboxAsync("Errore di durante la fase di invio!","INVIO FTP")
		End If
	End If
End Sub

Sub edt_FocusChanged (HasFocus As Boolean)
	Dim e As EditText = Sender
	Dim index As Int = e.Tag

	If HasFocus Then
		If index = IDX_PATH_DB Then
			e.Enabled = False
			e.Enabled = True
			ApriMascheraPathDB
			Return
		Else If index = IDX_PATH_SOUNDS Then
			e.Enabled = False
			e.Enabled = True
			ApriMascheraPathSounds
			Return
		End If
		CurrentEdit = e
		e.Gravity = Gravity.LEFT
		Scrollview1.ScrollPosition = Max(0, e.Top - 40dip)
	Else
		Select index
			Case 0, 1, 2
				e.Gravity = Gravity.RIGHT
			Case IDX_SERIAL
				e.Gravity = Gravity.CENTER
			Case Else
				e.Gravity = Gravity.LEFT
		End Select
	End If
End Sub

Sub edt_Click
	Dim e As EditText = Sender
	Dim index As Int = e.Tag
	If index = IDX_PATH_DB Then
		ApriMascheraPathDB
	Else If index = IDX_PATH_SOUNDS Then
		ApriMascheraPathSounds
	End If
End Sub

Sub SwiftButton3_Click
'	Panel1.Visible = True
'	Panel1.BringToFront
'	Panel1.Top=30dip
'	Dim btn As Button
'	btn.Initialize("btnClick")
'	btn.Typeface = Typeface.LoadFromAssets("b4x_fontawesome.otf")
'	btn.Text = Chr(0xF061)
'	Panel1.AddView(btn, 10dip, 10dip, 150dip, 50dip)
'	SwiftButton4.mBase.Visible=True
'	SwiftButton4.mBase.top = 85%y
	StartActivity(Impostazioni2)
End Sub

Private Sub EnterFolder (folder As ExternalFile)
	FoldersStack.Add(folder)
	Dim sb As StringBuilder
	sb.Initialize
	For Each f As ExternalFile In FoldersStack
		If f = Storage.Root Then
			sb.Append("Root")
		Else
			sb.Append(" / ").Append(f.Name)
		End If
	Next
	lblpath.Text = sb.ToString
	ListView1.Clear
		
	If FoldersStack.Size > 1 Then
		ListView1.AddSingleLine2("..", UpItem)
	End If
	For Each f As ExternalFile In Storage.ListFiles(folder)
		Log("log: " & f.Name)
		If f.IsFolder Then
			ListView1.AddSingleLine2($"[${f.Name}]"$, f)			
		Else If IsImageFile(f.Name) Then
			Dim cs As CSBuilder
			cs.Initialize.Append(f.Name).Append(" ").Color(0xFF00EEFF).Append("(click)").PopAll
			ListView1.AddSingleLine2(cs, f)
		Else
			ListView1.AddSingleLine2(f.Name, f)
		End If
	Next
End Sub

Private Sub IsImageFile (Name As String) As Boolean
	Dim n As String = Name.ToLowerCase
	For Each extension As String In Array(".jpg", ".png", ".gif", ".bmp")
		If n.EndsWith(extension) Then Return True
	Next
	Return False
End Sub

Sub edt_TextChanged (Old As String, New As String)
	Dim et As EditText = Sender
	Dim index As Int = et.Tag
	values(index) = New
	#if debug
		Log("EditText index: " & index & " valore: " & New)
	#End If
End Sub