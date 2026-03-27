library WoWReforgedI18n requires StringFormat, WoWReforgedUi // WoWReforgedUi loads TOC file on library initialization

function i18n takes string source returns AFormat
    return Format(GetLocalizedString(source))
endfunction

endlibrary
