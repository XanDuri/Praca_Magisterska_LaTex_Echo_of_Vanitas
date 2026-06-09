# Praca magisterska - Echoes of Vanitas (LaTeX)

Źródła pracy dyplomowej UWM: *Echoes of Vanitas - gra typu 2.5D RPG w silniku Godot z adaptacyjną sztuczną inteligencją*.

## Struktura repozytorium

```
Praca_Magisterska_LaTex_Echo_of_Vanitas/
├── LaTex/
│   └── Master_Degree_Project/   ← pliki .tex, kompilacja PDF
└── docs/
    └── screenshots/             ← zrzuty i wykresy używane w pracy
```

Grafiki do rozdziałów i dodatków leżą w **`docs/screenshots/`** i są wstawiane do PDF przez `\includegraphics` w `LaTex/Master_Degree_Project/`.

## Kompilacja

Wymagania: MiKTeX (Windows), `pdflatex`, `bibtex`.

```powershell
cd LaTex\Master_Degree_Project
.\build-thesis.ps1
```

Wynik: `MBZUAI-main.pdf` w tym samym katalogu.

Plik do wgrania w APD (magister, specjalność 1704, album 166297): **`MGR_1704_166297.pdf`** — kopia tego samego PDF obok pliku głównego.

## Autor

Łukasz Moszczyński - Uniwersytet Warmińsko-Mazurski w Olsztynie, 2026.
