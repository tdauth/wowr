library FileUtils

function FileStart takes nothing returns nothing
    call PreloadGenClear()
    call PreloadGenStart()
endfunction

function FileWriteLine takes string whichString returns nothing
    call Preload(whichString)
endfunction

function FileSave takes string fileName returns nothing
    // The line below creates the file at the specified location
    call PreloadGenEnd(fileName)
endfunction

function FileSaveSingleLine takes string whichString, string fileName returns nothing
    call FileStart()
    call FileWriteLine(whichString)
    call FileSave(fileName)
endfunction

endlibrary
