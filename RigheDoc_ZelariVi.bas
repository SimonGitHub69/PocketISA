B4A=true
Group=Default Group\ZelariVi
ModulesStructureVersion=1
Type=Activity
Version=9.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private SQLDataAccess As SQL
	Private SelectedRows As B4XSet	
	Private SelectedRows_T2 As B4XSet
	Private SelectedRows_T3 As B4XSet
	Private SelectionColor As Int = 0xFF009DFF
	Private MultiSelection As Boolean = False ' serve per gestire multiselezione
	Public vCodice As String
	Public vDescrizione As String
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.	
	Private Dialog As B4XDialog
	Private DateTemplate As B4XDateTemplate
	Private Base As B4XView
	Private B4XTable1 As B4XTable
	Private B4XTable2 As B4XTable
	Private B4XTable3 As B4XTable
	Private xui As XUI
	Dim xlbl As B4XView
	Dim sqlstr As String
	Private Button1 As Button
	Private Button2 As Button	
	Private Button3 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private Button7 As Button
	Private Panel2 As Panel
	Dim IDriga As Int
	Dim CodArt As String = ""
	Dim Descrizione As String
	Dim Qta As Double
	Private RowID_Riga As Long
	Dim Operazione As String 
	Private xui As XUI
	Private Panel1 As Panel
	Private Label1 As Label
	Private Label9 As Label
	Private EditText2 As EditText
	Private EditText1 As EditText
	Private EditText3 As EditText
	Private EditText5 As EditText
	Private Label10 As Label
	Private btnDate As SwiftButton
	Private SwiftButton1 As SwiftButton
	Private SwiftButton2 As SwiftButton
	Private DataList As List
	Private DataList2 As List
	Private DataList3 As List
	Private B4XFloatTextField1 As B4XFloatTextField
	Private B4XFloatTextField2 As B4XFloatTextField
	Private Label7 As Label
	Private Phone As IME
	Public vTipoDocNew As String
	Public vNumDocNew As Int
	Public vEsercizioNew As Int
	Public vDataDocNew As String
	Public vOperazione As String
	Public vRagSoc As String
	Public vNumListino As Int
	Public vBarcodeLetto As String
	Private EditText4 As EditText	
	Private Col3_Column As B4XTableColumn
	Private Col4_Column As B4XTableColumn
	Private Col5_Column As B4XTableColumn
	Private Col6_Column As B4XTableColumn	
	Private Col1_Column_T2 As B4XTableColumn
	Private Col2_Column_T2 As B4XTableColumn
	Private Col3_Column_T2 As B4XTableColumn
	Private Col4_Column_T2 As B4XTableColumn
	Private Col1_Column_T3 As B4XTableColumn
	Private Col2_Column_T3 As B4XTableColumn
	Private Col3_Column_T3 As B4XTableColumn
	Private Col4_Column_T3 As B4XTableColumn
	Private Label11 As Label
	Private Label8 As Label
	Private formatter As B4XFormatter
	Private Label12 As Label
	Private Label13 As Label
	Private Panel4 As Panel	
	Private Panel5 As Panel
	Private Label14 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:	
	' DateTime.DateFormat = "dd-MM-yyyy"
	If FirstTime Then
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("RigheDoc_ZelariVi")	
	Sleep(0)
	CifreRigaLeggibili
	ExtraUtility.formato_europeo_2dec(formatter)
	Panel2.Visible=False
	' Bottoni a filo basso (niente gap grigio sotto), come ListaDoc
	Dim btnBarH As Int = 60dip
	Dim footerTop As Int = 100%y - btnBarH
	Dim offset As Int = 2dip
	Dim numicons As Int = 6
	Dim icon_width As Int = Min(62dip, (100%x / numicons) - 2dip)
	Panel1.Initialize("")
	Panel1.Color = Colors.RGB(128, 128, 128)
	Button1.Initialize("Button1") ' Modifica
	Panel1.AddView(Button1, offset, 0, icon_width, btnBarH)
	Button2.Initialize("Button2") ' Nuovo
	Panel1.AddView(Button2, offset+(100%x / numicons), 0, icon_width, btnBarH)
	Button3.Initialize("Button3")
	Panel1.AddView(Button3, offset+(100%x / numicons) * 2, 0, icon_width, btnBarH)
	Button4.Initialize("Button4")
	Panel1.AddView(Button4, offset+(100%x / numicons) * 3, 0, icon_width, btnBarH)
	Button5.Initialize("Button5")
	Panel1.AddView(Button5, offset+(100%x / numicons) * 4, 0, icon_width, btnBarH)
	Button6.Initialize("Button6")
	Panel1.AddView(Button6, offset+(100%x / numicons) * 5, 0, icon_width, btnBarH)
	Activity.AddView(Panel1, 0, footerTop, 100%x, btnBarH)
	Panel1.BringToFront
	CreateLabel(Button1, Chr(0xF0CB), "Modifica")
	CreateLabel(Button2, Chr(0xF016), "Nuovo")
	CreateLabel(Button3, Chr(0xF1F8), "Elimina")
	CreateLabel(Button4, Chr(0xF0D0), "Vista")
	CreateLabel(Button5, Chr(0xF059), "Storico")
	CreateLabel(Button6, Chr(0xF153), "Fattur.")
	Button6.Enabled = False
	' Tabella / totale sopra la barra bottoni
	If Label11.IsInitialized Then
		Label11.Top = Min(Label11.Top, footerTop - Label11.Height - 4dip)
	End If
	If Label12.IsInitialized Then
		Label12.Top = Min(Label12.Top, footerTop - Label12.Height - 4dip)
	End If
	If B4XTable1.IsInitialized And B4XTable1.mBase.IsInitialized Then
		Dim tableBottom As Int = footerTop - 34dip
		B4XTable1.mBase.Height = Max(160dip, tableBottom - B4XTable1.mBase.Top)
	End If
	'--------------------------------
	Base = Activity
	Dialog.Initialize (Base)
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2099
	btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)	
	Label1.Text = ListaDoc.vTipoDoc & " n. " & ListaDoc.vNumerodoc & " del " & ListaDoc.vDataDoc & CRLF & ListaDoc.vRagSoc
	If (ListaDoc.vTrasmesso = 1) Then
		Label1.Color=Colors.Red
	Else
		Label1.Color=Colors.Cyan
	end  if
	If(NewDocument.vOperazione="NewDoc") Then									
		Label1.text = NewDocument.vTipoDocNew & " n. " & NewDocument.vNumDocNew &  " del " & NewDocument.vDataDocNew & Chr(10) & Chr(13) & NewDocument.vRagSoc
		vNumListino = NewDocument.vNumListinoNew
	Else
		vNumListino = DB_SQLite.Leggi_NRListinoTesteDoc(SQLDataAccess,ListaDoc.vTipoDoc,ListaDoc.vNumerodoc,ListaDoc.vEsercizio)
	End If	
	ListaRigheDoc
	Label13.Text = vNumListino
	If (ListaDoc.vTrasmesso=1) Then
		Button2.Enabled = False
		Button3.Enabled = False
		Button4.Enabled = False
		Button5.enabled = False
	End If
	ListaVistaDocArt(ListaDoc.vCodCliFor,CodArt)
	ListaVistaDocAll(ListaDoc.vCodCliFor)
	Panel4.Visible = False
	Panel5.Visible = False
	ExtraUtility.formato_europeo_2dec(formatter)
