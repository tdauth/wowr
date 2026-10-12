library StringFormat requires StringUtils

/**
 * Use this struct to format strings which should be internationalized.
 * \code
 local string message = Format(GetLocalizedString("MY_KEY)).s(FormatTimeString(R2I(GetTimeOfDay()))).i(3).s("Peter").result()
 * \endcode
 * With the string entry MY_KEY "It's %1% o'clock and you're going to die in %2% hours. Maybe you should ask %3% why you're still alive.",
 * in war3map.wts or an FDF file with a StringList.
 * Instead of \ref thistype.create you can use the global function Format.
 * Instead of \ref thistype.result you can use the global function String.
 * This structure has been inspired by <a href="http://www.boost.org/doc/libs/1_43_0/libs/format/index.html">Boost C++ Libraries projects's format module</a>.
 * Unfortunately vJass does not allow operator and method overloading.
 * \sa String, Format, tr, sc
 * \author Baradé
 */
struct AFormat
    private integer m_position
    private string m_text

    /**
     * \return Returns the current formatted text/string.
     */
    public method text takes nothing returns string
        return this.m_text
    endmethod

    /**
     * This text macro generates a new method for a specified argument type which can be used when formatting strings.
     * Searches for the next position token (in form of %1% or %2% ...) and replaces it by \p value.
     * \param NAME Name of the argument method (usually it is equal to its type char).
     * \param TYPE JASS/vJass type of the argument.
     * \param CONVERSION Conversion call from argument to string (like "I2S(value)").
     * \param PARAMETERS Optional parameter list which can be accessed in the \p CONVERSION parameter as well (useful for real precision parameters).
     */
    //! textmacro AFormatMethod takes NAME, TYPE, CONVERSION, PARAMETERS
        public method $NAME$ takes $TYPE$ value $PARAMETERS$ returns thistype
            local string positionString = "%" + I2S(this.m_position + 1) + "%"
            local integer index = IndexOfString(positionString, this.m_text)
            if (index != -1) then
                set this.m_text = SubString(this.m_text, 0, index) + $CONVERSION$ + SubString(this.m_text, index + StringLength(positionString), StringLength(this.m_text))
                set this.m_position = this.m_position + 1
            else
                call BJDebugMsg("Format error in string \"" + this.m_text + "\" at position " + I2S(this.m_position) + " for token argument \"" + $CONVERSION$ + "\".")
            endif

            return this
        endmethod
    //! endtextmacro

    //! runtextmacro AFormatMethod("i", "integer", "I2S(value)", "")
    //! runtextmacro AFormatMethod("r", "real", "R2S(value)", "")
    //! runtextmacro AFormatMethod("rw", "real", "R2SW(value, width, precision)", ", integer width, integer precision")
    //! runtextmacro AFormatMethod("s", "string", "value", "")

    /**
     * \return Returns the formatted string result and destroys the instance.
     * \note Don't use the destroyed instance afterwards!
     * \sa String()
     */
    public method result takes nothing returns string
        local string result = this.m_text
        call this.destroy()
        return result
    endmethod

    /**
     * Creates a new instance based on text \p text.
     * \sa Format()
     */
    static method create takes string text returns AFormat
        local thistype this = thistype.allocate()
        set this.m_position = 0
        set this.m_text = text
        return this
    endmethod
endstruct

/**
 * Global function and alternative to \ref AFormat.create().
 * \return Returns a newly created formatting instance.
 * \sa AFormat.create()
 */
function Format takes string text returns AFormat
    return AFormat.create(text)
endfunction

endlibrary
