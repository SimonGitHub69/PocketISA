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
	Public rp As RuntimePermissions
	Public DirExt As String
	Private XUI As XUI
	Public Color_DarkGreen As Int = Colors.RGB(0,150,0)	
	Public Color_Green As Int = Colors.RGB(74,163,36)
End Sub

' Altezza barra navigazione Android (pulsanti Indietro/Home). Su Honeywell taglia i footer a 100%y.
Public Sub GetSystemNavBarHeight As Int
	Try
		Dim ctxt As JavaObject
		ctxt.InitializeContext
		Dim res As JavaObject = ctxt.RunMethod("getResources", Null)
		Dim id As Int = res.RunMethod("getIdentifier", Array("navigation_bar_height", "dimen", "android"))
		If id > 0 Then
			Dim h As Int = res.RunMethod("getDimensionPixelSize", Array(id))
			Log("NavBar height: " & h)
			Return h
		End If
	Catch
		Log("GetSystemNavBarHeight: " & LastException.Message)
	End Try
	Return 48dip ' fallback tipico
End Sub

' Top Y sicuro per una barra alta barH (sopra la nav bar di sistema).
Public Sub FooterTopForBar (barH As Int) As Int
	Dim nav As Int = GetSystemNavBarHeight
	Return Max(0, 100%y - barH - nav)
End Sub

' Ricerca A-Z: pannelli a tutto schermo, lettere a filo basso/destro, tabella nello spazio utile.
' letterButtons = lista dei Button lettere (#, A..Z, 0..9). Idempotente su Resume.
Public Sub AdattaRicercaAZFullscreen (pnlMain As Panel, pnlAlt As Panel, tbl1 As B4XTable, tbl2 As B4XTable, letterButtons As List)
	Try
		Dim destW As Int = 100%x
		Dim destH As Int = 100%y
		If pnlMain.IsInitialized Then
			pnlMain.SetLayout(0, 0, destW, destH)
			destW = pnlMain.Width
			destH = pnlMain.Height
		End If
		If pnlAlt.IsInitialized Then
			pnlAlt.SetLayout(0, 0, 100%x, 100%y)
		End If

		Dim minTop As Int = 999999
		Dim maxBottom As Int = 0
		Dim minLeft As Int = 999999
		Dim maxRight As Int = 0
		Dim nBtn As Int = 0
		If letterButtons <> Null And letterButtons.IsInitialized Then
			For Each btn As Button In letterButtons
				If btn.IsInitialized Then
					nBtn = nBtn + 1
					minTop = Min(minTop, btn.Top)
					maxBottom = Max(maxBottom, btn.Top + btn.Height)
					minLeft = Min(minLeft, btn.Left)
					maxRight = Max(maxRight, btn.Left + btn.Width)
				End If
			Next
		End If

		If nBtn > 0 Then
			Dim lettersAtBottom As Boolean = minTop > destH * 0.42
			Dim lettersAtRight As Boolean = minLeft > destW * 0.55
			Dim lettersAtLeft As Boolean = maxRight < destW * 0.45
			If lettersAtBottom Then
				Dim dy As Int = destH - maxBottom
				If Abs(dy) >= 2dip Then
					For Each btn2 As Button In letterButtons
						If btn2.IsInitialized Then btn2.Top = btn2.Top + dy
					Next
					minTop = minTop + dy
					maxBottom = maxBottom + dy
				End If
			Else If lettersAtRight Then
				Dim dx As Int = destW - maxRight
				If Abs(dx) >= 2dip Then
					For Each btn3 As Button In letterButtons
						If btn3.IsInitialized Then btn3.Left = btn3.Left + dx
					Next
					minLeft = minLeft + dx
					maxRight = maxRight + dx
				End If
			Else If lettersAtLeft Then
				' colonna sinistra: resta, tabella a destra
			End If

			If tbl1.IsInitialized And tbl1.mBase.IsInitialized Then
				Dim tTop As Int = tbl1.mBase.Top
				Dim tLeft As Int = tbl1.mBase.Left
				If lettersAtBottom Then
					tbl1.mBase.SetLayoutAnimated(0, tLeft, tTop, Max(120dip, destW - tLeft), Max(150dip, minTop - tTop - 2dip))
				Else If lettersAtRight Then
					tbl1.mBase.SetLayoutAnimated(0, tLeft, tTop, Max(120dip, minLeft - tLeft - 2dip), Max(150dip, destH - tTop))
				Else If lettersAtLeft Then
					tbl1.mBase.SetLayoutAnimated(0, maxRight + 2dip, tTop, Max(120dip, destW - maxRight - 2dip), Max(150dip, destH - tTop))
				Else
					tbl1.mBase.Height = Max(150dip, destH - tTop)
				End If
			End If
		Else
			If tbl1.IsInitialized And tbl1.mBase.IsInitialized Then
				tbl1.mBase.Height = Max(150dip, destH - tbl1.mBase.Top)
			End If
		End If

		If tbl2.IsInitialized And tbl2.mBase.IsInitialized Then
			Dim altH As Int = destH
			Dim altW As Int = destW
			If pnlAlt.IsInitialized Then
				altH = pnlAlt.Height
				altW = pnlAlt.Width
			End If
			tbl2.mBase.SetLayoutAnimated(0, tbl2.mBase.Left, tbl2.mBase.Top, Max(120dip, altW - tbl2.mBase.Left), Max(150dip, altH - tbl2.mBase.Top))
		End If
	Catch
		Log("AdattaRicercaAZFullscreen: " & LastException)
	End Try
End Sub

