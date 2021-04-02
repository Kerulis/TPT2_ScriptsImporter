#SingleInstance, force
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
; #Persistent
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
SetWorkingDir %A_ScriptDir%

; !!!!! Press Escape at any time to kill the script !!!!!
Escape::ExitApp

; Must be in the Headquarters > Facility AI Screen
; This is ALT + B
; Must have copied text from a GitHub or Steam Page
!b::
    scripts := ParseInputForScripts(Clipboard)
    ImportAllScripts(scripts)
return

; Functions

ParseInputForScripts(scriptsString)
{
    splitArray := StrSplit(scriptsString, ["`n", A_Space, "_", "["])
    resultArray := []
    for index, element in splitArray
    {

        if (StrLen(element) > 50)
        {
            resultArray.Push(element)
        }
    }
return resultArray
}

ArrayToString(array)
{
    resultStr := ""
    for index, element in array
    {
        resultStr = %resultStr%`n%element%
    }
return resultStr
}

ImportAllScripts(scriptsArray)
{
    for index, element in scriptsArray
    {
        ClickImportButton()
        ClickTextBox()

        Clipboard := element
        Send, ^v

        ; Importing scripts too quickly lags the game :(
        Sleep, 900
        ClickSecondImportButton()
    }
return
}

ClickImportButton()
{
    ; Relative in game coords
    importOneX := 0.94
    importOneY := 0.06

    ClickRelativeXY(importOneX, importOneY)
return
}

ClickTextBox()
{
    ;; Relative in game coords
    textBoxX := 0.50
    textBoxY := 0.50

    ClickRelativeXY(textBoxX, textBoxY)
return
}

ClickSecondImportButton()
{
    ; Relative in game coords
    importTwoX := 0.50
    importTwoY := 0.175

    ClickRelativeXY(importTwoX, importTwoY)
return
}

ClickRelativeXY(relativeX, relativeY)
{
    width := 1280
    height := 786
    WinGetPos, , , width, height, The Perfect Tower II

    ; AHK starts at top left corner for Y
    ; WinGetPos gets borders, remove all borders for relative to absolute
    ; Add left and top borders back for click pos
    absoluteX := (relativeX * (width - 18)) + 9
    absoluteY := ((1 - relativeY) * (height - 22)) + 13 

    ; MsgBox, %absoluteX%,%absoluteY%
    MouseMove, absoluteX, absoluteY
    Click, %absoluteX% %absoluteY%
    Sleep, 150
    ; Send, {Down}
    ; Sleep, 1
    ; Send, {Up}
return
}

; TODO - detect top left corner of actual screen space (not borders) for coord system
