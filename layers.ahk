
#NoEnv  ;Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ;Enable warnings to assist with detecting common errors.
SendMode Input  ;Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ;Ensures a consistent starting directory.

;========================================================================================

; Remaps capslock to escape
Capslock::Esc

;========================================================================================

; A hotstring to fill in the current date and time when you type cdt
:*:cdt::
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt
SendInput %CurrentDateTime%
return


;========================================================================================

;Create a profile
Profile := 1 ;default

#F1:: ; press win + F1 to switch to layer 1 - mostly useful if you don't know what mode you're in 
Profile := 1 
TrayTip, Mode:, Insert Mode ; sends a notification when you switch modes
SetTimer, HideTrayTip, -1000
return

LCtrl & Ralt:: ; press Right alt to switch layers - there are two versions because the keycodes on UK and US keyboards are slightly different, so I have accounted for both
Profile := 2
TrayTip, Mode:, Power Mode
SetTimer, HideTrayTip, -1000
return

Ralt:: ; Feel free to change the layer switch button
Profile := 2
TrayTip, Mode:, Power Mode
SetTimer, HideTrayTip, -1000
return

;========================================================================================

;small lil function to make the tooltip go away
HideTrayTip(){
        TrayTip
        if SubStr(A_OSVersion,1,3) = "10." {
                Menu Tray, NoIcon
                Sleep 200
                Menu Tray, Icon
        }
}

;========================================================================================

#If Profile = 1 ; Profile 1 is default. Just uses global keycaps (see "remap capslock to escape")
return

;========================================================================================

#If Profile = 2
LCtrl & Ralt:: ; tap right alt again to switch back to layer 1
Profile := 1
return

Ralt::
Profile := 1
return

1::F1 ; rebind the number keys to be F keys 
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9

Tab::!Tab ; Tab is now a single key for Alt+tab allowing you to toggle between two programs with a single key tap

h::Left ; rebind the keys HJKL to the arrow keys 
j::Down
k::Up
l::Right

^k::MouseMove, 0, -10, 80, R ; Ctrl + HJKL will move the mouse  slightly
^h::MouseMove, -10, 0, 80, R
^j::MouseMove, 0, 10, 80, R
^l::MouseMove, 10, 0, 80, R

+k::MouseMove, 0, -50, 80, R ; Shift + HJKL will move the mouse a lot
+h::MouseMove, -50, 0, 80, R
+j::MouseMove, 0, 50, 80, R
+l::MouseMove, 50, 0, 80, R

q::LButton ; Rebind Q and E to left and right click respectively
e::RButton

w:: ; jump a word to the right (macro for ctrl + right arrow)
Send ^{Right}
return

b:: ; jump a word to the left (macro for ctrl + left arrow)
Send ^{Left}
return

i:: ; moves one letter to the left and switches mode back to typing
Send {Left}
Profile := 1
return

+i:: ; (Shift + i) - sends you to the start of the line and puts you into typing mode 
Send {Home}
Profile := 1
return

a:: ; puts you back into typing mode at the current cursor location
Profile := 1
return

+a:: ; (shift + a) sends you to the end of the line and puts you into typing mode
Send {End}
Profile := 1
return

^o:: ; (ctrl + o) sends ctrl + t - opens a new tab in browser
Send, ^t
Profile := 1
return

o:: ; puts you on a new line and into typing mode
Send {End}
Send {Enter}
Profile := 1
return

+o:: ; (shift + o) Puts you on a new line above the current one and into typing mode
Send {Home}
Send {Enter}
Send {Up}
Profile := 1
return

+d:: ; (shift + d) deletes the entire line
Send {Home}
Send +{End}
Send {Backspace}
return

d:: ; deletes to the end of the line from the current position
Send +{End}
Send {Backspace}
return

+c:: ; (shift + c) deletes to the end of the lin and puts you into typing mode
Send +{End}
Send {Backspace}
Profile := 1
return

c:: ; deletes a word and puts you into typing mode
Send ^+{Right}
Send {Backspace}
Profile := 1
return

u:: ; sends ctrl + z to undo a previous mistake
Send ^z
return

0:: ; yes this is actually the zero key - sends you to the start of the line
Send {Home}
return

y:: ; copies anything that's selected
Send, ^c
return

p:: ; pastes whatever is on the clipboard and puts you into typing mode
Send, ^v
Profile := 1
return

/:: ; sends ctrl + f to open the in page search and then puts you into typing mode 
Send, ^f
Profile := 1
return

;========================================================================================