Sub Convert_Date_YYYY_to_YY(Stringa As String) As String
	Try
		Dim NewData As String
		If (Stringa.Length>=10) Then		
			Dim Anno4 As Int = Stringa.SubString2(6,10)
			Dim Anno2 As Int = Anno4-2000
			NewData = Stringa.SubString2(0,6) & Anno2
		Else
			NewData = "" 
		End If
		Return NewData		
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Crea_UUID_Ciclo(codautoclave As String) As String
	Try
		Dim md5 As Cls_MD5
		Dim DataOra As String
		md5.Initialize
		Dim testo As String
		DataOra = Leggi_DataOraSQLite
		testo = DataOra & "|" & codautoclave
		Dim hash As String = md5.Hash(testo)
		Return hash
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub Formato_3dec_ITA_Str(NumberStr As String) As String
	Try
		Dim formatter As B4XFormatter
		Dim Number As Double = NumberStr.Replace(",",".")
		formatter.Initialize
		formatter.GetDefaultFormat.GroupingCharacter = "."
		formatter.GetDefaultFormat.DecimalPoint = ","
		formatter.GetDefaultFormat.MinimumIntegers = 1
		formatter.GetDefaultFormat.MinimumFractions = 3
		formatter.GetDefaultFormat.MaximumFractions = 3
		Return formatter.Format(Number)
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Formato_2dec_ITA_Str(NumberStr As String) As String
	Try		
		Dim formatter As B4XFormatter
		Dim Number As Double = NumberStr.Replace(",",".")
		formatter.Initialize
		formatter.GetDefaultFormat.GroupingCharacter = "."
		formatter.GetDefaultFormat.DecimalPoint = ","
		formatter.GetDefaultFormat.MinimumIntegers = 1
		formatter.GetDefaultFormat.MinimumFractions = 2
		formatter.GetDefaultFormat.MaximumFractions = 2
		Return formatter.Format(Number)
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Formato_3dec_ITA_Num(Number As Double) As String
	Try
		Dim formatter As B4XFormatter
		formatter.Initialize
		formatter.GetDefaultFormat.GroupingCharacter = "."
		formatter.GetDefaultFormat.DecimalPoint = ","
		formatter.GetDefaultFormat.MinimumIntegers = 1
		formatter.GetDefaultFormat.MinimumFractions = 3
		formatter.GetDefaultFormat.MaximumFractions = 3
		Return formatter.Format(Number)
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Formato_2dec_ITA_Num(Number As Double) As String
	Try
		Dim formatter As B4XFormatter
		formatter.Initialize
		formatter.GetDefaultFormat.GroupingCharacter = "."
		formatter.GetDefaultFormat.DecimalPoint = ","
		formatter.GetDefaultFormat.MinimumIntegers = 1
		formatter.GetDefaultFormat.MinimumFractions = 2
		formatter.GetDefaultFormat.MaximumFractions = 2		
		Return formatter.Format(Number)
	Catch		
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Convert_Date_YY_to_YYYY(Stringa As String) As String
	Try 		
		Dim Anno2 As Int = Stringa.SubString2(6,8)
		Dim Anno4 As Int = Anno2+2000
		Dim NewData As String = Stringa.SubString2(0,6) & Anno4
		Return NewData		
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub LeggiArticoloConPeso(Barcode As String, Opzione As Int) As List
	' Regola da rispettare EAN13 a peso
	' il primo carattere (1) deve essere 2 - indicatore di codice a peso
	' i caratteri (2-3-4-5-6-7)  sono il codice articolo
	' i caratteri (8-9) sono la parte intera del peso
	' i caratteri (10-11-12) sono la parte intera del peso
	Dim Result As List
	Try
		If( Barcode.Length = 13) Then			
			Result.Initialize
			Select Case Opzione
				Case 1 ' SOLO ARTICOLO
					Result.Add(Barcode.SubString2(1,7))
					Return 	Result
				Case 2 ' ARTICOLO + PESO
					Result.Add(Barcode.SubString2(1,7))
					Dim ParteIntera As String = Barcode.SubString2(7,9)
					Dim ParteDecimale As String = Barcode.SubString2(9,12)					
					Dim Peso As String = ParteIntera & "." & ParteDecimale 
					Result.Add(Peso)
					Return Result
				Case Else
					Return Null
			End Select
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub ConvertDataStrToLong(DataStr As String, FormatStr As String,  Language As String) As Long
	Try
		Dim DataLong As Long
		If DataStr = Null Then Return 0
		If DataStr.Trim = "" Then Return 0
		Select Case Language
			Case "ZZ"
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "dd-MM-yyyy HH:mm:ss" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,18)
				Else
					DateTime.DateFormat = "dd-MM-yy HH:mm:ss" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,16)
				End If
		
			Case "IT"
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "dd-MM-yyyy" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,10)						
				Else
					DateTime.DateFormat = "dd-MM-yy" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,8)						
				End If
		
			Case "ITX"
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "dd/MM/yyyy" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,10)
				Else
					DateTime.DateFormat = "dd/MM/yy" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,8)
				End If
		
			Case "EN"
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "yyyy-MM-dd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,10)						
				Else
					DateTime.DateFormat = "yy-MM-dd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,8)						
				End If
				
			Case "ENX"
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "yyyy/MM/dd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,10)
				Else
					DateTime.DateFormat = "yy/MM/dd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,8)
				End If					

			Case Else ' XX
				If(DataStr.Length>8) Then
					DateTime.DateFormat = "yyyyMMdd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,10)						
				Else
					DateTime.DateFormat = "yyMMdd" 'questa impostazione proviene da SQLite
					DataStr = DataStr.SubString2(0,8)						
				End If
								
		End Select
		' DateTime.DateFormat = "yyyy-MM-dd" 'questa impostazione proviene da SQLite
		DataLong  = DateTime.DateParse(DataStr)
		If(FormatStr <> "") Then
			DateTime.DateFormat = FormatStr
		End If
		Return DataLong
	Catch
		Log(LastException.Message) 'no changes will be made
		Return 0
	End Try
End Sub

' Sub Request_Permission
  '      If Not(rp.Check(rp.PERMISSION_ACCESS_FINE_LOCATION)) Then
  '          rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
  '          Wait For Activity_PermissionResult (Permission As String, Result As Boolean)
  '          Log($"${Permission} status: ${rp.Check(rp.PERMISSION_ACCESS_FINE_LOCATION)}"$)
  '          Sleep(0)
  '      End If
