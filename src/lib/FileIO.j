library FileIO
/***************************************************************
*
*   v1.1.0, by TriggerHappy
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*
*   Provides functionality to read and write files.
*   _________________________________________________________________________
*   1. Requirements
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       - Patch 1.29 or higher.
*       - JassHelper (vJASS)
*   _________________________________________________________________________
*   2. Installation
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*   Copy the script to your map and save it.
*   _________________________________________________________________________
*   3. API
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       struct File extends array
*
*           static constant integer AbilityCount
*           static constant integer PreloadLimit
*
*           readonly static boolean ReadEnabled
*           readonly static integer Counter
*           readonly static integer array List
*
*           static method open takes string filename returns File
*           static method create takes string filename returns File
*
*           ---------
*
*           method write takes string value returns File
*           method read takes nothing returns string
*           method clear takes nothing returns File
*
*           method readEx takes boolean close returns string
*           method readAndClose takes nothing returns string
*           method readBuffer takes nothing returns string
*           method writeBuffer takes string contents returns nothing
*           method appendBuffer takes string contents returns nothing
*
*           method close takes nothing returns nothing
*
*           public function Write takes string filename, string contents returns nothing
*           public function Read takes string filename returns string
*
***************************************************************/

    globals
        // Enable this if you want to allow the system to read files generated in patch 1.30 or below.
        // NOTE: For this to work properly you must edit the 'Amls' ability and change the levels to 2
        // as well as typing something in "Level 2 - Text - Tooltip - Normal" text field.
        //
        // Enabling this will also cause the system to treat files written with .write("") as empty files.
        //
        // This setting is really only intended for those who were already using the system in their map
        // prior to patch 1.31 and want to keep old files created with this system to still work.
        private constant boolean BACKWARDS_COMPATABILITY = false
    endglobals

    private keyword FileInit
    struct File extends array
        static constant integer AbilityCount = 10
        static constant integer PreloadLimit = 200

        readonly static integer Counter = 0
        readonly static integer array List
        readonly static integer array AbilityList

        readonly static boolean ReadEnabled

        readonly string filename
        private string buffer

        static method open takes string filename returns thistype
            local thistype this = .List[0]

            if (this == 0) then
                set this = Counter + 1
                set Counter = this
            else
                set .List[0] = .List[this]
            endif

            set this.filename = filename
            set this.buffer = null

            debug if (this >= JASS_MAX_ARRAY_SIZE) then
            debug   call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") WARNING: Maximum instance limit " + I2S(JASS_MAX_ARRAY_SIZE) + " reached.")
            debug endif

            return this
        endmethod

        // This is used to detect invalid characters which aren't supported in preload files.
        static if (DEBUG_MODE) then
            private static method validateInput takes string contents returns string
                local integer i = 0
                local integer l = StringLength(contents)
                local string ch = ""
                loop
                    exitwhen i >= l
                    set ch = SubString(contents, i, i + 1)
                    if (ch == "\\") then
                        return ch
                    elseif (ch == "\"") then
                        return ch
                    endif
                    set i = i + 1
                endloop
                return null
            endmethod
        endif
        method write takes string contents returns thistype
            local integer i = 0
            local integer c = 0
            local integer len = StringLength(contents)
            local integer lev = 0
            local string prefix = "-" // this is used to signify an empty string vs a null one
            local string chunk
            debug if (.validateInput(contents) != null) then
            debug   call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") ERROR: Invalid character |cffffcc00" + .validateInput(contents) + "|r")
            debug   return this
            debug endif

            set this.buffer = null

            // Check if the string is empty. If null, the contents will be cleared.
            if (contents == "") then
                set len = len + 1
            endif

            // Begin to generate the file
            call PreloadGenClear()
            call PreloadGenStart()
            loop
                exitwhen i >= len

                debug if (c >= .AbilityCount) then
                debug call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") ERROR: String exceeds max length (" + I2S(.AbilityCount * .PreloadLimit) + ").|r")
                debug endif

                set lev = 0
                static if (BACKWARDS_COMPATABILITY) then
                    if (c == 0) then
                        set lev = 1
                        set prefix = ""
                    else
                        set prefix = "-"
                    endif
                endif

                set chunk = SubString(contents, i, i + .PreloadLimit)
                call Preload("\" )\ncall BlzSetAbilityTooltip(" + I2S(.AbilityList[c]) + ", \"" + prefix + chunk + "\", " + I2S(lev) + ")\n//")
                set i = i + .PreloadLimit
                set c = c + 1
            endloop
            call Preload("\" )\nendfunction\nfunction a takes nothing returns nothing\n //")
            call PreloadGenEnd(this.filename)

            return this
        endmethod

        method clear takes nothing returns thistype
            return this.write(null)
        endmethod

        private method readPreload takes nothing returns string
            local integer i = 0
            local integer lev = 0
            local string array original
            local string chunk = ""
            local string output = ""

            loop
                exitwhen i == .AbilityCount
                set original[i] = BlzGetAbilityTooltip(.AbilityList[i], 0)
                set i = i + 1
            endloop

            // Execute the preload file
            call Preloader(this.filename)

            // Read the output
            set i = 0
            loop
                exitwhen i == .AbilityCount

                set lev = 0

                // Read from ability index 1 instead of 0 if
                // backwards compatability is enabled
                static if (BACKWARDS_COMPATABILITY) then
                    if (i == 0) then
                        set lev = 1
                    endif
                endif

                // Make sure the tooltip has changed
                set chunk = BlzGetAbilityTooltip(.AbilityList[i], lev)

                if (chunk == original[i]) then
                    if (i == 0 and output == "") then
                        return null // empty file
                    endif
                    return output
                endif

                // Check if the file is an empty string or null
                static if not (BACKWARDS_COMPATABILITY) then
                    if (i == 0) then
                        if (SubString(chunk, 0, 1) != "-") then
                            return null // empty file
                        endif
                        set chunk = SubString(chunk, 1, StringLength(chunk))
                    endif
                endif

                // Remove the prefix
                if (i > 0) then
                    set chunk = SubString(chunk, 1, StringLength(chunk))
                endif

                // Restore the tooltip and append the chunk
                call BlzSetAbilityTooltip(.AbilityList[i], original[i], lev)

                set output = output + chunk

                set i = i + 1
            endloop

            return output
        endmethod

        method close takes nothing returns nothing
            if (this.buffer != null) then
                call .write(.readPreload() + this.buffer)
                set this.buffer = null
            endif
            set .List[this] = .List[0]
            set .List[0] = this
        endmethod

        method readEx takes boolean close returns string
            local string output = .readPreload()
            local string buf = this.buffer

            if (close) then
                call this.close()
            endif

            if (output == null) then
                return buf
            endif

            if (buf != null) then
                set output = output + buf
            endif

            return output
        endmethod

        method read takes nothing returns string
            return .readEx(false)
        endmethod

        method readAndClose takes nothing returns string
            return .readEx(true)
        endmethod

        method appendBuffer takes string contents returns thistype
            set .buffer = .buffer + contents
            return this
        endmethod

        method readBuffer takes nothing returns string
            return .buffer
        endmethod

        method writeBuffer takes string contents returns nothing
            set .buffer = contents
        endmethod

        static method create takes string filename returns thistype
            return .open(filename).write("")
        endmethod

        implement FileInit
    endstruct
    private module FileInit
        private static method onInit takes nothing returns nothing
            local string originalTooltip

            // We can't use a single ability with multiple levels because
            // tooltips return the first level's value if the value hasn't
            // been set. This way we don't need to edit any object editor data.
            set File.AbilityList[0] = 'Amls'
            set File.AbilityList[1] = 'Aroc'
            set File.AbilityList[2] = 'Amic'
            set File.AbilityList[3] = 'Amil'
            set File.AbilityList[4] = 'Aclf'
            set File.AbilityList[5] = 'Acmg'
            set File.AbilityList[6] = 'Adef'
            set File.AbilityList[7] = 'Adis'
            set File.AbilityList[8] = 'Afbt'
            set File.AbilityList[9] = 'Afbk'

            // Backwards compatability check
            static if (BACKWARDS_COMPATABILITY) then
                static if (DEBUG_MODE) then
                    set originalTooltip = BlzGetAbilityTooltip(File.AbilityList[0], 1)
                    call BlzSetAbilityTooltip(File.AbilityList[0], SCOPE_PREFIX, 1)
                    if (BlzGetAbilityTooltip(File.AbilityList[0], 1) == originalTooltip) then
                        call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO WARNING: Backwards compatability enabled but \"" + GetObjectName(File.AbilityList[0]) + "\" isn't setup properly.|r")
                    endif
                endif
            endif

            // Read check
            set File.ReadEnabled = File.open("FileTester.pld").write(SCOPE_PREFIX).readAndClose() == SCOPE_PREFIX
        endmethod
    endmodule
    public function Write takes string filename, string contents returns nothing
        call File.open(filename).write(contents).close()
    endfunction
    public function Read takes string filename returns string
        return File.open(filename).readEx(true)
    endfunction
endlibrary
