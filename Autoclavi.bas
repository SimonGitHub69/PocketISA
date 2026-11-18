B4A=true
Group=Default Group\Carbon
ModulesStructureVersion=1
Type=Activity
Version=13.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public xui As XUI
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private ListAutoclavi As List
	Private pnlGrid As Panel
	Private NumRows As Int = 7
	Private NumCols As Int = 4
	Private CellWidth As Float
	Private CellHeight As Float
	Private GapWidth As Float
	Private txt_size As Int
	Private ttubo As String
	Private selezione_autoclave As String
	Private SwiftButton1 As SwiftButton
	Private ComboProcessi As B4XComboClick
	Private txt_title As Label
	Private LastIndex As Int = -1
	Private pnlContainer As Panel
	Private SelectedRows As B4XSet
	Private pnlGrid As Panel    ' quello che già usi per contenere i bottoni
	Private RowColor As Int = Colors.RGB(240, 240, 240)
	Private arr_proc() As String
	Private arr_proc0() As String
	Private arr_proc1() As String
	Private arr_proc2() As String
	Private arr_proc3() As String
	Private arr_proc4() As String
	Private B4XTable1 As B4XTable
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Private SwiftButton2 As SwiftButton	
	Private SwiftButton3 As SwiftButton
	Private SwiftButton4 As SwiftButton
	Private SwiftButton6 As SwiftButton
	Private CustomListView1 As CustomListView
	Private lblTitoloTubo As Label
	Private lblTitoloControlli As Label
	Private arr_proc0() As String = Array As String("-")
	Private arr_proc1() As String = Array As String("Cambio Ricetta", "Inizio Caricamento", "Fine Caricamento")
	Private arr_proc2() As String = Array As String("Interrompi Pressata", "Inizio Pressata", "Controllo Pressata", "Fine Pressata")
	Private arr_proc3() As String = Array As String("Registra VALORI", "Inizio Ciclo", "Controllo Ciclo", "Fine Ciclo", "Interrompi Ciclo")
	Private arr_proc4() As String = Array As String("INVIA DATI SERVER", "__________________________________", "AZZERA DATI AUTOCLAVE")
	Private SwiftButton_Eye As SwiftButton
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Try
		Activity.RemoveAllViews
		Sleep(0)

		If FirstTime Then
			ExtraUtility.CopyDBIfNeeded(Main.DBName)

			If File.Exists(ExtraUtility.DirExt, Main.DBName) Then
				SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
			Else
				MsgboxAsync("Pathname " & ExtraUtility.DirExt & "/" & Main.DBName & " non trovato!", "ERRORE PATH")
				Return
			End If
		End If

		Activity.LoadLayout("Autoclavi")
		Activity.Color = Colors.LightGray

		Starter.UltimoProc = 0

		If Starter.Parametro2 = "" Then
			txt_title.Text = "SELEZIONARE AUTOCLAVE"
			ComboProcessi.Visible = False
		Else
			txt_title.Text = "SELEZIONARE IL PROCESSO"
			ComboProcessi.Visible = True
		End If

		B4XTable1.mBase.Visible = False
		SwiftButton1.mBase.Visible = False
		SwiftButton_Eye.mBase.Visible = False
		
		Dim posautoclave As Int = Choose_PosAutoclave(Starter.Parametro2)
		Swift_Buttons_Visible(posautoclave, True)

		arr_proc = Leggi_ArrayProc(Starter.UltimoProc)
		Leggi_Autoclavi
		CustomListView1.GetBase.Visible = False
			
	Catch
		Log(LastException)
		MsgboxAsync(LastException.Message, "Errore Activity_Create")
	End Try
End Sub

Sub Leggi_Titoli_Processi(nproceso As Int) As String
	Try
		Dim titolo As String
		Select nproceso
			Case 1000
				titolo = "INIZIO CARICAMENTO"
			Case 2000
				titolo = "FINE CARICAMENTO"
			Case 3000
				titolo = "INIZIO PRESSATA"
			Case 4000
				titolo = "CONTROLLO PRESSATA"
			Case 5000
				titolo = "INTERROMPI PRESSATA"
			Case 6000
				titolo = "FINE PRESSATA"
			Case 7000
				titolo = "INIZIO CICLO"
			Case 8000
				titolo = "CONTROLLO CICLO"
			Case 9000
				titolo = "INTERROMPI CICLO"
			Case 9999
				titolo = "FINE CICLO"
		End Select
		Return titolo
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Sub Activity_Resume
	Try
		If(Starter.Parametro2<>"") Then
			CreaGriglia(Starter.Parametro6, Starter.Parametro5, Starter.Parametro7, Starter.Parametro2)
			ComboProcessi.Visible=True
		Else
			If pnlGrid.IsInitialized = False Then
				' fallback: crea un panel
				pnlGrid.Initialize("")
				Activity.AddView(pnlGrid, 0, 0, 100%x, 100%y)
			End If
			pnlGrid.RemoveAllViews
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Leggi_Autoclavi()
	Try
		' carico il combo cn le autoclavi
		Dim ttubo As String
		ListAutoclavi.Initialize
		ListAutoclavi = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT Descrizione,UltimoProc FROM GS_AUTOCLAVI",Null,0)
		If(ListAutoclavi.Size>0) Then
			Dim arr_Autoclave() As String
			Dim numpos As Int
			For Each arr_Autoclave() As String In ListAutoclavi
				numpos = Choose_PosAutoclave(arr_Autoclave(0))
				If(arr_Autoclave(1)<>Null)	Then
					If(arr_Autoclave(1)>0) And (arr_Autoclave(1)<9999) Then
						Swift_Buttons_Visible(-numpos,True)						
					End If
					If(arr_Autoclave(1)=9999) Then
						Swift_Buttons_Visible(-numpos,True)
					End If
				End If
			Next
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("ESEGUIRE UNA LETTURA DEI DATI!",True)
			SwiftButton2.Enabled=False
			SwiftButton2.mBase.Enabled=False
			SwiftButton2.mbase.Alpha=0.4
			SwiftButton2.xLBL.Color=Colors.Gray
			SwiftButton3.Enabled=False
			SwiftButton3.mBase.Enabled=False
			SwiftButton3.mbase.Alpha=0.4
			SwiftButton3.xLBL.Color=Colors.Gray
			SwiftButton6.Enabled=False
			SwiftButton6.mBase.Enabled=False
			SwiftButton6.mbase.Alpha=0.4
			SwiftButton6.xLBL.Color=Colors.Gray
			SwiftButton4.Enabled=False
			SwiftButton4.mBase.Enabled=False
			SwiftButton4.mbase.Alpha=0.4
			SwiftButton4.xLBL.Color=Colors.Gray		
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ComboProcessi_Click()
	Try
		Swift_Buttons_Visible(0,False)
		If (ComboProcessi.IsOpen) Then
			NascondiGriglia
			B4XTable1.mBase.Visible=False
			SwiftButton1.mBase.Visible=False
			MostraGriglia
		End If
		#if DEBUG
			Log("ComboProcessi_click")
		#End If		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ComboProcessi_SelectedIndexChanged (Index As Int)
	Try
		Log("ComboProcessi " & ComboProcessi.GetItem(Index)		)
		If (ComboProcessi.GetItem(Index).ToUpperCase = "REGISTRA VALORI") Then
			txt_title.Text = ""
			NascondiGriglia
			StartActivity("Autoclave_Reg")
			MostraGriglia
		ELSE If (ComboProcessi.GetItem(Index).ToUpperCase = "CAMBIO RICETTA") Then
			txt_title.Text = "Selezionare la ricetta:"
			B4XTable1.mBase.Visible=True
			SwiftButton1.mBase.Visible=True
			ComboProcessi.Visible=False
			ListaRicette
			NascondiGriglia
			ComboProcessi.Text = ""
			ComboProcessi.Visible = True
		Else
			Wait For (Calcola_Processo(Starter.Parametro2, Starter.UltimoProc, Starter.UltimoCiclo, ComboProcessi.GetItem(Index))) Complete (m As Map)

			If m = Null Then Return

			If m.GetDefault("CONFERMATO", False) = True Then
	
				Dim Processo As Int = m.Get("PROCESSO")
				Dim Ciclo As Int = m.Get("CICLO")

				Log("Processo: " & Processo)
				Log("Ciclo: " & Ciclo)
	
				If Processo = 2000 Or Processo = 3000 Or Processo = 5000 Or Processo = 6000 Or _
	   					Processo = 7000 Or Processo = 9000 Or Processo = 9999 Then
		
					Wait For (Aggiorna_Fine_Evento(Starter.Parametro2, Starter.UltimoProc, Processo, Ciclo)) Complete (Result As Boolean)
		
					If Result Then
						txt_title.Text = m.GetDefault("TITOLO", "")
					End If
		
				Else
					ExtraUtility.Aggiorna_Autoclave_UltProc(SQLDataAccess, Starter.Parametro2, Processo, Ciclo)
					txt_title.Text = m.GetDefault("TITOLO", "")
					If(Processo=-1) Then
						Activity.Finish
					End If
				End If
	
			Else
				Leggi_Menu_Combo_Processi(ComboProcessi, Starter.UltimoProc)
				Log("Operazione annullata")
			End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Choose_PosAutoclave(codautoclave As String) As Int
	Try
		Select Case codautoclave
			Case "IROP1"
				Return 1
			Case "IROP2"
				Return 2
			Case "MAROSO"
				Return 3
			Case "PANINI"
				Return 4
			Case Else
				Return 0
		End Select
	Catch
		Return Null
		Log(LastException)
	End Try
End Sub                                 

Private Sub Choose_Autoclave(Index As Int)
	Try			
		Dim codautoclave As String
		Dim sqlstr As String	
		Dim ntubi As Int
		Dim Ultproc As Int
		Dim CodOpe1 As String
		Dim CodOpe2 As String
		Dim CodOpe3 As String
		Dim UUID_Ciclo As String
		Ultproc = 0
		Select Index
			Case 1
				codautoclave="IROP1"
			Case 2
				codautoclave="IROP2"
			Case 3
				codautoclave="MAROSO"
			Case 4
				codautoclave="PANINI"
			Case Else
				codautoclave=""
		End Select
		Starter.Parametro2 = codautoclave
		ntubi =Leggi_NumTubi(codautoclave)
		Starter.CodRicetta = ""		
		ComboProcessi.DropDownVisible(False)
		If(Index>0) Then	
			Select Case True
				Case ntubi<=12
					NumCols = 3
				Case (ntubi>12 And ntubi<=20)
					NumCols = 4
				Case (ntubi>20 And ntubi<=36)
					NumCols = 5
				Case (ntubi>36 And ntubi<=40)
					NumCols = 5
			End Select
			NumRows = Round(ntubi/NumCols)+1
			Starter.Parametro6 = NumRows
			Starter.Parametro5 = NumCols
			Starter.Parametro7 = ntubi
			'pnlGrid.Initialize("")
			If(codautoclave<>"") Then				
				CreaGriglia(NumRows, NumCols, ntubi, codautoclave)
			End If
		End If
		#If DEBUG 
			Log(codautoclave)
		#end  if
		ComboProcessi.ResetSelection		
		sqlstr = "SELECT ULTIMOPROC,CODRICETTA,CODDIP1,CODDIP2,CODDIP3,UUID_CICLO FROM GS_AUTOCLAVI WHERE CODICE=?"
		Dim Cursor1 As Cursor
		Cursor1 = SQLDataAccess.ExecQuery2(sqlstr, Array As String(codautoclave))
		If Cursor1.RowCount > 0 Then
			Cursor1.Position = 0
			Ultproc = Cursor1.GetInt("ULTIMOPROC")
			Starter.CodRicetta = Cursor1.GetString("CODRICETTA")
			CodOpe1 =  Cursor1.GetString("CODDIP1")
			CodOpe2 =  Cursor1.GetString("CODDIP2")
			CodOpe3 =  Cursor1.GetString("CODDIP3")
			UUID_Ciclo = Cursor1.GetString("UUID_CICLO")
			If(CodOpe1<>Null) Then
				Starter.CodDip1 = CodOpe1
			End If
			If(CodOpe2<>Null) Then
				Starter.CodDip2 = CodOpe2
			End If
			If(CodOpe3<>Null) Then
				Starter.CodDip3 = CodOpe3
			End If			
			If(UUID_Ciclo<>Null) Then
				Starter.UUID_Ciclo = UUID_Ciclo
			End If
			#IF DEBUG
				Log("trovato ultimo evento " & Cursor1.Getint("ULTIMOPROC"))
			#End If
		Else
			Ultproc = 0
		End If		
		Cursor1.Close		
		If(Ultproc>0) Then
			If(Starter.CodRicetta<>Null) And (Ultproc<=2000) Then
				txt_title.Text = "Ricetta: " & Starter.CodRicetta & " - " & Leggi_Menu_Combo_Processi(ComboProcessi,Ultproc)
			Else
				txt_title.Text = Leggi_Menu_Combo_Processi(ComboProcessi,Ultproc)
			End If
			Swift_Buttons_Visible(0,False)
			MostraGriglia			
		Else
			txt_title.Text = "SELEZIONARE IL PROCESSO"
			Swift_Buttons_Visible(0,True)
			NascondiGriglia
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub MostraGriglia
	Try		
		If pnlGrid.IsInitialized Then pnlGrid.Visible = True
	Catch
		Log(LastException)
	End Try
