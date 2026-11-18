B4A=true
Group=Default Group\Kuore
ModulesStructureVersion=1
Type=Activity
Version=10.7
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private XUI As XUI
	Public SQLDataAccess As SQL
	Public vTipoTab As Int
	Public vCodice As String
	Public vDescrizione As String
	Public vTipoDoc As String
	Public vDataDoc As String
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Public rp As RuntimePermissions
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private RowID_Riga As Long
	Private IDriga As Int
	Private TabStrip1 As TabStrip
	Private ComboBoxTipoDoc As B4XComboBox
	Private btnDate As SwiftButton
	Private Base As B4XView
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private EditText1 As EditText
	Private SwiftButton1 As SwiftButton
	Private EditText2 As EditText	
	Private B4XImageView1 As B4XImageView
	Private B4XImageView2 As B4XImageView
	Private B4XTable1 As B4XTable
	Private B4XTable2 As B4XTable
	Private List_TipoDoc As List
	Private List_TipoDoc_Desc As List
	Private List_TipoDoc_TipoCliFor As List
	Private vBarcodeLetto As String
	Private sqlstr As String
	Private CodArt As String
	Private DesArt As String
	Private Partita As String
	Private SelectedRows As B4XSet
	Private SelectedRows2 As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private Col1_Column As B4XTableColumn
	Private Col2_Column As B4XTableColumn
	Private Col3_Column As B4XTableColumn
	Private Col4_Column As B4XTableColumn
	Private Col5_Column As B4XTableColumn
	Private Col1V_Column As B4XTableColumn
	Private Col2V_Column As B4XTableColumn
	Private Col3V_Column As B4XTableColumn
	Private Col4V_Column As B4XTableColumn
	Private Col5V_Column As B4XTableColumn
	Private xlbl As B4XView
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Phone As IME	
	Private Label1 As Label
	Private Label2 As Label
	Private Label4 As Label
	Private NumDoc As Int
	Private CodCliFor As String
	Private EsercizioDoc As Int
	Private DataDoc As String
	Private DataDocStr As String
	Private Label3 As Label
	Private Label5 As Label
	Private Label10 As Label
	Private Panel1 As Panel
	Private Panel2 As Panel
	Private Panel3 As Panel
	Private Label31 As Label
	Private Label41 As Label
	Private Label51 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Sleep(0)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Phone.Initialize("")
	vCodice = ""
	vDescrizione = ""
	vTipoDoc = ""
	Activity.LoadLayout("testedoc_kuore_spunta")
	'----------------------------------
	' Leggi_ParametriDoc
	'----------------------------------
	TabStrip1.LoadLayout("page1_kuore_spunta", "Testata")
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	'----------------------------------
	' Leggi parametridoc
	'----------------------------------
	Leggi_ParametriDoc("")
	TabStrip1.LoadLayout("page2_kuore_spunta", "Dettaglio")	
	Panel3.Initialize("")
	Panel3.Color = Colors.RGB(128, 128, 128)
	Dim offset As Int = -3
	Dim numicons As Int = 5
	Dim icon_width As Int = 75dip
	Button1.Initialize("Button1") ' Apri
	Panel3.AddView(Button1, offset, 0, icon_width, 60dip)
	Button2.Initialize("Button2") ' nuovo
	Panel3.AddView(Button2, offset+(100%x / numicons), 0, icon_width, 60dip)
	Button3.Initialize("Button3")
	Panel3.AddView(Button3, offset+(100%x / numicons) * 2, 0, icon_width, 60dip)
	Button4.Initialize("Button4")
	Panel3.AddView(Button4, offset+(100%x / numicons) * 3, 0, icon_width, 60dip)
	Button5.Initialize("Button5")
	Panel3.AddView(Button5, offset+(100%x / numicons) * 4, 0, icon_width, 60dip)
	'Button6.Initialize("Button6")
	'Panel1.AddView(Button6, offset+(100%x / numicons) * 5, 0, icon_width, 60dip)
	Activity.AddView(Panel3, 0, 100%y - 60dip, 100%x, 70dip)
	CreateLabel(Button1, Chr(0xF0CB), "Modifica")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Elimina")
	CreateLabel(Button4, Chr(0xF0D0), "Cerca")
	CreateLabel(Button5, Chr(0xF0C7), "Salva")
	'--------------------------------
	TabStrip1.LoadLayout("page3_kuore_spunta", "Verifica Carnet")
	Dim b As Boolean = False
	For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
		btn.visible = b
	Next
	Base = Activity
	Dialog.Initialize (Base)
	Label1.Text = ListaDoc.vTipoDoc & " n. " & ListaDoc.vNumerodoc & " del " & ListaDoc.vDataDoc
	Label10.Text = ListaDoc.vTipoDoc & " n. " & ListaDoc.vNumerodoc & " del " & ListaDoc.vDataDoc 
	If (ListaDoc.vTrasmesso = 1) Then
		Label1.Color=Colors.Red
	Else
		Label1.Color=Colors.Cyan
	end  if
	ListaRigheDoc
	ListaRigheDocVerifica
	vBarcodeLetto = ""
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
	End If
	EditText2.InputType = EditText2.INPUT_TYPE_TEXT
	DateTime.DateFormat = "dd-MM-yyyy"
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	'Button5.TextColor=Colors.Red
	Button5.Enabled=False
	EditText1.InputType=EditText1.INPUT_TYPE_NUMBERS
