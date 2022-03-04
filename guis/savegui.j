globals 
framehandle Frame02 = null 
trigger TriggerFrame02 = null 
framehandle Frame06 = null 
trigger TriggerFrame06 = null 
framehandle Frame08 = null 
trigger TriggerFrame08 = null 
framehandle Frame010 = null 
trigger TriggerFrame010 = null 
framehandle Frame06Copy = null 
trigger TriggerFrame06Copy = null 
framehandle Frame02Copy = null 
trigger TriggerFrame02Copy = null 
framehandle Frame02CopyCopy = null 
trigger TriggerFrame02CopyCopy = null 
framehandle Frame02CopyCopyCopy = null 
trigger TriggerFrame02CopyCopyCopy = null 
framehandle Frame02CopyCopyCopyCopy = null 
trigger TriggerFrame02CopyCopyCopyCopy = null 
framehandle Frame06CopyCopy = null 
trigger TriggerFrame06CopyCopy = null 
framehandle Frame04 = null 
trigger TriggerFrame04 = null 
framehandle Frame04Copy = null 
trigger TriggerFrame04Copy = null 
framehandle Frame04CopyCopy = null 
trigger TriggerFrame04CopyCopy = null 
framehandle Frame04CopyCopyCopy = null 
trigger TriggerFrame04CopyCopyCopy = null 
framehandle Frame04CopyCopyCopyCopy = null 
trigger TriggerFrame04CopyCopyCopyCopy = null 
framehandle Frame011 = null 
trigger TriggerFrame011 = null 
framehandle Frame011Copy = null 
trigger TriggerFrame011Copy = null 
framehandle Frame013 = null 
trigger TriggerFrame013 = null 
framehandle Frame014 = null 
trigger TriggerFrame014 = null 
endglobals 
 
library SaveGui initializer init 
function Frame06Func takes nothing returns nothing 
call BlzFrameSetEnable(Frame06, false) 
call BlzFrameSetEnable(Frame06, true) 
endfunction 
 
function Frame08Func takes nothing returns nothing 
call BlzFrameSetEnable(Frame08, false) 
call BlzFrameSetEnable(Frame08, true) 
endfunction 
 
function Frame010Func takes nothing returns nothing 
call BlzFrameSetEnable(Frame010, false) 
call BlzFrameSetEnable(Frame010, true) 
endfunction 
 
function Frame06CopyFunc takes nothing returns nothing 
call BlzFrameSetEnable(Frame06Copy, false) 
call BlzFrameSetEnable(Frame06Copy, true) 
endfunction 
 
function Frame06CopyCopyFunc takes nothing returns nothing 
call BlzFrameSetEnable(Frame06CopyCopy, false) 
call BlzFrameSetEnable(Frame06CopyCopy, true) 
endfunction 
 
function Frame011Func takes nothing returns nothing 
call BlzFrameSetEnable(Frame011, false) 
call BlzFrameSetEnable(Frame011, true) 
endfunction 
 
function Frame011CopyFunc takes nothing returns nothing 
call BlzFrameSetEnable(Frame011Copy, false) 
call BlzFrameSetEnable(Frame011Copy, true) 
endfunction 
 
private function init takes nothing returns nothing 

call BlzLoadTOCFile(".toc")
set Frame02 = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame02, FRAMEPOINT_TOPLEFT, 0.137450, 0.527022) 
 call BlzFrameSetAbsPoint(Frame02, FRAMEPOINT_BOTTOMRIGHT, 0.470640, 0.497740) 
 call BlzFrameSetText(Frame02, "|cffffffff-load xxxx|r") 

set Frame06 = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame06, FRAMEPOINT_TOPLEFT, 0.477820, 0.527022) 
 call BlzFrameSetAbsPoint(Frame06, FRAMEPOINT_BOTTOMRIGHT, 0.536943, 0.497740) 
 call BlzFrameSetText(Frame06, "|cffFCD20DUpdate|r") 
call BlzFrameSetScale(Frame06, 1.00) 
 set TriggerFrame06 = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame06, Frame06, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame06, function Frame06Func) 

set Frame08 = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame08, FRAMEPOINT_TOPLEFT, 0.540810, 0.527022) 
 call BlzFrameSetAbsPoint(Frame08, FRAMEPOINT_BOTTOMRIGHT, 0.599933, 0.497740) 
 call BlzFrameSetText(Frame08, "|cffFCD20DLoad|r") 
call BlzFrameSetScale(Frame08, 1.00) 
 set TriggerFrame08 = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame08, Frame08, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame08, function Frame08Func) 