' End Sub

Sub CheckUpdating(SQLData As SQL) As Boolean
	Try
		Dim rs As ResultSet
		rs = SQLData.ExecQuery("SELECT Sync_State FROM " & Main.PrefixSQL & "_SYNC_STATE")
		If (rs.RowCount=0) Then
			rs.Close
			MsgboxAsync("Tabella 'IS_SYNC_STATE' NON TROVATA!","CONTROLLO SINCRONIZZAZIONE")
			Return(False)
		Else
			Dim CK_Updating As Int
			Do While rs.NextRow
				CK_Updating = rs.GetInt("Sync_State")
			Loop
			rs.Close
			If (CK_Updating=1) Then
				Return True
			Else
				Return False
			End If
		End If
	Catch
		MsgboxAsync(LastException.Message,"CONTROLLO SINCRONIZZAZIONE")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub CheckSerialDevice(SQLData As SQL, SerialNumber As String) As Boolean
	Try
		If (Main.Ditta="Carbon") Then
			Return(True)
		End If
		Dim rs As ResultSet
		rs = SQLData.ExecQuery("SELECT SERIALNUMBER,DATASCAD FROM " & Main.PrefixSQL & "_PALMDEVICE WHERE SERIALNUMBER ='" & SerialNumber & "'")
		If (rs.RowCount=0) Then						
			rs.Close
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")		
			Return(False)
		Else
			DateTime.DateFormat = "yyyy-MM-dd"
			Dim PerDiff As Period
			Dim DataScad_long As Long
			Dim DataScadProg As String		
			Do While rs.NextRow
				DataScadProg = rs.GetString("DATASCAD")
			Loop
			rs.Close
			DataScad_long = DateTime.DateParse(DataScadProg)
			PerDiff = DateUtils.PeriodBetween(DateTime.Now,DataScad_long)
			If (PerDiff.Days<=15) And (PerDiff.Days>0)  And (PerDiff.Years=0) Then			
				MsgboxAsync("Programma DEMO hai ancora " & PerDiff.Days & " giorni di prova!","CONTROLLO DISPOSITIVO")				
			End If
			If (PerDiff.Days<0) Or (PerDiff.Years<0) Then
				Return False
			Else 
				Return True
			End If
		End If
	Catch
		MsgboxAsync(LastException.Message,"CONTROLLO DISPOSITIVO")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_MaxNumDoc(SqlData As SQL, TipoDoc As String, Esercizio As Int) As Int
	Try
		Dim sql As String
		Dim NumDocNew As Int
		sql = "SELECT IFNULL(max(numerodoc),0) as maxnumdoc FROM " & Main.PrefixSQL & "_TESTEDOCUMENTI where tipodoc='" & TipoDoc & "'"
		NumDocNew = SqlData.ExecQuerySingleResult(sql)
		NumDocNew = NumDocNew+1
		Return NumDocNew
	Catch
		MsgboxAsync(LastException.Message,"ERRORE")
		Return 0
	End Try
End Sub


Sub ConvertDateTimeTo_ITA_Format (d As String,Time As Boolean) As String
	Try
		Dim rv As String
		Dim t As Long    
		If d.Length>10 And Time Then
			DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
			t=DateTime.DateParse(d)
			DateTime.DateFormat = "dd/MM/yyyy HH:mm:ss"    
			rv=DateTime.Date(t)
		Else
			DateTime.DateFormat="yyyy-MM-dd"
			t=DateTime.DateParse(d)
			DateTime.DateFormat = "dd/MM/yyyy"
			rv=DateTime.Date(t)
		End If
	    Return rv    
	Catch
		Log(LastException.Message) 'no changes will be made
		Return ""
	End Try
End Sub

Private Sub IsSerialVuoto (snx As String) As Boolean
	If snx = Null Or snx.Trim = "" Then Return True
	Dim s As String = snx.Trim.ToLowerCase
	Return (s = "null" Or s = "unknown" Or s = "unavailable")
End Sub

' Legge il seriale hardware del dispositivo.
' NON usa Build.getSerial(): su Android 10+ richiede SecurityException
' (READ_PRIVILEGED_PHONE_STATE) e in debug B4A interrompe l'app anche dentro Try/Catch.
' Ordine: Build.SERIAL -> system property PDA -> Android ID.
Sub GetManufacturerSerialNumber As String
	Dim snx As String = ""

	Try
		Dim jo As JavaObject
		jo.InitializeStatic("android.os.Build")
		snx = jo.GetField("SERIAL")
	Catch
		snx = ""
	End Try

	If IsSerialVuoto(snx) Then
		Try
			Dim r As Reflector
			Dim types(1) As String
			types(0) = "java.lang.String"
			r.Target = r.CreateObject("android.os.SystemProperties")
			Dim m As Object = r.GetMethod("get", types)
			snx = r.InvokeMethod(r.Target, m, Array("ro.serialno"))
			If IsSerialVuoto(snx) Then
				snx = r.InvokeMethod(r.Target, m, Array("ril.serialnumber"))
			End If
		Catch
			snx = ""
		End Try
	End If

	If IsSerialVuoto(snx) Then
		snx = GetAndroidID
	End If

	If snx = Null Then snx = ""
	Return snx.Trim
End Sub

Sub GetAndroidID As String
	Try
		Dim ctxt As JavaObject
		ctxt.InitializeContext
		
		Dim r As JavaObject
		r.InitializeStatic("android.provider.Settings$Secure")
		
		Dim cr As JavaObject = ctxt.RunMethod("getContentResolver", Null)
		Dim id As String = r.RunMethod("getString", Array(cr, "android_id"))
		Return id
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub
'private Sub ConvertDate(DateTimeString As String, DateTimeFormat As String, NewDateTimeFormat As String,Language As String,Country As String) As String
'	Dim JOLocale As JavaObject
'	Dim JODTConvertTo As JavaObject
'	Dim JODTConvertFrom As JavaObject
'	Dim JODate As JavaObject
'	JOLocale.InitializeNewInstance("java.util.Locale",Array As Object(Language,Country))
'	JODTConvertTo.InitializeNewInstance("java.text.SimpleDateFormat",Array As Object(NewDateTimeFormat,JOLocale))
'	JODTConvertFrom.InitializeNewInstance("java.text.SimpleDateFormat",Array As Object(DateTimeFormat))
'	JODate  = JODTConvertFrom.RunMethod("parse",Array As Object(DateTimeString))
'	Return JODTConvertTo.RunMethod("format",Array As Object(JODate))
'End Sub

