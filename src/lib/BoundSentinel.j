library BoundSentinel initializer init
//*************************************************
//* BoundSentinel
//* -------------
//*  Don't leave your units unsupervised, naughty
//* them may try to get out of the map bounds and
//* crash your game.
//*
//*  To implement, just get a vJass compiler and
//* copy this library/trigger to your map.
//*
//*************************************************

//==================================================
   globals
       // High enough so the unit is no longer visible, low enough so the
       // game doesn't crash...
       //
       // I think you need 0.0 or soemthing negative prior to patch 1.22
       //
       private constant real EXTRA = 500.0
   endglobals

   //=========================================================================================
   globals
       private real maxx
       private real maxy
       private real minx
       private real miny
   endglobals

   //=======================================================================
   private function dis takes nothing returns nothing
    local unit u=GetTriggerUnit()
    local real x=GetUnitX(u)
    local real y=GetUnitY(u)

       if(x>maxx) then
           set x=maxx
       elseif(x<minx) then
           set x=minx
       endif
       if(y>maxy) then
           set y=maxy
       elseif(y<miny) then
           set y=miny
       endif
       call SetUnitX(u,x)
       call SetUnitY(u,y)
    set u=null
   endfunction

   private function init takes nothing returns nothing
    local trigger t=CreateTrigger()
    local region  r=CreateRegion()
    local rect    rc

       set minx=GetCameraBoundMinX() - EXTRA
       set miny=GetCameraBoundMinY() - EXTRA
       set maxx=GetCameraBoundMaxX() + EXTRA
       set maxy=GetCameraBoundMaxY() + EXTRA
       set rc=Rect(minx,miny,maxx,maxy)
       call RegionAddRect(r, rc)
       call RemoveRect(rc)

       call TriggerRegisterLeaveRegion(t,r, null)
       call TriggerAddAction(t, function dis)

    //this is not necessary but I'll do it anyway:
    set t=null
    set r=null
    set rc=null
   endfunction
endlibrary
