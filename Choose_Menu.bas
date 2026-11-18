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
	Public vTipoCliFor As String = ""
	Public vOperazioneMenu As String
	Public vCodCliForInventario As String
	Public vReparto As String
	Public mMySoundLoadID1 As Int
	Public mMySoundLoadID2 As Int
	Public mMySoundLoadID3 As Int
	Public mMySoundLoadID4 As Int
	Public mMySoundLoadID5 As Int
	Public mMySoundLoadID6 As Int
	Public mMySoundLoadID7 As Int
	Public mSoundPool As SoundPool
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Label1 As Label
	Private Scelta_Menu1 As Button
	Private Scelta_Menu2 As Button
	Private Scelta_Menu3 As Button
	Private Scelta_Menu4 As Button
	Private Scelta_Menu5 As Button
	'Private webReport As WebView
	Private Button1 As Button
	Private Button2 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private ProgressBar1 As ProgressBar
	'Private F_LeggiMetodo As Boolean = False
	'Private F_ScriviMetodo As Boolean = False
	Private Label2 As Label 
	Public ApsList As List
	Public Scan As MLScan
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Label1.Initialize("")
	Label2.Initialize("")
	Scelta_Menu1.Initialize("")
	Scelta_Menu2.Initialize("")
	Scelta_Menu3.Initialize("")
	Scelta_Menu4.Initialize("")
	Scelta_Menu5.Initialize("")
	Button1.Initialize("")
	Button2.Initialize("")
	Button4.Initialize("")
	Button5.Initialize("")
	Button6.Initialize("")
	ProgressBar1.Initialize("")
	'Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
		ExtraUtility.CopySoundsIfNeeded("ok.wav")
		ExtraUtility.CopySoundsIfNeeded("button.wav")
		ExtraUtility.CopySoundsIfNeeded("error.wav")
		ExtraUtility.CopySoundsIfNeeded("Sound1.wav")
		ExtraUtility.CopySoundsIfNeeded("Sound2.wav")
		ExtraUtility.CopySoundsIfNeeded("Sound3.wav")
		ExtraUtility.CopySoundsIfNeeded("VoiceOK.wav")
		If (Main.Ditta="Nesti") Then
			ExtraUtility.CopyIfNeeded("semaphore0.png","Icons")
			ExtraUtility.CopyIfNeeded("semaphore1.png","Icons")
			ExtraUtility.CopyIfNeeded("semaphore2.png","Icons")
			ExtraUtility.CopyIfNeeded("semaphore3.png","Icons")
			ExtraUtility.CopyIfNeeded("semaphore4.png","Icons")
		End If
		If Not(mSoundPool.IsInitialized) Then
			mSoundPool.Initialize(2)
		End If
	End If
	Dim soundDir As String = ExtraUtility.rp.GetSafeDirDefaultExternal("sounds")
	mMySoundLoadID1 = mSoundPool.Load(soundDir, "Sound1.wav")
	mMySoundLoadID2 = mSoundPool.Load(soundDir, "Sound2.wav")
	mMySoundLoadID3 = mSoundPool.Load(soundDir, "Sound3.wav")
	mMySoundLoadID4 = mSoundPool.Load(soundDir, "error.wav")
	mMySoundLoadID5 = mSoundPool.Load(soundDir, "ok.wav")
	mMySoundLoadID6 = mSoundPool.Load(soundDir, "voiceok.wav")
	mMySoundLoadID7 = mSoundPool.Load(soundDir, "button.wav")
	Activity.RemoveAllViews
	Activity.LoadLayout("Menu_" & Main.Ditta)	
	Sleep(0)			
	Dim DataOggi As String
	DataOggi = ExtraUtility.DateToFormat(DateTime.Now,  "dd-MM-yyyy HH:mm:ss","it","")	
	Label1.text = "Ver. " & Main.VersioneSW & Chr(13) & Chr(10) & "Ditta: " & Main.DittaScelta &  Chr(13) & Chr(10) & "Utente: " & Main.Utente & Chr(13) & Chr(10) & "Sync: " & DataOggi
	ProgressBar1.Progress = 0
	ProgressBar1.Visible = False
	Label2.Visible = False
	If(Main.Ditta="Nesti") Then
		If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
			Scelta_Menu1.Enabled=True
			Scelta_Menu2.Enabled=True
			Scelta_Menu3.Enabled=True
			Scelta_Menu4.Enabled=True
			Scelta_Menu5.Enabled=True
		Else
			Scelta_Menu1.Enabled=False
			Scelta_Menu2.Enabled=False
			Scelta_Menu3.Enabled=False
			Scelta_Menu4.Enabled=True
			Scelta_Menu5.Enabled=False
		End If
	End If
End Sub

Sub Activity_Resume
	' Log(Activity.GetStartingIntent)
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Scelta_Menu1_Click
	Try
		' Activity.RemoveAllViews
		Select Case Main.Ditta
			Case "ZelariVi"
				' Documenti: tutti (reset filtro lasciato da Clienti/Fornitori)
				vTipoCliFor = ""
				vOperazioneMenu = ""
				StartActivity( ListaDoc)
				
			Case "Trendy"
				vTipoCliFor = "F"
				vOperazioneMenu = ""
				StartActivity( ListaDoc)
				
			Case "Esseci"
				vTipoCliFor = "F"
				vOperazioneMenu = ""
				StartActivity( ListaDoc)
				
			Case "Nesti"
				vTipoCliFor = "F"
				vOperazioneMenu = "Carico Ordine Fornitore"
				StartActivity( ListaDocTablet)				
								
			Case "Kuore"
				vTipoCliFor = "C"
				vOperazioneMenu = "SpuntaCarnet"
				StartActivity(ListaDoc)
				
			Case "Carbon"
				vReparto = "LAMINAZIONE"
				StartActivity(ListaTempi_Carbon)				
			
			Case "Gefin"
				StartActivity(ListaTempi_Gefin)
				
		End Select	
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Scelta_Menu2_Click
	Try
		Select Case Main.Ditta
			Case "ZelariVi"
				' Magazzino / Documenti: nessun filtro residuo da Clienti/Fornitori
				vTipoCliFor = ""
				vOperazioneMenu = ""
				StartActivity( ListaDoc)
				
			Case "Esseci"
				vTipoCliFor = "C"
				StartActivity( ListaDoc)
				
			Case "Nesti"
				' Spostamento
				vTipoCliFor = "Z"
				vCodCliForInventario = "C 91012"
				vOperazioneMenu = "Spostamento"
				StartActivity( ListaDocTablet)
				
		End Select	
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Scelta_Menu3_Click
	Try
		Select Case Main.Ditta
			Case "ZelariVi"
				' Lista Fornitori
				NewDocument.vTipoTab = 1
				vTipoCliFor = "F"
				StartActivity(ListaTab)
			Case "Florenzi"
				' Inventario
				vTipoCliFor = "F"
				StartActivity(ListaDoc)
			Case "Trendy"
				' Inventario
				vTipoCliFor = "F"
				StartActivity(ListaDoc)
			Case "Esseci"
				' Inventario
				vTipoCliFor = "X"
				StartActivity(ListaDoc)
			Case "Nesti"
				' Inventario
				vTipoCliFor = "X"				
				vCodCliForInventario = "F   324"
				vOperazioneMenu = "Inventario"
				StartActivity( ListaDocTablet)
			Case "Kuore"
				' Creazione Documento
				vOperazioneMenu = "CreazioneDoc"
				vTipoCliFor = "C"
				StartActivity(ListaDoc)
			Case "Gefin"
				' Inventario
				vTipoCliFor = "F"
				Inizializza_Parametridoc
				StartActivity(ListaDoc)
			Case "Carbon"
				vReparto = "AUTOCLAVI"
				Starter.Parametro2 = ""
				StartActivity(Autoclavi)
															
		End Select
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Scelta_Menu4_Click
	Try
		Select Case Main.Ditta
			Case "ZelariVi"
				' Lista Clienti
				NewDocument.vTipoTab = 1
				vTipoCliFor = "C"
				StartActivity(ListaTab)
			Case "Trendy"
				' Verifica Prezzo
				StartActivity( VerificaPrezzo)
			Case "Esseci"
				' Verifica Prezzo
				StartActivity( VerificaPrezzo)
			Case "Nesti"
				' Cash				
				vTipoCliFor = "W"
				vOperazioneMenu = "Cash"
				StartActivity(ListaDocTablet)
			Case "Kuore"
				' Check Referenza
				StartActivity(CheckRef_Kuore)

		End Select
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Scelta_Menu5_Click
	Try
		Select Case Main.Ditta
			Case "ZelariVi"
				'StartActivity(ListaTab)
			Case "Trendy"
				'StartActivity( VerificaPrezzo)
			Case "Esseci"
				'StartActivity( VerificaPrezzo)
			Case "Nesti"
				vTipoCliFor = "G"
				vOperazioneMenu = "Picking"
				StartActivity( ListaDocTablet)
			Case "Kuore"				
				
		End Select
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	Try
	   	Select KeyCode
	   		Case KeyCodes.KEYCODE_BACK 
	       		HandleBackKey 
		   		Return True
			Case KeyCodes.KEYCODE_HOME
				Return False
			Case Else
				Return False
		End Select
	Catch
		Return False
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