Sub DateToFormat(Date  As Long, DateTimeFormat As String,Language As String,Country As String) As String    'ignore
	Try
		Dim JOLocale As JavaObject
		Dim JODTConvertTo As JavaObject
		Dim JODate As JavaObject
		JODate.InitializeNewInstance("java.util.Date",Array (Date))
		JOLocale.InitializeNewInstance("java.util.Locale",Array As Object(Language,Country))
		JODTConvertTo.InitializeNewInstance("java.text.SimpleDateFormat",Array As Object(DateTimeFormat,JOLocale))
		Dim Result As String = JODTConvertTo.RunMethod("format",Array As Object(JODate))
		Return Result
	Catch
		Log(LastException.Message) 'no changes will be made
		Return ""
	End Try
End Sub

' Percorsi candidati dove puo' trovarsi il DB (ordine di ricerca).
Private Sub GetDBCandidates As List
	Dim candidates As List
	candidates.Initialize
	Try
		' 1) percorso storico Pocket ISA (sempre preferito in scrittura)
		candidates.Add(rp.GetSafeDirDefaultExternal("db"))
	Catch
		Log(LastException)
	End Try
	Try
		candidates.Add(File.Combine(File.DirDefaultExternal, "db"))
	Catch
		Log(LastException)
	End Try
	Try
		' 2) cartella pubblica SD: /storage/emulated/0/db
		candidates.Add(File.Combine(File.DirRootExternal, "db"))
	Catch
		Log(LastException)
	End Try
	Try
		' 3) radice SD: /storage/emulated/0
		candidates.Add(File.DirRootExternal)
	Catch
		Log(LastException)
	End Try
	Try
		candidates.Add(File.DirInternal)
	Catch
		Log(LastException)
	End Try
	Return candidates
End Sub

' Cartella DB di default (scrivibile): Android/data/.../files/db
Public Sub GetDBFolder As String
	Try
		If File.ExternalWritable Then
			Return rp.GetSafeDirDefaultExternal("db")
		Else
			Return File.DirInternal
		End If
	Catch
		Log(LastException.Message)
		Return File.DirInternal
	End Try
End Sub

' Persistenza Path DB fuori dal SQLite (altrimenti al riavvio non si sa quale DB aprire).
Private Sub PathDBConfigFile As String
	Return "pocketisa_pathdb.txt"
End Sub

Public Sub SavePathDBConfig (folder As String, dbFile As String)
	Try
		If folder = Null Then folder = ""
		If dbFile = Null Then dbFile = ""
		folder = NormalizzaPathDb(folder)
		dbFile = dbFile.Trim
		If IsUsableDbFolder(folder) = False Then
			Log("PathDB rifiutato (non valido): " & folder)
			folder = GetDBFolder
		End If
		File.WriteString(File.DirInternal, PathDBConfigFile, folder & Chr(10) & dbFile)
		Main.PathDB = folder
		If dbFile <> "" Then Main.DBName = dbFile
		DirExt = folder
		Log("PathDB salvato in config: " & folder & " / " & dbFile)
	Catch
		Log(LastException.Message)
	End Try
End Sub

Public Sub LoadPathDBConfig As Boolean
	Try
		If File.Exists(File.DirInternal, PathDBConfigFile) = False Then Return False
		Dim txt As String = File.ReadString(File.DirInternal, PathDBConfigFile)
		If txt = Null Or txt.Trim = "" Then Return False
		Dim lines() As String = Regex.Split(Chr(10), txt.Replace(Chr(13), ""))
		Dim folder As String = ""
		Dim dbFile As String = ""
		If lines.Length > 0 Then folder = lines(0).Trim
		If lines.Length > 1 Then dbFile = lines(1).Trim
		folder = NormalizzaPathDb(folder)
		If folder = "" Or IsUsableDbFolder(folder) = False Then
			Log("PathDB config non usabile, reset: " & folder)
			ClearPathDBConfig
			Return False
		End If
		Main.PathDB = folder
		DirExt = folder
		If dbFile <> "" Then Main.DBName = dbFile
		Log("PathDB caricato da config: " & folder & " / " & dbFile)
		Return True
	Catch
		Log(LastException.Message)
		Return False
	End Try
End Sub

Public Sub ClearPathDBConfig
	Try
		If File.Exists(File.DirInternal, PathDBConfigFile) Then
			File.Delete(File.DirInternal, PathDBConfigFile)
		End If
		Main.PathDB = ""
		DirExt = GetDBFolder
		Log("PathDB config cancellato, fallback: " & DirExt)
	Catch
		Log(LastException.Message)
	End Try
End Sub

' Corregge path relativi tipo /Android/data/... o /db copiati dal file manager.
Public Sub NormalizzaPathDb (folder As String) As String
	Try
		If folder = Null Then Return ""
		folder = folder.Trim
		Do While folder.EndsWith("/") And folder.Length > 1
			folder = folder.SubString2(0, folder.Length - 1)
		Loop
		If folder = "" Then Return ""
		' Gia' assoluto sotto /storage o DirInternal
		If folder.StartsWith("/storage/") Or folder.StartsWith(File.DirInternal) Then Return folder
		' Path relativo da file manager Honeywell: /Android/data/...
		If folder.StartsWith("/Android/") Or folder = "/Android" Then
			Dim rel As String = folder
			If rel.StartsWith("/") Then rel = rel.SubString(1)
			Dim p1 As String = File.Combine(File.DirRootExternal, rel)
			Dim probe As List = File.ListFiles(p1)
			If probe.IsInitialized Then Return p1
			Dim p2 As String = File.Combine("/storage/native-emulated", rel)
			probe = File.ListFiles(p2)
			If probe.IsInitialized Then Return p2
			' Preferisci native-emulated su Honeywell se DirRootExternal non risolve
			If File.DirRootExternal.Contains("native-emulated") Then Return p1
			Return p2
		End If
		' /db sulla memoria principale
		If folder = "/db" Or folder.StartsWith("/db/") Then
			Return File.Combine(File.DirRootExternal, folder.SubString(1))
		End If
		Return folder
	Catch
		Return folder
	End Try
