# Visual Studio Code

## Wstęp

Visual Studio Code to kompleksowy edytor tekstu przeznaczony dla programistów.

## Zalety

- wspiera workspace
- wspiera kompilator pawn, po kliknięciu w błąd przenosi nas do niego
- wbudowany terminal
- więcej ciekawych dodatków niż w nodepad++
- wsparcie dla git'a

## Wady

- dłużej się włącza
- mniej przejżysty

## Instalacja

Visual Studio Code można [pobrać ze strony](https://code.visualstudio.com/download)

## Dostosowanie do PAWN

### Podświetlanie składni

Aby dostosować Visual Studio Code do pawn, należy pobrać rozszerzenie "Pawn Tools" by Southclaws.
Zrobimy to klikając *CTRL+SHIFT+X* a następnie wpisując nazwę dodatku i klikając "install".
Dodatkowo polecam wejść w `%USERPROFILE%\.vscode\extensions\southclaws.vscode-pawn-0.6.4` plik `package.json` i dodać do "extensions" rozszerzenia .hwn i .def.

### Automatyczne budowanie

Aby automatycznie zbudować skrypt mrucznika został dodany plik .vscode/tasks.json
Budowanie uruchamiamy skrótem *CTRL+SHIFT+B*

### Kodowanie plików

Aby w plikach pawn poprawnie kodowane były polskie znaki, został dodany plik `.vs\settings.json`.

### Szablony plików

Aby korzystać z mrucznikowych szablonów plików, należy pobrać dodatek [VZ File Templates for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=VisualZoran.vz-file-templates)

# Notepad++

## Wstęp

Notepad++ to prosty i szybki edytor tekstowy.

## Zalety

- szybko się włącza
- zaawansowane opcje wyszukiwania i zamiany (regexp)
- szybkie i wygodne wyszukiwanie
- prosty

## Wady

- słabe wsparcie workspace'ów
- brak wsparcia błędów kompilatora pawn

## Instalacja

Notepad++ można [pobrać ze strony](https://notepad-plus-plus.org/download)

## Dostosowanie do PAWN

Opis, jak dostosować notepad++ do SAMP znajdziemy [pod tym linkiem](https://forum.sa-mp.com/showthread.php?t=657898)
Pamiętajmy, że poprawne kodowanie dla plików pawn z polskimi znakami to ANSI lub Windows-1250.