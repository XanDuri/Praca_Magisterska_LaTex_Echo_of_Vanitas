# Zrzuty ekranu do pracy dyplomowej

W tym katalogu trzymam grafiki, które trafiają do pracy magisterskiej (*Echoes of Vanitas*) przez LaTeX.

Źródło własne: zrzuty z gry, wykresy z logów AI, szkice koncepcyjne. Pliki są podpinane w rozdziałach przez `\includegraphics` oraz makra `\optchart` / `\optshot` w `LaTex/Master_Degree_Project/thesis-preamble.tex`.

## Struktura katalogów

| Folder | Zawartość |
|--------|-----------|
| `01_gameplay/` | HUD, walka, hub, ekran startowy |
| `02_ui/` | menu (questy, ekwipunek, ustawienia), toasty |
| `03_dungeon/` | loch proceduralny, boss, radar, minimapa, modyfikatory runu |
| `04_ai_debug/` | HUD F3, wykresy RL (`rl_epsilon.png`, `rl_reward.png` itd.), `brain_json_example.png` |
| `05_puzzles/` | mini-gry (lockpick, pipe, light sequence…) |
| `06_diagrams/` | diagramy / schematy (jeśli użyte w tekście) |
| `07_animations/` | paski animacji (gracz, wróg) |
| *(katalog główny)* | szkice wczesne (`1st_concept_*.jpg`), `enemie_art_skeatch.png`, `anim_*.png` |

## Jak to łączy się z LaTeX

`graphicspath` w `thesis-preamble.tex` wskazuje na `../../docs/screenshots/` względem `LaTex/Master_Degree_Project/`. Dlatego w repozytorium folder `docs/` musi leżeć obok `LaTex/`.

Przykład w rozdziale:

```latex
\includegraphics[width=0.9\textwidth]{start_screen.png}
```

LaTeX szuka pliku m.in. w `01_gameplay/start_screen.png` (katalogi z `graphicspath` są przeszukiwane po kolei).

Wykresy uczenia elit generuję skryptem `tools/plot_brain_log.py` z pliku `user://brain_log.csv` i zapisuję wynik w `04_ai_debug/`.

## Uwagi

- Pliki `*.import` to metadane Godota — nie są potrzebne do kompilacji PDF; można je ignorować w git.
- Jeśli brakuje PNG, LaTeX wstawia ramkę-zastępnik (makra `\optchart` / `\optshot`), żeby praca i tak się budowała.
