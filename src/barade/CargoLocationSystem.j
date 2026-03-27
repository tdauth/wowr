library CargoLocationSystem requires UnitEventEx

function GetUnitActualX takes unit whichUnit returns real
    local unit transporter = GetUnitTransporter(whichUnit)
    if (transporter != null) then
        return GetUnitX(transporter)
    endif
    return GetUnitX(whichUnit)
endfunction

function GetUnitActualY takes unit whichUnit returns real
    local unit transporter = GetUnitTransporter(whichUnit)
    if (transporter != null) then
        return GetUnitY(transporter)
    endif
    return GetUnitY(whichUnit)
endfunction

endlibrary
