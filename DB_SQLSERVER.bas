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
	Private sqlstr As String
	Private TermoVal As Int
End Sub

Sub WriteTextWriter(Table As String)
	Dim TextWriter1 As TextWriter
	TextWriter1.Initialize(File.OpenOutput(File.DirDefaultExternal, "TextFiles/Prova.txt", False))
	For i = 1 To 10
		TextWriter1.WriteLine(Table & " - Line " & i)
	Next
	TextWriter1.Close
End Sub

Sub Leggi_Articoli(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM GS_ARTICOLI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		'---------------------------------------
		' SERVE PER SCRIVERE UN FILE DI TESTO 
		'---------------------------------------
'		Dim TextWriter1 As TextWriter
'		If(File.Exists(File.DirDefaultExternal,"TextFiles/" & "GS_ARTICOLI.txt")) Then
'			File.Delete(File.DirDefaultExternal,"TextFiles/" & "GS_ARTICOLI.txt")
'		End If
'		TextWriter1.Initialize(File.OpenOutput(File.DirDefaultExternal, "TextFiles/" & "GS_ARTICOLI.txt", False))		
'		TextWriter1.WriteLine("Inizio")
		'---------------------------------------
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim DescArt As String = Lista.Get("DESCRIZIONE")
			DescArt = Regex.Replace("[^\w\ +.@-_\(\)\%\/=\:\,\*\°\[\]\€\&\\\!\?\<\>\;\|\^\#\$]",DescArt,"")
			sqlstr = "INSERT INTO GS_ARTICOLI(CODICE,DESCRIZIONE) VALUES ('" _
	 		& Lista.Get("CODICE") & "','" & DescArt & "')"	
			' Log(k & " - " & sqlstr)
			' TextWriter1.WriteLine(k & " - " & sqlstr)
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "Articoli")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'---------------------------------------
		' SERVE PER SCRIVERE UN FILE DI TESTO
		'---------------------------------------
		' TextWriter1.Close
		'---------------------------------------
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella Articoli vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Articoli_Carbon(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM GS_ARTICOLI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim CodArt As String =  Lista.Get("CODICE")
			Dim DescArt As String = Lista.Get("DESCRIZIONE")
			Dim CodCiclo1 As String = Lista.Get("CODCICLO1")
			Dim CodCiclo2 As String = Lista.Get("CODCICLO2")
			Dim CodCiclo3 As String = Lista.Get("CODCICLO3")
			DescArt = Regex.Replace("[^\w\ +.@-_\(\)\%\/=\:\,\*\°\[\]\€\&\\\!\?\<\>\;\|\^\#\$]",DescArt,"")
			sqlstr = "INSERT INTO GS_ARTICOLI(CODICE,DESCRIZIONE,CODCICLO1,CODCICLO2,CODCICLO3) VALUES (?,?,?,?,?)"
			' TextWriter1.WriteLine(k & " - " & sqlstr)
			SQLData.ExecNonQuery2(sqlstr,Array As Object(CodArt, DescArt,CodCiclo1,CodCiclo2,CodCiclo3))
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "Articoli")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'---------------------------------------
		' SERVE PER SCRIVERE UN FILE DI TESTO
		'---------------------------------------
		' TextWriter1.Close
		'---------------------------------------
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella Articoli vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Autoclavi(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Dim InTransazione As Boolean = False
	
	Try
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		
		SQLData.BeginTransaction
		InTransazione = True
		
		For Each Key As String In res.Keys
			Dim Lista As Map = res.Get(Key)
			k = k + 1
			
			Dim Codice As String = Lista.GetDefault("CODICE", "")
			Dim Descrizione As String = Lista.GetDefault("DESCRIZIONE", "")
			Dim Numtubi As Int = Lista.GetDefault("NUMTUBI", 0)
			Dim Da_Num1 As Int = Lista.GetDefault("DA_NUM1", 0)
			Dim A_Num1 As Int = Lista.GetDefault("A_NUM1", 0)
			Dim Da_Num2 As Int = Lista.GetDefault("DA_NUM2", 0)
			Dim A_Num2 As Int = Lista.GetDefault("A_NUM2", 0)
			Dim Da_Num3 As Int = Lista.GetDefault("DA_NUM3", 0)
			Dim A_Num3 As Int = Lista.GetDefault("A_NUM3", 0)
			
			Descrizione = Descrizione.Replace("'", "")
			Descrizione = Descrizione.Replace(Chr(13), " ")
			Descrizione = Descrizione.Replace(Chr(10), " ")
			
			If Codice <> "" Then
				Dim Count As Int = 0
				
				Dim rs As ResultSet = SQLData.ExecQuery2( _
					"SELECT COUNT(*) AS NRECS FROM GS_AUTOCLAVI WHERE CODICE = ?", _
					Array As String(Codice))
				
				If rs.NextRow Then Count = rs.GetInt("NRECS")
				rs.Close
				
				If Count = 0 Then
					SQLData.ExecNonQuery2( _
						"INSERT INTO GS_AUTOCLAVI " & _
						"(CODICE, DESCRIZIONE, NUMTUBI, DA_NUM1, A_NUM1, DA_NUM2, A_NUM2, DA_NUM3, A_NUM3) " & _
						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", _
						Array As Object(Codice, Descrizione, Numtubi, Da_Num1, A_Num1, Da_Num2, A_Num2, Da_Num3, A_Num3))
				End If
			End If
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		InTransazione = False
		Return True
		
	Catch
		Log(LastException.Message)
		If InTransazione Then SQLData.EndTransaction
		Return False
	End Try
End Sub

Sub Leggi_Ricette(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM GS_RICETTE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim Descrizione As String = Lista.Get("DESCRIZIONE")
			Descrizione = Descrizione.Replace("'","")
			Descrizione = Descrizione.Replace(Chr(13)," ").Trim
			If(Descrizione="") Then
				Descrizione = "-"
			End If
			sqlstr ="INSERT INTO GS_RICETTE(CODICE,DESCRIZIONE) VALUES (?,?)"
			' & Lista.Get("CODICE") & "','" & Descrizione & "'")
			SQLData.ExecNonQuery2(sqlstr, Array As String(Lista.Get("CODICE"),Descrizione))
			' Log(sqlstr & " - " & Lista.Get("CODICE") & " - " & Descrizione)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "ricette")
			If (TermoVal>0) Then
				' Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
'		TextWriter1.WriteLine("Fine")
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella Ricette vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Reparti(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM GS_REPARTI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim Descrizione As String = Lista.Get("DESCRIZIONE")
			Descrizione = Descrizione.Replace("'","")
			Descrizione = Descrizione.Replace(Chr(13)," ")
			sqlstr ="INSERT INTO GS_REPARTI(CODICE,DESCRIZIONE) VALUES (?,?)"
	 		' & Lista.Get("CODICE") & "','" & Descrizione & "'")	
			SQLData.ExecNonQuery2(sqlstr, Array As String(Lista.Get("CODICE"),Descrizione))
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "reparti")
			If (TermoVal>0) Then
				' Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
'		TextWriter1.WriteLine("Fine")
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella Reparti vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Operatori(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM GS_OPERATORI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
'		Dim TextWriter1 As TextWriter
'		If(File.Exists(File.DirDefaultExternal,"TextFiles/" & "GS_OPERATORI.txt")) Then
'			File.Delete(File.DirDefaultExternal,"TextFiles/" & "GS_OPERATORI.txt")
'		End If
'		TextWriter1.Initialize(File.OpenOutput(File.DirDefaultExternal, "TextFiles/" & "GS_OPERATORI.txt", False))
'		TextWriter1.WriteLine("Inizio")
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim Nome As String = Lista.Get("NOME")
			Dim Reparto As String = Lista.Get("REPARTO")
			Nome = Nome.Replace("'","")
			Nome = Nome.Replace(Chr(13)," ")
			Reparto = Reparto.Replace("'","")
			Reparto = Reparto.Replace(Chr(13)," ")
			sqlstr ="INSERT INTO GS_OPERATORI (CODICE,NOME,REPARTO) VALUES ('" _
	 		& Lista.Get("CODICE") & "','" & Nome & "','" & Reparto & "')"	
			' TextWriter1.WriteLine(sqlstr)
			' Log(sqlstr)
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "Operatori")
			If (TermoVal>0) Then
				' Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
'		TextWriter1.WriteLine("Fine")
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella Operatori vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_ParametriDoc(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Select Case Main.Ditta
			Case "Gefin"
				SQLData.ExecNonQuery("DELETE FROM GS_PARAMETRIDOC")
			Case "Florenzi"
				SQLData.ExecNonQuery("DELETE FROM GS_TABPARAMETRIDOC")
			Case "Trendy"
				SQLData.ExecNonQuery("DELETE FROM GS_TABPARAMETRIDOC")
			Case Else
				SQLData.ExecNonQuery("DELETE FROM IS_PARAMETRIDOC")
		End Select
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Select Case Main.Ditta
				Case "Gefin"
					sqlstr ="INSERT INTO GS_PARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "')"	
				Case "Florenzi"
					sqlstr ="INSERT INTO GS_TABPARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "')"	
				Case "ZelariVi"
					sqlstr ="INSERT INTO IS_PARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "')"					
				Case "Esseci"
					sqlstr ="INSERT INTO IS_PARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR,TIPO) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "','" & Lista.Get("TIPO") & "')"	
				Case "Trendy"
					sqlstr ="INSERT INTO GS_TABPARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "')"	
				Case "Nesti"
					sqlstr ="INSERT INTO IS_PARAMETRIDOC (CODICE,TIPODOC,DESCRIZIONE,TIPOCLIFOR,TIPO) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("TIPOCLIFOR") & "','" & Lista.Get("TIPO") & "')"	
				Case "Kuore"
					sqlstr ="INSERT INTO IS_PARAMETRIDOC (CODICE,TIPO,DESCRIZIONE,CLIFOR) VALUES ('" _
			 		& Lista.Get("CODICE") & "','" & Lista.Get("TIPO") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("CLIFOR") & "')"	
			End Select
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "ParametriDoc")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_PARAMETRIDOC vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_AnagraficaDepositi(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_ANAGRAFICADEPOSITI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		Try
			For Each Key As String In res.Keys
				Dim Value As Object = res.Get(Key)
				Dim Lista As Map = Value
				k = k + 1
				sqlstr = "INSERT INTO IS_ANAGRAFICADEPOSITI (CODICE,DESCRIZIONE,FLAG_UBICAZIONICORSIA,TIPO_MAGAZZINO) " _
				& "VALUES ('" & Lista.Get("CODICE") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("FLAG_UBICAZIONICORSIA") & "','" _
				& Lista.Get("TIPO_MAGAZZINO") & "')"			 
				SQLData.ExecNonQuery(sqlstr)
				' ---------------------------------- DISPLAY TERMO ----------------------------------------------
				TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "AnagraficaDepositi")
				If (TermoVal>0) Then
					Sleep(0)
					CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
				End If
				' ------------------------------------------------------------------------------------------------
			Next
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("tabella anagraficadepositi vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_ListiniArticoli(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_LISTINIARTICOLI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		Try
			For Each Key As String In res.Keys
				Dim Value As Object = res.Get(Key)
				Dim Lista As Map = Value
				k = k + 1
				sqlstr = "INSERT INTO IS_LISTINIARTICOLI (CODART,NRLISTINO,UM,PREZZO,PREZZOEURO,UTENTE) VALUES ('" _
				 & Lista.Get("CODART") & "','" & Lista.Get("NRLISTINO") & "','" & Lista.Get("UM") & "','" & Lista.Get("PREZZO") & "','" _
				 & Lista.Get("PREZZOEURO") & "','" & Lista.Get("UTENTE") & "')"								 
				SQLData.ExecNonQuery(sqlstr)
				' ---------------------------------- DISPLAY TERMO ----------------------------------------------
				TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "ListiniArticoli")
				If (TermoVal>0) Then
					Sleep(0)
					CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
				End If
				' ------------------------------------------------------------------------------------------------
			Next
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella listiniarticoli vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_TabListini2(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_TABLISTINI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		Try
			For Each Key As String In res.Keys
				Dim Value As Object = res.Get(Key)
				Dim Lista As Map = Value
				k = k + 1
				sqlstr ="INSERT INTO IS_TABLISTINI(NRLISTINO,DESCRIZIONE,CODCAMBIO,FLGCOSTISTD) VALUES ('" _
				 & Lista.Get("NRLISTINO") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("CODCAMBIO") & "','" & Lista.Get("FLGCOSTISTD") & "')"								 
				SQLData.ExecNonQuery(sqlstr)
				' ---------------------------------- DISPLAY TERMO ----------------------------------------------
				TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "TabListini")
				If (TermoVal>0) Then
					Sleep(0)
					CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
				End If
				' ------------------------------------------------------------------------------------------------
			Next
		Catch
			Log(LastException.Message) 'no changes will be mades
		End Try
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella tablistini vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_TabListini(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_TABLISTINI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		Try
			For Each Key As String In res.Keys
				Dim Value As Object = res.Get(Key)
				Dim Lista As Map = Value
				k = k + 1
				sqlstr ="INSERT INTO IS_TABLISTINI(NRLISTINO,DESCRIZIONE,CODCAMBIO,PREZZOMINIMOVEND,FLGCOSTISTD) VALUES ('" _
				 & Lista.Get("NRLISTINO") & "','" & Lista.Get("DESCRIZIONE") & "','" & Lista.Get("CODCAMBIO") & "','" & Lista.Get("PREZZOMINIMOVEND") & "','" & Lista.Get("FLGCOSTISTD") & "')"								 
				SQLData.ExecNonQuery(sqlstr)
				' ---------------------------------- DISPLAY TERMO ----------------------------------------------
				TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "TabListini")
				If (TermoVal>0) Then
					Sleep(0)
					CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
				End If
				' ------------------------------------------------------------------------------------------------
			Next
		Catch
			Log(LastException.Message) 'no changes will be mades
		End Try
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella tablistini vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Updating(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.ExecNonQuery("DELETE FROM " & Main.PrefixSQL & "_SYNC_STATE")
		Log ("DELETE FROM " & Main.PrefixSQL & "_SYNC_STATE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO " & Main.PrefixSQL & "_SYNC_STATE(Table_Sync,Sync_State) VALUES ('" & Lista.Get("TABLE_SYNC") & "'," & Lista.Get("SYNC_STATE") & ")"
			Log(sqlstr)
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "is_sync_state")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		If res.Size = 0 Then
			MsgboxAsync("Tabella " & Main.PrefixSQL & "_SYNC_STATE vuota","Errore")
		End If
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		MsgboxAsync("Errore tabella " & Main.PrefixSQL & "_SYNC_STATE " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_PalmDevice(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45		
		SQLData.ExecNonQuery("DELETE FROM " & Main.PrefixSQL & "_PALMDEVICE")
		Log ("DELETE FROM " & Main.PrefixSQL & "_PALMDEVICE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		SQLData.BeginTransaction		
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO " & Main.PrefixSQL & "_PALMDEVICE(SERIALNUMBER,DATASCAD) VALUES ('" & Lista.Get("SERIALNUMBER") & "','" & Lista.Get("DATASCAD") & "')"					 
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "PalmDevice")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		If res.Size = 0 Then
			MsgboxAsync("Tabella " & Main.PrefixSQL & "_PALMDEVICE vuota","Errore")
		End If
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		MsgboxAsync("Errore tabella " & Main.PrefixSQL & "_PALMDEVICE " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_IS_Vista_UmPref(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTA_UMPREF")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim Barcode As String = ""
			Barcode = Lista.Get("BARCODE")
			Barcode = Barcode.Replace("'","")			
			sqlstr ="INSERT INTO IS_VISTA_UMPREF(CODICE,UMB,UMV,UML,FCVB,FCLB) VALUES ('" _
			 & Lista.Get("CODICE") & "','" & Lista.Get("UMB") & "','" & Lista.Get("UMV") & "','" _
			 & Lista.Get("UML") & "','" & Lista.Get("FCVB") & "','" & Lista.Get("FCLB") & "')"			 
			' Log ("IS_BARCODE -> " & sqlstr)
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_VISTA_UMPREF")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VISTA_UMPREF vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_VISTA_UMPREF " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_IS_Barcode(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_BARCODE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim Barcode As String = ""
			Barcode = Lista.Get("BARCODE")
			Barcode = Barcode.Replace("'","")
			sqlstr ="INSERT INTO IS_BARCODE(ARTICOLO,BARCODE) VALUES ('" _
			 & Lista.Get("ARTICOLO") & "','" & Barcode & "')"			
			' Log ("IS_BARCODE -> " & sqlstr)					 
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_BARCODE")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful		
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_BARCODE vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_BARCODE " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_IS_VISTA_NOTE_ORDINI(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTA_NOTE_ORDINI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim vAnnotazioni As String = Lista.Get("ANNOTAZIONI")
			vAnnotazioni = vAnnotazioni.Replace("'","")
			sqlstr ="INSERT INTO IS_VISTA_NOTE_ORDINI(IDT_GIRO,IDTESTA,CODART,QTAGEST,UMGEST,ANNOTAZIONI) VALUES ('" _
			 & Lista.Get("IDT_GIRO") & "','" & Lista.Get("IDTESTA")  & "','" & Lista.Get("CODART") & "','" _
			 & Lista.Get("QTAGEST") & "','" & Lista.Get("UMGEST") & "','" & vAnnotazioni & "')"		
			Log(sqlstr)			
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_VISTA_NOTE_ORDINI")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VISTA_NOTE_ORDINI vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_VISTA_NOTE_ORDINI " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_IS_VISTA_CLIENTI_GIRO(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTA_CLIENTI_GIRO")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim RagSoc As String = Lista.Get("RAGSOC")
			RagSoc = RagSoc.Replace("'","")
			sqlstr ="INSERT INTO IS_VISTA_CLIENTI_GIRO(CODCLIFOR,RAGSOC,IDT_GIRO) VALUES ('" _
			 & Lista.Get("CODCLIFOR") & "','" & RagSoc & "','" & Lista.Get("IDT_GIRO") & "')"					
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_VISTA_CLIENTI_GIRO")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VISTA_CLIENTI_GIRO vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_VISTA_CLIENTI_GIRO " & LastException.Message,"Errore")
		Return False
	End Try
End Sub


Sub Leggi_IS_ImpostazioniCtrlInv(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_IMPOSTAZIONICTRLINV")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO IS_IMPOSTAZIONICTRLINV(NOMEIMPOSTAZIONE,CODMAGAZZINO,CODUBICAZIONE,FLAG_UBICAZIONECORSIA) VALUES ('" _
			 & Lista.Get("NOMEIMPOSTAZIONE") & "','" & Lista.Get("CODMAGAZZINO") & "','" & Lista.Get("CODUBICAZIONE") & "','" & Lista.Get("FLAG_UBICAZIONECORSIA") & "')"					
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_IMPOSTAZIONICTRLINV")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_IMPOSTAZIONICTRLINV vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True		
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_IMPOSTAZIONICTRLINV " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_IS_TabCodificaEAN(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_TABCODIFICAEAN")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO IS_TABCODIFICAEAN(CODICE,NUMCIFRE,LUNG,VARIABILE,TIPO,DESCRIZIONE) VALUES ('" _
			 & Lista.Get("CODICE") & "','" & Lista.Get("NUMCIFRE") & "','" & Lista.Get("LUNG") & "','" _
			 & Lista.Get("VARIABILE") & "','" & Lista.Get("TIPO") & "','" &  Lista.Get("DESCRIZIONE") & "')"					
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_TABCODIFICAEAN")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_TABCODIFICAEAN vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_TABCODIFICAEAN " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_Semaforo_Corsie_Giro(jobResult As String, SQLData As SQL, IdTesta As Long, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		SQLData.BeginTransaction
		'SQLData.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE_local WHERE IDTESTA = " & IdTesta)
		'Log("DELETE FROM IS_SEMAFOROCORSIE_local")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			SQLData.ExecNonQuery2("INSERT OR REPLACE INTO IS_SEMAFOROCORSIE_local (IDTESTA,CORSIA,UTENTE,OCCUPATA,TIPOCORSIA) VALUES (?,?,?,?,?)", _
			Array As String(Lista.Get("IDTESTA"),Lista.Get("CORSIA"),Lista.Get("UTENTE"),Lista.Get("OCCUPATA"),"*"))	
			Log("SQL(" & k & ") -> " & sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_SEMAFOROCORSIE_local")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		'If res.Size = 0 Then
		'	MsgboxAsync("Tabella IS_SEMAFOROCORSIE vuota","Errore")
		'End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_SEMAFOROCORSIE_local " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Azzera_SemaforoCorsie_Local(SQLData As SQL, Utente As String) As ResumableSub
	Try
		Select Case Main.Ditta
			Case "Nesti"
				SQLData.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE WHERE UTENTE ='" & Utente & "'")
					
		End Select
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Semaforo_Corsie(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Sleep(0)
		SQLData.BeginTransaction
		SQLData.ExecNonQuery("DELETE FROM IS_SEMAFOROCORSIE")
		Log("DELETE FROM IS_SEMAFOROCORSIE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			SQLData.ExecNonQuery2("INSERT OR REPLACE INTO IS_SEMAFOROCORSIE(CORSIA,UTENTE,OCCUPATA) VALUES (?,?,?)", _
			Array As String(Lista.Get("CORSIA"),Lista.Get("UTENTE"),Lista.Get("OCCUPATA")))	
			Log("SQL(" & k & ") -> " & sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_SEMAFOROCORSIE")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		'show the report
		'If res.Size = 0 Then
		'	MsgboxAsync("Tabella IS_SEMAFOROCORSIE vuota","Errore")
		'End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella IS_SEMAFOROCORSIE " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_Vista_FattoriConv(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_FATTORICONV")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_FATTORICONV(CODART,FLAG_BILANCIA,UMBASE,UMA,FATTORE) VALUES ('" _
			 & Lista.Get("CODART") & "','" & Lista.Get("FLAG_BILANCIA") & "','" _
			 & Lista.Get("UMBASE") & "','" & Lista.Get("UMA") & "','" & Lista.Get("FATTORE") & "')"					
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_FATTORICONV")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful		
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella VISTA_FATTORICONV vuota","Errore")
		End If
		SQLData.EndTransaction
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		Return True
	Catch
		Log(LastException.Message & " SQL: " & sqlstr ) 'no changes will be made
		MsgboxAsync("Errore tabella VISTA_FATTORICONV " & LastException.Message,"Errore")
		Return False
	End Try
End Sub

Sub Leggi_IS_ListinoArt(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_LISTINOART")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO IS_LISTINOART(CODICE,CODLISTINO,DESCRIZIONE) VALUES ('" _
			 & Lista.Get("CODICE") & "','" & Lista.Get("CODLISTINO") & "','" & Lista.Get("DESCRIZIONE") & "')"			
			' Log ("IS_BARCODE -> " & sqlstr)					 
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "ListinoArt")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_LISTINOART vuota","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		MsgboxAsync("Errore tabella IS_LISTINOART " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_IS_VistaPuntiVenditaPalmare(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTAPUNTIVENDITAPALMARE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO IS_VISTAPUNTIVENDITAPALMARE(PALMARE,CODDEPOSITO) VALUES ('" _
			 & Lista.Get("PALMARE") & "','" & Lista.Get("CODDEPOSITO") & "')"			
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_VISTAPUNTIVENDITAPALMARE")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VISTAPUNTIVENDITAPALMARE vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		MsgboxAsync("Errore tabella IS_VISTAPUNTIVENDITAPALMARE " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Vista_Disponibilita_Corsia(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_DISPONIBILITA_CORSIA")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_DISPONIBILITA_CORSIA(CODART,CODDEPOSITO,CODUBICAZIONE,FLAG_UBICAZIONICORSIA,NRIFPARTITA,GIACENZA1,UM1,LOTTO,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA) " _
			& "VALUES ('" & Lista.Get("CODART") & "','" & Lista.Get("CODDEPOSITO") & "','"  & Lista.Get("CODUBICAZIONE") & "','"  & Lista.Get("FLAG_UBICAZIONICORSIA") _
			& "','"  & Lista.Get("NRIFPARTITA") & "','"  & Lista.Get("GIACENZA1") & "','"  & Lista.Get("UM1") & "','"  & Lista.Get("LOTTO") _ 
			& "','"  & Lista.Get("GIACENZA2") & "','"  & Lista.Get("UM2") &  "','" & Lista.Get("GIACENZAPESO") & "','" & Lista.Get("GIACENZAPESOTEORICO") & "','" & Lista.Get("FLAG_BILANCIA") & "')"
			SQLData.ExecNonQuery(sqlstr)
'			 Log (sqlstr)
'			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_DISPONIBILITA_CORSIA")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
'			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		Return True
	Catch
		MsgboxAsync("Errore tabella VISTA_DISPONIBILITA_CORSIA " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_RighedocumentiGiro_Server(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int, idtesta As Int, corsia As String, esercizio As Int, numerodoc As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_RIGHEDOCUMENTI_GIRO WHERE rifidtesta=" & idtesta & " AND Corsia='" & corsia & "'")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		SQLData.ExecNonQuery("DELETE FROM IS_RIGHEDOCUMENTI WHERE rifidtesta=" & idtesta & " AND Corsia='" & corsia & "'")
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			
			sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI_GIRO ([TipoDoc],[RifIdTesta],[RifIdRiga],[Pos],[Corsia],[CodCliFor],[Ubicazione],[TipoRiga],[Codart]," _
			& "[Descrizione],[Ordinato],[UM1],[Acq_UM1],[UM2],[Acq_UM2],[UM3],[Acq_UM3],[Ordinamento],[QtaTotUMBase],[UMBase],[Partita1],[QtaP1],[Partita2]," _
			& "[QtaP2],[Partita3],[QtaP3],[StatoRiga],[UtenteModifica],[DataModifica],[DispUMBase],[PesoReale]) VALUES " _
			& "('" & Lista.Get("TipoDoc") & "'," & Lista.Get("RifIdTesta") & ","  & Lista.Get("RifIdriga") & ","  & Lista.Get("Pos") & ",'" & Lista.Get("Corsia")  _
			& "','"  & Lista.Get("CodCliFor") & "','"  & Lista.Get("Ubicazione") & "','"  & Lista.Get("TipoRiga") & "','"  & Lista.Get("Codart") & "','" & Lista.Get("Descrizione") _ 
			& "','"  & Lista.Get("Ordinato") & "','"  & Lista.Get("UM1") &  "','" & Lista.Get("Acq_UM1") & "','" & Lista.Get("UM2") & "','" & Lista.Get("Acq_UM2") _
			& "','"  & Lista.Get("UM3") & "'," & Lista.Get("Acq_UM3") & "," & Lista.Get("Ordinamento") & "," & Lista.Get("QtaTotUMBase") & ",'" & Lista.Get("UMBase") _
			& "','"  & Lista.Get("Partita1") & "',"  & Lista.Get("QtaP1") & ",'"  & Lista.Get("Partita2") & "',"  & Lista.Get("QtaP2") & ",'"  & Lista.Get("Partita3") _
			& "',"  & Lista.Get("QtaP3") & ",'"  & Lista.Get("StatoRiga") & "','"  & Lista.Get("UtenteModifica") &  "','" & Lista.Get("DataModifica") & "',0," _
			&  Lista.Get("PesoReale") & ")"
			SQLData.ExecNonQuery(sqlstr)
			' Log (sqlstr)
			
			Copia_Righedocumenti_Giro(SQLData,esercizio, numerodoc,idtesta , corsia)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_RIGHEDOCUMENTI_GIRO")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		Return True
	Catch
		MsgboxAsync("Errore tabella IS_RIGHEDOCUMENTI_GIRO " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Private Sub Copia_Righedocumenti_Giro(SQLData As SQL, esercizio As Int, numerodoc As Int, idtesta As Int, corsia As String)
	sqlstr = "DELETE FROM IS_RIGHEDOCUMENTI WHERE RifIdTesta = " & idtesta & " AND CORSIA = '" & corsia & "'"
	SQLData.ExecNonQuery(sqlstr)
	sqlstr = "INSERT INTO IS_RIGHEDOCUMENTI(TipoDoc,Esercizio,Numerodoc,idriga,UtenteModifica,CodArt,Qta,UM,PrzUnit,Sconto,Note,DataConsegna,Magazzino,MagazzinoColl,RifTipoDoc,RifNumerodoc," _
	& "RifEsercizio, RifIdriga, VARIAMISURE, RIFCLIENTE, Descrizione, rifidtesta, TipoRiga, NumRifDoc, DataRifDoc, DataScadenza, NrRifPartita, UM2, Qta2, Peso, NumEtichette, Status," _
	& "Ordinato,um3,QtaTotUMAConv, QtaTotUM2, CoeffConvUMA, Ubicazione, UbicazioneColl, Priorita, Flag_SvuotaCella, TipoReadGiac,Partita1,Partita2,Partita3, QP1, QP2, QP3, Corsia," _
	& "Ordinamento, QtaTotUMBase, UMBase, CodClifor, Qta3, QtaTotUMBaseDisp)" _
	& "SELECT TipoDoc," & esercizio & " As Esercizio," & numerodoc & " As numerodoc,rifidriga,UtenteModifica,Codart,Acq_UM1 As Qta, UM1 As UM, 0 As PrzUnit, '' as Sconto, '' as Note, '' as DataConsegna," _
	& "'' as Magazzino, '' as MagazzinoColl, '' as RifTipoDoc, 0 as RifNumerodoc, 0 as RifEsercizio, RifIdriga, '' as VARIAMISURE, '' as RIFCLIENTE, Descrizione," _
	& "rifidtesta, TipoRiga, 0 As NumRifDoc, '' as DataRifDoc, '' as DataScadenza, '' as NrRifPartita, UM2, Acq_UM2 as Qta2, Acq_UM3 as Peso, 0 as NumEtichette, StatoRiga as Status," _
	& "Ordinato, UM3, 0 As QtaTotUMAConv, 0 As QtaTotUM2, 1 As CoeffConvUMA, Ubicazione, '' as UbicazioneColl, 0 as Priorita, '' Flag_SvuotaCella, '' as TipoReadGiac," _
	& "Partita1, Partita2, Partita3, QtaP1, QtaP2, QtaP3, Corsia, Ordinamento, QtaTotUMBase, UMBase, CodClifor, 0 As Qta3, 0 As QtaTotUMBaseDisp FROM IS_RIGHEDOCUMENTI_GIRO WHERE " _
	& "RifIdTesta = " & idtesta & " AND CORSIA = '" & corsia & "'"
	Log(sqlstr)
	SQLData.ExecNonQuery(sqlstr)
End Sub

Sub Leggi_Vista_Disponibilita_Articolo(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_DISPONIBILITA_ARTICOLO")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_DISPONIBILITA_ARTICOLO(CODART,CODDEPOSITO,CODUBICAZIONE,FLAG_UBICAZIONICORSIA,NRIFPARTITA,GIACENZA1,UM1,LOTTO,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA) " _
			& "VALUES ('" & Lista.Get("CODART") & "','" & Lista.Get("CODDEPOSITO") & "','"  & Lista.Get("CODUBICAZIONE") & "','"  & Lista.Get("FLAG_UBICAZIONICORSIA") _
			& "','"  & Lista.Get("NRIFPARTITA") & "','"  & Lista.Get("GIACENZA1") & "','"  & Lista.Get("UM1") & "','"  & Lista.Get("LOTTO") _ 
			& "','"  & Lista.Get("GIACENZA2") & "','"  & Lista.Get("UM2") &  "','" & Lista.Get("GIACENZAPESO") & "','" & Lista.Get("GIACENZAPESOTEORICO") & "','" & Lista.Get("FLAG_BILANCIA") & "')"
			SQLData.ExecNonQuery(sqlstr)
'			 Log (sqlstr)
'			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_DISPONIBILITA_ARTICOLO")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
'			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		Return True
	Catch
		MsgboxAsync("Errore tabella VISTA_DISPONIBILITA_ARTICOLO " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Vista_Giacenze_Corsia(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_GIACENZA_CORSIA")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_GIACENZA_CORSIA(CODART,CODDEPOSITO,CODUBICAZIONE,FLAG_UBICAZIONICORSIA,NRIFPARTITA,GIACENZA1,UM1,LOTTO,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA) " _
			& "VALUES ('" & Lista.Get("CODART") & "','" & Lista.Get("CODDEPOSITO") & "','"  & Lista.Get("CODUBICAZIONE") & "','"  & Lista.Get("FLAG_UBICAZIONICORSIA") & "','"  & Lista.Get("NRIFPARTITA") _
			& "','"  & Lista.Get("GIACENZA1") & "','"  & Lista.Get("UM1") & "','"  & Lista.Get("LOTTO") & "','"  & Lista.Get("GIACENZA2") & "','"  & Lista.Get("UM2") &  "','" _
			& Lista.Get("GIACENZAPESO") & "','" & Lista.Get("GIACENZAPESOTEORICO") & "','" & Lista.Get("FLAG_BILANCIA") & "')"
			SQLData.ExecNonQuery(sqlstr)
'			 Log (sqlstr)
'			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_GIACENZA_CORSIA")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
'			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		Return True
	Catch
		MsgboxAsync("Errore tabella VISTA_GIACENZA_CORSIA " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Vista_Giacenze_Articolo(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_GIACENZA_ARTICOLO")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_GIACENZA_ARTICOLO(CODART,CODDEPOSITO,CODUBICAZIONE,FLAG_UBICAZIONICORSIA,NRIFPARTITA,GIACENZA1,UM1,LOTTO,GIACENZA2,UM2,GIACENZAPESO,GIACENZAPESOTEORICO,FLAG_BILANCIA) " _
			& "VALUES ('" & Lista.Get("CODART") & "','" & Lista.Get("CODDEPOSITO") & "','"  & Lista.Get("CODUBICAZIONE") & "','"  & Lista.Get("FLAG_UBICAZIONICORSIA") _
			& "','"  & Lista.Get("NRIFPARTITA") & "','"  & Lista.Get("GIACENZA1") & "','"  & Lista.Get("UM1") & "','"  & Lista.Get("LOTTO") _ 
			& "','"  & Lista.Get("GIACENZA2") & "','"  & Lista.Get("UM2") &  "','" & Lista.Get("GIACENZAPESO") & "','" & Lista.Get("GIACENZAPESOTEORICO") & "','" & Lista.Get("FLAG_BILANCIA") & "')"
			SQLData.ExecNonQuery(sqlstr)
'			 Log (sqlstr)
'			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_GIACENZA_ARTICOLO")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
'			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		'show the report
		'If res.Size = 0 Then
		'	MsgboxAsync("Tabella VISTA_GIACENZA_ARTICOLO vuota!","Errore")
		'End If
		Return True
	Catch
		MsgboxAsync("Errore tabella VISTA_GIACENZA_ARTICOLO " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Vista_Giacenze(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTA_GIACENZA")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If		
		Sleep(0)
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTA_GIACENZA(CODART,CODDEPOSITO,CODUBICAZIONE,FLAG_UBICAZIONICORSIA,NRIFPARTITA,GIACENZA1,UM1,LOTTO,GIACENZA2,UM2,GIACENZAPESO,FLAG_BILANCIA) " _
			& "VALUES ('" & Lista.Get("CODART") & "','" & Lista.Get("CODDEPOSITO") & "','"  & Lista.Get("CODUBICAZIONE") & "','"  & Lista.Get("FLAG_UBICAZIONICORSIA") _
			& "','"  & Lista.Get("NRIFPARTITA") & "','"  & Lista.Get("GIACENZA1") & "','"  & Lista.Get("UM1") & "','"  & Lista.Get("LOTTO") _ 
			& "','"  & Lista.Get("GIACENZA2") & "','"  & Lista.Get("UM2") &  "','" & Lista.Get("GIACENZAPESO") & "','" & Lista.Get("FLAG_BILANCIA") & "')"
			SQLData.ExecNonQuery(sqlstr)
'			 Log (sqlstr)
'			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTA_GIACENZA")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
'			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		SQLData.EndTransaction
		#IF DEBUG
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella VISTA_GIACENZA vuota!","Errore")
		End If
		Return True
	Catch
		MsgboxAsync("Errore tabella VISTA_GIACENZA " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_VistaGiacenzePalmare(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM VISTAGIACENZAPERPALMARE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
			Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		SQLData.BeginTransaction		
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO VISTAGIACENZAPERPALMARE(GIACENZA,CODART,CODDEPOSITO) VALUES ('" _
			 & Lista.Get("GIACENZA") & "','" & Lista.Get("CODART") & "','"  & Lista.Get("CODDEPOSITO") & "')"			
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VISTAGIACENZAPERPALMARE")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		#IF DEBUG
			Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella VISTAGIACENZAPERPALMARE vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch				
		MsgboxAsync("Errore tabella VISTAGIACENZAPERPALMARE " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_Is_Vista_DocPalm(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int)	As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTADOCPALM")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		#IF DEBUG
			Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		SQLData.BeginTransaction		
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			Dim DescArt As String = Lista.Get("DESCRIZIONEART")
			DescArt = DescArt.Replace("'","")
			Dim RagSoc As String = Lista.Get("DSCCONTO1")
			RagSoc = RagSoc.Replace("'","")
			sqlstr ="INSERT INTO IS_VISTADOCPALM (IDTESTA,ESERCIZIO,TIPODOC,NUMERODOC,BIS," _
			 & "DATADOC,DOCCHIUSO,BLOCCATO,CODCLIFOR,NUMRIFDOC,DATARIFDOC,CODCFFATT,TIPOPAR,IDRIGA,POSIZIONE,TIPORIGA,RIGACHIUSA,RIGABLOCCATA,CODART,DESCRIZIONEART," _
			 & "DATACONSEGNA,NUMLISTINO,UMGEST,SCONTORIGA,SCONTIESTESI,NRRIFPARTITA,PREZZOUNITNETTOEURO,PREZZOUNITLORDOEURO,QTAGEST,QTAGESTRES," _
			 & "QTAPREZZO,QTAPREZZORES,QTAGESTPRELEVATA,DSCCONTO1,UMV,UMP,UMA,QTAEVASAP,NUMEROETICHETTE,FLAG_BILANCIA,UM2,CORSIA,UBICAZIONE,ORDINAMENTO) VALUES ('" _
			 & Lista.Get("IDTESTA") & "','" & Lista.Get("ESERCIZIO") & "','"  & Lista.Get("TIPODOC") & "','"  & Lista.Get("NUMERODOC") & "','"  & Lista.Get("BIS") & "','" _
			 & Lista.Get("DATADOCUM") & "','" & Lista.Get("DOCCHIUSO") & "','" & Lista.Get("BLOCCATO") & "','" & Lista.Get("CODCLIFOR") & "','" & Lista.Get("NUMRIFDOC") & "','" _
			 & Lista.Get("DATARIFDOCUM") & "','" & Lista.Get("CODCFFATT") & "','" & Lista.Get("TIPOPAR") & "','" & Lista.Get("IDRIGA") & "','" & Lista.Get("POSIZIONE") & "','" _
			 & Lista.Get("TIPORIGA") & "','" & Lista.Get("RIGACHIUSA") & "','" & Lista.Get("RIGABLOCCATA") & "','" & Lista.Get("CODART") & "','" & DescArt & "','" _
			 & Lista.Get("DATACONSEGNAUM") & "','" & Lista.Get("NUMLISTINO") & "','" & Lista.Get("UMGEST") & "','" & Lista.Get("SCONTORIGA") & "','" & Lista.Get("SCONTIESTESI") & "','" _
			 & Lista.Get("NRRIFPARTITA") & "','" & Lista.Get("PREZZOUNITNETTOEURO") & "','" & Lista.Get("PREZZOUNITLORDOEURO") & "','" & Lista.Get("QTAGEST") & "','" & Lista.Get("QTAGESTRES") & "','" _
			 & Lista.Get("QTAPREZZO") & "','" & Lista.Get("QTAPREZZORES") & "','" & Lista.Get("QTAGESTPREELEVATA") & "','" & RagSoc & "','" & Lista.Get("UMV") & "','" _
			 & Lista.Get("UMP") & "','" & Lista.Get("UMA") & "','" & Lista.Get("QTAEVASAP") & "','" &  Lista.Get("NumeroEtichette") & "','" & Lista.Get("flag_bilancia") & "','" _
			 & Lista.Get("UM2") & "','" & Lista.Get("CORSIA") & "','" & Lista.Get("UBICAZIONE") & "','" & Lista.Get("ORDINAMENTO") & "')"
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "IS_VISTADOCPALM")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		#IF DEBUG
			Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		#End If
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VISTADOCPALM vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch				
		MsgboxAsync("Errore tabella IS_VISTADOCPALM " & LastException.Message,"Errore")
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_RigheDocPartite(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_RIGHEDOCPARTITE")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			Dim vDESCRIZIONE As String = Lista.Get("DESCRIZIONE")
			vDESCRIZIONE = vDESCRIZIONE.Replace("'",Chr(0x00B4))			' accento dritto sostituito con accento acuto formato Unicode 00B4
			Dim vNUMRIFDOC As String = Lista.Get("NUMRIFDOC")
			vNUMRIFDOC = vNUMRIFDOC.Replace("'",Chr(0x00B4))			' accento dritto sostituito con accento acuto formato Unicode 00B4
			k = k + 1			
			sqlstr ="INSERT INTO IS_RIGHEDOCPARTITE(IDTESTA,IDRIGA,QTAGEST,CODART,PARTITA,TIPODOC,NUMERODOC,ESERCIZIO,DATADOC,NUMRIFDOC," _
			& "RIFERIMENTI,DESCRIZIONE,VERDIBA,PESOORO,CARATI,FLAG_VISPALM) VALUES ('" & Lista.Get("IDTESTA") & "','" & Lista.Get("IDRIGA") & "','" _
			& Lista.Get("QTAGEST") & "','" & Lista.Get("CODART") & "','" & Lista.Get("PARTITA") & "','" _
			& Lista.Get("TIPODOC") & "','" & Lista.Get("NUMERODOC") & "','" & Lista.Get("ESERCIZIO") & "','" & Lista.Get("DATADOC") & "','" _
			& vNUMRIFDOC & "','" & Lista.Get("RIFERIMENTI") & "','" & vDESCRIZIONE & "','" & Lista.Get("VERDIBA") & "','" _
			& Lista.Get("PESOORO") & "','" & Lista.Get("CARATI") & "','" & Lista.Get("FLAG_VISPALM") & "')"
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "RIGHEDOCPARTITE")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_DOCPARTITE vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_TabCambi(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_TABCAMBI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value
			k = k + 1
			sqlstr ="INSERT INTO IS_TABCAMBI(CODICE,DIVISA,DESCRIZIONE) VALUES ('" _
			 & Lista.Get("CODICE") & "','" & Lista.Get("DIVISA") & "','" & Lista.Get("DESCRIZIONE") & "')"								 
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "TabCambi")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_TABCAMBI vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_AnagraficaCF(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		
		SQLData.ExecNonQuery("DELETE FROM " & Main.PrefixSQL & "_ANAGRAFICACF")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value						
			' vDSCCONTO1 = vDSCCONTO1.Replace("'",Chr(0x00B4))			' accento dritto sostituito con accento acuto formato Unicode 00B4
			k = k + 1			
			Select Case Main.Ditta
				Case "Trendy"
					SQLData.ExecNonQuery2("INSERT INTO GS_ANAGRAFICACF (CODICE,RAGSOC,LOCALITA,TIPOCLIFOR) VALUES (?,?,?,?)", _
			 		Array As Object(Lista.Get("CODICE"),Lista.Get("RAGSOC"),Lista.Get("LOCALITA"),Lista.Get("TIPOCLIFOR")))			
					
				Case "Florenzi"
					SQLData.ExecNonQuery2("INSERT INTO GS_ANAGRAFICACF (CODICE,RAGSOC,LOCALITA,TIPOCLIFOR) VALUES (?,?,?,?)", _
			 		Array As Object(Lista.Get("CODICE"),Lista.Get("RAGSOC"),Lista.Get("LOCALITA"),Lista.Get("TIPOCLIFOR")))											
		
				Case "Kuore"
					SQLData.ExecNonQuery2("INSERT INTO IS_ANAGRAFICACF (CODCLIFOR,DSCCONTO1,LOCALITA,TIPOCLIFOR) VALUES (?,?,?,?)", _
			 		Array As Object(Lista.Get("CODCLIFOR"),Lista.Get("DSCCONTO1"),Lista.Get("LOCALITA"),Lista.Get("TIPOCLIFOR")))		
							
				Case "Nesti"
					SQLData.ExecNonQuery2("INSERT INTO IS_ANAGRAFICACF (CODCLIFOR,DSCCONTO1,SCONTO,CODCAMBIO,MAGAZZINO,CODAGENTE1,NOTE,FAX,TELEFONO,LISTINO,TIPOCONTO,LOCALITA,Visibile,utente,TipoDoc) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", _
			 		Array As Object(Lista.Get("CODCLIFOR"),Lista.Get("DSCCONTO1"),Lista.Get("SCONTO"),Lista.Get("CODCAMBIO"),Lista.Get("MAGAZZINO"),Lista.Get("CODAGENTE1"),Lista.Get("NOTE"),Lista.Get("FAX"),Lista.Get("TELEFONO"), _
					Lista.Get("LISTINO"),Lista.Get("TIPOCONTO"),Lista.Get("LOCALITA"),Lista.Get("VISIBILE"),Lista.Get("UTENTE"),Lista.Get("TipoDoc")))											
					
				Case Else
					SQLData.ExecNonQuery2("INSERT INTO IS_ANAGRAFICACF (CODCLIFOR,DSCCONTO1,SCONTO,CODCAMBIO,MAGAZZINO,CODAGENTE1,NOTE,FAX,TELEFONO,LISTINO,TIPOCONTO,LOCALITA,Visibile,utente) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", _
			 		Array As Object(Lista.Get("CODCLIFOR"),Lista.Get("DSCCONTO1"),Lista.Get("SCONTO"),Lista.Get("CODCAMBIO"),Lista.Get("MAGAZZINO"),Lista.Get("CODAGENTE1"),Lista.Get("NOTE"),Lista.Get("FAX"),Lista.Get("TELEFONO"), _
					Lista.Get("LISTINO"),Lista.Get("TIPOCONTO"),Lista.Get("LOCALITA"),Lista.Get("VISIBILE"),Lista.Get("UTENTE")))						
					
			End Select
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "AnagraficaCF")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_Anagraficacf vuota!","Errore")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub DisplayTermoDelay (NumTable As Int, PassoTable As Int, k As Int, NRecs As Int, tablename As String) As Int
	Try
		Dim Passo As Int = NRecs/PassoTable
		If(Passo=0) Then
			Passo = 1
		End If
		If ((k Mod Passo)=0) Then
			Dim TermoStep As Int = 0
			If(NRecs<>0) Then
				TermoStep = K * (PassoTable/NRecs)
				Dim TermoX As Int = (PassoTable*NumTable) + TermoStep
				Log("Inseriti " & tablename  & " - " & k & " - TermoX " & TermoX)				
				Return TermoX
			Else
				Return 0	
			End If
		Else
			Return 0
		End If		
	Catch
		Log(LastException.Message) 'no changes will be made
		Return 0
	End Try
End Sub

Sub Leggi_VistaDocumenti(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		SQLData.ExecNonQuery("DELETE FROM IS_VISTADOCUMENTI")
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		SQLData.BeginTransaction
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value			
			Dim vRAGSOC As String = Lista.Get("RAGSOC")
			vRAGSOC = vRAGSOC.Replace("'",Chr(0x00B4))		' accento dritto sostituito con accento acuto formato Unicode 00B4
			Dim vDESCART As String = Lista.Get("DESCRIZIONEART")
			vDESCART = vDESCART.Replace("'",Chr(0x00B4))	' accento dritto sostituito con accento acuto formato Unicode 00B4
			Dim vDESCAGG As String = Lista.Get("DESCRIZIONEAGG")
			vDESCAGG = vDESCAGG.Replace("'",Chr(0x00B4))	' accento dritto sostituito con accento acuto formato Unicode 00B4
			k = k + 1					
			sqlstr = "INSERT INTO IS_VISTADOCUMENTI (ESERCIZIO,TIPODOC,NUMERODOC,BIS,DATADOC,DATACONSEGNA,CODCLIFOR,CODZONA,IDRIGA,POSIZIONE," _
			 & "CODART,DESCRIZIONEART,MAGAZZINO,UM,PREZZOUNITNETTOEURO,PREZZOUNITLORDOEURO,VARIAMISURE,RIFCLIENTE,TOTDOCUMENTOEURO,QTA,RAGSOC," _
			 & "TOTALEQUANTITA,DESCRIZIONEAGG) " _
			 & " VALUES ('" & Lista.Get("ESERCIZIO") & "','" & Lista.Get("TIPODOC") & "','" & Lista.Get("NUMERODOC") & "','" & Lista.Get("BIS") & "','" _
			 & Lista.Get("DATADOC") & "','" & Lista.Get("DATACONSEGNA") & "','" & Lista.Get("CODCLIFOR") & "','" & Lista.Get("CODZONA") & "','" _
			 & Lista.Get("IDRIGA") & "','" & Lista.Get("POSIZIONE") & "','" & Lista.Get("CODART") & "','" & vDESCART & "','" _
			 & Lista.Get("MAGAZZINO") & "','" & Lista.Get("UM") & "','" & Lista.Get("PREZZOUNITNETTOEURO") & "','" & Lista.Get("PREZZOUNITLORDOEURO") & "','" _
			 & Lista.Get("VARIAMISURE") & "','" & Lista.Get("RIFCLIENTE") & "','" &  Lista.Get("TOTDOCUMENTOEURO") & "','" _
			 & Lista.Get("QTA") & "','" & vRAGSOC & "','" & Lista.Get("TOTALEQUANTITA") & "','" & vDESCAGG & "')"
			SQLData.ExecNonQuery(sqlstr)
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "VistaDocumenti")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			MsgboxAsync("Tabella IS_VistaDocumenti vuota!","Errore")
			Log("nessun record trovato per vistadocumenti")
		End If
		SQLData.EndTransaction
		Return True
	Catch
		MsgboxAsync("Errore: " & LastException.Message,"ERRORE IS_VISTADOCUMENTI") 'no changes will be made
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub

Sub Leggi_AnagraficaArticoli(jobResult As String, SQLData As SQL, NumTable As Int, PassoTable As Int) As ResumableSub
	Try
		Select Case Main.Ditta
			Case "Florenzi"
				SQLData.ExecNonQuery("DELETE FROM GS_ARTICOLI")
			Case "Trendy"
				SQLData.ExecNonQuery("DELETE FROM GS_ARTICOLI")
			Case Else
				SQLData.ExecNonQuery("DELETE FROM IS_ANAGRAFICAARTICOLI")
		End Select				
		Dim res As Map = DBPhp.Json2Map(jobResult)
		Dim k As Int = 0
		Log($"Start Current time is $time{DateTime.Now}  Records ${res.size}"$) 'Current time is 11:17:45		
		SQLData.BeginTransaction				
		For Each Key As String In res.Keys
			Dim Value As Object = res.Get(Key)
			Dim Lista As Map = Value			
			Dim vDESCRIZIONE As String = Lista.Get("DESCRIZIONE")			
			vDESCRIZIONE = vDESCRIZIONE.Replace("'",Chr(0x00B4))			' accento dritto sostituito con accento acuto formato Unicode 00B4			
			k = k + 1
			Select Case Main.Ditta
				Case "ZelariVi"
					sqlstr = "INSERT INTO IS_ANAGRAFICAARTICOLI (CODICE,DESCRIZIONE,PREZZORIF,ARTTIPOLOGIA,CODICEARTIMBALLO,UM," _
					& "codiceprimario,BARCODE,GIACENZA,GRUPPO,CATEGORIA,CODCATEGORIASTAT,SOTTOSCORTA) VALUES ('" _
					&  Lista.Get("CODICE") & "','" & vDESCRIZIONE & "','" & Lista.Get("PREZZORIF") & "','" & Lista.Get("ARTTIPOLOGIA") & "','" _
					&  Lista.Get("CODICEARTIMBALLO") & "','" & Lista.Get("UM") & "','" & Lista.Get("codiceprimario") & "','" & Lista.Get("BARCODE") & "','" _
					&  Lista.Get("GIACENZA") & "','" & Lista.Get("GRUPPO") & "','" & Lista.Get("CATEGORIA") & "','" & Lista.Get("CODCATEGORIASTAT") & "','" _
					&  Lista.Get("SOTTOSCORTA") & "')"
					
				Case "Kuore"
					sqlstr = "INSERT INTO IS_ANAGRAFICAARTICOLI (CODART,PARTITA,BARCODE,DESCRIZIONE,VERDIBA,PESOORO,CARATI,FLAGCOPPIE) VALUES ('" _
					&  Lista.Get("CODART") & "','" & Lista.Get("PARTITA") & "','"  & Lista.Get("BARCODE") & "','" & Lista.Get("DESCRIZIONE") _
					& "','" & Lista.Get("VERDIBA") & "','" &  Lista.Get("PESOORO") & "','" & Lista.Get("CARATI") & "','" &  Lista.Get("FLAGCOPPIE") & "')"

				Case "Florenzi"
					sqlstr = "INSERT INTO GS_ARTICOLI (BARCODE,CODART,DESCRIZIONE,MAGAZZINO) VALUES ('" _
					&  Lista.Get("BARCODE") & "','" & Lista.Get("CODART") & "','" & vDESCRIZIONE & "','" & Lista.Get("MAGAZZINO") & "')"
													
				Case "Trendy"
					Dim DesCat1 As String = Lista.Get("DESCCAT1")
					DesCat1 = DesCat1.Replace("'",Chr(0x00B4))
					Dim DesCat2 As String = Lista.Get("DESCCAT2")
					DesCat2 = DesCat2.Replace("'",Chr(0x00B4))
					Dim DesCat3 As String = Lista.Get("DESCCAT3")
					DesCat3 = DesCat3.Replace("'",Chr(0x00B4))
					Dim DesMarchio As String = Lista.Get("DESCMARCHIO")
					DesMarchio = DesMarchio.Replace("'",Chr(0x00B4))
					sqlstr = "INSERT INTO GS_ARTICOLI (BARCODE,CODART,DESCRIZIONE,CODCAT1,DESCCAT1,CODCAT2,DESCCAT2,CODCAT3,DESCCAT3," _
					& "CODMARCHIO,DESCMARCHIO,TIPOMATERIALE,DESCMATERIALE,PESO,PREZZOLISTINO,ARTICOLOAQTA,STATO,CODNEGOZIO,CODCLIENTE," _
					& "NUMFILIALE,NUMDOC,DATADOC,TIPODOC,DUPLICATO) VALUES ('" _
					&  Lista.Get("BARCODE") & "','" & Lista.Get("CODART") & "','" & vDESCRIZIONE & "','" & Lista.Get("CODCAT1") & "','" & DesCat1 & "','" _
					&  Lista.Get("CODCAT2") & "','" & DesCat2 & "','" & Lista.Get("CODCAT3")   & "','" & DesCat3 & "','"  _
					&  Lista.Get("CODMARCHIO") & "','" & DesMarchio & "','" & Lista.Get("TIPOMATERIALE") & "','" & Lista.Get("DESCMATERIALE") & "','" _
					&  Lista.Get("PESO") & "','" & Lista.Get("PREZZOLISTINO") & "','" & Lista.Get("ARTICOLOAQTA") & "','" & Lista.Get("STATO") & "','" _ 					
					&  Lista.Get("CODNEGOZIO") & "','" & Lista.Get("CODCLIENTE") & "','" & Lista.Get("NUMFILIALE") & "','" & Lista.Get("NUMDOC") & "','" _
					&  Lista.Get("DATADOC") & "','" & Lista.Get("TIPODOC") & "','" & Lista.get("DUPLICATO") & "')"
					
				Case "Esseci"
					sqlstr = "INSERT INTO IS_ANAGRAFICAARTICOLI (CODICE,DESCRIZIONE,PREZZORIF,ARTTIPOLOGIA,CODICEARTIMBALLO,UM," _
					& "codiceprimario,BARCODE,GIACENZA,GRUPPO,CATEGORIA,CODCATEGORIASTAT,SOTTOSCORTA,UMV,UMA) VALUES ('" _
					&  Lista.Get("CODICE") & "','" & vDESCRIZIONE & "','" & Lista.Get("PREZZORIF") & "','" & Lista.Get("ARTTIPOLOGIA") & "','" _
					&  Lista.Get("CODICEARTIMBALLO") & "','" & Lista.Get("UM") & "','" & Lista.Get("codiceprimario") & "','" & Lista.Get("BARCODE") & "','" _
					&  Lista.Get("GIACENZA") & "','" & Lista.Get("GRUPPO") & "','" & Lista.Get("CATEGORIA") & "','" & Lista.Get("CODCATEGORIASTAT") & "','" _
					&  Lista.Get("SOTTOSCORTA") & "','" & Lista.Get("UMV") & "','" & Lista.Get("UMA") & "')" 
					
				Case "Nesti"					
					sqlstr = "INSERT INTO IS_ANAGRAFICAARTICOLI (CODICE,DESCRIZIONE,PREZZORIF,ARTTIPOLOGIA,CODICEARTIMBALLO,UM,codiceprimario," _
					& "BARCODE,GIACENZA,GRUPPO,CATEGORIA,CODCATEGORIASTAT,SOTTOSCORTA,UMV,UMA,ESAURITO,CORSIA,UBICAZIONE,FLAG_BILANCIA,ORDINAMENTO) VALUES ('" _
					&  Lista.Get("CODICE") & "','" & vDESCRIZIONE & "','" & Lista.Get("PREZZORIF") & "','" & Lista.Get("ARTTIPOLOGIA") & "','" _
					&  Lista.Get("CODICEARTIMBALLO") & "','" & Lista.Get("UM") & "','" & Lista.Get("codiceprimario") & "','" & Lista.Get("BARCODE") & "','" _
					&  Lista.Get("GIACENZA") & "','" & Lista.Get("GRUPPO") & "','" & Lista.Get("CATEGORIA") & "','" & Lista.Get("CODCATEGORIASTAT") & "','" _
					&  Lista.Get("SOTTOSCORTA") & "','" & Lista.Get("UMV") & "','" & Lista.Get("UMA") & "','" & Lista.Get("ESAURITO") & "','" _
					&  Lista.Get("CORSIA") & "','" & Lista.Get("UBICAZIONE") & "','" & Lista.Get("FLAG_BILANCIA") & "'," & Lista.Get("ORDINAMENTO") & ")" 
			Case Else
					MsgboxAsync("Nome ditta '" & Main.Ditta & "' non corretta!", "ERRORE DITTA")
									
			End Select
			SQLData.ExecNonQuery(sqlstr)		
			' ---------------------------------- DISPLAY TERMO ----------------------------------------------
			TermoVal = DisplayTermoDelay(NumTable, PassoTable, k, res.Size, "AnagraficaArticoli")
			If (TermoVal>0) Then
				Sleep(0)
				CallSub2(Choose_Menu, "DisplayTermo", TermoVal)				
			End If
			' ------------------------------------------------------------------------------------------------
		Next
		SQLData.TransactionSuccessful
		Log($"End Current time is $time{DateTime.Now}"$) 'Current time is 11:17:45
		'show the report
		If res.Size = 0 Then
			Select Case Main.Ditta
				Case "Florenzi"
					MsgboxAsync("Tabella " & Main.PrefixSQL & "_ARTICOLI vuota","Errore")
				Case "Trendy"
					MsgboxAsync("Tabella " & Main.PrefixSQL & "_ARTICOLI vuota","Errore")
				Case Else
					MsgboxAsync("Tabella " & Main.PrefixSQL & "_ANAGRAFICAARTICOLI vuota","Errore")
			End Select
		End If
		SQLData.EndTransaction
		Return True
	Catch
		Select Case Main.Ditta
			Case "Florenzi"
				MsgboxAsync("Errore tabella " & Main.PrefixSQL & "_ARTICOLI " & LastException.Message,"Errore")
			Case "Trendy" 
				MsgboxAsync("Errore tabella " & Main.PrefixSQL & "_ARTICOLI " & LastException.Message,"Errore")
			Case Else
				MsgboxAsync("Errore tabella " & Main.PrefixSQL & "_ANAGRAFICAARTICOLI " & LastException.Message,"Errore")
		End Select	
		Log(LastException.Message) 'no changes will be made
		Return False
	End Try
End Sub