End Sub

Private Sub Leggi_ParametriDoc(TipoCF As String)
	Try
		Dim ListDoc As List
		ListDoc.Initialize
		List_TipoDoc.Initialize
		List_TipoDoc_Desc.Initialize
		List_TipoDoc_TipoCliFor.Initialize
		ComboBoxTipoDoc.cmbBox.Clear
		ListDoc = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT CODICE, DESCRIZIONE, TIPO, CLIFOR FROM IS_PARAMETRIDOC",Null,0)
		ComboBoxTipoDoc.cmbBox.Add("")
		List_TipoDoc.Add("")
		List_TipoDoc_Desc.Add("")
		List_TipoDoc_TipoCliFor.Add("")
		For Each arr_TipoDoc() As String In ListDoc
			ComboBoxTipoDoc.cmbBox.Add(arr_TipoDoc(0) & " - " & arr_TipoDoc(1))
			List_TipoDoc.Add(arr_TipoDoc(1))
			List_TipoDoc_Desc.Add( arr_TipoDoc(2))
			List_TipoDoc_TipoCliFor.Add(arr_TipoDoc(3))
		Next
		ComboBoxTipoDoc.SelectedIndex=0
	Catch
		Log(LastException)
	End Try
End Sub

Sub Activity_Resume
	Try
		If(vCodice<>"") Then
			Select NewDocument.vTipoTab
				Case 1
				'	Label10.Text = vCodice
				'	Label11.Text = vDescrizione
				
				Case 2
				'	Label7.Text = vCodice
				'	Label8.Text = vDescrizione	
				
				Case 3
					'	Label7.Text = vCodice
					'	Label8.Text = vDescrizione
					
				Case 4
					If(EditText1.IsInitialized=False) Then
						EditText1.Initialize("")
					End If
					EditText1.Text = NumberFormat(vCodice,0,0)
					Dim DataDoc_long As Long = DateTime.DateParse(vDescrizione)
					If(btnDate.IsInitialized=False) Then
						btnDate.Initialize(Me,"")
					End If
					btnDate.xLBL.text =  ExtraUtility.DateToFormat(DataDoc_long,"dd-MM-yyyy","it","")
					Dim vDataDocStr As String = btnDate.xLBL.Text
					vDataDoc = vDataDocStr				
					Dim idx As Int = ExtraUtility.LeggiIndexComboBox(ComboBoxTipoDoc,vTipoDoc)
					If (idx>0) Then
						ComboBoxTipoDoc.SelectedIndex = idx		
					End If				
					
				Case Else
				'	Label10.Text = vCodice
				'	Label11.Text = vDescrizione
				
			End Select
		Else		
			vCodice = ""
			vDescrizione = ""
		End If
			
	Catch
		Log(LastException)
	End Try
End Sub



Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub btnDate_Click
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
	If Result = XUI.DialogResponse_Positive Then
		btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
		
		Dim vDataDocStr As String = btnDate.xLBL.Text
		vDataDoc = DateTime.DateParse(vDataDocStr)
		
		' Dim DataDoc As Long
		' vDataDocNew = btnDate.xLBL.Text
		' DataDoc = DateTime.DateParse(vDataDocNew)
	End If
End Sub

Sub SwiftButton1_Click
	NewDocument.vTipoTab = 4
	StartActivity(ListaTab)	
End Sub