End Sub

Sub NascondiGriglia
	Try
		If pnlGrid.IsInitialized Then pnlGrid.Visible = False
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ImpostaMisureGriglia(ntubi As Int)
	Select True
		Case ntubi <= 12
			CellWidth = 100dip
			CellHeight = 110dip
			GapWidth = 15dip

		Case ntubi <= 20
			CellWidth = 80dip
			CellHeight = 85dip
			GapWidth = 10dip

		Case ntubi <= 30
			CellWidth = 62dip
			CellHeight = 72dip
			GapWidth = 10dip

		Case ntubi <= 35
			CellWidth = 62dip
			CellHeight = 62dip
			GapWidth = 10dip

		Case ntubi <= 40
			CellWidth = 62dip
			CellHeight = 53dip
			GapWidth = 10dip

		Case Else
			CellWidth = 75dip
			CellHeight = 52dip
			GapWidth = 10dip
	End Select
End Sub

Sub CreaGriglia(Righe As Int, Colonne As Int, ntubi As Int, codautoclave As String)
	Try
		If pnlGrid.IsInitialized = False Then
			pnlGrid.Initialize("")
			Activity.AddView(pnlGrid, 0, 0, 100%x, 100%y)
		End If

		pnlGrid.RemoveAllViews

		Dim xOffset As Float
		Dim yOffset As Float
		Dim txt_size As Int

		ImpostaMisureGriglia(ntubi)

		Select True
			Case ntubi <= 12
				xOffset = 15dip
				yOffset = 70dip
				txt_size = 48

			Case ntubi <= 20
				xOffset = 5dip
				yOffset = 70dip
				txt_size = 36

			Case ntubi <= 30
				xOffset = 5dip
				yOffset = 70dip
				txt_size = 28

			Case ntubi <= 35
				xOffset = 5dip
				yOffset = 63dip
				txt_size = 24

			Case ntubi <= 40
				xOffset = 5dip
				yOffset = 63dip
				txt_size = 24

			Case Else
				xOffset = 15dip
				yOffset = 70dip
				txt_size = 24
		End Select

		Dim autoclave As Map = Leggi_Info_Autoclave(codautoclave)
		If autoclave.IsInitialized = False Or autoclave.Size = 0 Then Return

		Starter.UltimoProc = autoclave.GetDefault("UltimoProc", 0)

		Dim ListaTubi As List
		ListaTubi.Initialize
		ListaTubi.Add(Array As Int(autoclave.GetDefault("Da_num1", 0), autoclave.GetDefault("A_num1", 0)))
		ListaTubi.Add(Array As Int(autoclave.GetDefault("Da_num2", 0), autoclave.GetDefault("A_num2", 0)))
		ListaTubi.Add(Array As Int(autoclave.GetDefault("Da_num3", 0), autoclave.GetDefault("A_num3", 0)))

		Dim Risultato As List = GeneraArray(ListaTubi)

		Dim indiceTubo As Int = 0

		For i = 0 To Righe - 1
			For j = 0 To Colonne - 1

				If indiceTubo >= ntubi Then Exit

				Dim ttubo As String = ""
				If indiceTubo < Risultato.Size Then
					ttubo = Risultato.Get(indiceTubo)
				End If

				indiceTubo = indiceTubo + 1

				Dim btn As Button
				btn.Initialize("btnGrid")
				btn.Text = ttubo
				btn.TextColor = Colors.Green
				btn.TextSize = txt_size
				btn.Typeface = Typeface.DEFAULT_BOLD
				btn.Color = Colors.Gray

				Dim mTag As Map
				mTag.Initialize
				mTag.Put("RIGA", i)
				mTag.Put("COLONNA", j)
				mTag.Put("NTUBO", ttubo)
				btn.Tag = mTag

				If ttubo <> "" Then
					Dim MD5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess, Starter.Parametro2, ttubo)

					If MD5_Comp <> "" Then
						Dim res As Map = Leggi_Info_Tubo(MD5_Comp, Starter.Parametro2, ttubo, Starter.UltimoProc, Starter.UltimoCiclo)

						If res.IsInitialized And res.Size > 0 Then
							Dim Count As Int = res.GetDefault("COUNT", 0)

							If Count > 0 Then
								Dim Stato As String = res.GetDefault("STATO", "")

								#if DEBUG
									Log("Tubo: " & ttubo & " - Stato: " & Stato & " griglia ")
								#End If

								Set_Color_btn(btn, Stato, Count)

								If res.GetDefault("DATAORA_FINE", Null) <> Null Then
									' btn.Color = Colors.DarkGray
									' eventualmente blocco pulsante:
									' btn.Enabled = False
								End If
							End If
						End If
					End If
				End If

				pnlGrid.AddView(btn, _
					xOffset + j * (CellWidth + GapWidth), _
					yOffset + i * (CellHeight + GapWidth), _
					CellWidth, _
					CellHeight)

			Next
		Next

	Catch
		Log(LastException)
	End Try
End Sub

'Sub CreaGriglia_old(Righe As Int, Colonne As Int, ntubi As Int, codautoclave As String)
'	Try
'		If pnlGrid.IsInitialized = False Then
'			pnlGrid.Initialize("")
'			Activity.AddView(pnlGrid, 0, 0, 100%x, 100%y)
'		End If
'		pnlGrid.RemoveAllViews
'		Dim xOffset As Float 
'		Dim yOffset As Float
'		Dim ntubo As Int = 0
'		Dim Count As Int = 0 
'		Dim ttubo As String = ""
'		Dim txt_size As Int = 24
'		Select Case True
'			Case ntubi<=12
'				xOffset = 15dip
'				yOffset = 70dip
'				txt_size = 48
'				CellWidth = 100dip
'				CellHeight = 110dip
'				GapWidth = 15dip
'			
'			Case (ntubi>12 And ntubi<=20)
'				xOffset = 5dip
'				yOffset = 70dip
'				txt_size = 36
'				CellWidth = 80dip
'				CellHeight = 85dip
'				GapWidth = 10dip
'	
'			Case (ntubi>20 And ntubi<=30)
'				xOffset = 5dip
'				yOffset = 70dip
'				txt_size = 28
'				CellWidth = 62dip
'				CellHeight = 72dip
'				GapWidth = 10dip
'				
'			Case (ntubi>30 And ntubi<=35)
'				xOffset = 5dip
'				yOffset = 63dip
'				txt_size = 24
'				CellWidth = 62dip
'				CellHeight = 62dip
'				GapWidth = 10dip
'	
'			Case (ntubi>35 And ntubi<=40)
'				xOffset = 5dip
'				yOffset = 63dip
'				txt_size = 24
'				CellWidth = 62dip
'				CellHeight = 53dip
'				GapWidth = 10dip
'							
'			Case Else
'				xOffset = 15dip
'				yOffset = 70dip
'				txt_size = 24
'				CellWidth = 75dip
'				CellHeight = 52dip
'				GapWidth = 10dip
'				
'				
'		End Select		
'		Dim autoclave As Map
'		autoclave.Initialize
'		autoclave = Leggi_Info_Autoclave(codautoclave)		
'		Starter.UltimoProc = autoclave.Get("UltimoProc")
'		Dim ListaTubi As List		
'		ListaTubi.Initialize		
'		ListaTubi.Add(Array As Int(autoclave.Get("Da_num1"), autoclave.Get("A_num1")))
'		ListaTubi.Add(Array As Int(autoclave.Get("Da_num2"), autoclave.Get("A_num2")))
'		ListaTubi.Add(Array As Int(autoclave.Get("Da_num3"), autoclave.Get("A_num3")))		
'		Dim Risultato As List = GeneraArray(ListaTubi)
'		Dim Stato As String
'		For i = 0 To Righe - 1
'			For j = 0 To Colonne - 1
'				' Crea un bottone per la cella				
'				Dim btn As Button
'				btn.Initialize("btnGrid") ' tutti i bottoni usano lo stesso event name			
'				If(ntubo<Risultato.Size) Then
'					ttubo = Risultato.Get(ntubo)
'				Else
'					ttubo = ""
'				End If
'				ntubo = ntubo + 1
'				btn.Text = ttubo
'				btn.TextColor = Colors.Green
'				btn.TextSize = txt_size
'				btn.Typeface = Typeface.DEFAULT_BOLD
'				btn.Tag = Array As Int(i, j) ' salviamo riga e colonna nel Tag
'				If(ttubo<>"") Then
'					Dim res As Map
'					Dim MD5_Comp As String = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2, ttubo)
'					res = Leggi_Info_Tubo(MD5_Comp, Starter.Parametro2, ttubo, Starter.UltimoProc, Starter.UltimoCiclo)
'					If(res.Size>1) And (MD5_Comp<>"") Then
'						Count = res.Get("COUNT")
'						If(Count>0) Then
'							Stato = res.Get("STATO")
'							#if DEBUG
'								Log("Stato: " & Stato)
'							#End If
'							Set_Color_btn(btn,Stato,Count)
'							If(res.Get("DATAORA_FINE")<>Null) Then
'								'	btn.Color = Colors.DarkGray  ' quando verrà bloccato
'							End If					
'						End If
'					Else
'						btn.Color = Colors.Gray
'					End If
'				End If
'				' Dim Risultato As List = GeneraArray(Intervalli)
'				' Log(Risultato)    ' → (1, 2, 3, 5, 6, 7, 10)
'				If(ntubo<=ntubi) Then
'					pnlGrid.AddView(btn, xOffset + j * (CellWidth + GapWidth), yOffset + i * (CellHeight + GapWidth), CellWidth, CellHeight)
'				End If
'			Next
'		Next
'	Catch
'		Log(LastException)
'	End Try
'End Sub

