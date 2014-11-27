; Note: From now on whenever you run AutoHotkey dire;ctly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

;Window Scroll Up
; Window Shading (roll up a window to its title bar) -- by Rajat
; http://www.autohotkey.com
; This script reduces a window to its title bar and then back to its
; original size by pressing a single hotkey.  Any number of windows
; can be reduced in this fashion (the script remembers each).  If the
; script exits for any reason, all "rolled up" windows will be
; automatically restored to their original heights.

; Set the height of a rolled up window here.  The operating system
; probably won't allow the title bar to be hidden regardless of
; how low this number is:
ws_MinHeight = 25

; This line will unroll any rolled up windows if the script exits
; for any reason:
OnExit, ExitSub
return  ; End of auto-execute section

#z::  ; Change this line to pick a different hotkey.
; Below this point, no changes should be made unless you want to
; alter the script's basic functionality.
; Uncomment this next line if this subroutine is to be converted
; into a custom menu item rather than a hotkey.  The delay allows
; the active window that was deactivated by the displayed menu to
; become active again:
;Sleep, 200
WinGet, ws_ID, ID, A
Loop, Parse, ws_IDList, |
{
	IfEqual, A_LoopField, %ws_ID%
	{
		; Match found, so this window should be restored (unrolled):
		StringTrimRight, ws_Height, ws_Window%ws_ID%, 0
		WinMove, ahk_id %ws_ID%,,,,, %ws_Height%
		StringReplace, ws_IDList, ws_IDList, |%ws_ID%
		return
	}
}
WinGetPos,,,, ws_Height, A
ws_Window%ws_ID% = %ws_Height%
WinMove, ahk_id %ws_ID%,,,,, %ws_MinHeight%
ws_IDList = %ws_IDList%|%ws_ID%
return

ExitSub:
Loop, Parse, ws_IDList, |
{
	if A_LoopField =  ; First field in list is normally blank.
		continue      ; So skip it.
	StringTrimRight, ws_Height, ws_Window%A_LoopField%, 0
	WinMove, ahk_id %A_LoopField%,,,,, %ws_Height%
}
ExitApp  ; Must do this for the OnExit subroutine to actually Exit the script.

#a::
Run, C:\Program Files (x86)\Mozilla Firefox\firefox.exe rtphq.com/login
return

#s::
Run, C:\Program Files\Internet Explorer\iexplore.exe rtphq.com/login
return

; When I press #q, I want to Empty the Recycle Bin
#j::
FileRecycleEmpty
return

#`::
Run C:\projects
return

^!n::
IfWinExist Untitled - Subl
	WinActivate
else
	Run Subl c:\projects
return

;prevent touchpad while typing

; Script Function:
;       Disables trackpad for 500ms any time a key is pressed (prevents accidental mouse clicks)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;keyboard hook code credit: http://www.autohotkey.com/forum/post-127490.html#127490
#Persistent
OnExit, Unhook

hHookKeybd := SetWindowsHookEx(WH_KEYBOARD_LL   := 13, RegisterCallback("Keyboard", "Fast"))
Return

ReenableTrackpad:
BlockInput, MouseMoveOff
Return

Unhook:
UnhookWindowsHookEx(hHookKeybd)
ExitApp

Keyboard(nCode, wParam, lParam)
{
   Critical
   If !nCode
   {
      BlockInput, MouseMove
      SetTimer, ReenableTrackpad, 500
   }
   Return CallNextHookEx(nCode, wParam, lParam)
}

SetWindowsHookEx(idHook, pfn)
{
   Return DllCall("SetWindowsHookEx", "int", idHook, "Uint", pfn, "Uint", DllCall("GetModuleHandle", "Uint", 0), "Uint", 0)
}

UnhookWindowsHookEx(hHook)
{
   Return DllCall("UnhookWindowsHookEx", "Uint", hHook)
}

CallNextHookEx(nCode, wParam, lParam, hHook = 0)
{
   Return DllCall("CallNextHookEx", "Uint", hHook, "int", nCode, "Uint", wParam, "Uint", lParam)
}