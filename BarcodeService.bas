B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.4
@EndOfDesignText@
Sub Process_Globals
	Dim BR As BroadCastReceiver
End Sub

Sub Service_Create
	Log("BarcodeService - Service_Create")
	BR.Initialize("BR")
	BR.RegisterReceiver("com.datalogic.decodewedge.decode_action")
	Log("BarcodeService - Receiver registrato")
End Sub

Sub Service_Start (StartingIntent As Intent)
	Log("BarcodeService - Service_Start")
End Sub

Sub BR_BroadcastReceived(Action As String, Extras As Map)
	Log("BARCODE ACTION: " & Action)
	If Extras.IsInitialized = False Then Return
	
	Dim barcode As String = Extras.Get("com.datalogic.decode.intentwedge.barcode_string")
	Log("BARCODE: " & barcode)
	
	If barcode <> "" Then
		CallSubDelayed2(Main, "BarcodeRicevuto", barcode)
	End If
End Sub

Sub Service_Destroy
	Try
		BR.UnregisterReceiver
	Catch
	End Try
End Sub