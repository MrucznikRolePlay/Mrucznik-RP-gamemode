# Mrucznik-RP-2.5
Mapa serwera Mrucznik Role Play

## Ważne adnotacje odnośnie kodu
- aby pobrać różnicę między nowym GetTickCount a starym GetTickCount, użyj funkcji GetTickDiff

## [Edytory do PAWN](IDE.md)

## Kompilacja
Gamemod Mrucznika jest przystosowany do [sampctl](https://github.com/Southclaws/sampctl).
Aby skompilować gamemode z użyciem sampctl, należy [zainstalować sampctl](https://github.com/Southclaws/sampctl/wiki/Windows) a następnie wpisać następujące polecenia:
- sampctl package ensure
- sampctl package build

Jeżeli nie chcemy używać sampctl, należy ściągnąć [najnowszą wersję kompilatora pawn](https://github.com/pawn-lang/compiler/releases).
Należy też pobrać [inne include](https://github.com/Mrucznik/Mrucznik-RP-Includes/releases/tag/before-sampctl), ponieważ obecne są przystosowane do sampctl.
Kompilator dostarczony w samp'em nie skompiluje poprawnie gamemodu z przyczyn mi nie znanych.