Sub Set_Color_btn(btn As Button, stato As String, Count As Int)
	Try				
		If(Count>0) Then
			Select stato
				Case "S" 	' scoppiato
					btn.Color = Colors.red
				Case "P" 	' Perdita
					btn.Color = Colors.Yellow
				Case "A"	' Note - altro
					btn.Color = Colors.white
				Case "K"	' OK
					btn.Color = Colors.RGB(34,100,50)
				Case "X"	' Scollegato
					btn.Color = Colors.Gray
				Case "Y"		' Scollegato forzatamente
					btn.Color = Colors.Gray
				Case Null		' Da collegare
					btn.Color = Colors.Gray
				Case "E"		' Collegamento Eliminato
					btn.Color = Colors.Gray
				Case "C"
					btn.Color = Colors.Blue
				Case ""
					' niente
				Case Else
					btn.Color = Colors.Cyan
			End Select
		Else
			btn.Color = Colors.Gray
		End If
	Catch
		Log(LastException)
	End Try
End Sub


Sub btnGrid_Click
	Try
		'--------------------------------------
		' UltimoProc = 3 Inizio Pressata
		'--------------------------------------
		Dim MD5_Comp As String
		MD5_Comp = "zzzzzzzzzzzzz"
		Dim btn As Button = Sender
		If (Starter.UltimoProc=4000) Or(Starter.UltimoProc=8000) Or (Starter.UltimoProc=5000) Or (Starter.UltimoProc=9000) Then ' Controllo Pressata e Controllo Ciclo
			MD5_Comp = ExtraUtility.Leggi_MD5_Caricamento(SQLDataAccess,Starter.Parametro2,btn.Text)			
			If(MD5_Comp="") And (Starter.UltimoProc<>5000) And (Starter.UltimoProc<>9000) Then
				ExtraUtility.Play_Sound("Error.wav")
				ToastMessageShow("TUBAZIONE NON CARICATA!",False)
			End If
		End If
		If(MD5_Comp<>"") Or (Starter.UltimoProc=5000) Or (Starter.UltimoProc=9000) Then
			Select	Starter.UltimoProc
				Case 3000			
					' Inizio Pressata			
					ExtraUtility.Play_Sound("Error.wav")
					ToastMessageShow("SELEZIONARE CONTROLLO PRESSATA!",False)	
								
				Case 7000
					' Inizio Ciclo
					ExtraUtility.Play_Sound("Error.wav")
					ToastMessageShow("SELEZIONARE CONTROLLO CICLO!",False)
					
				Case Else			
					Starter.SelectedID = btn.text
					If(Starter.UltimoProc>0) Then
						If(btn.Text>0) Then
							#IF DEBUG
								Log("TUBO N. " & btn.Text)
							#End If
							Starter.Parametro1 = Starter.Parametro2 & " - TUBO "  & btn.text
							Starter.NumTubo = NumberFormat(btn.text,0,0) ' numero tubo
							StartActivity("Autoclave_Ins")
						End If
					Else
						ExtraUtility.Play_Sound("Error.wav")
						ToastMessageShow("SELEZIONARE UN PROCESSO!",True)
					End If
					
			End Select
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Check_Dati_Trasmessi (codautoclave As String) As Boolean
	Try
		Dim Trovato As Boolean = False
		Dim RS As ResultSet = SQLDataAccess.ExecQuery2( _
			"SELECT IFNULL(DATA_TRASMESSO,'') AS DATA_TRASMESSO FROM GS_AUTOCLAVI WHERE CODICE = ?", _
			Array As String(codautoclave))
		If RS.NextRow Then
			If(RS.GetString("DATA_TRASMESSO")<>"") Then
				Trovato = True
			Else
				Trovato = False
			End If
		End If
		RS.Close
		Return Trovato
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Sub Leggi_Info_Autoclave(CodAutoclave As String) As Map
	Try
		Starter.Parametro2 = CodAutoclave

		Dim Autoclave As Map
		Autoclave.Initialize
		Autoclave.Put("Trovato", False)
		Autoclave.Put("CodRicetta", "")

		Dim RS As ResultSet = SQLDataAccess.ExecQuery2( _
			"SELECT NUMTUBI, DA_NUM1, A_NUM1, DA_NUM2, A_NUM2, DA_NUM3, A_NUM3, ULTIMOPROC, DATAORA_AGG, CODRICETTA, ULTIMOCICLO, UUID_CICLO " & _
			"FROM GS_AUTOCLAVI WHERE CODICE = ?", _
			Array As String(CodAutoclave))

		If RS.NextRow Then
			Autoclave.Put("Trovato", True)
			Autoclave.Put("numtubi", RS.GetInt("NUMTUBI"))
			Autoclave.Put("Da_num1", RS.GetInt("DA_NUM1"))
			Autoclave.Put("A_num1", RS.GetInt("A_NUM1"))
			Autoclave.Put("Da_num2", RS.GetInt("DA_NUM2"))
			Autoclave.Put("A_num2", RS.GetInt("A_NUM2"))
			Autoclave.Put("Da_num3", RS.GetInt("DA_NUM3"))
			Autoclave.Put("A_num3", RS.GetInt("A_NUM3"))
			Autoclave.Put("UltimoProc", RS.GetInt("ULTIMOPROC"))
			Autoclave.Put("UltimoCiclo", RS.GetInt("ULTIMOCICLO"))
			Autoclave.Put("DataOra_Agg", RS.GetString("DATAORA_AGG"))
			Autoclave.Put("CodRicetta", RS.GetString("CODRICETTA"))					
			Autoclave.Put("UUID_CICLO", RS.GetString("UUID_CICLO"))
		End If

		RS.Close

		Dim CodRicetta As String = Autoclave.GetDefault("CodRicetta", "")
		Dim UltimoProc As Int = Autoclave.GetDefault("UltimoProc", 0)
		Dim UltimoCiclo As Int = Autoclave.GetDefault("UltimoCiclo", 0)
		Dim UUID_Ciclo As String = Autoclave.GetDefault("UUID_CICLO", "")
		
		If CodRicetta <> Null And CodRicetta.Trim <> "" Then
			Starter.CodRicetta = CodRicetta
		Else
			Starter.CodRicetta = ""
		End If
		If UltimoProc <> 0 Then
			Starter.UltimoProc = UltimoProc
		Else
			Starter.UltimoProc = 0
		End If
		If UltimoCiclo <> 0 Then
			Starter.UltimoCiclo = UltimoCiclo
		Else
			Starter.UltimoCiclo = 0
		End If
		If (UUID_Ciclo <> "") Then
			Starter.UUID_Ciclo = UUID_Ciclo
		Else
			Starter.UUID_Ciclo = ""
		End If
		Return Autoclave
	Catch
		Log(LastException.Message)
		Starter.CodRicetta = ""
		Return Null
	End Try
End Sub

Sub Aggiorna_Fine_Evento(CodAutoclave As String, OldProcesso As Int, NewProcesso As Int, Ciclo As Int) As ResumableSub
	Try
		Dim c As Cursor = SQLDataAccess.ExecQuery2("SELECT CODAUTOCLAVE FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND PROCESSO = ? AND REPLICA = ?", _
			Array As String(CodAutoclave,NewProcesso,Ciclo))
		If c <> Null And c.IsInitialized Then
			SQLDataAccess.BeginTransaction
			If c.RowCount = 0 And NewProcesso>0 And OldProcesso>0 Then
				Dim DataOra As String = ExtraUtility.Leggi_DataOraSQLite
				Select 	NewProcesso
					Case 3000 ' Inizio Pressata
						Aggiorna_Evento_Componenti(CodAutoclave, NewProcesso, Ciclo)
		
					Case 4000 ' Interompi Pressata
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _											
						"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
						"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO = 3000 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
						"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
						Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))
					
					Case 5000 ' Interompi Pressata
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _											
						"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
						"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO BETWEEN 3000 And 4999 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
						"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
						Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))
						
		        		'"SELECT  CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?, ?, ?  FROM GS_AUTOCLAVE_STORY_H " & _
		        		'"WHERE CODAUTOCLAVE = ? AND PROCESSO = ? AND REPLICA = ?", Array As Object(DataOra,NewProcesso,Ciclo,CodAutoclave,3000,Ciclo))
						
					Case 6000 ' Fine Pressata
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _											
						"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
						"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO BETWEEN 3000 And 4999 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
						"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
						Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))
						
'						SQLDataAccess.ExecNonQuery2( _
'						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, DATAORA_INIZIO, PROCESSO, REPLICA, STATO) " & _
'		        		"SELECT  CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, ?, ?, ?, ?  FROM GS_AUTOCLAVE_STORY_H " & _
'		        		"WHERE CODAUTOCLAVE = ? AND PROCESSO = ? AND REPLICA = ?", _
'						Array As Object(DataOra,NewProcesso,Ciclo,"C",CodAutoclave,3000,Ciclo))
										
					Case 7000 ' Inizio Ciclo
						Aggiorna_Evento_Componenti(CodAutoclave, NewProcesso, Ciclo)
						
					Case 8000 ' Interompi Pressata
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _											
						"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
						"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO = 7000 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
						"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
						Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))
					
					Case 9000 ' Interrompi Ciclo
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA,UUID_CICLO) " & _											
						"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
						"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO BETWEEN 7000 And 8999 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
						"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
						Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))
						
'						SQLDataAccess.ExecNonQuery2( _
'						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, DATAORA_INIZIO, PROCESSO, REPLICA, STATO) " & _
'		        		"SELECT  CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, ?, ?, ?, ?  FROM GS_AUTOCLAVE_STORY_H " & _
'		        		"WHERE CODAUTOCLAVE = ? AND PROCESSO = ? AND REPLICA = ?", Array As Object(DataOra,NewProcesso,Ciclo,"C",CodAutoclave,7000,Ciclo))
					
					Case 9999 ' Fine Ciclo								
						Dim D As clsDialogGS
						D.Initialize(Activity)
						Wait For (D.ShowYesNo( _
							"VUOI REGISTRARE I DATI?")) Complete (Result As Int)
						If Result = xui.DialogResponse_Positive Then
							SQLDataAccess.ExecNonQuery2( _
							"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, NOTE, STATO, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _											
							"SELECT CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, MD5_COMP, '' AS NOTE, STATO, ?,?,?,? FROM GS_AUTOCLAVE_STORY_H H " & _
							"WHERE H.CODAUTOCLAVE = ? AND H.REPLICA = ? AND UUID_CICLO = ? AND H.PROCESSO BETWEEN 7000 And 8999 AND H.ID = (Select H2.ID FROM GS_AUTOCLAVE_STORY_H H2 WHERE H2.CODAUTOCLAVE = " & _
							"H.CODAUTOCLAVE And H2.NTUBO = H.NTUBO AND H2.REPLICA = H.REPLICA AND H2.UUID_CICLO = H.UUID_CICLO ORDER BY H2.DATAORA_INIZIO DESC,H2.PROCESSO DESC,H2.ID DESC LIMIT 1) ORDER BY H.CODAUTOCLAVE, H.NTUBO", _
							Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,Ciclo,Starter.UUID_Ciclo))					
							
							Wait For (Registra_Dati(Starter.Parametro2)) Complete (Result2 As Boolean)
							If( Result2) Then
								ExtraUtility.Aggiorna_Autoclave_FineCiclo(SQLDataAccess,CodAutoclave)
								MsgboxAsync("REGISTRAZIONE CONCLUSA CON SUCCESSO!","REGISTRAZIONE SERVER OK!")								
							End If
						Else
							#if DEBUG
								Log("premuto NO")
							#End If				
						End If					
						
					Case Else					
						SQLDataAccess.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVE_STORY_H (CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, STATO, MD5_COMP, NOTE, DATAORA_INIZIO, PROCESSO, REPLICA, UUID_CICLO) " & _
		        		"SELECT  CODAUTOCLAVE, NTUBO, CODICEDIP1, CODICEDIP2, CODICEDIP3, STATO, MD5_COMP, '' AS NOTE, ?, ?, ?, ? FROM GS_AUTOCLAVE_STORY_H " & _
		        		"WHERE CODAUTOCLAVE = ? AND PROCESSO = ? AND REPLICA = ? AND UUID_CICLO = ?", Array As Object(DataOra,NewProcesso,Ciclo,Starter.UUID_Ciclo,CodAutoclave,OldProcesso,Ciclo,Starter.UUID_Ciclo))
					
				End Select				
				SQLDataAccess.TransactionSuccessful
				SQLDataAccess.EndTransaction
				#if DEBUG
					Log("Aggiornamento processo effettuato!")
				#End If	
				ExtraUtility.Aggiorna_Autoclave_UltProc(SQLDataAccess,Starter.Parametro2,NewProcesso,Ciclo)
				If(NewProcesso<>9999) Then
					ToastMessageShow("OPERAZIONE COMPLETATA CON SUCCESSO!", True)
				End If					
			End If
			Return True
		Else
			Return False
		End If
	Catch
		ExtraUtility.Play_Sound("Error.wav")
		ToastMessageShow("ERRORE DI REGISTRAZIONE!!!!!", True)
		Log(LastException)
		Return False
	End Try