End Sub

Sub Activity_Resume
	Sleep(0)
	If(Ricerca_AZ.vCodice<>"") Then
		EditText4.Text=Ricerca_AZ.vCodice
		Label9.Text=Ricerca_AZ.vDescrizione
		Dim PrezzoMin As Double = 0
		Dim PrezzoCorr As Double = 0
		PrezzoMin = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,Main.NRListinoMin,EditText4.Text)
		PrezzoCorr = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
		Label7.Text = PrezzoMin
		EditText1.Text = PrezzoCorr
		EditText2.RequestFocus
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

' 100 e 22.5 escono dal bordo della cella: la riga cresce con la cifra, il resto della maschera scende.
Private Sub CifreRigaLeggibili
	PreparaCifra(EditText2)
	PreparaCifra(EditText1)
	PreparaCifra(EditText3)
	PreparaCifra(EditText5)
	' Il prezzo in riga resta a destra, non centrato come nel layout
	EditText1.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
	Dim extra As Int = ExtraCifra(EditText2)
	If extra > 0 Then
		AllargaRigaCifre(extra)
	End If
	AdattaCifra(EditText2)
	AdattaCifra(EditText1)
	AdattaCifra(EditText3)
	AdattaCifra(EditText5)
End Sub

Private Sub PreparaCifra(edt As EditText)
	Try
		Dim jo As JavaObject = edt
		jo.RunMethod("setIncludeFontPadding", Array(False))
		edt.Padding = Array As Int(2dip, 0, 2dip, 0)
		Dim grav As Int = edt.Gravity
		Dim horiz As Int = Bit.And(grav, Bit.Or(Gravity.LEFT, Bit.Or(Gravity.RIGHT, Gravity.CENTER_HORIZONTAL)))
		If horiz = 0 Then horiz = Gravity.CENTER_HORIZONTAL
		edt.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, horiz)
		edt.SingleLine = True
	Catch
		Log("PreparaCifra: " & LastException)
	End Try
End Sub

' Pixel che mancano perche' la cifra stia tutta nella cella, con un filo di aria.
Private Sub ExtraCifra(edt As EditText) As Int
	Try
		Dim jo As JavaObject = edt
		Dim px As Float = jo.RunMethod("getTextSize", Null)
		Dim need As Int = px + 10dip
		Dim extra As Int = need - edt.Height
		If extra < 1dip Then Return 0
		If extra > 16dip Then extra = 16dip
		Return extra
	Catch
		Log("ExtraCifra: " & LastException)
		Return 8dip
	End Try
End Sub

Private Sub AllargaRigaCifre(extra As Int)
	Dim rowTop As Int = EditText2.Top
	Dim oldBottom As Int = EditText2.Top + EditText2.Height
	EditText1.Height = EditText1.Height + extra
	EditText2.Height = EditText2.Height + extra
	EditText3.Height = EditText3.Height + extra
	EditText5.Height = EditText5.Height + extra
	If Abs(btnDate.mBase.Top - rowTop) <= 8dip Then
		btnDate.mBase.Height = btnDate.mBase.Height + extra
	End If
	If B4XFloatTextField1.mBase.Top >= oldBottom - 3dip Then
		B4XFloatTextField1.mBase.Top = B4XFloatTextField1.mBase.Top + extra
	End If
	If B4XFloatTextField2.mBase.Top >= oldBottom - 3dip Then
		B4XFloatTextField2.mBase.Top = B4XFloatTextField2.mBase.Top + extra
	End If
	If SwiftButton1.mBase.Top >= oldBottom - 3dip Then
		SwiftButton1.mBase.Top = SwiftButton1.mBase.Top + extra
	End If
	If SwiftButton2.mBase.Top >= oldBottom - 3dip Then
		SwiftButton2.mBase.Top = SwiftButton2.mBase.Top + extra
	End If
	If Button7.Top >= oldBottom - 3dip Then
		Button7.Top = Button7.Top + extra
	End If
	If Panel2.Height < EditText2.Top + EditText2.Height + 8dip Then
		Panel2.Height = EditText2.Top + EditText2.Height + 8dip
	End If
End Sub

' Se dopo l'allargamento la cifra ancora non entra, il carattere scende solo del necessario.
Private Sub AdattaCifra(edt As EditText)
	Try
		Dim jo As JavaObject = edt
		Dim px As Float = jo.RunMethod("getTextSize", Null)
		If edt.Height <= 8dip Then Return
		If px + 4dip <= edt.Height Then Return
		Dim scale As Float = ScalaCarattere
		Dim newSp As Float = (edt.Height - 6dip) / (1dip * scale)
		If newSp < 11 Then newSp = 11
		edt.TextSize = newSp
		edt.Padding = Array As Int(2dip, 0, 2dip, 0)
	Catch
		Log("AdattaCifra: " & LastException)
	End Try
End Sub

Private Sub ScalaCarattere As Float
	Try
		Dim ctx As JavaObject
		ctx.InitializeContext
		Dim cfg As JavaObject = ctx.RunMethodJO("getResources", Null).RunMethod("getConfiguration", Null)
		Dim scale As Float = cfg.GetField("fontScale")
		If scale < 1 Then scale = 1
		Return scale
	Catch
		Return 1
	End Try
