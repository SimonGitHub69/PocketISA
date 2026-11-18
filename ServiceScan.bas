B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.4
@EndOfDesignText@
#Region Service Attributes
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Public ScanLogic As ClsScanLogic
End Sub

Sub Service_Create
	ScanLogic.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground
End Sub

Sub Service_Destroy
End Sub

Public Sub GestisciBarcode(Codice As Object, Tipo As Object)
	Dim sCodice As String = "" & Codice
	Dim sTipo As String = "" & Tipo

	Log("ServiceScan -> ricevuto: " & sCodice)
	Log("ServiceScan -> tipo: " & sTipo)
		
	' qui puoi:
	' - salvare su DB
	' - chiamare API
	' - controllare codici
End Sub