Private Sub TabStrip1_PageSelected (Position As Int)
	Try
		Dim b As Boolean 
		Select Position
		Case 0
			' Testata
			b = False
			For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
				btn.visible = b
			Next
			Panel3.Visible=True
			
		Case 1			
			' Dettaglio		
			Panel3.Visible=True
			b = True
			For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
				btn.visible = b
			Next			
			Dim TipoDoc As String = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)		
			Dim Pos As Int = TipoDoc.IndexOf("-")
			If(TipoDoc.Length>0) Then
				vTipoDoc = TipoDoc.SubString2(0,Pos-1).trim			
			Else
				vTipoDoc = ""
			End If			
			Dim vDataDocStr As String = btnDate.xLBL.Text
			vDataDoc = DateTime.DateParse(vDataDocStr)
			EsercizioDoc = ExtraUtility.DateToFormat(vDataDoc,"yyyy","it","")			
			Dim NumDocStr As String = ""
			NumDocStr = EditText1.Text
			If(NumDocStr<>"") Then
				NumDoc = NumDocStr
			Else
				NumDoc = 0
			End If
			DataDoc = 	vDataDocStr
			CodCliFor = ""
			Label1.Text = "Doc. "  & vTipoDoc & " n. " & NumDoc & " del " & DataDoc
			EditText1.RequestFocus
			If (vTipoDoc="") Or (EditText1.Text="")  Then
				TabStrip1.ScrollTo(0,True)
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Inserimento errato controllare tipo documento e numero","ERRORE")
			End If
			B4XTable1.Refresh
			
		Case 2
			' Verifica Carnet
			Panel3.Visible=False
			b = False
			For Each btn As Button In Array(Button1, Button2, Button3, Button4, Button5)
				btn.visible = b
			Next					
			'B4XTable2.top=Label15.bottom
			'B4XTable2.Height=Panel2.Bottom-Label5.Bottom-25dip
			Dim vDataDocStr As String = btnDate.xLBL.Text
			DataDoc = DateTime.DateParse(vDataDocStr)
			EsercizioDoc = ExtraUtility.DateToFormat(DataDoc,"yyyy","it","")
			vDataDoc = vDataDocStr
			Dim TipoDoc As String = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)
			Dim Pos As Int = TipoDoc.IndexOf("-")
			If(TipoDoc.Length>0) Then
				vTipoDoc = TipoDoc.SubString2(0,Pos-1).trim
			Else
				vTipoDoc = ""
			End If
			Label10.Text = "Doc. "  & vTipoDoc & " n. " & EditText1.Text & " del " & vDataDoc
			EditText1.RequestFocus
			If (vTipoDoc="") Or (EditText1.Text="")  Then
				TabStrip1.ScrollTo(0,True)
				ExtraUtility.Play_Sound("error.wav")
				MsgboxAsync("Inserimento errato controllare tipo documento e numero","ERRORE")
			Else		
				Dim NumeroDoc As Long = EditText1.Text
				Dim rs2 As ResultSet = SQLDataAccess.ExecQuery("SELECT IDRIGA,CODART,PARTITA,DESCRIZIONE,QTAGEST FROM IS_RIGHEDOCPARTITE WHERE NUMERODOC = '" _
				& NumeroDoc & "' AND DATADOC = '" & vDataDoc & "' AND TipoDoc = '" & vTipoDoc & "' ORDER BY IDRIGA")				
				' Dim DataList2 As List
				B4XTable2.MaximumRowsPerPage = 10
				B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
				' DataList2.Initialize
				
				Dim NumberTotalRead As Int = B4XTable1.SQL1.ExecQuerySingleResult("SELECT count(*) FROM data")
				Dim NumberOfMatches As Int
				Dim NR As Int = 0
				Dim Partita As String
							
				Dim DataList3 As List
				DataList3.Initialize		
				If(rs2.RowCount>0) Then
					Do While rs2.NextRow						
						If(NR<=NumberTotalRead) Then
							Partita = rs2.Getstring("PARTITA")
							NumberOfMatches = B4XTable1.SQL1.ExecQuerySingleResult2("SELECT count(*) FROM data WHERE c2 = ?", Array As String(Partita))
						Else
							NumberOfMatches = 0
						End If						
						If(NumberOfMatches=0) Then
							Dim row2(5) As Object
							row2(0) = rs2.Getint("IDRIGA")
							row2(1) = rs2.Getstring("CODART")
							row2(2) = rs2.Getstring("PARTITA")
							row2(3) = rs2.GetString("DESCRIZIONE")
							row2(4) = rs2.GetString("QTAGEST")
							Log(row2(0) & " -" & row2(1))
							DataList3.Add(row2)
						Else
							NR = NR + 1
						End If
					Loop
					rs2.Close
					B4XTable2.MaximumRowsPerPage = 15
					B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
					B4XTable2.SetData(DataList3)
					B4XTable2.UpdateTableCounters
					B4XTable2.Refresh
				End If
			End If
			
		End Select
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub EditText2_EnterPressed	
	vBarcodeLetto = EditText2.Text.Trim.ToUpperCase
	Leggi_Info_Articolo(vBarcodeLetto,"INSERT")
	'------------------------------------------------------------------------------------
	Phone.HideKeyboard
	EditText2.RequestFocus
End Sub