End Sub

Sub B4XTable1_DataUpdated
	SetColumnAlignment(B4XTable1,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable1,"Qta",Gravity.RIGHT)
	SetColumnAlignment(B4XTable1,"Prezzo",Gravity.RIGHT)
	For i = 0 To B4XTable1.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows.Contains(RowId))
	'	For j = 0 To B4XTable1.Columns.size - 1
	'		Dim column As B4XTableColumn = B4XTable1.Columns.Get(j)
	'       ExtraUtility.SetSingleLine( i + 1 , column,True,"END")			
	'	Next
	Next
	For i = 1 To Col3_Column.CellsLayouts.Size - 1
		' Colonna 3
		Dim pnl1 As B4XView = Col3_Column.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 11
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)
		lbl1.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)
		' Colonna 4
		Dim pnl2 As B4XView = Col4_Column.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 13
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
		' Colonna 5
		Dim pnl3 As B4XView = Col5_Column.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 13
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
		lbl3.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
		Dim bxPrezzo As B4XView = pnl3.GetView(0)
		bxPrezzo.SetTextAlignment("CENTER", "RIGHT")
	Next
End Sub

Sub B4XTable2_DataUpdated
	SetColumnAlignment(B4XTable2,"Data",Gravity.CENTER)
	SetColumnAlignment(B4XTable2,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable2,"Qta",Gravity.RIGHT)
	SetColumnAlignment(B4XTable2,"P. Netto",Gravity.RIGHT)
	For i = 0 To B4XTable2.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable2.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows_T2.Contains(RowId))
	Next
	For i = 1 To Col3_Column_T2.CellsLayouts.Size - 1
		' Colonna 1
		Dim pnl1 As B4XView = Col1_Column_T2.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 12
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)		
		lbl1.Padding = Array As Int (5dip, 0dip, 0dip, 0dip)				
		' Colonna 2
		Dim pnl2 As B4XView = Col2_Column_T2.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 13
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (5dip, 0dip, 5dip, 0dip)
		' Colonna 3
		Dim pnl3 As B4XView = Col3_Column_T2.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 13
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (5dip, 0dip, 5dip, 0dip)
		' Colonna 4
		Dim pnl4 As B4XView = Col4_Column_T2.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 14
		lbl4.Typeface = Typeface.DEFAULT
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
	Next
End Sub

Sub B4XTable3_DataUpdated
	SetColumnAlignment(B4XTable3,"Data",Gravity.CENTER)
	SetColumnAlignment(B4XTable3,"Descrizione",Gravity.LEFT)
	SetColumnAlignment(B4XTable3,"Qta",Gravity.RIGHT)
	SetColumnAlignment(B4XTable3,"P. Netto",Gravity.RIGHT)
	For i = 0 To B4XTable3.VisibleRowIds.Size-1
		Dim RowId As Long = B4XTable3.VisibleRowIds.Get(i)
		SetRowColor(i, SelectedRows_T3.Contains(RowId))
	Next
	For i = 1 To Col4_Column_T3.CellsLayouts.Size - 1
		' Colonna 1
		Dim pnl1 As B4XView = Col1_Column_T3.CellsLayouts.Get(i)
		Dim lbl1 As Label = pnl1.GetView(0)
		lbl1.TextSize = 11
		lbl1.Typeface = Typeface.DEFAULT
		lbl1.TextColor = Colors.RGB(9,0,104)		
		lbl1.Padding = Array As Int (2dip, 0dip, 0dip, 0dip)				
		' Colonna 2
		Dim pnl2 As B4XView = Col2_Column_T3.CellsLayouts.Get(i)
		Dim lbl2 As Label = pnl2.GetView(0)
		lbl2.TextSize = 12
		lbl2.Typeface = Typeface.DEFAULT
		lbl2.TextColor = Colors.RGB(9,0,104)
		lbl2.Padding = Array As Int (5dip, 0dip, 5dip, 0dip)
		' Colonna 3
		Dim pnl3 As B4XView = Col3_Column_T3.CellsLayouts.Get(i)
		Dim lbl3 As Label = pnl3.GetView(0)
		lbl3.TextSize = 14
		lbl3.Typeface = Typeface.DEFAULT
		lbl3.TextColor = Colors.RGB(9,0,104)
		lbl3.Padding = Array As Int (5dip, 0dip, 5dip, 0dip)
		' Colonna 4
		Dim pnl4 As B4XView = Col4_Column_T3.CellsLayouts.Get(i)
		Dim lbl4 As Label = pnl4.GetView(0)
		lbl4.TextSize = 14
		lbl4.Typeface = Typeface.DEFAULT
		lbl4.TextColor = Colors.RGB(9,0,104)
		lbl4.Padding = Array As Int (0dip, 0dip, 5dip, 0dip)
	Next
End Sub

Sub CreateLabel(Label As Label, Text1 As String, Text2 As String) As B4XBitmap
	Try
		Dim cs As CSBuilder
		' Icona un po' piu' piccola cosi' icona+testo stanno nella barra senza taglio
		cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(26).Append(Text1).Pop.Append(CRLF).Size(9).Append(Text2).Alignment("ALIGN_CENTER").PopAll
		xlbl = Label
		xlbl.Text = cs
		xlbl.TextColor = xui.Color_RGB(105, 105, 105)
		xlbl.SetTextAlignment("CENTER", "CENTER")
		Dim lbl As Label = Label
		lbl.Gravity = Gravity.CENTER
		lbl.Padding = Array As Int(0, 0, 0, 4dip)
		Return xlbl.Snapshot
	Catch
		Log(LastException.Message)
		Return Null
	End Try
End Sub