'generate a webview of the records
'Sub ShowReport(res As List)
'	ProgressDialogShow2("Generating report, please be patient...",False)
'	'remove all views
'	Activity.RemoveAllViews
'	'load the report layout
'	Activity.LoadLayout("vReport")
'	Activity.Title = "Users Report"
'	'lets build the report
'	Dim HtmlCSS As String = "table {width: 100%;border: 1px solid #cef;text-align: left; }" _
'		& " th { font-weight: bold;	background-color: #acf;	border-bottom: 1px solid #cef; }" _ 
'		& "td,th {	padding: 4px 5px; }" _
'		& ".odd {background-color: #def; } .odd td {border-bottom: 1px solid #cef; }" _
'		& "a { text-decoration:none; color: #000;}"
'	Dim sb As StringBuilder
'	sb.Initialize
'	'define the body of the page
'	sb.Append("<html><body>").Append(CRLF)
'	'inject the css style
'	sb.Append("<style type='text/css'>").Append(HtmlCSS).Append("</style>").Append(CRLF)
'	'define the table and heading
'	sb.Append("<table><thead><tr>").Append(CRLF)
'	'lets get the first record from to determine the fields
'	'get the records, its json
'	Dim rec1 As String = res.Get(0)
'	'convert the record to json
'	Dim recm As Map = DBPhp.Json2Map(rec1)
'	'define a list to store column names
'	Dim cols As List
'	cols.Initialize
'	For Each strKey As String In recm.Keys
'		cols.Add(strKey)
'	Next
'	'create each column as table heading
'	For i = 0 To cols.Size - 1
'		sb.Append("<th>").Append(cols.get(i)).Append("</th>")
'	Next
'	sb.Append("</thead>")
'	sb.Append("</tr>").Append(CRLF)
'	Dim row As Int
'	'add the column data per record
'	For Each recm As Map In res
'		If row Mod 2 = 0 Then
'			sb.Append("<tr>")
'		Else
'			sb.Append("<tr class='odd'>")
'		End If
'		For i = 0 To cols.Size - 1
'			sb.Append("<td>")
'			Dim colName As String = cols.Get(i)
'			Dim colValue As String = recm.GetDefault(colName,"")
'			sb.Append(colValue)
'			sb.Append("</td>")
'		Next
'		sb.Append("</tr>").Append(CRLF)
'		row = row + 1
'	Next
'	sb.Append("</table></body></html>")
'	'inject to webview
'	webReport.LoadHtml(sb.ToString)
'End Sub

Private Sub HandleBackKey
   Try
	   Msgbox2Async("Vuoi uscire dal programma?", "Pocket ISA", "SI", "NO", "", Null, False)
	   Wait For MsgBox_Result (Result As Int)
	   If Result = DialogResponse.POSITIVE Then
			Activity.Finish
			ExtraUtility.CloseActivities
			ExitApplication
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

