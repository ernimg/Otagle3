#NoEnv
#SingleInstance, Force
SetBatchLines, -1
#Include ../../Neutron.ahk

neutron := new NeutronWindow()
neutron.Load("Otagle.html")

neutron.Gui("+LabelNeutron")


neutron.Show("w1024 h768")
return

FileInstall, Otagle.html, Otagle.html


NeutronClose:
ExitApp
return

;------------------------------------------------------Triger function------------------------------------------------------
handler_word(neutron, event){
    RunWord()
}

handler_totalComander(neutron, event)
{
    RunTC()
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

F_ReadConfig_ini()
     {
     global
     local LayerIndex, VerticalIndex
     local ButtonX, ButtonY, ButtonW, ButtonH, PictureDef, PictureSel
     
     IniRead, WhichMonitor,               % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     IniRead, HowManyLayers,              % A_ScriptDir . "\Config.ini", Main, HowManyLayers
     TableOfLayers := [{}]
     
     Loop, % HowManyLayers
          {
          LayerIndex := A_Index
          IniRead, Title%LayerIndex%,                    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Title
          IniRead, ButtonWidth,                          % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonWidth
          IniRead, ButtonHeight,                         % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHeight
          IniRead, ButtonHorizontalGap,                  % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHorizontalGap
          IniRead, ButtonVerticalGap,                    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonVerticalGap
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons vertically
          TableOfLayers[LayerIndex] := []
          Gui, % "Layer" . LayerIndex . ": New", % "+hwndGuiLayer" . LayerIndex . "Hwnd" . " +LabelMyGui_On"
          Loop, % AmountOfKeysVertically
               {
               VerticalIndex := A_Index
               Loop, % AmountOfKeysHorizontally
                    {
                    IniRead, ButtonX,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_X"
                    IniRead, ButtonY,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Y"
                    ButtonW := ButtonWidth
                    ButtonH := ButtonHeight
                    ;~ IniRead, ButtonY,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Y"
                    ;~ IniRead, ButtonW,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_W"
                    IniRead, PictureDef,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Picture"
                    IniRead, PictureSel,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_PictureIfSelected"
                    IniRead, ButtonA,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Action"
                    
                    
                    Gui, % "Layer" . LayerIndex . ": Add", Button
                         , % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h" . ButtonH 
                         . " hwnd" . LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd" . " gL_ButtonPressed" . " v" . VerticalIndex . "_" . A_Index     
                    if (PictureDef = "") ; if there is no picture assigned to particular button, then the button should be disabled
                         GuiControl, % "Layer" . LayerIndex . ": Disable", % %LayerIndex%_%VerticalIndex%_%A_Index%hwnd ; Disable unused button
                    else ; if there is a picture, prepare its graphics
                         {   
                         WhichButton := LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd"
                         Opt1 := {1: 0, 2: PictureDef, 4: "Black"}
                         Opt2 := {2: PictureSel, 4: "Yellow"}
                         ;~ Opt5 := {2: PictureSel, 4: "Yellow"}
                         If !ImageButton.Create(%WhichButton%, Opt1, Opt2 )
                              MsgBox, 0, % "ImageButton Error" . LayerIndex . "_" . VerticalIndex . "_" . A_Index, % ImageButton.LastError
                         TableOfLayers[LayerIndex][VerticalIndex . "_" . A_Index] := PictureDef     ; add key of object: index of button / picture
                         TableOfLayers[LayerIndex][VerticalIndex . "_" . A_Index] := ButtonA        ; add value of object: path to executable
                         }
                    }
               }
          ;~ vOutput := ""
          ;~ for vKey, vValue in TableOfLayers[LayerIndex]
               ;~ vOutput .= vKey " " vValue "`r`n"
          ;~ MsgBox, % vOutput
          }
     }