Private Sub  ListaVistaDocArt(CodCliFor As String, CodArticolo As String)
	Try
		' Tabella 2
		Sleep(0)
		B4XTable2.SearchField.HintText = "Cerca"
		B4XTable2.SearchField.HintColor = Colors.Green
		B4XTable2.SearchField.Update
		B4XTable2.MaximumRowsPerPage = 5
		B4XTable2.RowHeight = 36dip
		B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
		SelectedRows_T2 = B4XCollections.CreateSet
		Col1_Column_T2 = B4XTable2.AddColumn("Data", B4XTable2.COLUMN_TYPE_DATE) 		' Data Doc.
		Col1_Column_T2.Width = 140
		Col2_Column_T2 = B4XTable2.AddColumn("Descrizione", B4XTable2.COLUMN_TYPE_TEXT) 	' Descrizione
		Col2_Column_T2.Width = 300
		Col3_Column_T2 = B4XTable2.AddColumn("Qta", B4XTable2.COLUMN_TYPE_NUMBERS) 	    ' Quantita
		Col3_Column_T2.Width = 100
		Col4_Column_T2 = B4XTable2.AddColumn("P. Netto", B4XTable2.COLUMN_TYPE_NUMBERS) 	' Prezzo netto
		Col4_Column_T2.Width = 140	
		'ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
		'ExtraUtility.CreateCustomFormat2dec(Col5_Column,B4XTable1)
		DataList2.Initialize
		' CHHU#071000000000000000000000000000000000000	
		sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _
		& " WHERE CodCliFor = '" & CodCliFor & "' AND CODART='" & CodArticolo & "'" _
		& " GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"
		Log(sqlstr)
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rs.NextRow
			Dim rowx(4) As Object
			rowx(0) = rs.GetString("DATADOC")		
			' rowx(2) = ExtraUtility.ConvertDataStrToLong(rs.GetString("DATADOC"),"","EN")
			rowx(1) = rs.Getstring("DESCRIZIONEAGG")
			rowx(2) = rs.GetDouble("QTA")
			rowx(3) = rs.GetDouble("PREZZOUNITNETTOEURO")
			DataList2.Add(rowx)
		Loop
		rs.Close
		B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
		B4XTable2.SetData(DataList2)
		B4XTable2.UpdateTableCounters
	Catch
		Log(LastException.Message)
	End Try
End Sub

Private Sub  ListaVistaDocAll(CodCliFor As String)
	Try
		' Tabella 3 Storico
		Sleep(0)
		B4XTable3.SearchField.HintText = "Cerca"
		B4XTable3.SearchField.HintColor = Colors.Green
		B4XTable3.SearchField.Update
		B4XTable3.MaximumRowsPerPage = 10
		B4XTable3.RowHeight = 76dip
		B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
		SelectedRows_T3 = B4XCollections.CreateSet
		Col1_Column_T3 = B4XTable3.AddColumn("Data", B4XTable3.COLUMN_TYPE_DATE) 		' Data Doc.
		Col1_Column_T3.Width = 115
		Col2_Column_T3 = B4XTable3.AddColumn("Descrizione", B4XTable3.COLUMN_TYPE_TEXT) 	' Descrizione
		Col2_Column_T3.Width = 350
		Col3_Column_T3 = B4XTable3.AddColumn("Qta", B4XTable3.COLUMN_TYPE_NUMBERS) 		' Qta
		Col3_Column_T3.Width = 100
		Col4_Column_T3 = B4XTable3.AddColumn("P. Netto", B4XTable3.COLUMN_TYPE_NUMBERS) 	' Prezzo netto
		Col4_Column_T3.Width = 140
		'ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
		ExtraUtility.CreateCustomFormat2dec(Col4_Column_T3,B4XTable3)
		DataList3.Initialize
		' CHHU#071000000000000000000000000000000000000	
		sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _
		& " WHERE CodCliFor = '" & CodCliFor & "' GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"
		Log(sqlstr)
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rs.NextRow
			Dim rowx(4) As Object
			rowx(0) = rs.GetString("DATADOC")		
			' rowx(2) = ExtraUtility.ConvertDataStrToLong(rs.GetString("DATADOC"),"","EN")
			rowx(1) = rs.Getstring("DESCRIZIONEAGG")
			rowx(2) = rs.GetDouble("QTA")
			rowx(3) = rs.GetDouble("PREZZOUNITNETTOEURO")
			DataList3.Add(rowx)
		Loop
		rs.Close
		B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
		B4XTable3.SetData(DataList3)
		B4XTable3.UpdateTableCounters
	Catch
		Log(LastException.Message)
	End Try
End Sub

private Sub ListaRigheDoc
	Try
		Sleep(0) 'this is required as the table layout is not immediately created.'
		B4XTable1.SearchField.HintText = "Cerca"
		B4XTable1.SearchField.HintColor = Colors.Green
		B4XTable1.SearchField.Update
		B4XTable1.MaximumRowsPerPage = 10
		B4XTable1.RowHeight = 40dip ' 40dip
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		SelectedRows = B4XCollections.CreateSet
		B4XTable1.AddColumn("n.", B4XTable1.COLUMN_TYPE_NUMBERS).Width=85 ' n
		B4XTable1.AddColumn("CodArt", B4XTable1.COLUMN_TYPE_TEXT).Width=1 ' CODART
		' B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT).Width=380 ' DESCRIZIONE
		Col3_Column = B4XTable1.AddColumn("Descrizione", B4XTable1.COLUMN_TYPE_TEXT) ' Descrizione
		Col3_Column.Width = 380
		Col4_Column = B4XTable1.AddColumn("Qta", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col4_Column.Width=100 ' NUMBERS
		Col5_Column = B4XTable1.AddColumn("Prezzo", B4XTable1.COLUMN_TYPE_NUMBERS)
		Col5_Column.Width=140 ' NUMBERS
		Col6_Column = B4XTable1.AddColumn("Sconto", B4XTable1.COLUMN_TYPE_TEXT)
		Col6_Column.Width=1 ' NUMBERS
		Col6_Column.Panel.Visible = False
		'B4XTable1.NumberOfFrozenColumns= 1
		ExtraUtility.CreateCustomFormat(Col4_Column,B4XTable1)
		ExtraUtility.CreateCustomFormat2dec(Col5_Column,B4XTable1)
		DataList.Initialize
		If(NewDocument.vOperazione="NewDoc") Then
			sqlstr = "select Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & vTipoDocNew
			sqlstr = sqlstr & "' AND Numerodoc = '" & vNumDocNew  & "' AND Esercizio = '" & vEsercizioNew & "'"
		Else
			sqlstr = "select Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto from IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & ListaDoc.vTipoDoc
			sqlstr = sqlstr & "' AND Numerodoc = '" & ListaDoc.vNumerodoc  & "' AND Esercizio = '" & ListaDoc.vEsercizio & "'"
		End If
		Log(sqlstr)
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		Do While rs.NextRow
			Dim rowx(6) As Object
			rowx(0) = rs.GetInt("Idriga")
			rowx(1) = rs.Getstring("Codart")
			rowx(2) = rs.Getstring("Descrizione")
			rowx(3) = rs.GetDouble("Qta")
			rowx(4) = rs.GetDouble("PrzUnit")		
			rowx(5) = rs.GetDouble("Sconto")
			DataList.Add(rowx)
		Loop
		rs.Close
		B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
		B4XTable1.SetData(DataList)
		B4XTable1.UpdateTableCounters
		'-------------------------------------------------------------------------------------
		' serve per fare la somma delle colonne
		'-------------------------------------------------------------------------------------
		Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
		Dim total As Double = 0
		Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
		Dim totalriga As Double
		Do While rs.NextRow
			totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
			total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),"N")
		Loop
		rs.Close
		Label11.Text = formatter.Format(total)
		'-------------------------------------------------------------------------------------
	Catch
		Log(LastException.Message)
	End Try
