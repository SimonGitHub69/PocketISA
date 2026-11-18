B4A=true
Group=Default Group\General
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' B4XComboClick - CustomView (B4A)
' Dropdown con ScrollView + righe personalizzate (colori per riga)

Sub Class_Globals
	Private mBase As Panel
	Private mCallback As Object
	Private mEventName As String

	Private pnlMain As Panel
	Private lbl As Label
	Private lblArrow As Label

	Private pnlDrop As Panel
	Private sv As ScrollView
	Private pnlItems As Panel

	Private mItems As List
	Private mSelectedIndex As Int = -1

	Private HeaderHeight As Int = 40dip
	Private ItemHeight As Int = 40dip
	Private DropDownHeight As Int = 370dip ' 370

	' colori default
	Private RowBackColor As Int = Colors.RGB(245, 245, 245)
	Private RowTextColor As Int = Colors.RGB(33, 33, 33)
	Private ArrowTextColor As Int = Colors.Gray
	
	Private Text_Size As Int = 18
	
	Private mSelectedTextColor As Int = Colors.Black
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
	mItems.Initialize
End Sub

Public Sub DesignerCreateView (Base As Panel, lblObj As Label, Props As Map)
	mBase = Base
	mBase.Color = Colors.Transparent

	Dim totale As Int = 40dip + DropDownHeight
	If mBase.Height < totale Then mBase.Height = totale

	' header
	pnlMain.Initialize("pnlMain")
	mBase.AddView(pnlMain, 0, 0, mBase.Width, 40dip)

	' >>> NON usare lblObj: crea una label vera
	lbl.Initialize("")
	Dim hLbl As Int = 32dip
	Dim topLbl As Int = 0 '  (40dip - hLbl) / 2
	lbl.Gravity = Gravity.CENTER_VERTICAL
	lbl.TextSize = Text_Size
	mSelectedIndex = -1
	pnlMain.AddView(lbl, 4dip, topLbl, pnlMain.Width - 28dip, hLbl)

	Dim lblgd As GradientDrawable
	lblgd.Initialize("LEFT_RIGHT", Array As Int(0xFFB0B0B0, 0xFFEFEFEF))
	lblgd.CornerRadius = 5dip
	lbl.Background = lblgd

	' freccia
	lblArrow.Initialize("")
	lblArrow.Text = "▼"
	lblArrow.Gravity = Gravity.CENTER
	
	Dim aw As Int = 24dip
	pnlMain.AddView(lblArrow, pnlMain.Width - aw - 4dip, topLbl, aw, hLbl)

	Dim lblArrowgd As GradientDrawable
	lblArrowgd.Initialize("LEFT_RIGHT", Array As Int(0xFFB0B0B0, 0xFFEFEFEF))
	lblArrowgd.CornerRadius = 5dip
	lblArrow.Background = lblArrowgd

	' dropdown (QUI lasci la tua implementazione ScrollView/Panel che hai scelto)
	pnlDrop.Initialize("")
	mBase.AddView(pnlDrop, 0, 36dip, mBase.Width, DropDownHeight)
	pnlDrop.Visible = False

	sv.Initialize(DropDownHeight)
	pnlDrop.AddView(sv, 0, 0, pnlDrop.Width, pnlDrop.Height)

	pnlItems.Initialize("")
	sv.Panel.AddView(pnlItems, 0, 0, sv.Width, 0)
End Sub


' --- apertura/chiusura dropdown ---
Private Sub pnlMain_Click
	pnlDrop.Visible = Not(pnlDrop.Visible)
	If SubExists(mCallback, mEventName & "_Click") Then
		CallSub(mCallback, mEventName & "_Click")
	End If
	ResetSelection
End Sub

Private Sub row_Click
    Dim p As Panel = Sender
    Dim l As Label = p.GetView(0)

    mSelectedIndex = p.Tag
    lbl.Text = l.Text

    ' salvo e applico il colore della riga selezionata
    mSelectedTextColor = l.TextColor
    lbl.TextColor = mSelectedTextColor

    pnlDrop.Visible = False

    If SubExists(mCallback, mEventName & "_SelectedIndexChanged") Then
        CallSub2(mCallback, mEventName & "_SelectedIndexChanged", mSelectedIndex)
    End If
End Sub

Public Sub getSelectedTextColor As Int
	Return mSelectedTextColor
End Sub

' =========================
'   API PUBBLICHE
' =========================

Public Sub Clear
	mItems.Clear
	pnlItems.RemoveAllViews
	pnlItems.Height = 0
	sv.Panel.Height = 0
	mSelectedIndex = -1
	lbl.Text = ""
End Sub

Public Sub AddAll(lst As List)
	Clear
	For Each s As String In lst
		AddItemStyled(s, RowTextColor, RowBackColor, False)
	Next
End Sub

Public Sub AddItem(Text As String)
	AddItemStyled(Text, RowTextColor, RowBackColor, False)
End Sub

Public Sub AddItemStyled(Text As String, TextCol As Int, BackCol As Int, IsBold As Boolean)
	mItems.Add(Text)
	Dim idx As Int = mItems.Size - 1

	Dim p As Panel
	p.Initialize("row")
	p.Tag = idx
	p.Color = BackCol
	pnlItems.AddView(p, 0, idx * ItemHeight, sv.Width, ItemHeight)

	Dim l As Label
	l.Initialize("")
	l.Text = Text
	l.TextColor = TextCol
	l.Gravity = Gravity.CENTER_VERTICAL
	l.TextSize = Text_Size
	l.Color = BackCol
	l.Padding = Array As Int(4dip, 0, 0, 0, 0)

	If IsBold Then
		l.Typeface = Typeface.DEFAULT_BOLD
	Else
		l.Typeface = Typeface.DEFAULT
	End If

	p.AddView(l, 8dip, 0, p.Width - 16dip, p.Height)

	pnlItems.Height = (idx + 1) * ItemHeight
	sv.Panel.Height = pnlItems.Height
End Sub

Public Sub SelectedIndex As Int
	Return mSelectedIndex
End Sub

Public Sub GetItem(i As Int) As String
	If i < 0 Or i > mItems.Size - 1 Then Return ""
	Return mItems.Get(i)
End Sub

Public Sub SetDropDownHeight(h As Int)
	DropDownHeight = h
	pnlDrop.Height = h
	sv.Height = h
	Dim totale As Int = HeaderHeight + DropDownHeight
	If mBase.Height < totale Then mBase.Height = totale
End Sub

Public Sub SetDefaultColors(RowBack As Int, RowText As Int, ArrowText As Int)
	RowBackColor = RowBack
	RowTextColor = RowText
	ArrowTextColor = ArrowText
	lbl.TextColor = RowTextColor
	lblArrow.TextColor = ArrowTextColor
	sv.Panel.Color = RowBackColor
End Sub

Public Sub ResetSelection
	mSelectedIndex = -1
	lbl.Text = "Seleziona Evento..."
	lbl.Padding = Array As Int(10dip,0,0,0)
	lbl.TextColor = Colors.Red
	lbl.Typeface = Typeface.DEFAULT
End Sub

Public Sub DropDownVisible(value As Boolean)	
	pnlDrop.Visible = value
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub setVisible(b As Boolean)
	mBase.Visible = b
End Sub

Public Sub getText As String
	Return lbl.Text
End Sub

Public Sub setText (text As String)
	lbl.Text = text
End Sub

Public Sub IsOpen As Boolean
	Return pnlDrop.Visible
End Sub