set Frame010 = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame010, FRAMEPOINT_TOPLEFT, 0.351840, 0.200004) 
 call BlzFrameSetAbsPoint(Frame010, FRAMEPOINT_BOTTOMRIGHT, 0.451850, 0.165750) 
 call BlzFrameSetText(Frame010, "|cffFCD20DClose|r") 
call BlzFrameSetScale(Frame010, 1.00) 
 set TriggerFrame010 = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame010, Frame010, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame010, function Frame010Func) 

set Frame06Copy = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame06Copy, FRAMEPOINT_TOPLEFT, 0.601040, 0.526469) 
 call BlzFrameSetAbsPoint(Frame06Copy, FRAMEPOINT_BOTTOMRIGHT, 0.660163, 0.497740) 
 call BlzFrameSetText(Frame06Copy, "|cffFCD20DSave Into File|r") 
call BlzFrameSetScale(Frame06Copy, 1.00) 
 set TriggerFrame06Copy = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame06Copy, Frame06Copy, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame06Copy, function Frame06CopyFunc) 

set Frame02Copy = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame02Copy, FRAMEPOINT_TOPLEFT, 0.134680, 0.485017) 
 call BlzFrameSetAbsPoint(Frame02Copy, FRAMEPOINT_BOTTOMRIGHT, 0.468970, 0.445790) 
 call BlzFrameSetText(Frame02Copy, "|cffffffff-loadi xxxx|r") 

set Frame02CopyCopy = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame02CopyCopy, FRAMEPOINT_TOPLEFT, 0.135240, 0.437497) 
 call BlzFrameSetAbsPoint(Frame02CopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.472300, 0.398270) 
 call BlzFrameSetText(Frame02CopyCopy, "|cffffffff-loadu xxxx|r") 

set Frame02CopyCopyCopy = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame02CopyCopyCopy, FRAMEPOINT_TOPLEFT, 0.133580, 0.391087) 
 call BlzFrameSetAbsPoint(Frame02CopyCopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.472290, 0.351860) 
 call BlzFrameSetText(Frame02CopyCopyCopy, "|cffffffff-loadb xxxx|r") 

set Frame02CopyCopyCopyCopy = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame02CopyCopyCopyCopy, FRAMEPOINT_TOPLEFT, 0.130820, 0.343577) 
 call BlzFrameSetAbsPoint(Frame02CopyCopyCopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.475060, 0.304350) 
 call BlzFrameSetText(Frame02CopyCopyCopyCopy, "|cffffffff-loadr xxxx|r") 

set Frame06CopyCopy = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0) 
 call BlzFrameSetAbsPoint(Frame06CopyCopy, FRAMEPOINT_TOPLEFT, 0.604900, 0.285579) 
 call BlzFrameSetAbsPoint(Frame06CopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.669548, 0.256850) 
 call BlzFrameSetText(Frame06CopyCopy, "|cffFCD20DSave All Into Files|r") 
call BlzFrameSetScale(Frame06CopyCopy, 1.00) 
 set TriggerFrame06CopyCopy = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame06CopyCopy, Frame06CopyCopy, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame06CopyCopy, function Frame06CopyCopyFunc) 

