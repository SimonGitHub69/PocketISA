B4A=true
Group=Default Group
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
	Public vCodice As String
	Public vDescrizione As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Dialog As B4XDialog
	Private Base As B4XView
	Dim sqlstr As String
	Private Panel2 As Panel
	Public Operazione As String 
	Private Panel1 As Panel
	Private Label1 As Label
	Private Label9 As Label
	Private EditText2 As EditText
	Private EditText1 As EditText
	Private EditText4 As EditText
	Private Label10 As Label
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private Phone As IME
	Public vTipoDocNew As String
	Public vNumDocNew As Int
	Public vEsercizioNew As Int
	Public vDataDocNew As String
	Public vOperazione As String
	Public vRagSoc As String
	Public vNumListino As Int
	Public vBarcodeLetto As String	
	Private formatter As B4XFormatter
	Private Button7 As Button
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Panel3 As Panel
	Private Label5 As Label
	Private EditText5 As EditText
	Private EditText6 As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:	
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("VerificaPrezzo")
	Sleep(0)
	ExtraUtility.formato_europeo_2dec(formatter)
	Panel2.Visible=False
	Dim Panel1 As Panel	
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)		
	Base = Activity
	Dialog.Initialize (Base)
	Label1.Text = "VERIFICA PREZZO"
	Dim stringa As String = DB_SQLite.Leggi_NRListinoVendita(SQLDataAccess)
	Dim arr_Listno() As String
	arr_Listno = Regex.Split("§",stringa)
	vNumListino = arr_Listno(0)		
	vBarcodeLetto = ""
	Operazione = "Add"
	vBarcodeLetto = ""
	Panel2.Visible=True
	Panel1.SendToBack
	Dim cdw As ColorDrawable
	cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
	Panel2.Background = cdw
	Label9.Text=""
	EditText1.Text=""
	EditText2.Text=""
	EditText4.Text=""
	EditText4.RequestFocus
End Sub

Sub Activity_Resume
	Sleep(0)
	If(Ricerca_AZ.vCodice<>"") Then
		EditText4.Text=Ricerca_AZ.vCodice
		Label9.Text=Ricerca_AZ.vDescrizione
		Dim PrezzoCorr As Double = 0
		PrezzoCorr = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
		EditText1.Text = PrezzoCorr
		EditText4.Text = ""
		EditText4.RequestFocus		
		Ricerca_AZ.vCodice = ""
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Sub Button7_Click
	StartActivity(Ricerca_AZ)	
End Sub

Sub SwiftButton1_Click()
	' Annulla
	Panel2.Visible=False
	Sleep(0)
	Dim Phone As IME
	Phone.HideKeyboard
	EditText1.Text=""
	EditText2.Text=""
	EditText4.Text=""
	EditText6.Text=""
	Label9.Text=""
	Activity.Finish
End Sub

Sub SwiftButton2_Click
	' Annulla
	Panel2.Visible=False
	Sleep(0)
	Dim Phone As IME
	Phone.HideKeyboard
	Activity.Finish
End Sub

Sub EditText4_EnterPressed
	Try
		' 8056455939510	
		vBarcodeLetto = EditText4.Text
		Select Main.Ditta
			Case "ZelariVi"
			sqlstr = "select CODICE,DESCRIZIONE,UMV,UMA,UM from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA='0' AND BARCODE like '" & EditText4.Text.Trim & "%'"
			Case "Esseci"
				sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI " _
				& "AA LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
				
			Case "Trendy"
				sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI " _
				& "AA LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
				
			Case "Nesti"
				sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,AA.CODICE,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM from IS_ANAGRAFICAARTICOLI " _
				& "AA LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE AA.CODICE = '" & EditText4.Text.Trim & "'"
		End Select
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				Label9.Text = rs.GetString("DESCRIZIONE")
				EditText4.Text = rs.GetString("CODICE")		
				EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
				EditText5.Text = rs.GetString("UMV")
				EditText2.Text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)								
			Loop		
			rs.close
			EditText6.Text = EditText4.Text
			EditText4.RequestFocus
		Else
			Select Main.Ditta
				Case "Esseci"
					sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& "ON AA.CODICE=BC.ARTICOLO LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'" 							
					Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
					If (rs.RowCount>0) Then
						Do While rs.NextRow
							Label9.Text = rs.GetString("DESCRIZIONE")
							EditText4.Text = rs.GetString("ARTICOLO")
							EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
							EditText5.Text = rs.GetString("UMV")
							EditText2.Text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)
						Loop
						rs.close
						EditText6.Text = EditText4.Text
					Else
						ExtraUtility.Play_Sound("error.wav")
						Label9.Text = "*** CODICE ERRATO ***"
						EditText6.Text = EditText4.Text
						EditText1.Text = ""
						EditText5.Text = ""
						EditText2.Text = ""
					End If
					
				Case "Trendy"
					sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& "ON AA.CODICE=BC.ARTICOLO LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'" 							
					Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
					If (rs.RowCount>0) Then
						Do While rs.NextRow
							Label9.Text = rs.GetString("DESCRIZIONE")
							EditText4.Text = rs.GetString("ARTICOLO")						
							EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
							EditText5.Text = rs.GetString("UMV")					
							EditText2.Text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)							
						Loop					
						rs.close
						EditText6.Text = EditText4.Text
					Else
						ExtraUtility.Play_Sound("error.wav")
						Label9.Text = "*** CODICE ERRATO ***"
						EditText6.Text = EditText4.Text
						EditText1.Text = ""
						EditText5.Text = ""
						EditText2.Text = ""
					End If
					
				Case "Nesti"
					sqlstr = "SELECT IFNULL(VG.GIACENZA,0) AS GIACENZA,BC.ARTICOLO,AA.DESCRIZIONE,AA.UMV,AA.UMA,AA.UM FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA " _
					& "ON AA.CODICE=BC.ARTICOLO LEFT OUTER JOIN VISTAGIACENZAPERPALMARE VG ON VG.CODART=AA.CODICE WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'" 							
					Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
					If (rs.RowCount>0) Then
						Do While rs.NextRow
							Label9.Text = rs.GetString("DESCRIZIONE")
							EditText4.Text = rs.GetString("ARTICOLO")
							EditText1.Text = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
							EditText5.Text = rs.GetString("UMV")
							EditText2.Text = NumberFormat2(rs.GetDouble("GIACENZA"),0,0,0,False)
						Loop
						rs.close
						EditText6.Text = EditText4.Text
					Else
						ExtraUtility.Play_Sound("error.wav")
						Label9.Text = "*** CODICE ERRATO ***"
						EditText6.Text = EditText4.Text
						EditText1.Text = ""
						EditText5.Text = ""
						EditText2.Text = ""
					End If
					
				Case Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText6.Text = EditText4.Text
					EditText1.Text = ""
					EditText5.Text = ""
					EditText2.Text = ""
			End Select
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub EditText4_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		If(EditText4.Text <> "")  Then
			EditText4.Text=""
			EditText4.RequestFocus			
			' Phone.ShowKeyboard(EditText4)
		Else
			If(Label9.Text = "*** CODICE ERRATO ***") Then
				' caso errore riamngo sul codice
				EditText4.RequestFocus
			End If
		End If
	End If
End Sub