End Sub

Sub SetColumnAlignment(tableName As B4XTable, columnID As String, alignment As Int)
	Dim column As B4XTableColumn = tableName.GetColumn(columnID)
	Dim hAlign As String
	If alignment = Gravity.RIGHT Then
		hAlign = "RIGHT"
	Else If alignment = Gravity.LEFT Then
		hAlign = "LEFT"
	Else
		hAlign = "CENTER"
	End If
	For i = 1 To column.CellsLayouts.Size - 1        'starts at 1 due to header
		Dim pnl As B4XView = column.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		lbl.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, alignment)
		lbl.Padding= Array As Int (0, 0, 10, 0)
		Dim bx As B4XView = pnl.GetView(0)
		bx.SetTextAlignment("CENTER", hAlign)
	Next
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
		Log(LastException.Message)
	End Try
End Sub

Sub EditText1_FocusChanged (HasFocus As Boolean)
	If HasFocus=True Then
		If (EditText1.Text="0.0") Then
			EditText1.Text = ""
		End If
	End If
End Sub

Sub DeleteRow (tbl As B4XTable, RowId As Long)
	Sleep(0) 'this is required as the table layout is not immediately created.'
	'Dim RowData As Map = tbl.GetRow(RowId)
	Dim sql As String = ""
	SQLDataAccess.BeginTransaction
	sql = "DELETE FROM IS_RIGHEDOCUMENTI WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc & "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga = " & IDriga 
	Log(sql)
	SQLDataAccess.ExecNonQuery(sql)
	sql = "UPDATE IS_RIGHEDOCUMENTI SET Idriga = Idriga-1 WHERE Numerodoc = '" & ListaDoc.vNumerodoc & "' And TipoDoc = '" & ListaDoc.vTipoDoc & "' And Esercizio = '" & ListaDoc.vEsercizio & "' And Idriga > 1 And Idriga > " & IDriga
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
	'-------------------------------------------------------------------------------------
	' serve per fare la somma delle colonne
	'-------------------------------------------------------------------------------------
	Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
	Dim total As Double = 0
	Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
	Dim totalriga As Double
	Do While rs.NextRow
		totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
		total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),"N")
	Loop
	rs.Close
	Label11.Text = formatter.Format(total)
	'-------------------------------------------------------------------------------------
	tbl.Refresh
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If(Panel2.Visible=False) Then
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
		Dim Col2Value As String = B4XTable1.GetRow(RowId).GetValueAt(1)    ' Codart
		Dim Col3Value As String = B4XTable1.GetRow(RowId).GetValueAt(2)    ' Descrizione
		Dim Col4Value As Double = B4XTable1.GetRow(RowId).GetValueAt(3)    ' Qta
	   '	Dim Col5Value As Double = B4XTable1.GetRow(RowId).GetValueAt(4)    ' Prz. Unitario
		Log($"Number of rows selected: ${SelectedRows.Size}"$)
		Log($"Row selected: ${RowId}"$)
		Log($"Value of row selected: ${Col1Value}"$)
		RowID_Riga = RowId
		IDriga = Col1Value
		CodArt = Col2Value
		Descrizione=Col3Value
		Qta=Col4Value				
	End If
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Activity.Finish		
		CallSubDelayed(ListaDoc, "ListaDocChkNew")
		Return True
	Else
		Return False
	End If
End Sub

'Sub AutoClose (TimedDialog As CustomLayoutDialog, UpdateLabel As Label, Disable() As Boolean)
'	UpdateLabel.Text = 9
'	Do While UpdateLabel.Text > 0
'		Sleep(1000)
'		'the timer was disabled
'		If Disable(0) = True Then Return
'		UpdateLabel.Text = NumberFormat(UpdateLabel.Text - 1, 0, 0)
'	Loop
'	TimedDialog.CloseDialog(DialogResponse.CANCEL)
'End Sub