Sub Leggi_Info_Articolo2(Barcode As String, Operazione As String)
	Try
		Dim sqlstr1 As String = "SELECT CODART,DESCRIZIONE,VERDIBA,PESOORO,CARATI,VERDIBA,PARTITA from IS_ANAGRAFICAARTICOLI WHERE PARTITA = '" & Barcode & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr1)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				CodArt = rs.GetString("CODART")
				DesArt = rs.GetString("DESCRIZIONE")
				Partita = rs.GetString("PARTITA")
			Loop
			Label5.Text = "V.D. " & rs.GetString("VERDIBA") & Chr(13) & Chr(10) & rs.GetString("PARTITA") & Chr(13) & Chr(10) & "Peso " & rs.Getstring("PESOORO") & Chr(13) & Chr(10) & "Ct " & rs.Getstring("CARATI")
			Dim FileName As String = CodArt & ".jpg"
			Dim DirExt1 As String = Main.PathImages
			Dim DirExt2 As String = ""
			Dim fn As String = ExtraUtility.GetFolderFileName(DirExt1,"/")
			DirExt2 = DirExt1.Replace(fn & "/","")
			If(DirExt1=DirExt2) Then
				DirExt2 = DirExt1.Replace(fn,"")
			End If
			If File.Exists(DirExt2,fn) = False  Then
				MsgboxAsync("Percorso immagini non trovato!" & CRLF & DirExt1,"ATTENZIONE")
			Else
				If File.Exists(DirExt1,FileName)  Then
					B4XImageView2.Load(DirExt1,FileName)
				Else
					FileName = "NOIMAGE.jpg"
					If File.Exists(DirExt1, FileName)  Then
						ExtraUtility.Play_Sound("Sound1.wav")
						B4XImageView2.Load(DirExt1,FileName)
					Else
						MsgboxAsync("Immagine 'NOIMAGE.jpg' non trovata!" & CRLF & DirExt1,"ATTENZIONE")
					End If
				End If
				Label3.Text = CodArt
				Label4.Text = DesArt
			End If
		End If
		rs.close
	Catch
		Log(LastException)
	End Try
End Sub

Sub Leggi_Info_Articolo(Barcode As String, Operazione As String)	
	Try	
		Dim sqlstr1 As String = "SELECT CODART,DESCRIZIONE,VERDIBA,PESOORO,CARATI,VERDIBA,PARTITA from IS_ANAGRAFICAARTICOLI WHERE PARTITA = '" & Barcode & "'"
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr1)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				CodArt = rs.GetString("CODART")
				DesArt = rs.GetString("DESCRIZIONE")
				Partita = rs.GetString("PARTITA")
			Loop
			Label51.Text = "V.D. " & rs.GetString("VERDIBA") & Chr(13) & Chr(10) & rs.GetString("PARTITA") & Chr(13) & Chr(10) & "Peso " & rs.Getstring("PESOORO") & Chr(13) & Chr(10) & "Ct " & rs.Getstring("CARATI")
			Dim FileName As String = CodArt & ".jpg"
			'Dim DirExt1 As String = File.DirRootExternal & "/Pocket_ISA/Immagini_Kuore3"  ' Directory EDA51 simone	/storage/emulated/0/Pocket_ISA/Immagini_Kuore3/
			'Dim DirExt1 As String = File.DirRootExternal & "/Pocket_ISA"  ' Directory EDA51 simone	/storage/emulated/0/Pocket_ISA/Immagini_Kuore3/
			'Dim DirExt2 As String = File.DirRootExternal & "/Pocket_ISA/Immagini_Kuore3/"  ' Directory EDA51 simone	/storage/emulated/0/Pocket_ISA/Immagini_Kuore3/
			'Dim DirExt1 As String = rp.GetSafeDirDefaultExternal("foto_kuore")  ' /storage/emulated/0/Android/data/biz.greensoft.PocketIsa/files/foto_kuore			
			Dim DirExt1 As String = Main.PathImages
			Dim DirExt2 As String = ""
			Dim fn As String = ExtraUtility.GetFolderFileName(DirExt1,"/")			
			DirExt2 = DirExt1.Replace(fn & "/","")
			If(DirExt1=DirExt2) Then
				DirExt2 = DirExt1.Replace(fn,"")
			End If					
			If File.Exists(DirExt2,fn) = False  Then
				MsgboxAsync("Percorso immagini non trovato!" & CRLF & DirExt1,"ATTENZIONE")
			Else			
				If File.Exists(DirExt1,FileName)  Then
					B4XImageView1.Load(DirExt1,FileName)
				Else					
					FileName = "NOIMAGE.jpg"
					If File.Exists(DirExt1, FileName)  Then
						ExtraUtility.Play_Sound("Sound1.wav")
						B4XImageView1.Load(DirExt1,FileName)
					Else
						MsgboxAsync("Immagine 'NOIMAGE.jpg' non trovata!" & CRLF & DirExt1,"ATTENZIONE")
					End If
				End If
				Label31.Text = CodArt
				Label41.Text = DesArt
			End If
			If(Operazione="INSERT") And (CodArt<>"") Then
				If(vBarcodeLetto.Length>0) Then
					Dim DataDocum As Long
					Dim vDataDocStr As String = btnDate.xLBL.Text
					DataDocum = DateTime.DateParse(vDataDocStr)
					Dim EsercizioDoc As Int = ExtraUtility.DateToFormat(DataDocum,"yyyy","it","")
					Dim Qta As Double = 1
					InserisciRigaDettaglio(Partita,CodArt,DesArt,Qta,0,vTipoDoc,NumDoc,EsercizioDoc,"NewDoc",False)
				End If
			End If
		Else
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("CODICE ERRATO!",False)
		End If
		rs.close
		EditText2.Text=""
	Catch
		Log(LastException)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		lbl.Padding= Array As Int (0, 0, 10, 0)
	Next
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"n.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"C. Art.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Partita",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.CENTER_HORIZONTAL)
	' SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
	Next
	For i = 1 To Col5_Column.CellsLayouts.Size - 1
		' Colonna 1 n
		Dim pnl1 As B4XView = Col1_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 12
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 2 Partita
		Dim pnl2 As B4XView = Col2_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 12
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 3 Cod. Art
		Dim pnl3 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 12
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 4 Descrizione
		Dim pnl4 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 12
		lbl4.Typeface = Typeface.DEFAULT
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 5 Quantita
		Dim pnl5 As B4XView = Col5_Column.CellsLayouts.Get(i)
		Dim lbl5 As Label = pnl5.GetView(0)
		lbl5.TextSize = 12
		lbl5.Typeface = Typeface.DEFAULT
		lbl5.TextColor = Colors.RGB(9,0,104)
		lbl5.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
	Next
