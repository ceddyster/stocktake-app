# Counter clear button issue

_Started 2026-09-11 04:21 UTC_

---

## User

As a counter, pressing clear my counts, does not remove counts from a submitted location

## Assistant

## Assistant

_[tool: grep]_

_[tool: grep]_

_[tool: read_file]_

_[tool: read_file]_

_[tool: grep]_

_[tool: grep]_

_[tool: read_file]_

_[tool: read_file]_

Found it. When a counter clears their counts, `runClearMine` deletes the count lines but leaves the location's `submitted` flag in the cloud doc — so on the next sync the submitted total (a stale number stored at submit time) comes right back. It also wipes the *entire* local `submitted` map instead of just the selected locations. The admin clear path handles this correctly; `runClearMine` doesn't. Mirroring it:

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Fixed. When a counter clears their counts in a submitted location, that location now un-submits both locally and in the cloud, so the stale submitted total no longer reappears on the next sync. It also no longer wipes submission flags for locations you didn't select.

I haven't rebuilt the `deploy/` folder — per the project rules that happens only when you ask.

## User

on the main page showing locations, please also show the join code

## Assistant

_[tool: grep]_

_[tool: grep]_

_[tool: grep]_

_[tool: read_file]_

I'll add the join code as a chip in the home-screen header, beside the role badge:

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Added a "CODE XXXXX" chip in the home-screen header next to the role badge, so the join code is visible on the main locations page.

## User

make the code bigger, and not have the word code in the bubble

## Assistant

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Done — code is bigger and the word "CODE" is gone from the bubble.

## User

have join code written above that new bubble

## Assistant

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Added a "JOIN CODE" label above the code bubble.

