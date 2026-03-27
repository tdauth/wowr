library OpLimit

function NewOpLimit takes code callback returns nothing
    call ForForce(bj_FORCE_PLAYER[0], callback)
endfunction

endlibrary
