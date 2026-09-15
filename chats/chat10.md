# Stocktake export format issue

_Started 2026-08-29 17:11 UTC_

---

## User

This is what the exported stocktake looks like. The values are the wrong format as there is a decimal after it with nothing following. Plee fix so it's either a regular number. Or a decimal up to 2 places

## Assistant

_[tool: grep]_

_[tool: read_file]_

_[tool: grep]_

_[tool: read_file]_

Found it. The xlsx number format is `0.##`, and in Excel that format code always renders the decimal point even when there's no fractional part (so `12` shows as `12.`). Switching it to `General` gives a plain number when whole, and up to 2 decimals otherwise (values are already rounded to 2 places by `fmt`).

_[tool: str_replace_edit]_

Fixed. The export now writes numbers with Excel's `General` format, so whole numbers show as plain integers (`12`, not `12.`) and fractional counts show up to 2 decimals (`12.5`, `12.75`). No other behaviour changed. Per the project rules I haven't rebuilt `deploy/` — tell me when you want a fresh deploy bundle.