End Sub

Sub SetRowColor2(RowIndex As Int, Selected As Boolean)
	Dim clr As Int
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
End Sub

Sub SetRowColor(RowIndex As Int, Selected As Boolean)
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
End Sub

Sub InserisciRigaDettaglio(PartitaArt As String, CodArticolo As String, Descr As String, Qta As Double, Listino As Double, TipoDoc As String, NumeroDoc As Int, AnnoDoc As Int,Operazione As String,AcceptDuplicate As Boolean)	
	Dim Pos As Int = B4XTable1.Size+1
	Dim nrecs As Int=0
	Dim nrecs_ver As Int=0
	If(AcceptDuplicate=False) Then
		nrecs = B4XTable1.sql1.ExecQuerySingleResult2($"select count(*) FROM data WHERE c2=?"$,Array As String(PartitaArt))
	End If
	nrecs_ver = B4XTable2.sql1.ExecQuerySingleResult2($"select count(*) FROM data WHERE c2=?"$,Array As String(PartitaArt))
	If(((nrecs=0) And (nrecs_ver>0)) Or ((nrecs>0) And (AcceptDuplicate)))  Then
		B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?)"$ , Array As Object(Pos,CodArticolo,PartitaArt,Descr,Qta))
		B4XTable1.ClearDataView	
		B4XTable1.Refresh
		B4XTable1.UpdateTableCounters
		Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
		column1.InternalSortMode="DESC"
		B4XTable1.SearchField.mBase.Visible=False
	Else
		If(nrecs_ver=0) And (nrecs=0) Then
			ExtraUtility.Play_Sound("error.wav")
			ToastMessageShow("CODICE ERRATO!",False)
		Else
			If(nrecs>0) Then
				ExtraUtility.Play_Sound("Sound3.wav")
				ToastMessageShow("CODICE GIA' PRESENTE!",False)
			End If
		End If
	End If
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
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
	Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId)
	SetRowColor(Index, Selected)
	Dim Col1Value As String = B4XTable1.GetRow(RowId).GetValueAt(0)    ' N.
	Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' C. Art
	Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' Partita
	Dim Col4Value As String = B4XTable1.GetRow(RowId).GetValueAt(3)    ' Descrizione
	Dim Col5Value As Double = B4XTable1.GetRow(RowId).GetValueAt(4)    ' Qta
	Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
	RowID_Riga = RowId
	IDriga = Col1Value
	CodArt = Col2Value
	Leggi_Info_Articolo(Col3Value,"READ")
	B4XTable1.SearchField.mBase.Visible=False
End Sub