End Sub

' Cartella usabile: sotto /storage o app, e scrivibile (o esiste gia').
Public Sub IsUsableDbFolder (folder As String) As Boolean
	Try
		If folder = Null Or folder.Trim = "" Then Return False
		folder = folder.Trim
		' Path incompleti tipo /Android/... senza /storage → no
		If folder.StartsWith("/Android") Then Return False
		If folder = "/db" Or folder.StartsWith("/db/") Then Return False
		If folder.StartsWith("/storage/") = False And folder.StartsWith(File.DirInternal) = False Then
			' Accetta solo storage/app
			If folder <> GetDBFolder Then Return False
		End If
		' Se esiste un file o la cartella e' listabile ok
		Dim files As List = File.ListFiles(folder)
		If files.IsInitialized Then Return True
		' Prova a creare la cartella (MakeDir ricorsivo non c'e': crea ultimo segmento)
		Dim slash As Int = folder.LastIndexOf("/")
		If slash > 0 Then
			File.MakeDir(folder.SubString2(0, slash), folder.SubString(slash + 1))
			files = File.ListFiles(folder)
			If files.IsInitialized Then Return True
		End If
		Return False
	Catch
		Return False
	End Try
End Sub

' Trova la cartella dove il file DB esiste gia'; altrimenti usa GetDBFolder.
Public Sub ResolveDBFolder (Filename As String) As String
	Try
		' 1) config locale (sopravvive al riavvio)
		If Main.PathDB = Null Or Main.PathDB.Trim = "" Then
			LoadPathDBConfig
		End If

		' 2) percorso impostato in memoria / Impostazioni (validato)
		If Main.PathDB <> Null And Main.PathDB.Trim <> "" Then
			Dim custom As String = NormalizzaPathDb(Main.PathDB)
			If IsUsableDbFolder(custom) Then
				Main.PathDB = custom
				DirExt = custom
				Log("DB path impostato: " & custom)
				Return custom
			Else
				Log("DB path non usabile, fallback: " & custom)
				ClearPathDBConfig
			End If
		End If

		Dim candidates As List = GetDBCandidates
		Dim i As Int
		For i = 0 To candidates.Size - 1
			Dim folder As String = candidates.Get(i)
			If folder <> "" And Filename <> "" And File.Exists(folder, Filename) Then
				Log("DB trovato in: " & folder & "/" & Filename)
				Return folder
			End If
		Next
		' Non trovato: elenca i percorsi controllati per il debug
		For i = 0 To candidates.Size - 1
			Log("DB non trovato in: " & candidates.Get(i) & "/" & Filename)
		Next
		Return GetDBFolder
	Catch
		Log(LastException.Message)
		Return GetDBFolder
	End Try
End Sub

Sub CopyDBIfNeeded (Filename As String)
	Try
		LoadPathDBConfig
		DirExt = ResolveDBFolder(Filename)
		If IsUsableDbFolder(DirExt) = False Then
			Log("DirExt non usabile, reset a GetDBFolder: " & DirExt)
			ClearPathDBConfig
			DirExt = GetDBFolder
		End If
		' Assicura che la cartella esista
		EnsureFolderExists(DirExt)
		If File.Exists(DirExt, Filename) = False Then
			File.Copy(File.DirAssets, Filename, DirExt, Filename)
			Log("DB copiato da Assets -> " & DirExt & "/" & Filename)
		Else
			Log("DB in uso: " & DirExt & "/" & Filename)
		End If
	Catch
		Log(LastException.Message)
		' Ultimo tentativo: cartella app default
		Try
			ClearPathDBConfig
			DirExt = GetDBFolder
			EnsureFolderExists(DirExt)
			If File.Exists(DirExt, Filename) = False Then
				File.Copy(File.DirAssets, Filename, DirExt, Filename)
			End If
			Log("DB recovery su: " & DirExt & "/" & Filename)
		Catch
			Log(LastException.Message)
		End Try
	End Try
End Sub

Private Sub EnsureFolderExists (folder As String)
	Try
		If folder = Null Or folder.Trim = "" Then Return
		Dim files As List = File.ListFiles(folder)
		If files.IsInitialized Then Return
		Dim slash As Int = folder.LastIndexOf("/")
		If slash > 0 Then
			File.MakeDir(folder.SubString2(0, slash), folder.SubString(slash + 1))
		End If
	Catch
		Log("EnsureFolderExists: " & LastException.Message)
	End Try
End Sub

' Scrive Path_DB in IMPOSTAZIONI come copia di lettura. Il file config resta la fonte primaria.
Public Sub SyncPathDbMirrorToSqlite (SQL As SQL, folder As String, dbFile As String, rowId As Int)
	Try
		If SQL.IsInitialized = False Then Return
		If folder = Null Then folder = ""
		folder = folder.Trim
		Do While folder.EndsWith("/") And folder.Length > 1
			folder = folder.SubString2(0, folder.Length - 1)
		Loop
		If folder = "" Then Return
		DB_SQLite.Alter_Table_IS_IMPOSTAZIONI(SQL)
		If rowId > 0 Then
			SQL.ExecNonQuery2("UPDATE IMPOSTAZIONI SET Path_DB = ? WHERE rowid = ?", Array As Object(folder, rowId))
		Else
			SQL.ExecNonQuery2("UPDATE IMPOSTAZIONI SET Path_DB = ?", Array As Object(folder))
		End If
		Log("Path_DB mirror SQLite = " & folder & " (db=" & dbFile & ")")
	Catch
		Log("SyncPathDbMirrorToSqlite: " & LastException.Message)
	End Try
