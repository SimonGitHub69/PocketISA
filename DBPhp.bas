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
End Sub

''validate username and password
'Sub Validate As Boolean
'	Dim strUser As String =""
'	Dim strPwd As String = ""
'	strUser = strUser.Trim
'	strPwd = strPwd.trim
'	If strUser <> "" And strPwd <> "" Then
'		Return True
'	End If
'	MsgboxAsync("The username and passwords are required!","Error")
'	Return False
'End Sub
'
''validate username, password and new password
'Sub Validate1 As Boolean
'	Dim strUser As String = ""
'	Dim strPwd As String = ""
'	Dim strPwdNew As String = ""
'	strUser = strUser.Trim
'	strPwd = strPwd.trim
'	strPwdNew = strPwdNew.trim
'	If strUser <> "" And strPwd <> "" And strPwdNew <> "" Then
'		Return True
'	End If
'	MsgboxAsync("The username, password and new passwords are required!","Error")
'	Return False
'End Sub

'convert a json string to a map
Sub Json2Map(jsonText As String) As Map
	Log(jsonText)
	Dim Map1 As Map
	Map1.Initialize
	If jsonText.Length = 0 Then Return Map1
	Dim json As JSONParser
	json.Initialize(jsonText)
	Map1 = json.NextObject
	Return Map1
End Sub

'hide the progress dialog as soon as the page is finished loading
Sub webReport_PageFinished (Url As String)
	ProgressDialogHide
End Sub

'convert a map to a querystring
Sub Map2QueryString(sm As Map) As String
	' convert a map to a querystring string
	Dim SU As StringUtils
	Dim iCnt As Int
	Dim iTot As Int
	Dim sb As StringBuilder
	Dim mValue As String
	sb.Initialize
	' get size of map
		iTot = sm.Size - 1
		iCnt = 0
	For Each mKey As String In sm.Keys
		mValue = sm.Getdefault(mKey,"")
		mValue = mValue.trim
		mValue = SU.EncodeUrl(mValue, "UTF8")
		mKey = mKey.Trim
		If mKey.EndsWith("=") = False Then mKey = mKey & "="
		sb.Append(mKey).Append(mValue)
		If iCnt < iTot Then sb.Append("&")
		iCnt = iCnt + 1
	Next
	Return sb.ToString
End Sub

' convert map to json
Sub Map2Json(m As Map) As String
	Dim gen As JSONGenerator
	Dim outJSON As String
	gen.Initialize(m)
	outJSON = gen.ToString
	Return outJSON
End Sub

'convert a json string to a list
Sub Json2List(jsonTxt As String) As List
	Dim root As List
	root.Initialize
	Try
		Dim parser As JSONParser
		parser.Initialize(jsonTxt)
		root = parser.NextArray
		Return root
	Catch
		Return root
	End Try
End Sub

'get the length of the string
Sub Len(Text As String) As Int
	Return Text.Length
End Sub