'execute a php call
Sub ExecutePHP_GET(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String)
	Try
		ProgressDialogShow2("Communicating with the server...",False)
		Dim job As HttpJob
		Dim scommand As String
		Dim json As String
		Dim Path_Php As String = ""
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		json = DBPhp.Map2QueryString(pQuery)
		If (Main.PortaPhp <> "") Then
			Path_Php = $"http://${Main.IP_ServerPHP}${Main.PortaPhp}/${Main.Folder_Php}/"$
		Else
			Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/"$
		End If
		If DBPhp.Len(json) = 0 Then
			scommand = $"${Path_Php}${phpFile}"$
		Else
			scommand = $"${Path_Php}${phpFile}?${json}"$
		End If
		Log("Inizio " & scommand)
		'execute a download on the php file
		job.Download(scommand)
		wait for(job) JobDone(job As HttpJob)
		If job.Success Then
			Log("response: " & job.GetString)
		Else
			Log("Error: " & job.ErrorMessage)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_ZELARI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim job As HttpJob
		Dim Path_Php As String = ""
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
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
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=1) Then
						DB_SQLite.Create_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
					End If
					
					Select job.JobName.ToLowerCase
						
						Case "get_is_palmdevice"
							DB_SQLite.Alter_Table_IS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "is_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_tabcambi"
							Log(Path_Php & "is_tabcambi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabCambi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_parametridoc"
							Log(Path_Php & "is_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
											
						Case "get_is_listiniarticoli"
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case "get_is_anagraficacf"
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficaarticoli"
							Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficadepositi"
							Log(Path_Php & "is_anagraficadepositi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaDepositi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
														
						Case "get_is_tablistini"
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_vistadocumenti"
							DB_SQLite.Alter_Table_IS_VISTADOCUMENTI(SQLDataAccess)
							Log(Path_Php & "is_vistadocumenti.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_VistaDocumenti(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST")
										
					End Select
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
					End If
				End If
			Else
				Log("Error: " & job.ErrorMessage)
			End If
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim job As HttpJob
		Dim Path_Php As String = ""
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
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
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
					End If
					
					Select job.JobName.ToLowerCase
						
						Case "get_is_palmdevice"
							DB_SQLite.Alter_Table_IS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "is_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_tabcambi"
							Log(Path_Php & "is_tabcambi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabCambi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_parametridoc"
							Log(Path_Php & "is_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
											
						Case "get_is_listiniarticoli"
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case "get_is_anagraficacf"
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficaarticoli"
							Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficadepositi"
							Log(Path_Php & "is_anagraficadepositi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaDepositi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
														
						Case "get_is_tablistini"
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_vistadocumenti"
							DB_SQLite.Alter_Table_IS_VISTADOCUMENTI(SQLDataAccess)
							Log(Path_Php & "is_vistadocumenti.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_VistaDocumenti(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST")
										
					End Select
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Fine: " & job.JobName.ToLowerCase,"DEBUG")
					End If
				End If
			Else
				Log("Error: " & job.ErrorMessage)
			End If
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False	
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_ESSECI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim job As HttpJob
		Dim Path_Php As String = ""
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try	
			NumTable = NumTable-1
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
	'		phpFile="is_barcode.php"	
	'		mAction="get_is_barcode"
			job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
				ProgressDialogHide
				If job.Success = True Then
					Dim jobResult As String = job.GetString
					'Dim jobTag As String = job.tag
					job.release				
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If					
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Create_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
					End If
					Select job.JobName.ToLowerCase
						
						Case "get_is_palmdevice"
							DB_SQLite.Alter_Table_IS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "is_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
													
						Case "get_is_tabcambi"
							Log(Path_Php & "is_tabcambi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabCambi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_parametridoc"
							Log(Path_Php & "is_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
											
						Case "get_is_listiniarticoli"
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficacf"
							DB_SQLite.Alter_Table_IS_ANAGRAFICACF(SQLDataAccess)
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)						
							Wait For(DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
														
						Case "get_is_anagraficaarticoli"
							Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
														
						Case "get_is_anagraficadepositi"
							Log(Path_Php & "is_anagraficadepositi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaDepositi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_tablistini"
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																			
						Case "get_is_barcode"
							Log(Path_Php & "is_barcode.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_IS_Barcode(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_listinoart"
							Log(Path_Php & "is_listinoart.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_LISTINOART(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_ListinoArt(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
								
						Case "get_is_vistapuntivenditapalmare"
							Log(Path_Php & "is_vistapuntivenditapalmare.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_VISTAPUNTIVENDITAPALMARE(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_VistaPuntiVenditaPalmare(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
				
						Case "get_vistagiacenzaperpalmare"
							Log(Path_Php & "vistagiacenzaperpalmare.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTAGIACENZAPERPALMARE(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_VistaGiacenzePalmare(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_ESSECI")						
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_ListaAutoclavi(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
	' SCRIVE LA TABELLA LISTATEMPI VERSO SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim Path_Php As String = ""
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			Select Case Main.Ditta
				Case "Carbon"
					sqlstr = "SELECT POS,CAUSALE,CODART,DATAORA,CODICEDIP,CODICEREP,REPARTO FROM GS_LISTATEMPI WHERE ifnull(TRASMESSO,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String( DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
					Log(sqlstr)
					json = DBPhp.Map2Json(m)
			End Select
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun dato da inviare!","Sincronizzazione " & Main.MessageBoxText)
				Return False
			Else
				Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
					MsgboxAsync("Errore GS_LISTATEMPI " & job.ErrorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("GS_LISTATEMPI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_ListaTempi(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
	' SCRIVE LA TABELLA LISTATEMPI VERSO SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim Path_Php As String = ""
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			Select Case Main.Ditta
				Case "Carbon"
					sqlstr = "SELECT POS,CAUSALE,CODART,DATAORA,CODICEDIP,CODICEREP,REPARTO FROM GS_LISTATEMPI WHERE ifnull(TRASMESSO,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String( DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
					Log(sqlstr)					
					json = DBPhp.Map2Json(m)								
			End Select
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun dato da inviare!","Sincronizzazione " & Main.MessageBoxText)
				Return False
			Else
				Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} GS_LISTATEMPI"$) 'Current time is 11:17:45
					MsgboxAsync("Errore GS_LISTATEMPI " & job.ErrorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("GS_LISTATEMPI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_Palmare_Out(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
	' SCRIVE LE TESTE VERSO SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim Path_Php As String = ""
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			Select Case Main.Ditta
				Case "Kuore"
					sqlstr = "SELECT '" & Main.Utente & "' AS UTENTE, 'MAG' as TIPORECORD, RD.CodArt as BARCODE,RD.Qta as QUANTITA, RD.Partita as PARTITA, 0 as ELABORATO," _
					& "TD.TipoDoc as TIPODOC, TD.DataDoc as DATADOC, TD.DataDoc as DATAMODIFICA,'" & Main.Utente & "' as UTENTEMODIFICA, RD.PrzUnit as PRZUNIT, TD.NOTE as NOTETESTATA, " _
					& "RD.NOTE as NOTERIGA, TD.CODCLIFOR as CODCLIFOR, TD.NRLISTINO as NRLISTINO, TD.Numerodoc as NUMERODOC, RD.Idriga AS IDRIGA FROM IS_RIGHEDOCUMENTI RD LEFT OUTER JOIN IS_TESTEDOCUMENTI " _
					& "TD ON TD.TipoDoc=RD.TipoDoc AND TD.Numerodoc=RD.Numerodoc And TD.Esercizio=RD.Esercizio WHERE ifnull(Trasmesso,0)=0"
					Log(sqlstr)									
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String( _
					DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_INTEGER, _
					DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT, DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER))	
					json = DBPhp.Map2Json(m)
								
			End Select
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun Documento da inviare!","Sincronizzazione " & Main.MessageBoxText)
				Return -1
			Else				
				Log($"Current time is $time{DateTime.Now} IS_PALMAREOUT"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				'job.Poststring(Path_Php & "users_post.php","action=" & mAction&"&json_data="&json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now} IS_PALMAREOUT"$) 'Current time is 11:17:45
					Return 1
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now} IS_PALMAREOUT"$) 'Current time is 11:17:45
					MsgboxAsync("Errore IS_PALMAREOUT " & job.ErrorMessage,"Errore")
					Return 2
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return -2
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("IS_PALMAREOUT " & LastException.Message) 'no changes will be made
		Return 3
	End Try
End Sub

Sub Execute_Scrivi_DB_TesteDoc(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub		
	' SCRIVE LE TESTE VERSO SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try		
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			Dim Path_Php As String = ""
			Dim m As Map
			Dim json As String
			Dim job As HttpJob
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			Select Case Main.Ditta
				Case "ZelariVi"
					sqlstr = "SELECT TipoDoc,IDKEY as Numerodoc,Esercizio,UtenteModifica,CodClifor,NrListino,1 as Trasmesso,IDKEY,Datadoc,ifnull(Valuta,0) as Valuta,ifnull(Elaborato,0) " _
					& " As Elaborato from IS_TESTEDOCUMENTI WHERE ifnull(Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER))
					json = DBPhp.Map2Json(m)
					
				Case "Gefin"
					sqlstr = "SELECT TipoDoc,IDKEY as Numerodoc,Esercizio,UtenteModifica,CodClifor,NrListino,1 as Trasmesso,IDKEY,Datadoc,ifnull(Elaborato,0) " _
					& " As Elaborato,Note from GS_TESTEDOCUMENTI_LT WHERE ifnull(Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))
					json = DBPhp.Map2Json(m)
					
				Case "Florenzi"
					sqlstr = "SELECT IDKEY as Idtesta, TipoDoc, IDKEY as Numerodoc, Esercizio, UtenteModifica, CodClifor, 1 as Trasmesso, Datadoc, Note " & _
         "FROM GS_TESTEDOCUMENTI_LT WHERE ifnull(Trasmesso,0)=0"

					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr, Null, 0, Array As String( _
					    DBUtils.DB_INTEGER, _
					    DBUtils.DB_TEXT, _
					    DBUtils.DB_INTEGER, _
					    DBUtils.DB_INTEGER, _
					    DBUtils.DB_TEXT, _
					    DBUtils.DB_TEXT, _
					    DBUtils.DB_INTEGER, _
					    DBUtils.DB_TEXT, _
					    DBUtils.DB_TEXT))

					json = DBPhp.Map2Json(m)
					
				Case "Trendy"
					sqlstr = "SELECT TipoDoc,IDKEY as Numerodoc,Esercizio,'' as Bis,UtenteModifica,CodClifor,NrListino,1 as Trasmesso,IDKEY,Datadoc,ifnull(Valuta,0) as Valuta,ifnull(Elaborato,0) " _
					& " As Elaborato,Note,CodNegozio,DataRifDoc,NumRifDoc from GS_TESTEDOCUMENTI WHERE ifnull(Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
					json = DBPhp.Map2Json(m)
				Case "Esseci"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,TD.CodClifor,TD.NrListino,1 as Trasmesso,TD.IDKEY,TD.Datadoc,ifnull(TD.Valuta,0) as Valuta,ifnull(TD.Elaborato,0) " _
					& " As Elaborato,TD.DataRifDoc,TD.NumRifDoc,pd.tIPO AS TipoCreaDoc from IS_TESTEDOCUMENTI as TD left outer join IS_PARAMETRIDOC AS PD ON TD.TipoDoc=PD.Tipodoc WHERE ifnull(Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
					json = DBPhp.Map2Json(m)
				Case "Nesti"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,TD.CodClifor,TD.NrListino,1 as Trasmesso,TD.IDKEY,TD.Datadoc,ifnull(TD.Valuta,0) as Valuta,ifnull(TD.Elaborato,0) " _
					& " As Elaborato,TD.DataRifDoc,TD.NumRifDoc,TD.rifidtesta,TD.flag_stp from IS_TESTEDOCUMENTI as TD left outer join IS_PARAMETRIDOC AS PD ON TD.TipoDoc=PD.Tipodoc WHERE ifnull(Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER))
					json = DBPhp.Map2Json(m)
				Case "Kuore"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,TD.CodClifor,TD.NrListino,1 as Trasmesso,TD.IDKEY,TD.Datadoc," _
					& "ifnull(TD.Valuta,0) As Valuta,ifnull(TD.Elaborato,0) As Elaborato,TD.DataRifDoc,substr(TD.Note,1,15) As NumRifDoc from IS_TESTEDOCUMENTI As TD WHERE ifnull(Trasmesso,0)=0"
					Log(sqlstr)
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String( _
					DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
					json = DBPhp.Map2Json(m)
			End Select
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} IS_TESTEDOCUMENTI"$) 'Current time is 11:17:45
			Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)		
			job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
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

Sub Execute_LeggiTab_PHP_POST_KUORE(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable -1
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
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
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Create_Table_IS_TESTEDOCUMENTI(SQLDataAccess)		
						DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Create_Table_IS_RIGHEDOCUMENTI_Ligth(SQLDataAccess)
						DB_SQLite.Alter_Table_IS_RIGHEDOCUMENTI_Light(SQLDataAccess)	
						DB_SQLite.Create_Table_IS_SYNC_STATE(SQLDataAccess)	
					End If
					Select job.JobName.ToLowerCase
				
						Case "get_is_sync_state"
							DB_SQLite.Create_Table_IS_SYNC_STATE(SQLDataAccess)
							Log(Path_Php & "is_sync_state.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Updating(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_palmdevice"
							DB_SQLite.Create_Table_IS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "is_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_parametridoc"
							DB_SQLite.Create_Table_IS_PARAMETRIDOC(SQLDataAccess)
							Log(Path_Php & "is_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
			
						Case "get_is_righedocpartite"
							DB_SQLite.Create_Table_IS_RIGHEDOCPARTITE(SQLDataAccess)
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For (DB_SQLSERVER.Leggi_RigheDocPartite(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																		
						Case "get_is_anagraficacf"
							DB_SQLite.Create_Table_IS_ANAGRAFICACF_KUORE(SQLDataAccess)
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For (DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficaarticoli"
							DB_SQLite.Create_Table_IS_ANAGRAFICAARTICOLI_KUORE(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_ANAGRAFICAARTICOLI_KUORE(SQLDataAccess)
							Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For (DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
															
						Case "get_is_tablistini"
							DB_SQLite.Create_Table_IS_TABLISTINI2(SQLDataAccess)
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini2(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																																						
						Case "get_is_listiniarticoli"
							DB_SQLite.Create_Table_IS_LISTINIARTICOLI(SQLDataAccess)
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
			
						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_KUORE")
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_GEFIN(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable -1
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Poststring(Path_Php & phpFile.ToLowerCase, "&action=" & mAction)
			job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
				ProgressDialogHide
				If job.Success = True Then
					Dim jobResult As String = job.GetString
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Create_Table_GS_LISTATEMPI(SQLDataAccess)						
						DB_SQLite.Alter_Table_GS_LISTATEMPI(SQLDataAccess)
						DB_SQLite.Create_Table_GS_PARAMETRIDOC(SQLDataAccess)
						DB_SQLite.Create_Table_GS_TESTEDOCUMENTI_LT(SQLDataAccess)
						DB_SQLite.Create_Table_GS_RIGHEDOCUMENTI_LT(SQLDataAccess)						
					End If
					Select job.JobName.ToLowerCase
						
						Case "get_gs_palmdevice"
							DB_SQLite.Create_Table_GS_PALMDEVICE(SQLDataAccess)	
							Log(Path_Php & "gs_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_operatori"
							DB_SQLite.Create_Table_GS_OPERATORI(SQLDataAccess)
							Log(Path_Php & "gs_operatori.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Operatori(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
										
						Case "get_gs_articoli"
							DB_SQLite.Create_Table_GS_ARTICOLI_EUREKA(SQLDataAccess)
							Log(Path_Php & "gs_articoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Articoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																			
																												
						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_CARBON")
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Inizializza_Parametridoc
	Dim rs As ResultSet
	rs = SQLDataAccess.ExecQuery("SELECT CODICE,DESCRIZIONE,TIPOCLIFOR FROM GS_PARAMETRIDOC")
	If (rs.RowCount=0) Then
		Dim sqlstr As String
		sqlstr = "INSERT INTO GS_PARAMETRIDOC (CODICE,DESCRIZIONE,TIPOCLIFOR) " _
		 & "VALUES ('INV','INVENTARIO','F')"
		SQLDataAccess.ExecNonQuery(sqlstr)
	End If
	rs.Close
End Sub

Sub Execute_LeggiTab_PHP_POST_CARBON(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable -1
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			' job.Poststring(Path_Php & phpFile.ToLowerCase, "&action=" & mAction)
			job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
				ProgressDialogHide
				If job.Success = True Then
					Dim jobResult As String = job.GetString
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura ListaTempi su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Alter_Table_GS_AUTOCLAVI(SQLDataAccess)
						DB_SQLite.Create_Table_GS_LISTATEMPI(SQLDataAccess)	
						DB_SQLite.Alter_Table_GS_LISTATEMPI(SQLDataAccess)	
						DB_SQLite.Create_Table_GS_AUTOCLAVI	(SQLDataAccess)
						DB_SQLite.Create_Table_GS_AUTOCLAVE_X(SQLDataAccess)
						DB_SQLite.Create_Table_GS_AUTOCLAVE_STORY_H(SQLDataAccess)
						DB_SQLite.Create_Table_GS_AUTOCLAVE_STORY_D(SQLDataAccess)
						DB_SQLite.Create_Table_GS_AUTOCLAVE_EVENT(SQLDataAccess)
						DB_SQLite.Create_Table_GS_RICETTE(SQLDataAccess)
					End If
					Select job.JobName.ToLowerCase
						
						Case "get_gs_palmdevice"
							DB_SQLite.Alter_Table_GS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "gs_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
		
						Case "get_gs_autoclavi"
							DB_SQLite.Create_Table_GS_AUTOCLAVI(SQLDataAccess)
							Log(Path_Php & "gs_autoclavi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Autoclavi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_ricette"
							DB_SQLite.Create_Table_GS_RICETTE(SQLDataAccess)
							Log(Path_Php & "gs_ricette.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL &  "&password=" & Main.Pwd_DBName & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Ricette(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_reparti"
							DB_SQLite.Create_Table_GS_REPARTI(SQLDataAccess)
							Log(Path_Php & "gs_reparti.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL &  "&password=" & Main.Pwd_DBName & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Reparti	(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_operatori"
							DB_SQLite.Create_Table_GS_OPERATORI(SQLDataAccess)
							Log(Path_Php & "gs_operatori.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Operatori(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)										
										
						Case "get_gs_articoli"
							DB_SQLite.Create_Table_GS_ARTICOLI_CARBON(SQLDataAccess)
							Log(Path_Php & "gs_articoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_Articoli_Carbon(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																												
						Case Else
							Log("Errore nella procedura: " & job.JobName & " Execute_LeggiTab_PHP_POST_CARBON")
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_TRENDY(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable -1 
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
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
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Alter_Table_GS_TESTEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Create_Table_GS_RIGHEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Alter_Table_GS_RIGHEDOCUMENTI(SQLDataAccess)
					End If
					Select job.JobName.ToLowerCase
						
						Case "get_gs_palmdevice"
							DB_SQLite.Alter_Table_GS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "gs_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)						
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_parametridoc"		
							DB_SQLite.Create_Table_GS_TABPARAMETRIDOC(SQLDataAccess)							
							Log(Path_Php & "gs_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)							
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																		
						Case "get_gs_anagraficacf"
							DB_SQLite.Create_Table_GS_ANAGRAFICACF(SQLDataAccess)
							Log(Path_Php & "gs_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)					
							Wait For (DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_gs_articoli"		
							DB_SQLite.Create_Table_GS_ARTICOLI(SQLDataAccess)
							DB_SQLite.Alter_Table_GS_ARTICOLI_TRENDY(SQLDataAccess)
							Log(Path_Php & "gs_articoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For (DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
											
						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_TRENDY")
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_FLORENZI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable -1 
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" _
				& Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
				ProgressDialogHide
				If job.Success = True Then
					Dim jobResult As String = job.GetString
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Create_Table_GS_TABPARAMETRIDOC(SQLDataAccess)
						DB_SQLite.Create_Table_GS_RIGHEDOCUMENTI_LT(SQLDataAccess)
						DB_SQLite.Create_Table_GS_TESTEDOCUMENTI_LT(SQLDataAccess)
					End If
						Select job.JobName.ToLowerCase
						
						Case "get_gs_palmdevice"
							DB_SQLite.Alter_Table_GS_PALMDEVICE(SQLDataAccess)
							#if DEBUG
								Log(Path_Php & "gs_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							#End If							
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_gs_tabparametridoc"		
							DB_SQLite.Create_Table_GS_TABPARAMETRIDOC(SQLDataAccess)							
							#if DEBUG
								Log(Path_Php & "gs_tabparametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							#End If							
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																		
						Case "get_gs_anagraficacf"
							DB_SQLite.Create_Table_GS_ANAGRAFICACF(SQLDataAccess)
							#if DEBUG
								Log(Path_Php & "gs_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							#End If							
							Wait For (DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_gs_articoli"		
							DB_SQLite.Create_Table_GS_ARTICOLI_BASE(SQLDataAccess)							
							#if DEBUG
								Log(Path_Php & "gs_articoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							#End If				
							Wait For (DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
											
						Case Else
							#if DEBUG
								Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_FLORENZI")
							#End If
																	
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_LeggiTab_PHP_POST_NESTI(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String, Utente As String, NumTable As Int, PassoTable As Int, wherePar1 As String,  wherePar2 As String) As ResumableSub
	Try
		Sleep(0)
		Dim Path_Php  As String = ""
		Dim job As HttpJob
		'Dim scommand As String
		'Dim json As String
		'initialize a new job that will run from a class object
		job.Initialize(JobName, frm)
		job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
		job.Tag = phpTag
		'json = DBPhp.Map2QueryString(pQuery)
		Try
			NumTable = NumTable-1
			Dim mAction As String =  JobName.ToLowerCase
			Label2.Text = mAction.Replace("get_","").ToUpperCase
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
	'		phpFile="is_barcode.php"	
	'		mAction="get_is_barcode"
			job.Poststring(Path_Php & phpFile.ToLowerCase,"servername=" & Main.Istanza_ServerSQL & "&dbname="& Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&utentepalmare=" & Utente)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log(job.JobName.ToLowerCase & " response ok: "  & job.GetString)
				ProgressDialogHide
				If job.Success = True Then
					Dim jobResult As String = job.GetString
					'Dim jobTag As String = job.tag
					job.release
					If (Main.DEBUG=1) Then
						MsgboxAsync("Azione Inizio: " & job.JobName.ToLowerCase,"DEBUG")
					End If
					'-------------------------------------------------
					' Verifica Struttura TesteDocumenti su SQLite
					'-------------------------------------------------
					If(NumTable=0) Then
						DB_SQLite.Create_Table_IS_TESTEDOCUMENTI(SQLDataAccess)
						DB_SQLite.Create_Table_IS_RIGHEDOCUMENTI(SQLDataAccess)						
						DB_SQLite.Alter_Table_IS_TESTEDOCUMENTI(SQLDataAccess)						
						DB_SQLite.Alter_Table_IS_RIGHEDOCUMENTI_NESTI(SQLDataAccess)
						DB_SQLite.Alter_Table_IS_RIGHEDOCUMENTI_GIRO(SQLDataAccess)
						DB_SQLite.Create_Table_IS_SEMAFOROCORSIE_local(SQLDataAccess)
						DB_SQLite.Create_View_Vista_IS_SEMAFOROCORSIE(SQLDataAccess)
						DB_SQLite.Create_View_Vista_VARIAZIONI_CLIENTI_GIRO(SQLDataAccess)						
						DB_SQLite.Create_Table_VISTA_GIACENZA_ARTICOLO(SQLDataAccess)
						DB_SQLite.Create_Table_VISTA_DISPONIBILITA_ARTICOLO(SQLDataAccess)
						DB_SQLite.Create_Table_VISTA_DISPONIBILITA_CORSIA(SQLDataAccess)
						DB_SQLite.Create_View_Vista_CORSIE_GIRO(SQLDataAccess)
						DB_SQLite.Create_Table_IS_PARTITE_ANNULLATE	(SQLDataAccess)
						DB_SQLite.Create_Table_IS_ARTICOLI_PESOREALE_CASH(SQLDataAccess)
					End If
					Select job.JobName.ToLowerCase
						
						Case "get_is_palmdevice"
							DB_SQLite.Alter_Table_IS_PALMDEVICE(SQLDataAccess)
							Log(Path_Php & "is_palmdevice.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_PalmDevice(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_tabcambi"
							Log(Path_Php & "is_tabcambi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabCambi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_parametridoc"							
							Log(Path_Php & "is_parametridoc.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ParametriDoc(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																		
						Case "get_is_listiniarticoli"
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case "get_is_anagraficacf"
							DB_SQLite.Create_Table_IS_ANAGRAFICACF(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_ANAGRAFICACF(SQLDataAccess)
							Log(Path_Php & "is_anagraficacf.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaCF(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficaarticoli"
							DB_SQLite.Create_Table_IS_ANAGRAFICAARTICOLI(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_ANAGRAFICAARTICOLI(SQLDataAccess)
							Log(Path_Php & "is_anagraficaarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_anagraficadepositi"
							DB_SQLite.Create_Table_IS_ANAGRAFICADEPOSITI(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_ANAGRAFICADEPOSITI(SQLDataAccess)							
							Log(Path_Php & "is_anagraficadepositi.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_AnagraficaDepositi(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_tablistini"
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
												
						Case "get_is_barcode"
							Log(Path_Php & "is_barcode.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_BARCODE(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_Barcode(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_listinoart"
							Log(Path_Php & "is_listinoart.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_LISTINOART(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_ListinoArt(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
						
						Case "get_is_vista_umpref"
							Log(Path_Php & "is_vista_umpref.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)						
							DB_SQLite.Create_Table_IS_VISTA_UMPREF(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_Vista_UmPref(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
			
						Case "get_is_vistadocpalm"
							Log(Path_Php & "is_vista_docpalm.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_VISTADOCPALM(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_VISTADOCPALM(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Is_Vista_DocPalm(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_vista_fattoriconv"
							Log(Path_Php & "vista_fattoriconv.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTA_FATTORICONV(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Vista_FattoriConv(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_tabcodificaean"
							Log(Path_Php & "is_tabcodificaean.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_TABCODIFICAEAN(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_TabCodificaEAN(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																											
						Case "get_is_impostazionictrlinv"
							Log(Path_Php & "is_impostazionictrlinv.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_IMPOSTAZIONICTRLINV(SQLDataAccess)
							DB_SQLite.Alter_Table_IS_IMPOSTAZIONICTRLINV(SQLDataAccess)							
							Wait For(DB_SQLSERVER.Leggi_IS_ImpostazioniCtrlInv(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_vista_giacenza"
							Log(Path_Php & "vista_giacenza.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTA_GIACENZA(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Vista_Giacenze(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
												
						Case "get_vista_giacenza_articolo"
							Log(Path_Php & "vista_giacenza_articolo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&codart=" & wherePar1 & "&coddeposito=" & wherePar2 & "&action=" & job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTA_GIACENZA_ARTICOLO(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Vista_Giacenze_Articolo	(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
													
						Case "get_vista_disponibilita_articolo"
							Log(Path_Php & "vista_disponibilita_articolo.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&codart=" & wherePar1 & "&coddeposito=" & wherePar2 & "&action=" & job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTA_DISPONIBILITA_ARTICOLO(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Vista_Disponibilita_Articolo (jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																				
						Case "get_vista_disponibilita_corsia"
							Log(Path_Php & "vista_disponibilita_corsia.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&coddeposito=" & wherePar1 & "&action=" & job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_VISTA_DISPONIBILITA_CORSIA(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Vista_Disponibilita_Corsia (jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
													
						Case "get_is_semaforocorsie"
							Log(Path_Php & "is_semaforocorsie.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_SEMAFOROCORSIE(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_Semaforo_Corsie(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
																			
						Case "get_is_vista_clienti_giro"
							Log(Path_Php & "vista_clienti_giro.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_VISTA_CLIENTI_GIRO(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_VISTA_CLIENTI_GIRO(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)

						Case "get_is_vista_note_ordini"
							Log(Path_Php & "is_vista_note_ordini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							DB_SQLite.Create_Table_IS_VISTA_NOTE_ORDINI(SQLDataAccess)
							Wait For(DB_SQLSERVER.Leggi_IS_VISTA_NOTE_ORDINI(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_listiniarticoli"
							Log(Path_Php & "is_listiniarticoli.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_ListiniArticoli(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case "get_is_tablistini"
							Log(Path_Php & "is_tablistini.php," & "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&action="&job.JobName.ToLowerCase)
							Wait For(DB_SQLSERVER.Leggi_TabListini(jobResult, SQLDataAccess, NumTable, PassoTable)) Complete (Success As Boolean)
							
						Case Else
							Log("Errore nella procedura: Execute_LeggiTab_PHP_POST_NESTI")
										
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
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_RigheDoc(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
	' SCRIVE LE RIGHE VERSO SERVER SQL
	Sleep(0) 'this is required as the table layout is not immediately created.'
	Try 
		If (ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)) Then
			'Dim DataConsegna As String
			Dim m As Map
			Dim Path_Php As String = ""
			Dim json As String
			Dim job As HttpJob
			If (Main.PortaPhp <> "") Then
				Path_Php = $"http://${Main.IP_ServerPHP}:${Main.PortaPhp}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			Else
				Path_Php = $"http://${Main.IP_ServerPHP}/${Main.Folder_Php}/${Main.DBName_ServerSQL}/"$
			End If
			job.Initialize(JobName, frm)
			job.GetRequest.Timeout = Main.TimeOut  ' Aggiunto un timeout di x minuti
			job.Tag = phpTag
			m.Initialize
			Dim sqlstr As String = ""
			Select Case Main.Ditta
				Case "ZelariVi"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY as Numerodoc,TD.Esercizio,TD.UtenteModifica,RD.ROWID-(SELECT MIN(ROWID)-1 FROM IS_RIGHEDOCUMENTI) as Idriga," _					
					& "RD.Codart,RD.Qta,'N.' as UM,RD.PrzUnit,RD.Sconto,RD.Note,RD.VARIAMISURE,RD.Magazzino,RD.DataConsegna,ifnull(RD.RIFCLIENTE,'') AS RIFCLIENTE from " _
					& "IS_RIGHEDOCUMENTI As RD JOIN IS_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio WHERE ifnull(TD.Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT))								
					'Dim gen As JSONGenerator
					'gen.Initialize(DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
					'DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					'DBUtils.DB_TEXT)))
					'Dim JsonString As String
					'JsonString = gen.ToPrettyString(4)
					'Log(JsonString)
					
				Case "Gefin"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,(RD.ROWID-(SELECT MIN(ROWID)-1 FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT)) as Idriga,RD.Barcode,RD.Codart," _
					& "RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,RTRIM(RD.Descrizione) AS Descrizione,ifnull(RD.CodIva,'') as CodIva,TD.UtenteModifica,TD.Note from " _
					& Main.PrefixSQL & "_RIGHEDOCUMENTI_LT As RD JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio " _
					& "WHERE ifnull(TD.Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))		
					
				Case "Trendy"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,'' as Bis,(RD.ROWID-(SELECT MIN(ROWID)-1 FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI)) as Idriga,RD.Barcode,RD.Codart," _
					& "RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.ArticoloAQta,RD.Note,RTRIM(RD.Descrizione) AS Descrizione,RD.TipoRiga,RD.CodIva,TD.UtenteModifica from " _
					& Main.PrefixSQL & "_RIGHEDOCUMENTI As RD JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio " _
					& "WHERE ifnull(TD.Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))			
					
				Case "Florenzi"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,TD.IDKEY,(RD.ROWID-(SELECT MIN(ROWID)-1 FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI_LT)) as Idriga,RD.Codart," _
					& "RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,RTRIM(RD.Descrizione) AS Descrizione,TD.UtenteModifica,RD.Barcode from " _
					& Main.PrefixSQL & "_RIGHEDOCUMENTI_LT As RD JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio " _
					& "WHERE ifnull(TD.Trasmesso,0)=0"
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))							
										
				Case "Esseci"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,TD.UtenteModifica,RD.ROWID-(SELECT MIN(ROWID)-1 FROM IS_RIGHEDOCUMENTI) as Idriga," _
					& "RD.Codart,RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,ifnull(RD.VARIAMISURE,'') as VARIAMISURE," _
					& "VP.CODDEPOSITO AS MAGAZZINO,RD.DataConsegna,ifnull(RD.rifidtesta,0) As rifidtesta,ifnull(RD.RIFCLIENTE,'') AS RIFCLIENTE,RD.TipoRiga,RTRIM(RD.Descrizione) AS Descrizione from " _
					& "(IS_RIGHEDOCUMENTI As RD JOIN IS_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio) " _
					& "LEFT OUTER JOIN IS_VISTAPUNTIVENDITAPALMARE As VP ON VP.PALMARE=TD.UtenteModifica WHERE ifnull(TD.Trasmesso,0)=0"				
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT ))
					
				Case "Nesti"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,TD.UtenteModifica,RD.ROWID-(SELECT MIN(ROWID)-1 FROM IS_RIGHEDOCUMENTI) as Idriga," _
					& "RD.Codart,RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note,ifnull(RD.VARIAMISURE,'') as VARIAMISURE," _
					& "VP.CODDEPOSITO AS MAGAZZINO,RD.DataConsegna,ifnull(RD.rifidtesta,0) As rifidtesta,ifnull(RD.RIFCLIENTE,'') AS RIFCLIENTE,RD.TipoRiga,RTRIM(RD.Descrizione) AS Descrizione, " _
					& "RD.NumEtichette,RD.Peso,RD.UM2,RD.Qta2,RD.Rifidriga,RD.NrRifPartita " _
					& " FROM (IS_RIGHEDOCUMENTI As RD JOIN IS_TESTEDOCUMENTI As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio) " _
					& "LEFT OUTER JOIN IS_VISTAPUNTIVENDITAPALMARE As VP ON VP.PALMARE=TD.UtenteModifica WHERE ifnull(TD.Trasmesso,0)=0"				
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))

				Case "Kuore"
					sqlstr = "SELECT TD.TipoDoc,TD.IDKEY As Numerodoc,TD.Esercizio,'' as Bis,(RD.ROWID-(SELECT MIN(ROWID)-1 FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI)) as Idriga," _					
					& "(case when ifnull(TD.CodiceUnico,0)=0 then '' else ifnull(RD.Partita,'') end) as NrRifPartita,RD.Codart,RD.Qta,IFNULL(RD.UM,'') as UM,RD.PrzUnit,RD.Sconto,RD.Note," _
					& "RTRIM(RD.Descrizione) As Descrizione,RD.TipoRiga,TD.UtenteModifica from " &  Main.PrefixSQL & "_RIGHEDOCUMENTI As RD JOIN " & Main.PrefixSQL & "_TESTEDOCUMENTI " _
					& "As TD ON TD.Numerodoc = RD.Numerodoc And TD.TipoDoc=RD.TipoDoc And TD.Esercizio=RD.Esercizio WHERE ifnull(TD.Trasmesso,0)=0"
					' Log(sqlstr)
					m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object ( _
					DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
					DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_REAL,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))	
										
			End Select
			json = DBPhp.Map2Json(m)	
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Nessun Documento da inviare!","Sincronizzazione " & Main.MessageBoxText)
				Return False
			Else
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now}"$ & Main.PrefixSQL & $"_RIGHEDOCUMENTI inizio"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					'Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now}"$ & Main.PrefixSQL & $"_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					Return True
				Else  
					Log("Error: " & job.ErrorMessage)			
					Log($"Current time is $time{DateTime.Now}"$ & Main.PrefixSQL & $"_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore " & Main.PrefixSQL & "_RIGHEDOCUMENTI " & job.errorMessage,"Errore")
					Return False					
				End If					
			End If			
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore " & Main.PrefixSQL & "_RIGHEDOCUMENTI " & LastException.Message,"Errore")
		Log(Main.PrefixSQL & "_RIGHEDOCUMENTI " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Button2_Click
	Try
		' Dim straction As String = "get_listarticoli"
		Dim straction As String = "get_listarticoli"
		Dim dbAction As Map = CreateMap("action=": straction)
		ExecutePHP_GET(Me, dbAction, straction, "users.php","")
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button4_Click
	' Tabelle Sqlite
	Try
		NewDocument.vTipoTab = 3
		StartActivity(ListaTab)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button5_Click
	'------------------------------
	' LEGGI TABELLE DAL SERVER		
	'------------------------------
	Msgbox2Async("Vuoi procedere con il LEGGI " & Main.MessageBoxText.ToUpperCase & "?", "Sincronizzazione " & Main.MessageBoxText, "SI", "NO", "", Null, False)
	Wait For MsgBox_Result (Result As Int)	
	If Result = DialogResponse.POSITIVE Then
		Try
			If( Main.IP_ServerPHP<>"") And (Main.Istanza_ServerSQL<>"") And (Main.User_ServerSQL<>"") And (Main.DBName_ServerSQL<>"") Then
				Label2.Visible = True
				ProgressBar1.Visible = True
				ProgressBar1.Progress = 0
				DateTime.DateFormat = "yyyyMMdd HHmmss"
				Dim dt As Long = DateTime.now
				Dim OraInizio As String = ""
				Dim F_Device As Boolean = True
				Dim F_Updating As Boolean = False
				Dim nt As Int = 0
				OraInizio = DateTime.Time(dt)
				' MsgboxAsync("Attendere elaborazione in corso e premere OK solo al termine...","Sincronizzazione iniziata alle ore: " & OraInizio)
				Log($"INIZIO IMPORTAZIONE ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45
				Select Main.Ditta
					Case "ZelariVi"
						Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_TABCAMBI","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI", _
						"IS_TABLISTINI","IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI")
					Case "Florenzi"
						Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_ANAGRAFICACF","GS_TABPARAMETRIDOC","GS_ARTICOLI")
					Case "Trendy"
						Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_PARAMETRIDOC","GS_ANAGRAFICACF","GS_ARTICOLI")
					Case "Esseci"
						' Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_BARCODE")
						Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_TABCAMBI","IS_BARCODE","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF", _
						"IS_ANAGRAFICADEPOSITI","IS_TABLISTINI","IS_ANAGRAFICAARTICOLI","IS_LISTINOART","IS_VISTAPUNTIVENDITAPALMARE","VISTAGIACENZAPERPALMARE")						
					Case "Nesti"
						If(Main.Device_ScreenX>1900) And (Main.Device_Orientation="landscape") Then
							Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_BARCODE","IS_PARAMETRIDOC","IS_ANAGRAFICACF","IS_ANAGRAFICAARTICOLI","IS_ANAGRAFICADEPOSITI", _
							"IS_VISTA_UMPREF","IS_VISTADOCPALM", "VISTA_FATTORICONV","IS_TABCODIFICAEAN","IS_IMPOSTAZIONICTRLINV","VISTA_GIACENZA","IS_SEMAFOROCORSIE", _
							"IS_VISTA_CLIENTI_GIRO","IS_TABLISTINI","IS_LISTINIARTICOLI","IS_VISTA_NOTE_ORDINI")
						Else
							Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_BARCODE","IS_PARAMETRIDOC","IS_ANAGRAFICACF","IS_ANAGRAFICAARTICOLI","IS_ANAGRAFICADEPOSITI", _
							"IS_VISTA_UMPREF","VISTA_FATTORICONV","IS_TABCODIFICAEAN","IS_SEMAFOROCORSIE","IS_TABLISTINI","IS_LISTINIARTICOLI")
						End If
					Case "Kuore"
						Dim Tables() As String = Array As String("IS_SYNC_STATE","IS_PALMDEVICE","IS_ANAGRAFICAARTICOLI","IS_TABLISTINI","IS_LISTINIARTICOLI","IS_PARAMETRIDOC","IS_ANAGRAFICACF","IS_RIGHEDOCPARTITE","IS_SYNC_STATE")
					Case Else
						Dim Tables() As String = Array As String("IS_PALMDEVICE","IS_TABCAMBI","IS_PARAMETRIDOC","IS_LISTINIARTICOLI","IS_ANAGRAFICACF","IS_ANAGRAFICADEPOSITI", _
						"IS_TABLISTINI","IS_VISTADOCUMENTI","IS_ANAGRAFICAARTICOLI")
					Case "Carbon"
						' Dim Tables() As String = Array As String("GS_REPARTI","GS_OPERATORI","GS_AUTOCLAVI","GS_AUTOCLAVE_STORY_H")
						Dim Tables() As String = Array As String("GS_REPARTI","GS_RICETTE","GS_OPERATORI","GS_ARTICOLI","GS_AUTOCLAVI")
						' Dim Tables() As String = Array As String("GS_REPARTI","GS_RICETTE","GS_OPERATORI","GS_ARTICOLI","GS_AUTOCLAVI")
						
					Case "Gefin"
						Dim Tables() As String = Array As String("GS_PALMDEVICE","GS_OPERATORI","GS_ARTICOLI")
				End Select			
				Dim Passo As Int = 100 / Tables.Length
				For Each table In Tables
					If (F_Device) And (F_Updating=False) Then
						nt = nt + 1
						Dim straction As String = "get_" & table
						Dim dbAction As Map = CreateMap("action=": straction)
						Log("LEGGI TABELLA: " & table) 								
						Select Main.Ditta
						Case "ZelariVi"
								WAIT FOR(Execute_LeggiTab_PHP_POST_ZELARI(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Carbon"
								WAIT FOR(Execute_LeggiTab_PHP_POST_CARBON(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Gefin"
								WAIT FOR(Execute_LeggiTab_PHP_POST_GEFIN(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Kuore"
								WAIT FOR(Execute_LeggiTab_PHP_POST_KUORE(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Trendy"
								WAIT FOR(Execute_LeggiTab_PHP_POST_TRENDY(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)							
						Case "Florenzi"
								WAIT FOR(Execute_LeggiTab_PHP_POST_FLORENZI(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Esseci"
								WAIT FOR(Execute_LeggiTab_PHP_POST_ESSECI(Me, dbAction, straction.ToLowerCase, table & ".php","", Main.Utente, nt, Passo)) complete (Success As Boolean)
						Case "Nesti"
								WAIT FOR(Execute_LeggiTab_PHP_POST_NESTI(Me, dbAction, straction.ToLowerCase, table & ".php","",Main.Utente, nt, Passo, "", "")) complete (Success As Boolean)
						Case Else
								WAIT FOR(Execute_LeggiTab_PHP_POST(Me, dbAction, straction.ToLowerCase, table & ".php","",Main.Utente, nt, Passo)) complete (Success As Boolean)
						End Select			
						If(Success) Then		
							'Label2.Text = table
							If(table = Main.PrefixSQL & "_SYNC_STATE") And ((nt=1) Or (nt=Tables.Length)) Then
								' controllo se sta aggiornando i dati
								F_Updating = ExtraUtility.CheckUpdating(SQLDataAccess)
							End If
							If(table = Main.PrefixSQL & "_PALMDEVICE") Then
								' controllo se il dispositivo è autorizzato o 'illegale'
								F_Device =	ExtraUtility.CheckSerialDevice(SQLDataAccess,Main.serialNo)
							End If
							Sleep(0)
							DisplayTermo((nt*100)/(Tables.Length))
							Log ("Termo " & ((nt*100)/Tables.Length))																								
						End If
					End If
				Next
				Log($"FINE IMPORTAZIONE ALLE $time{DateTime.Now}"$) 'Current time is 11:17:45		
				Dim dt As Long = DateTime.now
				Dim OraFine As String = ""
				OraFine = DateTime.Time(dt)
				Select Main.Ditta
					Case "ZelariVi"						
					Main.NRListinoMin = DB_SQLite.Leggi_NRListinoMinimo(SQLDataAccess)
				End Select
				Label2.Visible = False
				ProgressBar1.Visible = False
				If(F_Device=False) Then
					MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")					
				End If				
				If(F_Updating) Then
					ExtraUtility.Play_Sound("error.wav")
					MsgboxAsync("Sincronizzazione non possibile tabelle del SERVER in aggiornamento!","CONTROLLO SINCRONIZZAZIONE")
				End If	
				If(F_Device) And (F_Updating=False) Then
					ExtraUtility.Play_Sound("Sound2.wav")
					MsgboxAsync("Ora Inizio: " & OraInizio & CRLF & "Ora Fine: " & OraFine,"Sincronizzazione terminata")
				End If
			Else
				MsgboxAsync("Controllare le Impostazioni per procedere con la sincronizzazione!","ERRORE")
			End If
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
	End If
End Sub

Sub DisplayTermo(Value As Int)
	ProgressBar1.Progress = Value
	Dim jo As JavaObject = ProgressBar1
	Dim drawable As JavaObject = jo.RunMethod("getProgressDrawable", Null)
	drawable.RunMethod("setColorFilter", Array(Colors.Blue, "SRC_IN"))
	ProgressBar1.Height = 25dip
End Sub

Sub Button6_Click
	Try
		StartActivity("Impostazioni")
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button7_Click
	Try
		Msgbox2Async("Vuoi procedere con lo SCRIVI " & Main.MessageBoxText.ToUpperCase & "?", "Sincronizzazione " & Main.MessageBoxText, "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)	
		If Result = DialogResponse.POSITIVE Then
			Select Main.Ditta
			Case "Kuore"
				RegistraSulServer_Palmare_Out
			Case "Carbon"
				' RegistraSulServer
				' RegistraSulServer_ListaTempi
				' RegistraSulServer_Autoclavi("")
			Case Else
				RegistraSulServer
			End Select
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub RegistraSulServer_ListaTempi
	' SCRITTURA TABELLE DAL SERVER GS_LISTATEMPI
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim reparto As String
		Dim dbAction As Map
		reparto = "LAMINAZIONE"
		Log("Exec_Scrivi_ListaTempi(" &straction&"listatempi.php")
		straction = "insert_listatempi"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_ListaTempi(Me, dbAction, straction, "gs_listatempi.php",""))  complete (Result As Boolean)
		If (Result) Then
			SQLDataAccess.BeginTransaction
			sqlstr = "UPDATE GS_LISTATEMPI SET TRASMESSO=1 WHERE Ifnull(TRASMESSO,0)=0"
			Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)
			SQLDataAccess.TransactionSuccessful
			SQLDataAccess.EndTransaction
			MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
		End If
	Catch
		Log("ERRORE!: " & LastException)
	End Try
End Sub

Sub RegistraSulServer_Palmare_Out
	' SCRITTURA TABELLE DAL SERVER PALMARE_OUT
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_Palmare_Out(" &straction&" palmare_out.php")
		straction = "insert_palmare_out"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_Palmare_Out(Me, dbAction, straction, "palmare_out.php",""))  complete (Result3 As Int)
		If (Result3=1) Then
			SQLDataAccess.BeginTransaction
			sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0"
			Log(sqlstr)
			SQLDataAccess.ExecNonQuery(sqlstr)
			SQLDataAccess.TransactionSuccessful
			SQLDataAccess.EndTransaction
			ExtraUtility.Play_Sound("Sound2.wav")			
			MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)			
		Else
			If(Result3=3) Then
				MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
			End If
		End If
	Catch
		Log("ERRORE!: " & LastException)
	End Try
End Sub

Sub RegistraSulServer
	' --------------------------------
	' SCRITTURA TABELLE DAL SERVER
	' --------------------------------
	Try
		Dim sqlstr As String
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" &straction&" "& Main.PrefixSQL & "_testedocumenti.php e " & Main.PrefixSQL & "_righedocumenti.php)")
		straction = "insert_righedoc"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_RigheDoc(Me, dbAction, straction, Main.PrefixSQL & "_testedocumenti.php","")) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_testedoc"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_TesteDoc(Me, dbAction, straction, Main.PrefixSQL & "_testedocumenti.php",""))  complete (Result3 As Boolean)
			' Dim Result3 As Boolean = False
			If (Result3) Then
				SQLDataAccess.BeginTransaction
				Select Main.Ditta
					Case "Florenzi"
						sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0"
					Case "Gefin"
						sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI_LT SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0"
					Case Else
						sqlstr = "UPDATE " & Main.PrefixSQL & "_TESTEDOCUMENTI SET Trasmesso=1 WHERE Ifnull(Trasmesso,0)=0"					
				End Select									
				' Log(sqlstr)
				SQLDataAccess.ExecNonQuery(sqlstr)
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
			Else
				MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
			End If
		End If
	Catch
		Log("ERRORE!: " & LastException)
	End Try
End Sub

Sub Button3_Click
	Try
		Log("Click!")
		Scan.updateWifiList
		ApsList = Scan.listSavedNetworks
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

