#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
#Include ../../Neutron.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; zmienna przechowuje "scieżkę do głownego katalogu z plikami należy tylko wskazać plik."
;Pobranie tytułu 
IniRead, Title , % A_ScriptDir . "\Config.ini",Layer2,Title
;Pboranie marginesu poziomego 
IniRead, HorizontalGap,% A_ScriptDir . "\Config.ini",Layer2,ButtonHorizontalGap
;Pobranie marginesu pionowego
IniRead, VerticalGap,% A_ScriptDir . "\Config.ini",Layer2,ButtonVerticalGap
;Pobranie  ilości elementów w wierszu 
IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer2,Amount of buttons horizontally
;Pobranie ilości elementów w kolumnie
IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer2,Amount of buttons vertically
;Pobranie szerokości przycisku 
IniRead, BtnWidth,% A_ScriptDir . "\Config.ini",Layer2,ButtonWidth
;Pobranie wysokości przycisku
IniRead, BtnHeight,% A_ScriptDir . "\Config.ini",Layer2,ButtonHeight
btns:= []
Loop, %AmoountVBtn% 
{
    VarVertical := A_Index
    Loop, %AmoountHBtn%
    {
        IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer2, % "Button_" . VarVertical . "_" . A_Index . "_X"
        IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer2, % "Button_" . VarVertical . "_" . A_Index . "_Y"
        IniRead, PictureDef,    % A_ScriptDir . "\Config.ini",Layer2,  % "Button_" . VarVertical . "_" . A_Index . "_Picture"
        IniRead, Action ,% A_ScriptDir . "\Config.ini", Layer2, % "Button_" . VarVertical . "_" . A_Index . "Action"
        Bw := BtnWidth
        Bh := BtnHeight
        ; btn:= % "<a href=""#"" style="" position: absolute;  box-shadow: rgba(0, 0, 0, 0.15) 0px 8px 16px 0px; top:" . BtnY . "px;" . " left:" . BtnX . "px;" .  "width:" . Bw . "vw;" . "height:" . Bh . "px;""><img style=""display:block;width:100%;height:100%;"" src=""" . PictureDef . """></a>"
        btn:= % "<a href=""#"" class=""box_item"" style="" max-width:300px;   box-shadow: rgba(0, 0, 0, 0.15) 0px 8px 16px 0px; width:" . Bw . "vw;" . "height:" . Bh . "vh;""><img style=""display:block;width:100%;height:100%;padding:4px;"" src=""" . PictureDef . """></a>"
        btns[VarVertical,A_Index]:= btn
    }
}

FileDelete, Layer1_Strona_glowna.html
FileAppend,
(
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Assets/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../Bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="Style/style.css" />
    <title>Otagle</title>
</head>
<body>
    <header>
        <span class="title-bar" onmousedown="neutron.DragTitleBar()">Otagle</span>
        <span class="title-btn__item"  onclick="ahk.handler_bar(event,neutron.qs(menu-bar))">
          opcje
        </span>
        <span class="title-btn__item" onclick="neutron.Minimize()">
        <i class="fa fa-window-minimize" aria-hidden="true"></i>
        </span>
        <span class="title-btn__item" onclick="neutron.Maximize()">
        <i class="fa fa-window-maximize" aria-hidden="true"></i>
      </span>
        <span class="title-btn__item title-btn__close" onclick="neutron.Close()"><i class="fa fa-times" aria-hidden="true"></i>
      </span>
    </header>
    <nav class="menu-bar">
    <ul class="menu-bar__list">
        <li class="menu-bar__item">
            <a href="">Configure</a>
            <ul class="sub__menu">
            <li class="menu-bar__item"><a href="">Monitor</a></li>
            <li class="menu-bar__item"><a href="">Existing Layer Buttons</a></li>
            <li class="menu-bar__item"><a href="">Add Layer</a></li>
            </ul>
        </li>
        <li class="menu-bar__item">
            <a href="">Edit Buttons</a></li>
        <li class="menu-bar__item">
            <a href="">Run Wizzard</a></li>
        <li class="menu-bar__item">
            <a href="">About</a>
        </li>
    </ul>
</nav>
    <div class="wrapper" style="position: relative;">  
), Layer1_Strona_glowna.html
Loop,%AmoountVBtn% {
    column := A_Index
 Loop, %AmoountHBtn%
 {
    FileAppend,% btns[column,A_Index], Layer1_Strona_glowna.html
 }
}

FileAppend,
(
    </div>
    </body> 
</html>   
), Layer1_Strona_glowna.html

display(){
zm := neutron.documentQuesrySelector(".menu-bar")

MsgBox, %zm%
}