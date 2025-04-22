#!/bin/bash
meld "../wowr.w3x/war3mapMisc.txt" "../wowr.w3x/_Locales/deDE.w3mod/war3mapMisc.txt"
meld "../wowr.w3x/war3mapImported/WoWReforgedStrings.fdf" "../wowr.w3x/_Locales/deDE.w3mod/war3mapImported/WoWReforgedStrings.fdf"
java -Dfile.encoding=utf8 -jar wc3trans.jar "../wowr.w3x/war3map.wts" "../wowr.w3x/_Locales/deDE.w3mod/war3map.wts"
meld "../wowr.w3x/war3map.wts" "../wowr.w3x/_Locales/deDE.w3mod/war3map.wts"