Sub ListaRigheDocVerifica
	Sleep(0) 'this is required as the table layout is not immediately created.'
	'B4XTable2.SearchField.mBase.Visible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update
	B4XTable2.MaximumRowsPerPage = 10
	B4XTable2.RowHeight = 30dip
	B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
	SelectedRows2 = B4XCollections.CreateSet

	Dim Col1V_Column As B4XTableColumn =  B4XTable2.AddColumn("n.", B4XTable2.COLUMN_TYPE_NUMBERS)	 		' n.
	Col1V_Column.Width = 40dip

	Dim Col2V_Column As B4XTableColumn =  B4XTable2.AddColumn("C. Art.", B4XTable2.COLUMN_TYPE_TEXT) 		' B. Code
	Col2V_Column.Width = 60dip

	Dim Col3V_Column As B4XTableColumn =  B4XTable2.AddColumn("Partita", B4XTable2.COLUMN_TYPE_TEXT)	 		' C. Art.
	Col3V_Column.Width = 60dip

	Dim Col4V_Column As B4XTableColumn =  B4XTable2.AddColumn("Descrizione", B4XTable2.COLUMN_TYPE_TEXT) 	' Descrizione
	Col4V_Column.Width = 160dip

	Dim Col5V_Column As B4XTableColumn =  B4XTable2.AddColumn("Qta", B4XTable2.COLUMN_TYPE_NUMBERS)				' Qta
	Col5V_Column.Width=35dip ' NUMBERS
	
	Dim DataList2 As List
	DataList2.Initialize
	B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
	B4XTable2.SetData(DataList2)
	B4XTable2.UpdateTableCounters
End Sub

Sub ListaRigheDoc
	Sleep(0) 'this is required as the table layout is not immediately created.'
	'B4XTable1.SearchField.mBase.Visible=False
	'B4XTable1.SearchField.HintText = "Cerca"
	'B4XTable1.SearchField.HintColor = Colors.Green
	'B4XTable1.SearchField.Update	
	B4XTable1.MaximumRowsPerPage = 10
	B4XTable1.RowHeight = 30dip
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	SelectedRows = B4XCollections.CreateSet

	Dim Col1_Column As B4XTableColumn =  B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS)	 		' n.
	Col1_Column.Width = 40dip

	Dim Col2_Column As B4XTableColumn =  B4XTable1.AddColumn("C. Art.", B4XTable1.COLUMN_TYPE_TEXT) 		' B. Code
	Col2_Column.Width = 75dip

	Dim Col3_Column As B4XTableColumn =  B4XTable1.AddColumn("Partita", B4XTable1.COLUMN_TYPE_TEXT)	 		' C. Art.
	Col3_Column.Width = 75dip

	Dim Col4_Column As B4XTableColumn =  B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) 	' Descrizione
	Col4_Column.Width = 130dip

	Dim Col5_Column As B4XTableColumn =  B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_NUMBERS)			' Qta
	Col5_Column.Width=35dip ' NUMBERS

	Dim DataList As List
	DataList.Initialize
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	B4XTable1.SetData(DataList)
	B4XTable1.UpdateTableCounters
	
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Dim cs As CSBuilder
	cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(30).Append(Text1).Pop.Append(CRLF).Size(10).Append(Text2).Alignment("ALIGN_CENTER").PopAll
	xlbl = Label
	xlbl.Text = cs
	xlbl.TextColor = XUI.Color_RGB(105, 105, 105)
	Return xlbl.Snapshot
End Sub

