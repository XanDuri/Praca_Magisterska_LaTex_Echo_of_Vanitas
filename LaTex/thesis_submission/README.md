# Praca magisterska - Echoes of Vanitas (LaTeX)

Źródła pracy dyplomowej UWM (Łukasz Moszczyński).

## Kompilacja (Windows + MiKTeX)

`powershell
.\build-thesis.ps1
`

Wynik: `MBZUAI-main.pdf` w katalogu głównym.

## Struktura

- `MBZUAI-main.tex` - plik główny
- `Chapters/` - rozdziały
- `private/` - strona tytułowa, oświadczenia, marginesy
- `bibliography/keylatex.bib` - bibliografia
- `images/` - grafiki własne (zrzuty z `docs/screenshots/` są opcjonalne)

## Uwaga o zrzutach ekranu

`graphicspath` w `thesis-preamble.tex` wskazuje na `../../docs/screenshots/` względem tego folderu.
Przy samodzielnym repozytorium dodaj katalog `docs/screenshots/` obok `LaTex/` albo skopiuj PNG do `images/` i popraw ścieżki.
