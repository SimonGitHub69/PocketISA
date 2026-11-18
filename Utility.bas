B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

private Sub ConvertDate(DateTimeString As String, DateTimeFormat As String, NewDateTimeFormat As String,Language As String,Country As String) As String
	Dim JOLocale As JavaObject
	Dim JODTConvertTo As JavaObject
	Dim JODTConvertFrom As JavaObject
	Dim JODate As JavaObject
	JOLocale.InitializeNewInstance("java.util.Locale",Array As Object(Language,Country))
	JODTConvertTo.InitializeNewInstance("java.text.SimpleDateFormat",Array As Object(NewDateTimeFormat,JOLocale))
	JODTConvertFrom.InitializeNewInstance("java.text.SimpleDateFormat",Array As Object(DateTimeFormat))
	JODate  = JODTConvertFrom.RunMethod("parse",Array As Object(DateTimeString))
	Return JODTConvertTo.RunMethod("format",Array As Object(JODate))
End Sub

Sub Factorial(Number As Int) As Int
	If Number = 1 Then Return 1
	Return Number * Factorial(Number - 1)
End Sub

