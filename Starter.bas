B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=8.8
@EndOfDesignText@
#Region  Service Attributes 
    #StartAtBoot: False
    #ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Dim csu As CallSubUtils
	Public SelectedID As Int
	Public Parametro1 As String
	Public Parametro2 As String ' Codice Autoclave
	' Public Parametro3 As Int
	Public Parametro4 As String
	Public Parametro5 As Int
	Public Parametro6 As Int
	Public Parametro7 As Int    ' Ultimo Processo
	Public NumTubo As Int
	Public UltimoProc As Int
	Public MenuProc As Int
	Public StatoSacco As String
	Public StatoSaccoPrec As String
	Public CodRicetta As String
	Public CodDip1 As String
	Public CodDip2 As String
	Public CodDip3 As String
	Public CodDipRegVal As Int ' codice operatore che registra i valori
	Public RegScheda As Boolean
	Public SerialNumber As String
	Public par_AltezzaGrid As Int
	Public par_LargDescGrid As Int
	Public par_PathImages As String
	Public CodiceAZ As String
	Public UltimoCiclo As Int
	Public MD5_Comp As String
	Public UUID_Ciclo As String
	'-------------------------------
	' Scanner
	'-------------------------------
	Public UsaIntentScanner As Boolean
	Public Pda As BarcodeManager
	Public PropPda As Map
	Public ScanLogic As ClsScanLogic
	Private LastCode As String = ""
	Private LastReadTime As Long = 0
End Sub

Sub Service_Create
	If UsaIntentScanner = True Then 
		PropPda.Initialize
		ScanLogic.Initialize
	End If
End Sub

Sub Service_Start (StartingIntent As Intent)
	Try
		If csu.IsInitialized = False Then csu.Initialize

		If UsaIntentScanner Then
			AttivaScannerSeServe
		Else
			Log("Scanner non attivo")
		End If
	Catch
		Log(LastException)
	End Try

	Service.StopAutomaticForeground
End Sub

Public Sub AttivaScannerSeServe
	If UsaIntentScanner = False Then Return

	Try
		If PropPda.IsInitialized = False Then PropPda.Initialize
		If ScanLogic.IsInitialized = False Then ScanLogic.Initialize
		Pda.Initialize("Pda")
		Log("Scanner inizializzato")
	Catch
		Log("Errore scanner: " & LastException)
	End Try
End Sub

Sub Service_TaskRemoved
End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
End Sub

'========================
' EVENTI SCANNER
'========================

Sub Pda_onScanInit
	If UsaIntentScanner = False Then Return
	Log("Scanner Init")
End Sub

Sub Pda_onScanStarted
	If UsaIntentScanner = False Then Return
	Log("Scan Started")
End Sub

Sub Pda_onScanStopped
	If UsaIntentScanner = False Then Return
	Log("Scan Stopped")
	Try
		Pda.releaseTrigger
	Catch
		Log(LastException)
	End Try
End Sub

Sub Pda_onScanTimeout
	If UsaIntentScanner = False Then Return
	Log("Scan Timeout")
End Sub

Sub Pda_onRead(code As String, barcodetype As String, result As Object)
	If UsaIntentScanner = False Then Return

	Dim codiceLetto As String = code.Trim
	If codiceLetto = "" Then Return

	Dim adesso As Long = DateTime.Now
	If codiceLetto = LastCode And adesso - LastReadTime < 1000 Then
		FermaScanner
		Return
	End If

	LastCode = codiceLetto
	LastReadTime = adesso

	FermaScanner

	If ScanLogic.IsInitialized Then
		CallSubDelayed3(ScanLogic, "GestisciBarcode", codiceLetto, barcodetype)
	End If
End Sub

Private Sub FermaScanner
	Try
		Pda.stopDecode
		Pda.releaseTrigger
	Catch
		Log(LastException)
	End Try
End Sub