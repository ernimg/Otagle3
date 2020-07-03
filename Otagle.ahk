#NoEnv
#SingleInstance, Force
SetBatchLines, -1
#Include ../../Neutron.ahk
#Include GuiGenerator.ahk
; CreateHtml()
neutron := new NeutronWindow()
neutron.Load("Layer1_Strona_glowna.html")

neutron.Gui("+LabelNeutron")
neutron.Show("w1024 h768")
return
FileInstall, Otagle.html, Otagle.html



;------------------------------------------------------Triger function------------------------------------------------------
handler_btn(neutron, event,id){
     
     If (id = "Word"){
           RunWord()
           MsgBox,Uruchomiony program to:  ,%id% 
     }
     Else if (id = "TotalComander"){
          RunTC()
          MsgBox,Uruchomiony program to:  ,%id% 
     }
}

MsgText(string)
{
    vSize := StrPut(string, "CP0")
    VarSetCapacity(vUtf8, vSize)
    vSize := StrPut(string, &vUtf8, vSize, "CP0")
    Return StrGet(&vUtf8, "UTF-8") 
}
RunWord()
{
	
	IfWinExist, ahk_class OpusApp
	{
		IfWinNotActive, ahk_class OpusApp
			WinActivate, ahk_class OpusApp
	}
	else
	{
		run, winword.exe
	}
}
RunTC()
{
	IfWinExist, ahk_class TTOTAL_CMD
	{
		IfWinNotActive, ahk_class TTOTAL_CMD
			WinActivate, ahk_class TTOTAL_CMD
	}
	else
	{
		run, C:\totalcmd\TOTALCMD64.EXE
	}
}