End Sub

Sub CopySoundsIfNeeded (Filename As String)
	Try
		' Non sovrascrivere DirExt (deve restare la cartella del DB)
		Dim soundDir As String = rp.GetSafeDirDefaultExternal("sounds")
		If File.Exists(soundDir, Filename) = False Then
			File.Copy(File.DirAssets, Filename, soundDir, Filename)
			Log(File.DirAssets & " - " & Filename & " - " & soundDir & " - " & Filename)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub CopyIfNeeded (Filename As String, Folder As String)
	Try
		' Non sovrascrivere DirExt (deve restare la cartella del DB)
		Dim targetDir As String = rp.GetSafeDirDefaultExternal(Folder)
		If File.Exists(targetDir, Filename) = False Then
			File.Copy(File.DirAssets, Filename, targetDir, Filename)
			Log(File.DirAssets & " - " & Filename & " - " & targetDir & " - " & Filename)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub formato_europeo_0dec(formatter As B4XFormatter)
	Try
		'Formatto con Numero Europeo
		formatter.Initialize
		Dim DefaultFormat As B4XFormatData = formatter.GetDefaultFormat
		DefaultFormat.DecimalPoint = ","
		DefaultFormat.GroupingCharacter = "."
		DefaultFormat.MaximumFractions = 0
		DefaultFormat.MinimumFractions = 0
		DefaultFormat.MinimumIntegers = 1
		formatter.AddFormatData(DefaultFormat, 0,0,False)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub formato_europeo_2dec(formatter As B4XFormatter)
	Try
		'Formatto con Numero Europeo
		formatter.Initialize
		Dim DefaultFormat As B4XFormatData = formatter.GetDefaultFormat
		DefaultFormat.DecimalPoint = ","
		DefaultFormat.GroupingCharacter = "."
		DefaultFormat.MaximumFractions = 2
		DefaultFormat.MinimumFractions = 2
		DefaultFormat.MinimumIntegers = 1 
		formatter.AddFormatData(DefaultFormat, 0,0,False)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Leggi_DataOraSQLite As String
	Try
		DateTime.DateFormat = "yyyy-MM-dd"
		DateTime.TimeFormat = "HH:mm:ss"
		Return DateTime.Date(DateTime.Now) & " " & DateTime.Time(DateTime.Now)
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub LeggiIndexComboBox(vCombobox As B4XComboBox, vValue As String) As Int
	Try
		Dim idx As Int = -1
		Dim vStringa As String
		Dim vPos As Int
		For i=0 To vCombobox.Size-1
			vPos = vCombobox.GetItem(i).IndexOf("-")
			If(vPos>1) Then
				vStringa = vCombobox.GetItem(i).SubString2(0,vPos-1).trim
				If (vStringa=vValue) Then
					idx = i
				End If
			End If
		Next
		Return idx		
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Sub Leggi_MD5_Caricamento (SqlDataAccess As SQL, CodiceAutoclave As String, ntubo As Int) As String
	Dim Cursor3 As Cursor
	Try
		Dim MD5_Comp As String = ""
		
		Cursor3 = SqlDataAccess.ExecQuery2( _
			"SELECT MD5_COMP " & _
			"FROM GS_AUTOCLAVE_STORY_D " & _
			"WHERE CODAUTOCLAVE = ? " & _
			"AND NUMTUBO = ? AND POS>0 " & _
			"ORDER BY DATAORA DESC " & _
			"LIMIT 1", _
			Array As String(CodiceAutoclave, ntubo))
		
		If Cursor3.RowCount > 0 Then
			Cursor3.Position = 0
			MD5_Comp = Cursor3.GetString("MD5_COMP")
		End If
		
		Cursor3.Close
		Return MD5_Comp
		
	Catch
		Log(LastException)
		
		If Cursor3.IsInitialized Then
			Cursor3.Close
		End If
		
		Return ""
	End Try
End Sub

Sub CreateCustomFormat (c As B4XTableColumn, t As B4XTable)
	Try
		Dim formatter As B4XFormatter
		formatter.Initialize
		c.Formatter = formatter
		Dim Positive As B4XFormatData = c.Formatter.NewFormatData
		Positive.TextColor = t.TextColor
		Positive.FormatFont = XUI.CreateDefaultFont(16)
		Positive.DecimalPoint = ","
		Positive.GroupingCharacter = "."
		Positive.MaximumFractions = 0
		Positive.MinimumFractions = 0
		c.Formatter.AddFormatData(Positive, 0, c.Formatter.MAX_VALUE, True) 'Inclusive (zero included)
		Dim Negative As B4XFormatData = c.Formatter.CopyFormatData(Positive)
		Negative.TextColor = XUI.Color_Red
		Negative.FormatFont = XUI.CreateDefaultBoldFont(16)
		c.Formatter.AddFormatData(Negative,c.Formatter.MIN_VALUE, 0, False)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub CreateCustomFormat1Dec (c As B4XTableColumn, t As B4XTable)
	Try
		Dim formatter As B4XFormatter
		formatter.Initialize
		c.Formatter = formatter
		Dim Positive As B4XFormatData = c.Formatter.NewFormatData
		Positive.TextColor = t.TextColor
		Positive.FormatFont = XUI.CreateDefaultFont(16)
		Positive.DecimalPoint = ","
		Positive.GroupingCharacter = "."
		Positive.MaximumFractions = 1
		Positive.MinimumFractions = 1		
		c.Formatter.AddFormatData(Positive, 0, c.Formatter.MAX_VALUE, True) 'Inclusive (zero included)
		Dim Negative As B4XFormatData = c.Formatter.CopyFormatData(Positive)
		Negative.TextColor = XUI.Color_Red
		Negative.FormatFont = XUI.CreateDefaultBoldFont(16)
		'Negative.Prefix = "("
		'Negative.Postfix = ")"
		c.Formatter.AddFormatData(Negative,c.Formatter.MIN_VALUE, 0, False)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub CreateCustomFormat2Dec (c As B4XTableColumn, t As B4XTable)
	Try
		Dim formatter As B4XFormatter
		formatter.Initialize
		c.Formatter = formatter
		Dim Positive As B4XFormatData = c.Formatter.NewFormatData
		Positive.TextColor = t.TextColor
		Positive.FormatFont = XUI.CreateDefaultFont(16)
		Positive.DecimalPoint = ","
		Positive.GroupingCharacter = "."
		Positive.MaximumFractions = 2
		Positive.MinimumFractions = 2	
		c.Formatter.AddFormatData(Positive, 0, c.Formatter.MAX_VALUE, True) 'Inclusive (zero included)
		Dim Negative As B4XFormatData = c.Formatter.CopyFormatData(Positive)
		Negative.TextColor = XUI.Color_Red
		Negative.FormatFont = XUI.CreateDefaultBoldFont(16)
		'Negative.Prefix = "("
		'Negative.Postfix = ")"
		c.Formatter.AddFormatData(Negative,c.Formatter.MIN_VALUE, 0, False)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub NumberFormat_ITA(d As Double, ni As Int, nd As Int ) As String
	Try
		Dim s As String = NumberFormat2(d, ni, nd, nd,True)
		s = s.Replace(".","|")
		s = s.Replace(",","?")
		s = s.Replace("|",",")
		s = s.Replace("?",".")
		Return s
	Catch
		Log(LastException.Message) 'no changes will be made
		Return 0
	End Try
