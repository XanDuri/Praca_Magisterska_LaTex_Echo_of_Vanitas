# Praca magisterska — Echoes of Vanitas (LaTeX)

Źródła pracy dyplomowej UWM: *Echoes of Vanitas - gra typu 2.5D RPG w silniku Godot z adaptacyjną sztuczną inteligencją*.

## Struktura repozytorium

```
Praca_Magisterska_LaTex_Echo_of_Vanitas/
├── LaTex/
│   └── Master_Degree_Project/   ← pliki .tex, kompilacja PDF
└── docs/
    └── screenshots/             ← zrzuty i wykresy używane w pracy (patrz README tam)
```

Grafiki do rozdziałów i dodatków leżą w **`docs/screenshots/`** i są wstawiane do PDF przez `\includegraphics` w `LaTex/Master_Degree_Project/`. Opis folderów: [docs/screenshots/README.md](docs/screenshots/README.md).

## Kompilacja

Wymagania: MiKTeX (Windows), `pdflatex`, `bibtex`.

```powershell
cd LaTex\Master_Degree_Project
.\build-thesis.ps1
```

Wynik: `MBZUAI-main.pdf` w tym samym katalogu.

## Autor

Łukasz Moszczyński — Uniwersytet Warmińsko-Mazurski w Olsztynie, 2026.