set Frame04 = BlzCreateFrameByType("TEXT", "name", Frame02, "", 0) 
call BlzFrameSetAbsPoint(Frame04, FRAMEPOINT_TOPLEFT, 0.0540120, 0.527022) 
call BlzFrameSetAbsPoint(Frame04, FRAMEPOINT_BOTTOMRIGHT, 0.112030, 0.497740) 
call BlzFrameSetText(Frame04, "|cffFFCC00Load Heroes:\n|r") 
call BlzFrameSetEnable(Frame04, false) 
call BlzFrameSetScale(Frame04, 1.00) 
call BlzFrameSetTextAlignment(Frame04, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

set Frame04Copy = BlzCreateFrameByType("TEXT", "name", Frame02, "", 0) 
call BlzFrameSetAbsPoint(Frame04Copy, FRAMEPOINT_TOPLEFT, 0.0562220, 0.482809) 
call BlzFrameSetAbsPoint(Frame04Copy, FRAMEPOINT_BOTTOMRIGHT, 0.114240, 0.447450) 
call BlzFrameSetText(Frame04Copy, "|cffFFCC00Load Items:\n|r") 
call BlzFrameSetEnable(Frame04Copy, false) 
call BlzFrameSetScale(Frame04Copy, 1.00) 
call BlzFrameSetTextAlignment(Frame04Copy, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

set Frame04CopyCopy = BlzCreateFrameByType("TEXT", "name", Frame02, "", 0) 
call BlzFrameSetAbsPoint(Frame04CopyCopy, FRAMEPOINT_TOPLEFT, 0.0562220, 0.438059) 
call BlzFrameSetAbsPoint(Frame04CopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.114240, 0.402700) 
call BlzFrameSetText(Frame04CopyCopy, "|cffFFCC00Load Units:\n|r") 
call BlzFrameSetEnable(Frame04CopyCopy, false) 
call BlzFrameSetScale(Frame04CopyCopy, 1.00) 
call BlzFrameSetTextAlignment(Frame04CopyCopy, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

set Frame04CopyCopyCopy = BlzCreateFrameByType("TEXT", "name", Frame02, "", 0) 
call BlzFrameSetAbsPoint(Frame04CopyCopyCopy, FRAMEPOINT_TOPLEFT, 0.0567740, 0.394409) 
call BlzFrameSetAbsPoint(Frame04CopyCopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.114792, 0.359050) 
call BlzFrameSetText(Frame04CopyCopyCopy, "|cffFFCC00Load Buildings:\n|r") 
call BlzFrameSetEnable(Frame04CopyCopyCopy, false) 
call BlzFrameSetScale(Frame04CopyCopyCopy, 1.00) 
call BlzFrameSetTextAlignment(Frame04CopyCopyCopy, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

set Frame04CopyCopyCopyCopy = BlzCreateFrameByType("TEXT", "name", Frame02, "", 0) 
call BlzFrameSetAbsPoint(Frame04CopyCopyCopyCopy, FRAMEPOINT_TOPLEFT, 0.0584320, 0.342479) 
call BlzFrameSetAbsPoint(Frame04CopyCopyCopyCopy, FRAMEPOINT_BOTTOMRIGHT, 0.116450, 0.307120) 
call BlzFrameSetText(Frame04CopyCopyCopyCopy, "|cffFFCC00Load Researches:\n|r") 
call BlzFrameSetEnable(Frame04CopyCopyCopyCopy, false) 
call BlzFrameSetScale(Frame04CopyCopyCopyCopy, 1.00) 
call BlzFrameSetTextAlignment(Frame04CopyCopyCopyCopy, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

set Frame011 = BlzCreateFrame("ScriptDialogButton", Frame08,0,0) 
 call BlzFrameSetAbsPoint(Frame011, FRAMEPOINT_TOPLEFT, 0.476160, 0.286694) 
 call BlzFrameSetAbsPoint(Frame011, FRAMEPOINT_BOTTOMRIGHT, 0.536388, 0.259070) 
 call BlzFrameSetText(Frame011, "|cffFCD20DUpdate All|r") 
call BlzFrameSetScale(Frame011, 1.00) 
 set TriggerFrame011 = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame011, Frame011, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame011, function Frame011Func) 

set Frame011Copy = BlzCreateFrame("ScriptDialogButton", Frame08,0,0) 
 call BlzFrameSetAbsPoint(Frame011Copy, FRAMEPOINT_TOPLEFT, 0.541360, 0.286687) 
 call BlzFrameSetAbsPoint(Frame011Copy, FRAMEPOINT_BOTTOMRIGHT, 0.599378, 0.258510) 
 call BlzFrameSetText(Frame011Copy, "|cffFCD20DLoad All|r") 
call BlzFrameSetScale(Frame011Copy, 1.00) 
 set TriggerFrame011Copy = CreateTrigger() 
 call BlzTriggerRegisterFrameEvent(TriggerFrame011Copy, Frame011Copy, FRAMEEVENT_CONTROL_CLICK) 
 call TriggerAddAction(TriggerFrame011Copy, function Frame011CopyFunc) 

set Frame013 = BlzCreateFrame("EscMenuBackdrop", Frame06CopyCopy,0,0) 
 call BlzFrameSetAbsPoint(Frame013, FRAMEPOINT_TOPLEFT, 0.674530, 0.534810) 
 call BlzFrameSetAbsPoint(Frame013, FRAMEPOINT_BOTTOMRIGHT, 0.774540, 0.250830) 

set Frame014 = BlzCreateFrameByType("TEXT", "name", Frame013, "", 0) 
call BlzFrameSetAbsPoint(Frame014, FRAMEPOINT_TOPLEFT, 0.687790, 0.507740) 
call BlzFrameSetAbsPoint(Frame014, FRAMEPOINT_BOTTOMRIGHT, 0.757964, 0.285640) 
call BlzFrameSetText(Frame014, "|cffFFCC00Text Frame|r") 
call BlzFrameSetEnable(Frame014, false) 
call BlzFrameSetScale(Frame014, 1.00) 
call BlzFrameSetTextAlignment(Frame014, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 
endfunction 
endlibrary