End Sub

Sub Leggi_Info_Tubo(MD5_Comp As String, codautoclave As String, ntubo As Int, Processo As Int, Ciclo As Int) As Map
	Dim result As Map
	result.Initialize
	Dim c As Cursor
	Try
		If SQLDataAccess.IsInitialized = False Then
			result.Put("ERRORE", "DB non inizializzato")
			Return result
		Else
			#IF DEBUG
				Log("Processo -> " & Processo & " Ciclo " & Ciclo & " Tubo " & ntubo)			
			#End If
		End If		
		Select Processo
			Case 4000				
				c = SQLDataAccess.ExecQuery2( _
                    "SELECT CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,DATAORA_FINE,PROCESSO,STATO,REPLICA,UUID_CICLO " & _
                    "FROM GS_AUTOCLAVE_STORY_H " & _
                    "WHERE MD5_COMP = ? AND PROCESSO BETWEEN 3000 AND 4999 AND REPLICA = ? AND NTUBO = ? AND UUID_CICLO = ? " & _
                    "ORDER BY REPLICA DESC, PROCESSO DESC LIMIT 1", _
                    Array As String(MD5_Comp, Ciclo, ntubo, Starter.UUID_Ciclo))

			Case 8000
				c = SQLDataAccess.ExecQuery2( _
                    "SELECT CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,DATAORA_FINE,PROCESSO,STATO,REPLICA,UUID_CICLO " & _
                    "FROM GS_AUTOCLAVE_STORY_H " & _
                    "WHERE MD5_COMP = ? AND PROCESSO BETWEEN 7000 AND 8999 AND REPLICA = ? And UUID_CICLO = ? " & _
                    "ORDER BY REPLICA DESC, PROCESSO DESC LIMIT 1", _
                    Array As String(MD5_Comp, Ciclo, Starter.UUID_Ciclo))

			Case Else
				c = SQLDataAccess.ExecQuery2( _
                    "SELECT CODICEDIP1,CODICEDIP2,CODICEDIP3,NOTE,DATAORA_FINE,PROCESSO,STATO,REPLICA,UUID_CICLO " & _
                    "FROM GS_AUTOCLAVE_STORY_H WHERE MD5_Comp = ? And Processo = ? And REPLICA = ? And UUID_CICLO = ? " & _
                    "ORDER BY REPLICA DESC, PROCESSO DESC LIMIT 1", _
                    Array As String(MD5_Comp, Processo, Ciclo, Starter.UUID_Ciclo))
		End Select

		If c <> Null And c.IsInitialized Then
			If c.RowCount > 0 Then
				c.Position = 0
				result.Put("COUNT", c.RowCount)
				result.Put("DATAORA_FINE", c.GetString("DATAORA_FINE"))
				result.Put("NOTE", c.GetString("NOTE"))
				result.Put("STATO", c.GetString("STATO"))
				result.Put("PROCESSO", c.GetInt("PROCESSO"))
				result.Put("UUID_CICLO", c.GetString("UUID_CICLO"))
				#if DEBUG
					Log("Tubo " & ntubo & " stato " & c.GetString("STATO") & " uuid_ciclo " & c.GetString("UUID_CICLO"))
				#End If
				' result.Put("REPLICA", c.GetInt("REPLICA"))
			Else
				result.Put("COUNT", 0)
				#if DEBUG
					Log("trovati 0 record")
				#End If
			End If
			c.Close
		Else
			result.Put("ERRORE", "Query non inizializzata")
		End If

		Return result

	Catch
		If c <> Null And c.IsInitialized Then c.Close		
		Log(LastException)
		result.Put("ERRORE", LastException.Message)
		Return result
	End Try
End Sub

Sub Carica_Dati_Autoclave(CodAutoclave As String)
	Try
		Dim m As Map
		m = Leggi_Info_Autoclave(CodAutoclave)
		If(Starter.CodRicetta<>"") Then
			Starter.CodDip1 = ""
			Starter.CodDip2 = ""
			Starter.CodDip3 = ""
			txt_title.Text = "Selezionare la ricetta:"
			B4XTable1.mBase.Visible=True
			SwiftButton1.mBase.Visible=True
			ComboProcessi.Visible=False
			ListaRicette
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Calcola_Processo(CodAutoclave As String, UltimoProcesso As Int, UltimoCiclo As Int, Azione As String) As ResumableSub
	Try
		Dim m As Map
		m.Initialize
	
		Dim Color_Disable As Int = Colors.ARGB(255,204,204,204) ' Grigio chiaro
		Dim color_value As Int = ComboProcessi.SelectedTextColor
		Dim NuovoProcesso As Int = 0
		Dim NuovoCiclo As Int = UltimoCiclo
		Dim Label_txt As String = ""

		If(Color_Disable=color_value) Then
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("OPERAZIONE NON POSSIBILE!",False)
			Return Null
		End If
	
		Select Azione.ToUpperCase.Trim

			Case "REGISTRA VALORI"
				NuovoProcesso = 0
		
			Case "INIZIO CARICAMENTO"
				NuovoProcesso = 1000
			
			Case "FINE CARICAMENTO"
				NuovoProcesso = 2000
			
			Case "INIZIO PRESSATA"
				NuovoProcesso = 3000
			
				If UltimoProcesso = 5000 Then
					NuovoCiclo = UltimoCiclo + 1
				Else If UltimoCiclo = 0 Then
					NuovoCiclo = 1
				End If
			
			Case "CONTROLLO PRESSATA"
				NuovoProcesso = 4000
			
			Case "INTERROMPI PRESSATA"
				NuovoProcesso = 5000
			
			Case "FINE PRESSATA"
				NuovoProcesso = 6000
			
			Case "INIZIO CICLO"
				NuovoProcesso = 7000
			
				If UltimoProcesso = 9000 Then
					NuovoCiclo = UltimoCiclo + 1
				Else If UltimoCiclo = 0 Then
					NuovoCiclo = 1
				End If
			
			Case "CONTROLLO CICLO"
				NuovoProcesso = 8000
			
			Case "INTERROMPI CICLO"
				NuovoProcesso = 9000
			
			Case "FINE CICLO"
				NuovoProcesso = 9999
			
			Case "INVIA DATI SERVER"
				NuovoProcesso = 9999
				Wait For (Registra_Dati(Starter.Parametro2)) Complete (Result2 As Boolean)
				If( Result2) Then
					MsgboxAsync("REGISTRAZIONE CONCLUSA CON SUCCESSO!","REGISTRAZIONE SERVER OK!")
				End If
	
			Case "AZZERA DATI AUTOCLAVE"
				NuovoProcesso = 9999
				If(Check_Dati_Trasmessi(CodAutoclave)) Then
					Wait For (Azzera_Autoclave(Starter.Parametro2)) Complete (Result2 As Boolean)
					If( Result2) Then
						ExtraUtility.Play_Sound("error.wav")
						MsgboxAsync("AZZERAMENTO '" & CodAutoclave & "' CONCLUSO CON SUCCESSO!","AZZERAMENTO")
						NuovoProcesso = -1
					Else
						ExtraUtility.Play_Sound("error.wav")
						MsgboxAsync("AZZERAMENTO '" & CodAutoclave & "' ANNULLATO DALL'OPERATORE!","AZZERAMENTO ANNULLATO")
					End If
				Else
					ExtraUtility.Play_Sound("error.wav")
					MsgboxAsync("AZZERAMENTO NON POSSIBILE POICHE' I DATI NON SON O STATI INVIATI AL SERVER!","ERRORE AZZERAMENTO")		
				End If
								
			Case Else
				NuovoProcesso = 0
			
		End Select
	
		Label_txt = Leggi_Menu_Combo_Processi(ComboProcessi, NuovoProcesso)
	
		m.Put("PROCESSO", NuovoProcesso)
		m.Put("CICLO", NuovoCiclo)
		m.Put("TITOLO", Label_txt)
		m.Put("CONFERMATO", False)
		
		If (UltimoProcesso <> NuovoProcesso) And (NuovoProcesso<>-1) Then
			ExtraUtility.Play_Sound("error.wav")

			Dim D As clsDialogGS
			D.Initialize(Activity)

			Wait For (D.ShowYesNo( _
				"Vuoi procedere con" & CRLF & Label_txt.ToUpperCase & "?")) Complete (Result As Int)

			If Result = xui.DialogResponse_Positive Then
				m.Put("CONFERMATO", True)
				Starter.UltimoCiclo = NuovoCiclo
				#if DEBUG
					Log("premuto SI")
				#End If				
			Else
				m.Put("CONFERMATO", False)
				#if DEBUG
					Log("premuto NO")
				#End If				
				Return m
			End If
			
		Else
			m.Put("CONFERMATO", True)
		End If
		Return m
		
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