Sub Button5_Click ' Punto Interrogativo
	Try
		Sleep(0)
		If (Panel5.Visible) Then
			Panel5.Visible = False
		Else
			' Legge tutti i dati del record
			' DateTime.DateFormat = "yyyy-MM-dd"
			B4XTable3.MaximumRowsPerPage = 10
			B4XTable3.RowHeight = 76dip
			DataList3.Initialize
			If(NewDocument.vOperazione="NewDoc") Then
				sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _
				& " WHERE CodCliFor = '" & NewDocument.vCodCliFor & "' GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"
			Else
				sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _
				& " WHERE CODCLIFOR = '" & ListaDoc.vCodCliFor & "' GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"				
			End If
			Log(sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Dim rowx(4) As Object
				rowx(0) = ExtraUtility.ConvertDataStrToLong(rs.GetString("DATADOC"),"dd-MM-yy","EN")
				rowx(1) = rs.Getstring("DESCRIZIONEAGG")
				rowx(2) = rs.GetDouble("QTA")
				rowx(3) = rs.GetDouble("PREZZOUNITNETTOEURO")
				' rowx(3) = ExtraUtility.ConvertDataStrToLong(rs.GetString("DATADOC"),"","EN")
				DataList3.Add(rowx)
			Loop
			rs.Close
			B4XTable3.BuildLayoutsCache(B4XTable3.MaximumRowsPerPage)
			B4XTable3.SetData(DataList3)
			B4XTable3.UpdateTableCounters
			Panel5.Visible = True
		End If
	Catch
		Log(LastException.Message)
	End Try
End Sub

Sub Button4_Click ' Bacchetta Magica
	Sleep(0)
	If (Panel2.Visible) Then	
		If (Panel4.Visible) Then
			Panel4.Visible = False
		Else		
			' Legge tutti i dati del record
			B4XTable2.MaximumRowsPerPage = 5
			B4XTable2.RowHeight = 60dip
			DataList2.Initialize
			If(NewDocument.vOperazione="NewDoc") Then			
				sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _				
				& " WHERE CodCliFor = '" & NewDocument.vCodCliFor & "' AND CODART='" & EditText4.Text & "'" _
				& " GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"
			Else
				sqlstr = "SELECT DATADOC, DESCRIZIONEAGG, SUM(QTA) AS QTA, PREZZOUNITNETTOEURO FROM IS_VISTADOCUMENTI " _
				& " WHERE CODCLIFOR = '" & ListaDoc.vCodCliFor & "' AND CODART='" & EditText4.Text & "'" _
				& " GROUP BY DATADOC, DESCRIZIONEAGG, PREZZOUNITNETTOEURO"				
			End If
			Log(sqlstr)
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Dim rowx(4) As Object
				rowx(0) = ExtraUtility.ConvertDataStrToLong(rs.GetString("DATADOC"),"dd-MM-yy","EN")	
				rowx(1) = rs.Getstring("DESCRIZIONEAGG")
				rowx(2) = rs.GetDouble("QTA")
				rowx(3) = rs.GetDouble("PREZZOUNITNETTOEURO")
				DataList2.Add(rowx)
			Loop
			rs.Close
			B4XTable2.BuildLayoutsCache(B4XTable2.MaximumRowsPerPage)
			B4XTable2.SetData(DataList2)
			B4XTable2.UpdateTableCounters		
			Panel4.Visible = True
		End If			
	End If
End Sub

Sub Button3_Click ' Delete Record
	If SelectedRows.Contains(RowID_Riga) Then
		Dim sf As Object = xui.Msgbox2Async("Elimino la riga?", "CANCELLAZIONE RIGA", "OK", "", "NO", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			DeleteRow(B4XTable1, RowID_Riga)
		End If
	Else
		Dim sf As Object = xui.Msgbox2Async("Selezionare la riga da eliminare","ATTENZIONE","OK","","",Null)
	End If
End Sub

Sub Button2_Click ' New Record (Riga)
	Operazione="Add"
	Panel2.Visible=True
	Panel1.SendToBack
	B4XTable1.ClearDataView
	Dim cdw As ColorDrawable
	cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
	Panel2.Background = cdw
	Label10.Text="#" & (B4XTable1.Size+1)
	Label9.Text=""
	Label7.Text=""
	EditText1.Text=""
	EditText2.Text=""
	EditText3.Text=""
	EditText4.Text=""
	EditText5.Text=""
	B4XFloatTextField1.Text=""
	B4XFloatTextField2.Text=""
	EditText4.RequestFocus
End Sub

Sub Button1_Click ' Modifica Record (Riga)
	'Panel1.Width = 100%x
	'Panel1.Height = 100%y
	If (ListaDoc.vTrasmesso=1) Then
		'SwiftButton1.disabledColor = Colors.Gray
		'SwiftButton1.disabledColor = Colors.Transparent
		'SwiftButton2.disabledColor = Colors.Gray
		'SwiftButton1.SetColors(Colors.Blue,Colors.Magenta)
		SwiftButton1.mBase.Color = Colors.Transparent
		SwiftButton2.xLBL.TextColor = Colors.Gray
		SwiftButton1.Enabled = False
		SwiftButton1.xLBL.Text = ""
		EditText1.Enabled = False
		EditText2.Enabled = False
		EditText3.Enabled = False
		EditText4.Enabled = False
		EditText5.Enabled = False
		B4XFloatTextField1.TextField.Enabled = False
		B4XFloatTextField2.TextField.Enabled = False
		btnDate.Enabled = False
		Button7.enabled = False
	Else
		SwiftButton1.Enabled = True
	End If
	Try
		Operazione="Modify" 
		If (CodArt <> "") Then
			Panel2.Visible=True	
			Panel1.SendToBack
			Dim cdw As ColorDrawable
			cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
			Panel2.Background = cdw
			EditText4.Text=CodArt
			Label9.Text=Descrizione
			Label10.Text="#" & IDriga
			EditText2.Text=Qta
	'		' Legge tutti i dati del record 
			If(NewDocument.vOperazione="NewDoc") Then
				sqlstr = "SELECT Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto, DataConsegna, Magazzino, Note, VARIAMISURE, "
				sqlstr = sqlstr & "RIFCLIENTE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & NewDocument.vTipoDocNew & "' AND Numerodoc = '"
				sqlstr = sqlstr & NewDocument.vNumDocNew  & "' AND Esercizio = '" & NewDocument.vEsercizioNew & "' AND Idriga = '" & IDriga & "'"
			Else
				sqlstr = "SELECT Idriga, Codart, Descrizione, Qta, PrzUnit, Sconto, DataConsegna, Magazzino, Note, VARIAMISURE, "
				sqlstr = sqlstr & "RIFCLIENTE FROM IS_RIGHEDOCUMENTI WHERE TipoDoc = '" & ListaDoc.vTipoDoc & "' AND Numerodoc = '"
				sqlstr = sqlstr & ListaDoc.vNumerodoc  & "' AND Esercizio = '" & ListaDoc.vEsercizio & "' AND Idriga = '" & IDriga & "'"
			End If
			Log(sqlstr)				
			Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
			Do While rs.NextRow
				Label10.Text = "#" & rs.GetInt("Idriga")
				EditText4.Text = rs.GetString("Codart")
				Label9.Text = rs.GetString("Descrizione")
				Label7.Text = rs.GetString("Magazzino")
				EditText2.Text = rs.GetInt("Qta")
				EditText1.Text = rs.GetDouble("PrzUnit")
				EditText3.Text = rs.GetString("Sconto")
				Dim DataConsegna As String
				Dim DataConsegna_Long As Long
				DataConsegna = rs.GetString("DataConsegna")
				If DataConsegna <> Null Then DataConsegna = DataConsegna.Trim
				If DataConsegna <> Null And DataConsegna.Length >= 8 Then
					' In archivio puo' arrivare 19/11/2026 oppure 19-11-2026
					DataConsegna = DataConsegna.Replace("/", "-")
					If DataConsegna.Length > 10 Then DataConsegna = DataConsegna.SubString2(0, 10)
					If DataConsegna.Length > 8 Then
						DateTime.DateFormat = "dd-MM-yyyy"
					Else
						DateTime.DateFormat = "dd-MM-yy"
						DataConsegna = DataConsegna.SubString2(0, 8)
					End If
					DataConsegna_Long = DateTime.DateParse(DataConsegna)
					btnDate.xLBL.text = ExtraUtility.DateToFormat(DataConsegna_Long,"dd-MM-yyyy","","IT")
				End If		
				EditText5.Text=rs.getstring("RIFCLIENTE")
				B4XFloatTextField1.Text=rs.GetString("Note")
				B4XFloatTextField2.Text=rs.GetString("VARIAMISURE")
			Loop
			rs.close
		Else
			ToastMessageShow("Selezionare la riga da modificare!",False)
		End If
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
End Sub

Sub Button7_Click
	StartActivity(Ricerca_AZ)	
End Sub

Sub btnDate_Click
	Phone.HideKeyboard
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "Esci")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
			DateTime.DateFormat = "dd-MM-yy"
			btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)		
	End If
