B4A=true
Group=Default Group\GS_General
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
B4A=True
ModulesStructureVersion=1
Type=Class
Version=13.4
Sub Class_Globals
	Private xActivity As Activity
	Private xLblCodebarre As Label
	Private xLblSymbologie As Label
	Private xTxtForFocus As EditText
	Private xImgLecteur As ImageView
End Sub

Public Sub Initialize(a As Activity, lblCode As Label, lblType As Label, txtFocus As EditText, img As ImageView)
	xActivity = a
	xLblCodebarre = lblCode
	xLblSymbologie = lblType
	xTxtForFocus = txtFocus
	xImgLecteur = img
End Sub

Public Sub AfficheCAB(Code As String, TypeCode As String)
	' xLblCodebarre.Text = Code
	' xLblSymbologie.Text = TypeCode
End Sub

Public Sub SupprimeFocus
	Dim Ph As Phone
	Ph.HideKeyboard(xActivity)
End Sub

Public Sub CaricaImmagineScanner(PropPda As Map)
	If PropPda.IsInitialized Then
		If PropPda.ContainsKey("DEVICE_IMAGE") Then
			Dim bmp As Bitmap = PropPda.Get("DEVICE_IMAGE")
			xImgLecteur.Bitmap = bmp
		End If
	End If
End Sub