Sub Button3_Click ' Delete Record
	If SelectedRows.Contains(RowID_Riga) Then
		Dim sf As Object = XUI.Msgbox2Async("Elimino la riga?", "CANCELLAZIONE RIGA", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = XUI.DialogResponse_Positive Then
			Wait For (DeleteRow(B4XTable1, RowID_Riga)) Complete (Success As Boolean)			
		End If
		B4XTable1.SearchField.mBase.Visible=False
	Else
		Dim sf As Object = XUI.Msgbox2Async("Selezionare la riga da eliminare","ATTENZIONE","OK","","",Null)
	End If
End Sub

Sub Button4_Click
	' Cerca
	If(B4XTable1.SearchField.mBase.Visible=True) Then
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=False
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
	Else
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=True
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.SearchField.RequestFocusAndShowKeyboard
	End If
End Sub

Sub Button5_Click
	' Salva il documento
	Button5.TextColor=ExtraUtility.Color_DarkGreen
	Sleep(10)
	Msgbox2Async("Vuoi registrare il documento?", "Pocket ISA", "SI", "NO", "", Null, False)
	Wait For MsgBox_Result (ResultDial As Int)
	If ResultDial = DialogResponse.POSITIVE Then
		RegistraDocumento(vTipoDoc, NumDoc, EsercizioDoc, vDataDoc, CodCliFor)
		Activity.Finish
	Else
		Button5.TextColor=Colors.Red
	End If
End Sub

Sub RegistraDocumento(TipoDoc As String, NumeroDoc As Int, AnnoDoc As  Int, DataDocum As String, CodiceCliFor As String)
	Try
		Dim rowdata As Map
		Dim  sqlstr As String
		' Ripristina tutte le righe
		B4XTable1.CreateDataView($"c0 >0"$)
		B4XTable1.Refresh
		If(ListaDoc.vTipoOperazione<>"NewDoc") Then
			DataDocStr = ExtraUtility.DateToFormat(DateTime.Now,  "dd/MM/yyyy","it","")
			sqlstr  = "DELETE FROM IS_TESTEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumeroDoc & "' AND Esercizio='" & AnnoDoc & "' AND CodCliFor='" & CodCliFor & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
			sqlstr  = "DELETE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc='" & TipoDoc & "' AND Numerodoc='" & NumeroDoc & "' AND Esercizio='" & AnnoDoc & "' AND CodCliFor='" & CodCliFor & "'"
			SQLDataAccess.ExecNonQuery(sqlstr)
		End If
		sqlstr  = "INSERT INTO IS_TESTEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,UtenteModifica,CodCliFor,DataDoc) VALUES "
		sqlstr = sqlstr & "('" & TipoDoc & "','" & NumeroDoc & "','" & AnnoDoc & "','" & Main.Utente & "','" & CodCliFor  & "','" & DataDocum & "')"
		SQLDataAccess.ExecNonQuery(sqlstr)
		For i=0 To B4XTable1.Size
			rowdata = B4XTable1.GetRow(i)
			If rowdata.Size>0 Then
				' RowData.GetValueAt(1)
				Dim Status As String = rowdata.Get("Status")
				RowID_Riga =  rowdata.Get("n.") ' rowdata.GetValueAt(0)
				sqlstr  = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,UM,DataConsegna," _
				 & "Descrizione,rifidtesta,TipoRiga,DataScadenza,NrRifPartita,UM2,Qta2,Peso,NumEtichette,Status,Sconto,Note,Ordinato,UM3," _
				 & "QtaTotUMAConv,QtaTotUM2,CoeffConvUMA) VALUES " _
				 & "('" & TipoDoc & "','" & NumeroDoc & "','" & AnnoDoc & "','" & RowID_Riga & "','" & Main.Utente & "','" & rowdata.Get("Cod. Art.") & "','" _
				 & rowdata.get("Qta") & "','" & rowdata.Get("RifIdriga") & "','" & rowdata.Get("Descrizione Art.")  & "')"
				'SQLDataAccess.ExecNonQuery(sqlstr)
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub


Sub Button1_Click
	Try
		' Modifica
		Private input As B4XInputTemplate
		input.Initialize
		input.RegexPattern = "\d+"
		input.lblTitle.Text = "Quantità:"
		input.Text = ""
		input.ConfigureForNumbers(True, False) 'AllowDecimals, AllowNegative	
		Sleep(0)
		Wait For (Dialog.ShowTemplate(input, "NO", "", "OK")) Complete (Result As Int)
		If(input.Text.Length>0) Then
			Dim res As String = input.Text 'no need to check with IsNumber
			If  (res="0.5") Or (res="1") Or (res="1.0") Then		
				If (res="1") Then
					res = "1.0"
				End If
				B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET c4 = ? WHERE rowid = ?"$, Array As String(res, RowID_Riga))	' data è la tabella  a video		
				B4XTable1.Refresh
			Else
				MsgboxAsync("Inserimento quantità errato " & res & ", accetta solo valori 1 o 0.5!","ERRORE INSERIMENTO")
			End If
		End If
		B4XTable1.SearchField.mBase.Visible=False
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button2_Click
	' Nuovo
	B4XTable1.SearchField.Text = ""
	B4XTable1.SearchField.mBase.Enabled=False
	EditText2.RequestFocus	
	Phone.HideKeyboard	
End Sub

Private Sub EditText2_FocusChanged (HasFocus As Boolean)
	If (HasFocus) Then
		Phone.HideKeyboard
		Sleep(0)
		B4XTable1.SearchField.Text=""
		B4XTable1.SearchField.mBase.Visible=False		
	End If
End Sub

Private Sub HandleBackKey
	Try
		Msgbox2Async("Vuoi annullare le modifiche al documento?", "Pocket ISA", "SI", "NO", "", Null, False)
		Wait For MsgBox_Result (Result As Int)
		If Result = DialogResponse.positive Then			
			Activity.Finish
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long )As ResumableSub
	Try 
		Sleep(0) 'this is required as the table layout is not immediately created.'
		'Dim RowData As Map = tbl.GetRow(RowId)
		Dim sql As String = ""
		SQLDataAccess.BeginTransaction
		sql = "DELETE FROM " & Main.PrefixSQL & "_RIGHEDOCUMENTI WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc _
		& "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga = " & IDriga 
		Log(sql)
		SQLDataAccess.ExecNonQuery(sql)
		sql = "UPDATE " & Main.PrefixSQL & "_RIGHEDOCUMENTI SET Idriga = Idriga-1 WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" _
		& ListaDoc.vTipoDoc & "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga > 1 And Idriga > " & IDriga
		Log(sql)
		SQLDataAccess.ExecNonQuery(sql)
		SQLDataAccess.TransactionSuccessful
		SQLDataAccess.EndTransaction
		tbl.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array (RowId))	 			' deletes record from Table
		tbl.sql1.ExecNonQuery2("UPDATE data SET c0=c0-1 WHERE RowId >= ?", Array (RowId))	 	' update record from Table
		Dim page As Int = tbl.CurrentPage
		Dim FirstIndex As Int = tbl.FirstRowIndex	
		tbl.ClearDataView 'Updates the rows count.
		tbl.UpdateTableCounters
		If FirstIndex + 1 >= tbl.mCurrentCount Then
			page = page - 1
		End If
		tbl.CurrentPage = page
		' tbl.ClearDataView
		tbl.Refresh
		Return True
	Catch
		Return False
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