End Sub

Sub SwiftButton1_Click()
	' OK
	Panel4.Visible = False
	Dim vCodArt As String
	vCodArt = EditText4.Text
	Dim vQta As String
	vQta = EditText2.text
	If (ExtraUtility.Check_Sconto_Syntax(EditText3.Text)) Then
		If (vCodArt <> "") And (IsNumber(vQta)) Then
			Dim DataConsegna As String
			Select Operazione
				Case "Add" ' aggiungi riga			
		'			rowx(0) = rs.GetInt("Idriga")
		'			rowx(1) = rs.Getstring("Codart")
		'			rowx(2) = rs.Getstring("Descrizione")
					DataConsegna = btnDate.xLBL.Text
					Dim Pos As Int = B4XTable1.Size+1
					B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?,?,?,?,?,?)"$ , Array As Object(Pos, EditText4.Text, Label9.Text, EditText2.text, EditText1.text, EditText3.Text))
					Dim sql As String = "INSERT INTO IS_RIGHEDOCUMENTI (TipoDoc,Numerodoc,Esercizio,Idriga,UtenteModifica,Codart,Qta,"
					sql = sql & "Descrizione,Note,VariaMisure,Sconto,RifCliente,Magazzino,PrzUnit,DataConsegna) VALUES "
					If(NewDocument.vOperazione="NewDoc") Then 
						sql = sql & "('" & NewDocument.vTipoDocNew & "','" & NewDocument.vNumDocNew & "','" & NewDocument.vEsercizioNew & "','" & Pos & "','"
					Else
						sql = sql & "('" & ListaDoc.vTipoDoc & "','" & ListaDoc.vNumerodoc & "','" & ListaDoc.vEsercizio & "','" & Pos & "','"
					End If
					sql = sql & Main.Utente & "','" & EditText4.text & "','" & EditText2.text & "','" & Label9.Text & "','" & B4XFloatTextField1.Text
					sql = sql & "','" & B4XFloatTextField2.Text & "','" & EditText3.Text & "','" & EditText5.Text & "','" & Label7.Text & "','"
					sql = sql & EditText1.Text & "','" & DataConsegna & "')"
					SQLDataAccess.ExecNonQuery(sql)
					B4XTable1.ClearDataView
					Sleep(0)
					Dim pag As Int
					pag = B4XTable1.mCurrentCount/B4XTable1.RowsPerPage
					'Log("pagina " & pag)				
					Dim column1 As B4XTableColumn = B4XTable1.GetColumn("n.")
					'Log ("Sort " & column1.InternalSortMode)
					If column1.InternalSortMode <> "DESC" Then
						' column.InternalSortMode= "DESC"
						B4XTable1.CurrentPage = pag + 1
					Else
						' column.InternalSortMode= "ASC"
						B4XTable1.CurrentPage = 1
					End If
					'-------------------------------------------------------------------------------------
					' serve per fare la somma delle colonne
					'-------------------------------------------------------------------------------------
					Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
					Dim total As Double = 0
					Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
					Dim totalriga As Double
					Do While rs.NextRow
						totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
						total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),"N")
					Loop
					rs.Close
					Label11.Text = formatter.Format(total)
					'-------------------------------------------------------------------------------------
					' B4XTable1.ClearDataView
					B4XTable1.Refresh	
					
				Case "Modify"		
					DataConsegna = btnDate.xLBL.Text				
					If(NewDocument.vOperazione="NewDoc") Then
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ? WHERE rowid = ?", Array (IDriga,EditText4.text,Label9.Text,EditText2.text,EditText1.Text,EditText3.Text,RowID_Riga))
						Dim sql As String
						sql = "UPDATE IS_RIGHEDOCUMENTI SET CODART = ?, DESCRIZIONE = ?, QTA = ?, PrzUnit = ?, Sconto = ?, DataConsegna = ?, Note = ?, Variamisure = ?, Rifcliente = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text, Label9.Text, EditText2.Text, EditText1.text, EditText3.text, DataConsegna, B4XFloatTextField1.Text, B4XFloatTextField2.Text, EditText5.Text, NewDocument.vTipoDocNew, NewDocument.vEsercizioNew, NewDocument.vNumDocNew, IDriga))
					Else
						B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c0 = ?, c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ? WHERE rowid = ?", Array (IDriga,EditText4.text,Label9.Text,EditText2.text,EditText1.Text,EditText3.Text, RowID_Riga))
						Dim sql As String
						sql = "UPDATE IS_RIGHEDOCUMENTI SET Codart = ?, Descrizione = ?, Qta = ?, PrzUnit = ?, Sconto = ?, DataConsegna = ?, Note = ?, Variamisure = ?, Rifcliente = ?"
						sql = sql & " WHERE TIPODOC = ? AND ESERCIZIO = ? AND NUMERODOC = ? AND IDRIGA = ?"
						SQLDataAccess.ExecNonQuery2(sql, Array As String (EditText4.Text, Label9.Text, EditText2.Text, EditText1.text, EditText3.text, DataConsegna, B4XFloatTextField1.Text, B4XFloatTextField2.Text, EditText5.Text, ListaDoc.vTipoDoc, ListaDoc.vEsercizio, ListaDoc.vNumerodoc, IDriga))
					End If
					'-------------------------------------------------------------------------------------
					' serve per fare la somma delle colonne
					'-------------------------------------------------------------------------------------
					Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit
					Dim total As Double = 0
					Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))
					Dim totalriga As Double
					Do While rs.NextRow
						totalriga = Round2(rs.GetDouble("c3") * rs.GetDouble("c4"),2) 'c3 = Qta, c4 = PrzUnit, c5 = sconto, c6 = tiporiga
						total = total + ExtraUtility.Calc_Valore_Scontato(totalriga,rs.GetString("c5"),"N")
					Loop
					rs.Close
					Label11.Text = formatter.Format(total)
					'-------------------------------------------------------------------------------------
					' B4XTable1.ClearDataView
					B4XTable1.Refresh
					
			End Select
			Panel2.Visible=False
			Phone.HideKeyboard	
			If (Main.SwitchRepeatAdd=1) And (Operazione="Add") Then
				Panel2.Visible=True
				Panel1.SendToBack
				Dim cdw As ColorDrawable
				cdw.Initialize2(0xFF979A9C, 5, 3,Colors.Black)
				Panel2.Background = cdw
				Label10.Text="#" & (B4XTable1.Size+1)
				Label9.Text=""
				Label7.Text=""
				EditText1.Text=""
				EditText2.Text=""
				EditText3.Text=""
				EditText4.Text=""
				EditText5.Text=""
				B4XFloatTextField1.Text=""
				B4XFloatTextField2.Text=""
				EditText4.RequestFocus
				Panel2.Visible=True
			End If
			If (vQta = 0) Then
				MsgboxAsync("Quantità a zero, modificare la riga in caso di errore!","ATTENZIONE")
			End If
		Else
			MsgboxAsync("Inserimento errato controlla articolo e quantità","ERRORE INSERIMENTO")
		End If
	Else
		MsgboxAsync("Utilizzare solo valori numerici ed il carattere '+' per sconti composti o il punto come decimale!","ERRORE SCONTO")
	End If