End Sub

Sub CloseActivities
	Try
		Dim jo As JavaObject
		jo.InitializeContext
		jo.RunMethod("finishAffinity", Null)
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Check_Sconto_Syntax(ScontoStr As String) As Boolean
	Try
		If (ScontoStr.Trim <> "") Then
			Dim F_Error As Boolean = False 
			Dim arr_sconto() As String
			ScontoStr = ScontoStr.Replace("+","§")
			arr_sconto = Regex.Split("§",ScontoStr)
			For i=0 To arr_sconto.Length-1
				If Not(IsNumber(arr_sconto(i))) Then
					F_Error=True
				End If
			Next
			If (F_Error) Then			
				Return False
			Else
				Return True
			End If		
		Else
			Return True
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Calc_Valore_Scontato(Valore As Double, ScontoStr As String, TipoRiga As String) As Double
	Try
		' Calcola sconto composto
		Dim valore_scontato As Double = Valore
		If (TipoRiga.ToUpperCase="O") Then
			valore_scontato = 0 
		Else				
			If (ScontoStr <> "") Then
				ScontoStr = ScontoStr.Replace("+","§")
				Dim arr_sconto() As String
				arr_sconto = Regex.Split("§",ScontoStr)
				For i=0 To arr_sconto.Length-1
					If (IsNumber(arr_sconto(i))) Then
						valore_scontato = valore_scontato  * (1-( arr_sconto(i)/100))					
					End If
				Next
			Else
				valore_scontato = Valore		
			End If
		End If
		Return valore_scontato
	Catch
		Log(LastException.Message) 'no changes will be made
		Return 0
	End Try
End Sub

Sub ConvertToNumber(stringa As String) As Double
	Try	
		If IsNumber(stringa) Then
			Return stringa
		Else
			Dim Pos As Int = stringa.IndexOf(" ")
			If (Pos>0) Then
				stringa = stringa.SubString2(0,Pos)
				If IsNumber(stringa) Then
					Return stringa
				Else
					Return 0
				End If
			Else
				Return 0		
			End If		
		End If		
	Catch
		Log(LastException.Message) 'no changes will be made		
		Return 0
	End Try
End Sub


' SingleLine
Sub SetSingleLine(xRow As Int, xColumn As B4XTableColumn, SingleLine As Boolean,Ellipsize As String)
	Try
		Dim pnl As B4XView = xColumn.CellsLayouts.Get(xRow)
		Dim lbl As Label = pnl.GetView(0)
		lbl.SingleLine = SingleLine
		lbl.Ellipsize = Ellipsize	
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Play_Sound(FilenameSound As String)
	Try
		FilenameSound = FilenameSound.ToUpperCase
		Select FilenameSound
			Case "SOUND1.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID1, 1, 1, 1000, 0, 1)
			Case "SOUND2.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID2, 1, 1, 1000, 0, 1)
			Case "SOUND3.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID3, 1, 1, 1000, 0, 1)
			Case "ERROR.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID4, 1, 1, 1000, 0, 1)
			Case "OK.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID5, 1, 1, 1000, 0, 1)
			Case "VOICEOK.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID6, 1, 1, 1000, 0, 1)
			Case "BUTTON.WAV"
				Choose_Menu.mSoundPool.Play(Choose_Menu.mMySoundLoadID7, 1, 1, 1000, 0, 1)
			Case Else		
				MsgboxAsync("Filename: " & FilenameSound & " non trovato!","ERRORE SOUNDFILE!")		
		End Select		
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Decodifica_Colore_Valore (Val1 As Double, Val2 As Double) As String
	Try
		Dim Colore As String = ""
		If (Val2=0) Then
			Colore = "P"  ' Rosa
		else if (Val1>Val2) Then
			Colore = "Y"  ' Giallo
		else if (Val1<Val2) Then
			Colore = "R"  ' Rosso
		Else
			Colore = "G"  ' Verde
		End If
		Return Colore
	Catch
		Log(LastException.Message) 'no changes will be made
		Return ""
	End Try
End Sub