Private Sub Processo_Chiusura_Autoclave
	Try
		Msgbox2Async("Vuoi concludere il processo dell'autoclave?", "OPERAZIONE FINALE", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Dim DataOra_Fine As String = ExtraUtility.Leggi_DataOraSQLite
			SQLDataAccess.ExecNonQuery2("UPDATE GS_AUTOCLAVE_STORY_H SET DATAORA_FINE = ? WHERE DATAORA_FINE IS NULL AND CODAUTOCLAVE = ? AND IFNULL(TRASMESSO,0)=0",	Array As Object(DataOra_Fine,Starter.Parametro2))
			ToastMessageShow("Operazione conclusa con successo!",False)		
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub GeneraArray(Intervalli As List) As List
	' Ogni elemento della lista deve essere una coppia Array As Int: Array As Int = Array As Int(Da, A)
	Try
		Dim Risultato As List
		Risultato.Initialize
		For Each intervallo() As Int In Intervalli
			Dim Da As Int = intervallo(0)
			Dim A As Int = intervallo(1)
			For i = Da To A
				Risultato.Add(i)
			Next
		Next
		Return Risultato
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

private Sub ListaRicette
	'Sleep(0) 'this is required as the table layout is not immediately created.'
	Try
		Sleep(0)
		B4XTable1.Clear
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.RowHeight = 30dip
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=False
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("Codice", B4XTable1.COLUMN_TYPE_TEXT) ' NOME TABELLA
		Col1_Column.Width = 35%x
		Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) ' NOME TABELLA
		Col2_Column.Width = 65%x
		Dim DataList As List
		DataList.Initialize
		Dim rs1 As ResultSet = SQLDataAccess.ExecQuery("SELECT CODICE,DESCRIZIONE FROM GS_RICETTE")
		Do While rs1.NextRow
			Dim rowx(2) As Object
			rowx(0) = rs1.GetString("CODICE")
			rowx(1) = rs1.GetString("DESCRIZIONE")
			DataList.Add(rowx)
			If DataList.Size Mod 5 = 0 Then Sleep(0)
		Loop
		rs1.Close
		B4XTable1.SelectionColor = xui.Color_Transparent
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.SetData(DataList)
		B4XTable1.MaximumRowsPerPage = 20
		B4XTable1.SearchField.mBase.Height = 60dip
		B4XTable1.SearchField.mBase.Visible = True
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		For i = 1 To Col1_Column.CellsLayouts.Size - 1
			' colonna 1
			Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
			Dim lbl1 As Label = pnl1.GetView(0)
			lbl1.TextSize = 14
			'lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl1.TextColor = Colors.RGB(9,0,104)
			lbl1.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
			' colonna 2
			Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
			Dim lbl2 As Label = pnl2.GetView(0)
			lbl2.TextSize = 14
			'lbl.Typeface = Typeface.DEFAULT_BOLD
			lbl2.TextColor = Colors.RGB(9,0,104)
			lbl2.Padding = Array As Int (5dip, 5dip, 5dip, 5dip)
		Next
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
			Select NewDocument.vTipoTab
				Case 3 ' Tabelle SQLite
					' Nessun Padding
				Case 4 ' Tabelle LIstaDoc
					' Nessun Padding
				Case Else
					lbl.Padding = Array As Int (5dip, 0, 0, 0)
			End Select
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub B4XTable1_DataUpdated
	Try
		Sleep(0)
		Dim RowId As Long
		Dim column As B4XTableColumn
		SetColumnAlignment(B4XTable1,"Codice",Gravity.LEFT)
		SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
		For i = 0 To B4XTable1.VisibleRowIds.Size - 1
			RowId = B4XTable1.VisibleRowIds.Get(i)
			For j = 0 To B4XTable1.Columns.size - 1
				column = B4XTable1.Columns.Get(j)
				ExtraUtility.SetSingleLine(i+1, column,True,"END")
			Next
			SetRowColor(i, SelectedRows.Contains(RowId))
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean)
	Try
		Dim clr As Int
		If Selected Then
			clr = SelectionColor
		Else If RowIndex Mod 2 = 0 Then
			clr = B4XTable1.EvenRowColor
		Else
			clr = B4XTable1.OddRowColor
		End If
		For Each c As B4XTableColumn In B4XTable1.VisibleColumns
			Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
			pnl.Color = clr
		Next
	Catch
		Log(LastException)
	End Try
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Try
		Sleep(0)
		If(MultiSelection=False) Then
			SelectedRows.Clear
			B4XTable1.Refresh
		End If
		' Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Dim Selected As Boolean
		If SelectedRows.Contains(RowId) Then
			SelectedRows.Remove(RowId)
			Selected = False
		Else
			SelectedRows.Add(RowId)
			Selected = True
		End If
		B4XTable1.Refresh
		Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId)
		SetRowColor(Index, Selected)
		'leggo il valore della prima colonna (Codice)
		Dim m As Map = B4XTable1.GetRow(RowId)
		Starter.CodRicetta = m.Get("Codice")
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton1_Click ' FRECCIA CHE AGGIORNA LA RICETTA
	Try
		#if DEBUG
			Log(Starter.CodRicetta)
		#end if
		If(Starter.CodRicetta<>Null And Starter.CodRicetta<>"") Then
			ExtraUtility.Aggiorna_Autoclave_UltProc(SQLDataAccess,Starter.Parametro2,1000,0)
			B4XTable1.mBase.Visible=False
			SwiftButton1.mBase.Visible=False
			MostraGriglia
			Select Case True
				Case Starter.Parametro7<=12
					NumCols = 3
				Case (Starter.Parametro7>12 And Starter.Parametro7<=20)
					NumCols = 4
				Case (Starter.Parametro7>20 And Starter.Parametro7<=36)
					NumCols = 5
				Case (Starter.Parametro7>36 And Starter.Parametro7<=40)
					NumCols = 5
			End Select
			NumRows = Round(Starter.Parametro7/NumCols)+1
			NumCols = Starter.Parametro5
			If(Starter.Parametro2<>"") Then
				CreaGriglia(NumRows, NumCols, Starter.Parametro7, Starter.Parametro2)
			End If
			If  (Starter.CodRicetta<>"") Then
				txt_title.Text = "Ricetta: " & Starter.CodRicetta & " - Inizio Caricamento"
				Starter.UltimoProc = 1000
			Else
				txt_title.Text = Starter.Parametro2 & " - Inizio Caricamento"
				Starter.UltimoProc = 1000
			End If
		Else
			ExtraUtility.Play_Sound("Error.wav")
			ToastMessageShow("SELEZIONARE UNA RICETTA!",True)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_Num_Duplica (CodAutoclave As String, Processo As Int) As Int
	Try
		Dim NumDuplica As Int
		Dim Cursor3 As Cursor
		Cursor3 = SQLDataAccess.ExecQuery2("SELECT MAX(REPLICA) AS MAXREPLICA FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND PROCESSO = ?", Array As String(CodAutoclave,Processo))
		If(Cursor3.RowCount>0) Then
			Cursor3.Position = 0
			NumDuplica = Cursor3.GetInt("MAXREPLICA")
		Else
			NumDuplica = 0
		End If
		Cursor3.Close
		Return NumDuplica
	Catch
		Log(LastException)
		Return 0
	End Try
End Sub

Private Sub SwiftButton2_Click' IROP1
	Try
		Starter.Parametro2=SwiftButton2.xlbl.text.SubString(2)
		SwiftButton2.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
		SwiftButton3.Enabled=False
		SwiftButton4.Enabled=False
		SwiftButton6.Enabled=False
		Starter.Parametro2="IROP1"
		Press_Button_Autoclave(1)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton6_Click ' IROP2
	Try
		Starter.Parametro2=SwiftButton6.xlbl.text.SubString(2)
		SwiftButton6.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
		SwiftButton3.Enabled=False
		SwiftButton4.Enabled=False
		SwiftButton2.Enabled=False
		Starter.Parametro2="IROP2"
		Press_Button_Autoclave(2)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton3_Click ' MAROOSO
	Try
		Starter.Parametro2=SwiftButton3.xlbl.text.SubString(2)
		SwiftButton3.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
		SwiftButton2.Enabled=False
		SwiftButton4.Enabled=False
		SwiftButton6.Enabled=False
		Starter.Parametro2="MAROSO"
		Press_Button_Autoclave(3)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub SwiftButton4_Click ' PANINI
	Try
		Starter.Parametro2=SwiftButton4.xlbl.text.SubString(2)
		SwiftButton4.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
		SwiftButton3.Enabled=False
		SwiftButton2.Enabled=False
		SwiftButton6.Enabled=False
		Starter.Parametro2="PANINI"
		Press_Button_Autoclave(4)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Swift_Buttons_Visible(numautoclave As Int, visible As Boolean)
	Try
			If(visible) Then
			Select numautoclave
				Case 0
					SwiftButton2.Enabled=True
					SwiftButton3.Enabled=True
					SwiftButton4.Enabled=True
					SwiftButton6.Enabled=True
				Case 1 ' IROP1
					SwiftButton2.Enabled=True
					SwiftButton3.Enabled=False
					SwiftButton4.Enabled=False
					SwiftButton6.Enabled=False
					SwiftButton2.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case 2 ' IROP2
					SwiftButton2.Enabled=False
					SwiftButton3.Enabled=False
					SwiftButton4.Enabled=False
					SwiftButton6.Enabled=True
					SwiftButton6.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case 3 ' MAROSO
					SwiftButton2.Enabled=False
					SwiftButton3.Enabled=True
					SwiftButton4.Enabled=False
					SwiftButton6.Enabled=False
					SwiftButton3.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case 4 ' PANINI
					SwiftButton2.Enabled=False
					SwiftButton3.Enabled=False
					SwiftButton4.Enabled=True
					SwiftButton6.Enabled=False
					SwiftButton4.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case -1 ' IROP1
					SwiftButton2.Enabled=True
					SwiftButton2.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case -2 ' IROP1
					SwiftButton6.Enabled=True
					SwiftButton6.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case -3 ' MAROSO
					SwiftButton3.Enabled=True
					SwiftButton3.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case -4 ' PANINI
					SwiftButton4.Enabled=True
					SwiftButton4.SetColors(Colors.ARGB(255, 0, 150, 0),Colors.Green)
				Case -100 ' IROP1
					SwiftButton2.Enabled=True
					SwiftButton2.SetColors(Colors.ARGB(255, 0, 40, 0),Colors.Gray)
				Case -200 ' IROP1
					SwiftButton6.Enabled=True
					SwiftButton6.SetColors(Colors.ARGB(255, 0, 40, 0),Colors.Gray)
				Case -300 ' MAROSO
					SwiftButton3.Enabled=True
					SwiftButton3.SetColors(Colors.ARGB(255, 0, 40, 0),Colors.Gray)
				Case -400 ' PANINI
					SwiftButton4.Enabled=True
					SwiftButton4.SetColors(Colors.ARGB(255, 0, 40, 0),Colors.Gray)
			End Select
		End If
		SwiftButton2.mBase.Visible=visible
		SwiftButton3.mBase.Visible=visible
		SwiftButton4.mBase.Visible=visible
		SwiftButton6.mBase.Visible=visible	
	Catch
		Log(LastException)
	End Try
End Sub