End Sub

Sub SwiftButton2_Click
	' Annulla
	Panel4.Visible = False
	Panel2.Visible = False
	Sleep(0)
	Dim Phone As IME
	Phone.HideKeyboard
End Sub

Sub EditText4_EnterPressed
	' 8056455939510	
	Select Main.Ditta
		Case "ZelariVi"
			sqlstr = "select CODICE,DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE ARTTIPOLOGIA='0' AND BARCODE like '" & EditText4.Text.Trim & "%'"
		Case "Esseci"
			sqlstr = "select CODICE,DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE CODICE = '" & EditText4.Text.Trim & "'"
		Case "Nesti"
			sqlstr = "select CODICE,DESCRIZIONE from IS_ANAGRAFICAARTICOLI WHERE CODICE = '" & EditText4.Text.Trim & "'"		
	End Select
	Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
	If (rs.RowCount>0) Then
		Do While rs.NextRow
			Label9.Text = rs.GetString("DESCRIZIONE")
			EditText4.Text = rs.GetString("CODICE")		
		Loop		
		rs.close
	Else
		Select Main.Ditta
			Case "Esseci"
				sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				If (rs.RowCount>0) Then
					Do While rs.NextRow
						Label9.Text = rs.GetString("DESCRIZIONE")
						EditText4.Text = rs.GetString("ARTICOLO")
					Loop					
					rs.close				
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText4.Text = ""
				End If
			Case "Nesti"
				sqlstr = "SELECT BC.ARTICOLO,AA.DESCRIZIONE FROM IS_BARCODE BC JOIN IS_ANAGRAFICAARTICOLI AA ON AA.CODICE=BC.ARTICOLO WHERE BC.BARCODE = '" & EditText4.Text.Trim & "'"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				If (rs.RowCount>0) Then
					Do While rs.NextRow
						Label9.Text = rs.GetString("DESCRIZIONE")
						EditText4.Text = rs.GetString("ARTICOLO")
					Loop
					rs.close
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText4.Text = ""
				End If
			Case "ZelariVi"
				sqlstr = "SELECT DESCRIZIONE FROM IS_ANAGRAFICAARTICOLI WHERE CODICE = '" & EditText4.Text.Trim & "'"
				Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
				If (rs.RowCount>0) Then
					Do While rs.NextRow
						Label9.Text = rs.GetString("DESCRIZIONE")
					Loop
					rs.close
				Else
					ExtraUtility.Play_Sound("error.wav")
					Label9.Text = "*** CODICE ERRATO ***"
					EditText4.Text = ""
				End If				
			Case Else			
				MsgboxAsync("ERRORE RigheDoc_ZelariVi","ERRORE")
				ExtraUtility.Play_Sound("error.wav")
				Label9.Text = "*** CODICE ERRATO ***"
				EditText4.Text = ""
		End Select
	End If
	If (EditText4.Text <> "") Then
		' trova il listino minimo
		Dim PrezzoMin As Double = 0
		Dim PrezzoCorr As Double = 0 
		PrezzoMin = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,Main.NRListinoMin,EditText4.Text)
		PrezzoCorr = DB_SQLite.Leggi_PrezzoListinoArt(SQLDataAccess,vNumListino,EditText4.Text)
		Label7.Text = PrezzoMin
		EditText1.Text = PrezzoCorr
		' trova il listino corrente
	End If
End Sub

Sub EditText4_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then
		If(EditText4.Text <> "")  Then
			EditText2.RequestFocus
			Phone.ShowKeyboard(EditText2)
		Else
			If(Label9.Text = "*** CODICE ERRATO ***") Then
				' caso errore riamngo sul codice
				EditText4.RequestFocus
			End If
		End If
	End If
End Sub

Sub EditText2_FocusChanged (HasFocus As Boolean)
	If HasFocus=False Then		
		If (EditText2.Text.Length>5) Then
			EditText4.Text = EditText2.Text 
			EditText4_EnterPressed
			EditText2.Text = ""
			EditText2.RequestFocus
		End If
	End If
End Sub

Sub EditText2_EnterPressed
	If (EditText2.Text.Length <= 5) Then
		EditText1.RequestFocus
	End If
End Sub