Private Sub ComboBoxTipoDoc_SelectedIndexChanged (Index As Int)
	Dim TipoDoc As String = ComboBoxTipoDoc.cmbBox.GetItem(ComboBoxTipoDoc.cmbBox.SelectedIndex)
	Dim Pos As Int = TipoDoc.IndexOf("-")
	If(TipoDoc.Length>0) Then
		vTipoDoc = TipoDoc.SubString2(0,Pos-1).trim
	Else
		vTipoDoc = ""
	End If
	DataDocStr = btnDate.xLBL.Text
	Dim DataDocum As Int = DateTime.DateParse(DataDocStr)
End Sub

Private Sub B4XTable2_DataUpdated
	SetColumnAlignment(B4XTable2,"n.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable2,"Partita",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable2,"C. Art.",Gravity.CENTER_HORIZONTAL)
	SetColumnAlignment(B4XTable2,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable2,"Qta",Gravity.CENTER_HORIZONTAL)
	' SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	For i = 0 To B4XTable2.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable2.VisibleRowIds.Get(i)
		SetRowColor2(i, SelectedRows2.Contains(RowId))
	Next
	For i = 1 To Col5_Column.CellsLayouts.Size - 1
		' Colonna 1 n
		Dim pnl1 As B4XView = Col1V_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 12
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 2 Partita
		Dim pnl2 As B4XView = Col2V_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 12
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 3 Cod. Art
		Dim pnl3 As B4XView = Col3V_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 12
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
		' Colonna 4 Descrizione
		Dim pnl4 As B4XView = Col4V_Column.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 12
		lbl4.Typeface = Typeface.DEFAULT
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 5 Qta
		Dim pnl5 As B4XView = Col5V_Column.CellsLayouts.Get(i)
		Dim lbl5 As Label = pnl5.GetView(0)
		lbl5.TextSize = 12
		lbl5.Typeface = Typeface.DEFAULT
		lbl5.TextColor = Colors.RGB(9,0,104)
		lbl5.Padding = Array As Int (0dip, 0dip, 0dip, 0dip)
	Next
End Sub

Private Sub B4XTable2_CellClicked (ColumnId As String, RowId As Long)
	If(MultiSelection=False) Then
		SelectedRows2.Clear
		B4XTable2.Refresh
	End If
	' Log($"Number of rows selected: ${SelectedRows.Size}"$)
	Dim Selected As Boolean
	If SelectedRows2.Contains(RowId) Then
		SelectedRows2.Remove(RowId)
		Selected = False
	Else
		SelectedRows2.Add(RowId)
		Selected = True
	End If
	Dim Index As Int = B4XTable2.VisibleRowIds.IndexOf(RowId)
	SetRowColor2(Index, Selected)
	Dim Col1Value As String = B4XTable2.GetRow(RowId).GetValueAt(0)    ' N.
	Dim Col2Value As String = B4XTable2.GetRow(RowId).GetValueAt(1)    ' Articolo
	Dim Col3Value As String = B4XTable2.GetRow(RowId).GetValueAt(2)    ' Partita
	Dim Col4Value As String = B4XTable2.GetRow(RowId).GetValueAt(3)    ' Descrizione
	Dim Col5Value As Double = B4XTable2.GetRow(RowId).GetValueAt(4)    ' Qta
	Log($"Number of rows selected: ${SelectedRows2.Size}"$)
	Log($"Row selected: ${RowId}"$)
	Log($"Value of row selected: ${Col1Value}"$)
	RowID_Riga = RowId
	IDriga = Col1Value
	CodArt = Col3Value
	Leggi_Info_Articolo2(Col3Value,"READ")
	B4XTable2.SearchField.mBase.Visible=False
End Sub