Sub Aggiorna_Evento_Componenti(codautoclave As String, evento As Int, ciclo As Int)
	Dim rs As ResultSet
	Dim x As Int = 0 
	Dim eventox As String
	Dim md5_comp As String
	Dim statox As String
	Dim num_tubo As Int
	Try
		SQLDataAccess.BeginTransaction
		
		rs = SQLDataAccess.ExecQuery2( _
			"SELECT C.DATAORA, C.NUMTUBO, C.MD5_COMP " & _
			"FROM GS_AUTOCLAVE_STORY_D C " & _
			"INNER JOIN ( " & _
			"   SELECT NUMTUBO, MAX(DATAORA) AS MAX_DATAORA " & _
			"   FROM GS_AUTOCLAVE_STORY_D " & _
			"   WHERE CODAUTOCLAVE = ? " & _
			"   GROUP BY NUMTUBO " & _
			") X ON C.NUMTUBO = X.NUMTUBO " & _
			"AND C.DATAORA = X.MAX_DATAORA " & _
			"WHERE C.CODAUTOCLAVE = ? " & _
			"GROUP BY C.DATAORA, C.NUMTUBO, C.MD5_COMP ORDER BY C.NUMTUBO", _
			Array As String(codautoclave, codautoclave))
		
		Dim DataOra As String 

		Do While rs.NextRow

			md5_comp = rs.GetString("MD5_COMP")
			num_tubo = rs.GetInt("NUMTUBO")
		
			Select evento
				Case 3000 ' Inizio Pressata
					Dim arr_eventi() As Int = Array As Int(1000, 2000, 3000)
					Dim arr_cicli() As Int = Array As Int(0,0,ciclo)
					x = 3
					
				Case 7000 ' Inizio Ciclo				
					Dim arr_eventi() As Int = Array As Int(3000, 6000, 7000)
					Dim arr_cicli() As Int = Array As Int(ciclo,ciclo,ciclo)
					x = 3
										
				Case Else				
					Dim arr_eventi() As Int = Array As Int(evento)
					Dim arr_cicli() As Int = Array As Int(ciclo)
					x = 1
				
			End Select

			For i=0 To x-1
				
				eventox = arr_eventi(i)
				ciclo = arr_cicli(i)												
				statox = Leggi_Stato_Tubo(codautoclave, md5_comp, eventox, ciclo, num_tubo)
				
				If(eventox=3000) Or (eventox=7000) Then ' Inizio Pressata o Inizio Ciclo
					statox = "C"
				End If
																					
				If(evento=7000) And (eventox=3000) Then ' Inizio Ciclo e Inizio Pressata
					DataOra = rs.GetString("DATAORA")					
				Else
					DataOra = ExtraUtility.Leggi_DataOraSQLite
				End If
	
				#if DEBUG
					Log("n. tubo " & rs.GetInt("NUMTUBO") & " - MD5 " & rs.GetString("MD5_COMP") & " INSERT " & DataOra & " Evento " & eventox & " Stato " & statox)
				#End If				
				
				
				SQLDataAccess.ExecNonQuery2( _
					"INSERT INTO [GS_AUTOCLAVE_STORY_H] " & _
					"(CODICEDIP1, CODICEDIP2, CODICEDIP3, DATAORA_INIZIO, CODAUTOCLAVE, NTUBO, NOTE, STATO, PROCESSO, REPLICA, MD5_COMP, UUID_CICLO) " & _
					"SELECT ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? " & _
					"WHERE NOT EXISTS ( " & _
					" SELECT 1 FROM [GS_AUTOCLAVE_STORY_H] " & _
					" WHERE CODAUTOCLAVE = ? " & _
					" AND NTUBO = ? " & _
					" AND PROCESSO = ? " & _
					" AND REPLICA = ? " & _
					" AND MD5_COMP = ? " & _
					" AND UUID_CICLO = ? " & _
					")", _
					Array As Object( _
						Starter.CodDip1, _
						Starter.CodDip2, _
						Starter.CodDip3, _
						DataOra, _
						codautoclave, _
						num_tubo, _
						"", _ ' note
						statox, _
						eventox, _
						ciclo, _
						md5_comp, _
						Starter.UUID_Ciclo, _
						codautoclave, _
						num_tubo, _
						eventox, _
						ciclo, _
						md5_comp, _
						Starter.UUID_Ciclo _
					))
			Next
		Loop
		rs.Close
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		If(eventox=3000) Or (eventox=7000) Then
			Sleep(0)
			CreaGriglia(Starter.Parametro6, Starter.Parametro5, Starter.Parametro7, Starter.Parametro2)
		End If
	Catch
		Log(LastException)
		If rs <> Null Then rs.Close
	End Try

End Sub

Sub Leggi_Stato_Tubo(codautoclave As String, md5_comp As String, processo As Int, ciclo As Int, numtubo As Int) As String
	Try
		Dim stato As String
		Select 	processo
			Case 1000 ' Inizio caricamento
				stato = "C"
			Case 2000 ' Fine Caricamento
				stato = "C"
			Case 3000 ' Inizio Pressata
				stato = Leggi_Ultimo_Stato_Tubo(codautoclave,md5_comp,numtubo,5000,ciclo-1) ' cerco su interrompi pressata
				If(stato="") Then
					stato = "C"
				End If
			Case 6000 ' Fine Pressata
				stato = Leggi_Ultimo_Stato_Tubo(codautoclave,md5_comp,numtubo,4000,ciclo)
			Case 7000 ' Inizio Ciclo				
				stato = Leggi_Ultimo_Stato_Tubo(codautoclave,md5_comp,numtubo,8000,ciclo-1)
				If(stato="") Then
					stato = Leggi_Ultimo_Stato_Tubo(codautoclave,md5_comp,numtubo,6000,ciclo)
				End If
			Case Else
				stato = ""		
		End Select
		Return stato
	Catch
		Log(LastException)
		Return ""
	End Try
End Sub

Private Sub Leggi_Ultimo_Stato_Tubo(codautoclave As String, md5_comp As String, numtubo As Int, processo_old As Int, ciclo As Int) As String
	Dim RS As ResultSet
	Try
		RS = SQLDataAccess.ExecQuery2( _
            "SELECT STATO FROM GS_AUTOCLAVE_STORY_H WHERE CODAUTOCLAVE = ? AND MD5_COMP = ? AND NTUBO = ? AND PROCESSO >= ? AND REPLICA = ? ORDER BY DATAORA_INIZIO DESC LIMIT 1", _
			Array As String(codautoclave,md5_comp,numtubo,processo_old,ciclo))
			
		If RS.NextRow Then
			Dim stato As String = RS.GetString("STATO")
			RS.Close
			Return stato
		End If

	Catch
		Log(LastException)
	End Try

	If RS.IsInitialized Then RS.Close
	Return ""
End Sub

Private Sub Leggi_NumTubi(CodAutoclave As String) As Int
	Dim RS As ResultSet
	Try
		RS = SQLDataAccess.ExecQuery2( _
            "SELECT NUMTUBI FROM GS_AUTOCLAVI WHERE CODICE = ?", _
            Array As String(CodAutoclave))

		If RS.NextRow Then
			Dim n As Int = RS.GetInt("NUMTUBI")
			RS.Close
			Return n
		End If

	Catch
		Log(LastException)
	End Try

	If RS.IsInitialized Then RS.Close
	Return 0
End Sub
		
Private Sub Leggi_NumProc(evento As String) As Int
	Try
		Dim numproc As Int
		Select evento
			Case "Registra VALORI"
				numproc=0
			Case "Inizio Caricamento"
				numproc=1000
			Case "Fine Caricamento"
				numproc=2000
			Case "Inizio Pressata"
				numproc=3000
			Case "Controllo Pressata"
				numproc=4000
			Case "Interrompi Pressata"
				numproc=5000
			Case "Fine Pressata"
				numproc=6000
			Case "Inizio Ciclo"
				numproc=7000
			Case "Controllo Ciclo"
				numproc=8000
			Case "Interrompi Ciclo"
				numproc=9000
			Case "Fine Ciclo"
				numproc=9999			
		End Select
		Return numproc
	Catch
		Return 0
		Log(LastException)
	End Try
End Sub	
		
Private Sub Leggi_ArrayProc(numproc As Int) As String()
	Try
		If numproc = 0 Then
            Return arr_proc0

        Else If numproc = 1000 Or numproc = 2000 Then
            Return arr_proc1

        Else If numproc >= 3000 And numproc <= 6000 Then
            Return arr_proc2

        Else If numproc >= 7000 And numproc <= 9999 Then
            Return arr_proc3
        End If

        Return Null

    Catch
		Log(LastException)
        Return Null
    End Try
End Sub

Private Sub Leggi_UltProc(Index As Int, Menu As Int) As Int
	Try
		If(Index=1) And (Menu=1) Then
			Return 1000
		End If
		If(Index=2) And (Menu=1) Then
			Return 2000
		End If
		If(Index=1) And (Menu=2) Then
			Return 3000
		End If
		If(Index=2) And (Menu=2) Then
			Return 4000
		End If
		If(Index=0) And (Menu=2) Then
			Return 5000
		End If
		If(Index=1) And (Menu=3) Then
			Return 6000
		End If
		If(Index=2) And (Menu=3) Then
			Return 7000
		End If
		If(Index=3) And (Menu=3) Then
			Return 8000
		End If
		Return 0
	Catch
		Log(LastException)
		Return Null
	End Try	
End Sub

Private Sub Press_Button_Autoclave(CodiceAutoclave As Int)
	Try
		Choose_Autoclave(CodiceAutoclave)		
		SwiftButton_Eye.mBase.Visible = True
		ComboProcessi.Visible=True
		ComboProcessi.Text="Seleziona evento..."	
		Dim Info As Map = Leggi_Info_Autoclave(Starter.Parametro2)
		If Info.IsInitialized And Info.Get("Trovato") = True Then
			If(Starter.UltimoProc=0)  Then
				Starter.CodDip1 = ""
				Starter.CodDip2 = ""
				Starter.CodDip3 = ""
				txt_title.Text = "Selezionare la ricetta:"
				B4XTable1.mBase.Visible=True
				SwiftButton1.mBase.Visible=True
				ComboProcessi.Visible=False
				ListaRicette		
				txt_title.Text = Leggi_Menu_Combo_Processi(ComboProcessi, 1000)
			Else
				MostraGriglia
			End If			
		Else
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("Autoclave '" & CodiceAutoclave & "' non trovata!","ERRORE AUTOCLAVE")
			Log("Autoclave '" & CodiceAutoclave & "' non trovata")
		End If
		Swift_Buttons_Visible(0,False)		
	Catch
		Log(LastException)
	End Try
End Sub

Sub Annulla_Dati_Autoclave(CodAutoclave As Int)
	' da scrivere
End Sub

Private Sub SwiftButton_Eye_Click
	' Registra_Dati(Starter.Parametro2)
	CaricaTubi
	Try		
		If(False) Then		
			#if DEBUG
				
	'			Dim c As Cursor = SQLDataAccess.ExecQuery("SELECT sqlite_version()")
	'			c.Position = 0
	'			Log(c.GetString2(0))
	'			c.Close
				
				Dim dialog As B4XDialog
				dialog.Initialize(Activity)
					
				Wait For (dialog.Show("Vuoi registrare?", "SI", "", "NO")) Complete (Result As Int)
				If Result <> xui.DialogResponse_Positive Then Return
					
				Registra_Dati(Starter.Parametro2)
				
				If CustomListView1.AsView.Visible Then
					MostraGriglia
					CustomListView1.AsView.Visible = False
					Return
				End If
					
				Dim input As B4XInputTemplate
				input.Initialize
				input.lblTitle.Text = "Inserisci processo,ciclo"
				input.Text = ""
					
				Wait For (dialog.ShowTemplate(input, "OK", "", "Annulla")) Complete (Result2 As Int)
				If Result2 <> xui.DialogResponse_Positive Then Return
					
				Dim testo As String = input.Text.Trim
				If testo = "" Then Return
					
				Dim p() As String = Regex.Split(",", testo)
					
				If p.Length < 2 Then
					MsgboxAsync("Formato non valido. Scrivi ad esempio: 2000,2", "Errore")
					Return
				End If
					
				Dim evento As Int = p(0).Trim
				Dim ciclo As Int = p(1).Trim
					
				Try
					SQLDataAccess.BeginTransaction
					
					SQLDataAccess.ExecNonQuery2( _
							"DELETE FROM GS_AUTOCLAVE_STORY_H " & _
							"WHERE PROCESSO >= ? " & _
							"AND REPLICA = ? " & _
							"AND CODAUTOCLAVE = ?", _
							Array As Object(evento, ciclo, Starter.Parametro2))
					
					SQLDataAccess.ExecNonQuery2( _
							"UPDATE GS_AUTOCLAVI " & _
							"SET ULTIMOPROC = ?, ULTIMOCICLO = ? " & _
							"WHERE CODICE = ?", _
							Array As Object(evento - 1000, ciclo, Starter.Parametro2))
					
					SQLDataAccess.TransactionSuccessful
					
				Catch
					Log(LastException)
				End Try
					
				SQLDataAccess.EndTransaction
					
				MsgboxAsync("Operazione eseguita con successo!", "TEST")
				
			#End If
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub CaricaTubi
	Try
		CustomListView1.Clear
		If CustomListView1.AsView.Visible Then
			MostraGriglia
			ComboProcessi.Visible = True
			CustomListView1.AsView.Visible = False			
			Return
		Else
			NascondiGriglia
			CustomListView1.AsView.Visible = True			
			ComboProcessi.Visible = False
		End If
		Dim Controllo As String
		Dim Colore As Int
		Dim ProcMin As Int = Starter.UltimoProc + 1
		Dim ProcMax As Int = Starter.UltimoProc + 99
		Dim rs As ResultSet = SQLDataAccess.ExecQuery2( _
		"SELECT NTUBO AS NumTubo, " & _
		"COUNT(*) AS NumControlli " & _
		"FROM GS_AUTOCLAVE_STORY_H " & _
		"WHERE CODAUTOCLAVE = ? " & _
		"AND PROCESSO BETWEEN ? AND ? " & _
		"AND REPLICA = ? " & _
		"GROUP BY NTUBO " & _
		"ORDER BY NTUBO", _
		Array As String(Starter.Parametro2,ProcMin,ProcMax,Starter.UltimoCiclo))
		AggiungiRigaTitolo
		Do While rs.NextRow
			If(rs.GetInt("NumControlli")<3) Then
				Colore = Colors.Red
			Else
				Colore = Colors.Blue
			End If
			Controllo = rs.Getint("NumControlli")
			AggiungiRigaTubo(rs.GetString("NumTubo"),Controllo,Colore)
		Loop
		rs.Close
	Catch
		Log(LastException)
	End Try
End Sub

Sub AggiungiRigaTubo(NumTubo As String, NumControlli As Int, Colore As Int)
	Try
		Dim h As Int = 30dip
		Dim w As Int = CustomListView1.AsView.Width

		Dim p As Panel
		p.Initialize("")
		p.SetLayout(0, 0, w, h)

		' Colonna sinistra
		Dim lblTubo As Label
		lblTubo.Initialize("")
		lblTubo.Text = NumTubo
		lblTubo.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.CENTER_HORIZONTAL)
		lblTubo.TextSize = 18
		lblTubo.Color = Colors.ARGB(50,140,140,255)
		lblTubo.TextColor = Colors.DarkGray
		lblTubo.Typeface = Typeface.DEFAULT_BOLD
		p.AddView(lblTubo, 0, 0, 20%x, h)

		' Colonna destra
		Dim lblControlli As Label
		lblControlli.Initialize("")
		lblControlli.Text = NumControlli
		lblControlli.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.CENTER_HORIZONTAL)
		lblControlli.TextSize = 18
		lblControlli.Color = Colors.ARGB(100,140,140,255)
		lblControlli.TextColor = Colore
		p.AddView(lblControlli, 20%x, 0, 50dip, h)
		
		' Colonna 3
		Dim lblstato As Label
		lblstato.Initialize("")
		lblstato.Text = ""
		lblstato.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.CENTER_HORIZONTAL)
		lblstato.TextSize = 18
		lblstato.Color = Colors.ARGB(50,140,140,255)
		lblstato.TextColor = Colore
		p.AddView(lblstato,20%x+52dip,0,54dip,h)
		
		CustomListView1.Add(p, NumTubo)
	Catch
		Log(LastException)
	End Try
End Sub

Sub AggiungiRigaTitolo
	Try
		Dim h As Int = 30dip
		Dim w As Int = CustomListView1.AsView.Width

		Dim p As Panel
		p.Initialize("")
		p.SetLayout(0,0,w,h)
		p.Color = Colors.LightGray

		Dim lbl1 As Label
		lbl1.Initialize("")
		lbl1.Text = "N. Tubo"
		lbl1.Gravity = Gravity.CENTER
		lbl1.Typeface = Typeface.DEFAULT_BOLD
		lbl1.Color = Colors.ARGB(120,140,140,255)
		p.AddView(lbl1,0,0,20%x-2dip,h)

		Dim lbl2 As Label
		lbl2.Initialize("")
		lbl2.Text = "N. Ctr."
		lbl2.Gravity = Gravity.CENTER
		lbl2.Typeface = Typeface.DEFAULT_BOLD
		lbl2.Color = Colors.ARGB(120,140,140,255)
		p.AddView(lbl2,20%x,0,50dip,h)
		
		Dim lbl3 As Label
		lbl3.Initialize("")
		lbl3.Text = "Stato"
		lbl3.Gravity = Gravity.CENTER
		lbl3.Typeface = Typeface.DEFAULT_BOLD
		lbl3.Color = Colors.ARGB(120,140,140,255)
		p.AddView(lbl3,20%x+52dip,0,54dip,h)

		CustomListView1.Add(p,"HEADER")
	
	Catch
		Log(LastException)
	End Try
End Sub

'        Dim arr_proc0() As String = Array As String("-")
'        Dim arr_proc1() As String = Array As String("Cambio Ricetta", "Inizio Caricamento", "Fine Caricamento")
'        Dim arr_proc2() As String = Array As String("Interrompi Pressata", "Inizio Pressata", "Controllo Pressata", "Fine Pressata")
'        Dim arr_proc3() As String = Array As String("Registra VALORI", "Inizio Ciclo", "Controllo Ciclo", "Fine Ciclo", "Interrompi Ciclo")

Sub Leggi_Menu_Combo_Processi(cmb As B4XComboClick,  numprocesso As Int) As String
	Try
		Dim nome_evento As String
		Select numprocesso
			Case 0 ' Inizio Carcamento
				cmb.Clear
				cmb.AddItemStyled(arr_proc1(0), Colors.blue, Colors.rgb(230,230,230), True) 		' Cambio Ricetta
				cmb.AddItemStyled(arr_proc1(1), Colors.black, Colors.White, True)					' Inizio caricamento
				cmb.AddItemStyled(arr_proc1(2), Colors.Black, Colors.White, False)					' Fine Caricamento
				nome_evento = "INIZIO CARICAMENTO"		' Fine Caricamento
			Case 1000 ' Inizio Carcamento
				cmb.Clear
				cmb.AddItemStyled(arr_proc1(0), Colors.blue, Colors.rgb(230,230,230), True) 		' Cambio Ricetta
				cmb.AddItemStyled(arr_proc1(1), Colors.black, Colors.White, True)					' Inizio caricamento
				cmb.AddItemStyled(arr_proc1(2), Colors.Black, Colors.White, False)					' Fine Caricamento
				nome_evento = "INIZIO CARICAMENTO"		' Fine Caricamento
			
			Case 2000 ' Fine Caricamento
				cmb.Clear
				cmb.AddItemStyled(arr_proc2(0), Colors.LightGray, Colors.rgb(230,230,230), True) 	' Interrompi Pressata
				cmb.AddItemStyled(arr_proc2(1), Colors.black, Colors.White, True)					' Inizio Pressata
				cmb.AddItemStyled(arr_proc2(2), Colors.LightGray, Colors.White, False)				' Controllo Pressata
				cmb.AddItemStyled(arr_proc2(3), Colors.LightGray, Colors.White, False)				' Fine Pressata
				nome_evento = "FINE CARICAMENTO"
											
			Case 3000 ' Inizio Pressata
				cmb.Clear
				cmb.AddItemStyled(arr_proc2(0), Colors.LightGray, Colors.rgb(230,230,230), True) 	' Interrompi Pressata
				cmb.AddItemStyled(arr_proc2(1), Colors.LightGray, Colors.White, False)				' Inizio Pressata
				cmb.AddItemStyled(arr_proc2(2), Colors.Black, Colors.White, True)					' Controllo Pressata
				cmb.AddItemStyled(arr_proc2(3), Colors.LightGray, Colors.White, False)				' Fine Pressata
				nome_evento = "INIZIO PRESSATA"
		
			Case 4000 ' Controllo Pressata
				cmb.Clear
				cmb.AddItemStyled(arr_proc2(0), Colors.blue, Colors.rgb(230,230,230), True) 		' Interrompi Pressata
				cmb.AddItemStyled(arr_proc2(1), Colors.LightGray, Colors.White, False)				' Inizio Pressata
				cmb.AddItemStyled(arr_proc2(2), Colors.LightGray, Colors.White, False)				' Controllo Pressata
				cmb.AddItemStyled(arr_proc2(3), Colors.Black, Colors.White, True)
				nome_evento = "CONTROLLO PRESSATA"					' Fine Pressata
			
			Case 5000 ' Interrompi Pressata
				cmb.Clear
				cmb.AddItemStyled(arr_proc2(0), Colors.LightGray, Colors.rgb(230,230,230), True) 	' Interrompi Pressata
				cmb.AddItemStyled(arr_proc2(1), Colors.black, Colors.White, True)					' Inizio Pressata
				cmb.AddItemStyled(arr_proc2(2), Colors.LightGray, Colors.White, True)				' Controllo Pressata
				cmb.AddItemStyled(arr_proc2(3), Colors.LightGray, Colors.White, True)	
				nome_evento = "INTERROMPI PRESSATA"			' Fine Pressata
			
			Case 6000 ' Fine Pressata
				cmb.Clear
				cmb.AddItemStyled(arr_proc3(0), Colors.Blue, Colors.rgb(230,230,230), True) 		' Interrompi Pressata
				cmb.AddItemStyled(arr_proc3(1), Colors.black, Colors.White, True)					' Inizio Ciclo
				cmb.AddItemStyled(arr_proc3(2), Colors.LightGray, Colors.White, True)				' Controllo Ciclo
				cmb.AddItemStyled(arr_proc3(3), Colors.LightGray, Colors.White, True)					' Fine Ciclo
				cmb.AddItemStyled(arr_proc3(4), Colors.LightGray, Colors.White, True)				' Interrompi Ciclo
				nome_evento = "FINE PRESSATA"
							
			Case 7000 ' Inizio Ciclo
				cmb.Clear
				cmb.AddItemStyled(arr_proc3(0), Colors.Blue, Colors.rgb(230,230,230), True) 		' Registra Valori
				cmb.AddItemStyled(arr_proc3(1), Colors.LightGray, Colors.White, False)					' Inizio Ciclo
				cmb.AddItemStyled(arr_proc3(2), Colors.Black, Colors.White, True)				' Controllo Ciclo
				cmb.AddItemStyled(arr_proc3(3), Colors.LightGray, Colors.White, True)				' Fine Ciclo
				cmb.AddItemStyled(arr_proc3(4), Colors.LightGray, Colors.White, True)				' Interrompi Ciclo			
				nome_evento = "INIZIO CICLO"
				
			Case 8000 ' Controllo Ciclo
				cmb.Clear
				cmb.AddItemStyled(arr_proc3(0), Colors.bLUE, Colors.rgb(230,230,230), True) 	' Registra Valori
				cmb.AddItemStyled(arr_proc3(1), Colors.LightGray, Colors.White, True)			' Inizio Ciclo
				cmb.AddItemStyled(arr_proc3(2), Colors.LightGray, Colors.White, True)			' Controlo Ciclo
				cmb.AddItemStyled(arr_proc3(3), Colors.BLACK, Colors.White, True)				' Fine Ciclo
				cmb.AddItemStyled(arr_proc3(4), Colors.BLUE, Colors.White, True)				' Interrompi Ciclo
				nome_evento = "CONTROLLO CICLO"
			
			Case 9000 ' Interrompi Ciclo
				cmb.Clear
				cmb.AddItemStyled(arr_proc3(0), Colors.Blue, Colors.rgb(230,230,230), True) 		' Registra Valori
				cmb.AddItemStyled(arr_proc3(1), Colors.black, Colors.White, True)					' Inizio Ciclo
				cmb.AddItemStyled(arr_proc3(2), Colors.LightGray, Colors.White, True)				' Controllo Ciclo
				cmb.AddItemStyled(arr_proc3(3), Colors.LightGray, Colors.White, True)				' Fine Ciclo
				cmb.AddItemStyled(arr_proc3(4), Colors.LightGray, Colors.White, True)				' Interrompi Ciclo
				nome_evento = "INTERROMPI CICLO"
				
			Case 9999 ' Fine Ciclo
				cmb.Clear
				cmb.AddItemStyled(arr_proc4(0), Colors.Blue, Colors.rgb(230,230,230), True) 	' INVIA DATI SERVER
				cmb.AddItemStyled(arr_proc4(1), Colors.LightGray, Colors.White, False)			' -
				cmb.AddItemStyled(arr_proc4(2), Colors.Black, Colors.White, True)				' AZZERA DATI AUTOCLAVE
				nome_evento = "FINE CICLO"
				
		End Select
		Return nome_evento
	Catch
		Log(LastException)
		Return("")
	End Try