Sub Decodifica_Colore_Int (Colore As String) As Int
	Try
		Select Case Colore
			Case "G"
				Return Main.SelectionColor_Green
			Case "R"
				Return Main.SelectionColor_Red
			Case "Y"
				Return Main.SelectionColor_Yellow
			Case "P"
				Return Main.SelectionColor_Pink
			Case Else
				Return Main.SelectionColor_Cyan
		End Select
	Catch
		Log(LastException.Message) 'no changes will be made
		Return 0
	End Try
End Sub

Public Sub ToInt(Value As Object) As Int
	If Value = Null Then Return 0
    
	Dim s As String = "" & Value
	s = s.Trim
	If s.Length = 0 Then Return 0
    
	' Gestione virgola decimale (IT) e spazi
	s = s.Replace(",", ".")
    
	If IsNumber(s) = False Then Return 0
    
	Dim d As Int = s
	Return d   ' assegnando Double a Int, B4A tronca automaticamente
End Sub

Sub GetFolderFileName (path As String, pattern As String) As String	
	Try
		Dim filename As String 
		Dim end_pattern As Boolean = False
		Dim idx As Int = path.LastIndexOf(pattern)
		If(path<>"") Then 
			If((idx+1)=path.Length) Then
				idx = path.LastIndexOf2(pattern,idx-1)
				end_pattern = True
			End If
			If (end_pattern) Then
				filename = path.SubString2(idx+1,path.Length-1)
			Else
				filename = path.SubString(idx+1)
			End If
			Return filename		
		Else
			Return ""
		End If
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

 Sub Vaiid_EditText_Int (EditText As EditText, HasFocus As Boolean, val_min As Int, val_max As Int, um As String) As Boolean
	Try
		If(HasFocus=False) Then
			Dim v As Int = IIf(EditText.Text.Trim = "", 0, EditText.Text)
			If (v < val_min Or v > val_max) And v<>0 Then
				Play_Sound("Error.wav")
				ToastMessageShow("VALORE " & EditText.Text & " FUORI RANGE (" & val_min & "- " & val_max & ") " & um, True)
				EditText.Text = ""
				EditText.RequestFocus
				Return False
			Else
				Return True
			End If
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

Public Sub Aggiorna_Autoclave_UltProc(SQLData As SQL, CodiceAutoclave As String, UltimoProc As Int, Ciclo As Int)
	Try
		Dim DataOra_Agg As String = Leggi_DataOraSQLite
		If(UltimoProc>0) Then
			SQLData.BeginTransaction
			If(Starter.UUID_Ciclo="") Or (Starter.UUID_Ciclo=Null) Then
				Starter.UUID_Ciclo = Crea_UUID_Ciclo(CodiceAutoclave)
				SQLData.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET ULTIMOPROC=?,DATAORA_AGG=?,CODRICETTA=?,ULTIMOCICLO=?,UUID_CICLO=? WHERE CODICE=?", _
				Array As Object(UltimoProc,DataOra_Agg,Starter.CodRicetta,Ciclo,Starter.UUID_Ciclo,CodiceAutoclave))		
			Else
				SQLData.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET ULTIMOPROC=?,DATAORA_AGG=?,CODRICETTA=?,ULTIMOCICLO=? WHERE CODICE=?", _
				Array As Object(UltimoProc,DataOra_Agg,Starter.CodRicetta,Ciclo,CodiceAutoclave))		
			End If			
			#if debug
				Log("Aggiorna_Autoclave_UltProc " & CodiceAutoclave & " Ultimo proc. " & UltimoProc & " Ultimo ciclo " & Ciclo & " UUID_Ciclo " & Starter.UUID_Ciclo)
			#End If
			SQLData.TransactionSuccessful
			SQLData.EndTransaction
			Starter.UltimoProc=UltimoProc
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub Aggiorna_Autoclave_FineCiclo(SQLData As SQL,codautoclave As String)
	Try
		Dim DataOra_Agg As String = Leggi_DataOraSQLite
		SQLData.ExecNonQuery2("UPDATE GS_AUTOCLAVI SET DATA_TRASMESSO=? WHERE CODICE=?", _
		Array As Object(DataOra_Agg,codautoclave))			
		#if debug
		Log("Aggiorna_Autoclave_UltProc " & codautoclave & " DATA AGG. " & DataOra_Agg & " UUID_Ciclo " & Starter.UUID_Ciclo)
		#End If
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub Leggi_Ultimo_proc_Tubo(SqlData As SQL, CodAutoclave As String, nTubo As Int, UltProc As Int) As Double
	Try
		Dim UltProcTubo As Double
		Dim Cursor3 As Cursor
		Select Case UltProc
			Case 4000
				Cursor3 = SqlData.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO BETWEEN 4000 AND 4999 ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo))
			Case 8000
				Cursor3 = SqlData.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO BETWEEN 8000 AND 8999 ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo))
			Case Else
				Cursor3 = SqlData.ExecQuery2("SELECT PROCESSO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' AND PROCESSO = ? ORDER BY PROCESSO DESC, DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo,UltProc))
		End Select
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			UltProcTubo = Cursor3.GetDouble("PROCESSO")
		Else
			UltProcTubo = UltProc
		End If
		Cursor3.Close
		Return UltProcTubo
	Catch
		Log(LastException)
		Return 0
	End Try
	
End Sub

Public Sub Leggi_Ultimo_Stato_Tubo(SqlData As SQL, CodAutoclave As String, nTubo As Int) As String
	Try
		Dim UltStatoTubo As String
		Dim Cursor3 As Cursor
		Cursor3 = SqlData.ExecQuery2("SELECT STATO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND NTUBO=? AND IFNULL(DATAORA_FINE,'')='' ORDER BY DATAORA_INIZIO DESC LIMIT 1", Array As String(CodAutoclave,nTubo))
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			UltStatoTubo = Cursor3.GetString("STATO")
		Else
			UltStatoTubo = ""
		End If
		Cursor3.Close
		Return UltStatoTubo
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Public Sub MD5_stringa(testo As String) As String
	Try
		Dim md5 As Cls_MD5
		md5.Initialize
		Dim testo As String
		Dim hash As String = md5.Hash(testo)
		Return hash
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub
