B4A=true
Group=Default Group\Kuore
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
	' ----- External Storage Inizio -----
	Private Storage As ExternalStorage
	Private rp As RuntimePermissions
	'Private FoldersStack As List
	'Private UpItem As ExternalFile
	' ----- External Storage Fine -----
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	' Private Phone As IME
	Private xui As XUI
	Private B4XImageView1 As B4XImageView
	Private Label1 As Label
	Private EditText1 As EditText
	' ----- External Storage Inizio -----
	Private chkUsePreviouslySelected As CheckBox
	Private ListView1 As ListView
	Private ImageView1 As ImageView
	Private lblPath As Label
	Private FileName As String = ""
	' ----- External Storage Fine -----
	Private ZoomImageView1 As ZoomImageView
	Private Label2 As Label
	Private vBarcodeLetto As String
	Private sqlstr As String
	Private vCodice As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Do not forget to load the layout file created with the visual designer. For example:	
	If FirstTime Then
		' ----- External Storage Inizio -----
		'Storage.Initialize (Me, "Storage")
		'FoldersStack.Initialize
		'UpItem.Initialize
		' ----- External Storage Fine -----
		ExtraUtility.CopyDBIfNeeded(Main.DBName)
		SQLDataAccess.Initialize(ExtraUtility.DirExt, Main.DBName, False)
	End If
	Activity.LoadLayout("CheckRef_Kuore")
	Sleep(0)
	Label1.Text = "Referenza:"
	EditText1.Text=""	
	EditText1.RequestFocus
End Sub

Private Sub EnterFolder (folder As ExternalFile)
'	FoldersStack.Add(folder)
'	Dim sb As StringBuilder
'	sb.Initialize
'	For Each f As ExternalFile In FoldersStack
'		If f = Storage.Root Then
'			sb.Append("Root")
'		Else
'			sb.Append(" / ").Append(f.Name)
'		End If
'	Next
'	lblPath.Text = sb.ToString
'	ListView1.Clear
'	
'	If FoldersStack.Size > 1 Then
'		ListView1.AddSingleLine2("..", UpItem)
'	End If
'	For Each f As ExternalFile In Storage.ListFiles(folder)
'		If f.IsFolder Then
'			ListView1.AddSingleLine2($"[${f.Name}]"$, f)
'		Else If IsImageFile(f.Name) Then
'			Dim cs As CSBuilder
'			cs.Initialize.Append(f.Name).Append(" ").Color(0xFF00EEFF).Append("(click)").PopAll
'			ListView1.AddSingleLine2(cs, f)
'		Else
'			ListView1.AddSingleLine2(f.Name, f)
'		End If
'	Next
End Sub

Sub Activity_Resume
	Sleep(0)
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Public Sub Initialize
	
End Sub

'Private Sub GetCurrentFolder As ExternalFile
'	Return FoldersStack.Get(FoldersStack.Size - 1) 'get the last item
'End Sub

Private Sub IsImageFile (Name As String) As Boolean
	Dim n As String = Name.ToLowerCase
	For Each extension As String In Array(".jpg", ".png", ".gif", ".bmp")
		If n.EndsWith(extension) Then Return True
	Next
	Return False
End Sub

Private Sub EditText1_EnterPressed
	Try
		'ToastMessageShow("Articolo -> " & EditText1.Text,True)
		vBarcodeLetto = EditText1.Text.Trim
		Dim vCodice As String = EditText1.Text
		Select Main.Ditta
			Case "Kuore"
				sqlstr = "SELECT CODART from IS_ANAGRAFICAARTICOLI WHERE PARTITA = '" & vBarcodeLetto & "'"
		End Select
		Dim rs As ResultSet = SQLDataAccess.ExecQuery(sqlstr)
		If (rs.RowCount>0) Then
			Do While rs.NextRow
				vCodice = rs.GetString("CODART")
			Loop
			rs.close
			Label2.Text = vCodice
		End If		
		FileName = vCodice & ".jpg"
		' Dim DirExt As String = File.DirRootExternal & "/Pocket_ISA/Immagini_Kuore"
		' Dim DirExt As String =rp.GetSafeDirDefaultExternal("foto_kuore2")
		' Dim DirExt As String =rp.GetSafeDirDefaultExternal("/Pocket_ISA/Immagini_Kuore2")
		' If File.Exists(DirExt, Filename) = True Then
		' 	File.Copy(File.DirAssets, Filename, DirExt, Filename)
		
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
				ZoomImageView1.SetBitmap(xui.LoadBitmap(DirExt1, FileName))
				Label2.Text = vCodice
			Else
				FileName = "NOIMAGE.jpg"
				If File.Exists(DirExt1, FileName)  Then
					ExtraUtility.Play_Sound("Sound1.wav")
					ZoomImageView1.SetBitmap(xui.LoadBitmap(DirExt1, FileName))
				Else
					MsgboxAsync("Immagine 'NOIMAGE.jpg' non trovata!" & CRLF & DirExt1,"ATTENZIONE")
				End If
			End If
		End If		
					
			'If File.Exists(DirExt, FileName)  Then
			'	ZoomImageView1.SetBitmap(xui.LoadBitmap(DirExt, FileName))
			'	Label2.Text = vCodice
			'Else			
			'	FileName = "NOIMAGE.jpg"
			'	Label2.Text = "ERRORE!"
			'	ExtraUtility.Play_Sound("Error.wav")			
			'	ZoomImageView1.SetBitmap(xui.LoadBitmap(DirExt, FileName))
			'End If
				
		' End If		
		EditText1.Text = ""
		EditText1.RequestFocus
	Catch
		Log(LastException.Message) 'no changes will be made
	End Try
	
End Sub

Private Sub ZoomImageView1_Click
	'Dim DirExt As String = File.DirRootExternal & "/Pocket_ISA/Immagini_Kuore"
	'Dim DirExt As String =rp.GetSafeDirDefaultExternal("foto_kuore")
	Dim DirExt1 As String = Main.PathImages
	If (FileName<>"") Then
		ZoomImageView1.SetBitmap(xui.LoadBitmap(DirExt1, FileName))
	End If
End Sub