End Sub

Sub Registra_Dati(CodAutoclave As String) As ResumableSub
	Try
		ExtraUtility.Play_Sound("error.wav")
		
		Wait For (Msgbox2Async( _
			"Assicurati di essere in WIFI?", _
			"REGISTRA DATI SU SERVER", _
			"OK", _
			"NO", _
			"", _
			Null, _
			False)) MsgBox_Result (Result As Int)
		
		If Result <> DialogResponse.POSITIVE Then
			ExtraUtility.Play_Sound("error.wav")
			MsgboxAsync("OPERAZIONE ANNULLATA DALL'OPERATORE!", "ATTENZIONE!!!")
			Return False
		End If
		
		Wait For (RegistraSulServer_Autoclavi(CodAutoclave)) Complete (Esito As Boolean)
		If(Esito) Then
			ExtraUtility.Aggiorna_Autoclave_FineCiclo(SQLDataAccess, CodAutoclave)
		End If		
		Return Esito
		
	Catch
		Log(LastException)
		MsgboxAsync("ERRORE DI REGISTRAZIONE!" & CRLF & LastException.Message, "ATTENZIONE!!!")
		Return False
	End Try
End Sub

Sub RegistraSulServer_Autoclavi(CodAutoclave As String)As ResumableSub
	' --------------------------------------------------
	' SCRITTURA TABELLE DAL SERVER TESTE E RIGHE
	' --------------------------------------------------
	Try
		Dim straction As String
		Dim dbAction As Map
		Log("Exec_Scrivi_DB(" & straction & " gs_teste_righe_autoclave.php e gs_insert_autoclave_d.php)")
		straction = "insert_autoclave_d"
		dbAction = CreateMap("action=": straction)
		Wait For (Execute_Scrivi_DB_Autoclave_D(Me, dbAction, straction, "gs_teste_righe_autoclave.php","")) Complete (Result2 As Boolean)
		If( Result2) Then
			straction = "insert_autoclave_h"
			dbAction = CreateMap("action=": straction)
			Wait For (Execute_Scrivi_DB_Autoclave_H(Me, dbAction, straction, "gs_teste_righe_autoclave.php",""))  Complete (Result3 As Boolean)
			If (Result3) Then
				straction = "insert_autoclave_event"
				dbAction = CreateMap("action=": straction)
				Wait For (Execute_Scrivi_DB_Autoclave_Event(Me, dbAction, straction, "gs_teste_righe_autoclave.php",""))  Complete (Result4 As Boolean)
				If (Result4) Then
					#if DEBUG
						MsgboxAsync("Operazione terminata con successo!","Sincronizzazione " & Main.MessageBoxText)
					#End If					
					Return True
				Else
					#IF DEBUG
						MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)					
					#End If						
					Return False
				End If
			Else
				#IF DEBUG
					MsgboxAsync("Operazione errata, problema di sincronizzazione!","Sincronizzazione " & Main.MessageBoxText)
				#End If
				Return False
			End If			
		Else
			Return False
		End If
	Catch
		Log("ERRORE!: " & LastException)
		Return Null
	End Try
End Sub

Sub Execute_Scrivi_DB_Autoclave_Event(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
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
			sqlstr = "SELECT ID,POS,PRESS,TEMP,CODDIP,CODAUTOCLAVE,DATAORA,'" & Main.Utente & "' AS PALMARE,UUID_CICLO FROM GS_AUTOCLAVE_EVENT"
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_REAL,DBUtils.DB_INTEGER,DBUtils.DB_TEXT, _
				DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim RootEmpty As String = "{" & Chr(34) & "root" & Chr(34) &":[]}"
			If (json = RootEmpty) Then
				ExtraUtility.Play_Sound("error.wav")
				' MsgboxAsync("Nessun Documento da inviare!","Sincronizzazione " & Main.MessageBoxText)
				Return True
			Else
				Dim mAction As String = JobName
				Log($"Current time is $time{DateTime.Now}"$ & $"GS_AUTOCLAVE_STORY_EVENT inizio"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now}"$ & $"GS_AUTOCLAVE_STORY_EVENT fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)					
					MsgboxAsync("Errore " & "GS_AUTOCLAVE_STORY_EVENT " & job.errorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore " & Main.PrefixSQL & "_AUTO " & LastException.Message,"Errore")
		Log("GS_AUTOCLAVE_STORY_EVENT " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Execute_Scrivi_DB_Autoclave_D(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
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
			sqlstr = "SELECT id,POS,CODART,DESCART,CODAUTOCLAVE,MD5_COMP,DATAORA,NUMTUBO,'" & Main.Utente & "' as PALMARE,UUID_CICLO FROM GS_AUTOCLAVE_STORY_D"
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As Object (DBUtils.DB_INTEGER,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT, _
				DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT))
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
				Log($"Current time is $time{DateTime.Now}"$ & $"GS_AUTOCLAVE_STORY_D inizio"$) 'Current time is 11:17:45
				Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
				job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & "&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
				wait for(job) JobDone(job As HttpJob)
				If job.Success Then
					Log("response: " & job.GetString)
					Log($"Current time is $time{DateTime.Now}"$ & $"GS_AUTOCLAVE_STORY_D fine"$) 'Current time is 11:17:45
					Return True
				Else
					Log("Error: " & job.ErrorMessage)
					Log($"Current time is $time{DateTime.Now}"$ & Main.PrefixSQL & $"_RIGHEDOCUMENTI fine"$) 'Current time is 11:17:45
					MsgboxAsync("Errore " & "GS_AUTOCLAVE_STORY_D " & job.errorMessage,"Errore")
					Return False
				End If
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		MsgboxAsync("Errore " & Main.PrefixSQL & "_AUTO " & LastException.Message,"Errore")
		Log("GS_AUTOCLAVE_STORY_D " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub


Sub Execute_Scrivi_DB_Autoclave_H(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String) As ResumableSub
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
			sqlstr = "SELECT ID,CODICEDIP1,CODICEDIP2,CODICEDIP3,CODAUTOCLAVE,NTUBO,'" & Main.Utente &"' as PALMARE,NOTE,PROCESSO,STATO,MD5_COMP,DATAORA_INIZIO,REPLICA,UUID_CICLO FROM GS_AUTOCLAVE_STORY_H"
			m = DBUtils.ExecuteJSON(SQLDataAccess, sqlstr,Null,0,Array As String(DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT _
				,DBUtils.DB_INTEGER,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_TEXT,DBUtils.DB_INTEGER,DBUtils.DB_TEXT))
			json = DBPhp.Map2Json(m)
			json = json.Replace("+","%2B") ' sostituisco '+' con %2B (2BHex = '+') problema quando il webservice scrive su SQL Server
			json = json.Replace("&","%26") ' sostituisco '&' con %26 (26Hex = '&') problema quando il webservice scrive su SQL Server
			Dim mAction As String = JobName
			Log($"Current time is $time{DateTime.Now} GS_AUTOCLAVE_STORY_H"$) 'Current time is 11:17:45
			Log(Path_Php & phpFile & ",action="&mAction&"&json_data="&json)
			job.Poststring(Path_Php & phpFile, "servername=" & Main.Istanza_ServerSQL & "&dbname=" & Main.DBName_ServerSQL & "&username=" & Main.User_ServerSQL & _
				"&password=" & Main.Pwd_ServerSQL & "&action=" & mAction & "&json_data=" & json)
			wait for(job) JobDone(job As HttpJob)
			If job.Success Then
				Log("response: " & job.GetString)
				Log($"Current time is $time{DateTime.Now} GS_AUTOCLAVE_STORY_H"$) 'Current time is 11:17:45
				Return True
			Else
				Log("Error: " & job.ErrorMessage)
				Log($"Current time is $time{DateTime.Now} GS_AUTOCLAVE_STORY_H"$) 'Current time is 11:17:45
				MsgboxAsync("Errore GS_AUTOCLAVE_STORY_H " & job.ErrorMessage,"Errore")
				Return False
			End If
		Else
			MsgboxAsync("Dispositivo non autorizzato per il collegamento al server contattare " & Main.MessageNomeDitta & "!","CONTROLLO DISPOSITIVO")
			Return False
		End If
	Catch
		' MsgboxAsync("Errore IS_TESTEDOCUMENTI " & LastException.Message,"Errore")
		Log("GS_AUTOCLAVE_STORY_H " & LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Azzera_Autoclave(CodAutoclave As String) As ResumableSub
	Try
		Dim sql As String
		Dim D As clsDialogGS
		D.Initialize(Activity)
		Dim Descrizione As String
		ExtraUtility.Play_Sound("error.wav")
		Descrizione = "AZZERAMENTO AUTOCLAVE '" & CodAutoclave & "'"
		Wait For (D.ShowYesNo("Vuoi procedere con" & CRLF & Descrizione & "?")) Complete (Result As Int)
		If Result = DialogResponse.POSITIVE Then
			Dim Tables() As String = Array As String("GS_AUTOCLAVE_STORY_H", "GS_AUTOCLAVE_STORY_D","GS_AUTOCLAVE_EVENT","GS_AUTOCLAVI")			
			For Each table In Tables
				If (DB_SQLite.CheckIfTableExist(SQLDataAccess,table)=True) Then
					Select table
						Case "GS_AUTOCLAVI"
							Starter.CodDip1 = ""
							Starter.CodDip2 = ""
							Starter.CodDip3 = ""
							Starter.UltimoCiclo = 0
							Starter.CodRicetta = ""
							Starter.NumTubo = 0
							Starter.MD5_Comp = ""
							Starter.UUID_Ciclo = ""
							sql = "UPDATE GS_AUTOCLAVI SET ULTIMOPROC = NULL, CODRICETTA = NULL, CODDIP1 = NULL, CODDIP2 = NULL, CODDIP3 = NULL, DATAORA_AGG = NULL, ULTIMOCICLO = NULL, UUID_CICLO = NULL, DATA_TRASMESSO = NULL"
							#if debug
								Log ("UPDATE " & table)
							#End If
							SQLDataAccess.ExecNonQuery(sql)
						Case Else
							sql = "DELETE FROM " & table
							#if debug
								Log ("DELETE FROM " & table)
							#end if
							SQLDataAccess.ExecNonQuery(sql)
					End Select
				Else
					#if DEBUG
						Log ("TABELLA " & table & " NON TROVATA")
					#End If					
				End If
			Next
			ComboProcessi.Text = ""
			Return True
		Else
			ComboProcessi.Text = ""
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try

End Sub