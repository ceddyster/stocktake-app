# App terminology standardization

_Started 2026-09-11 05:34 UTC_

---

## User

go though app, have places renames to locations, so everything matches

## Assistant

_[tool: grep]_

The app already uses "location" in many spots. Let me find remaining "place(s)" usages that aren't `placeholder`.

_[tool: grep]_

_[tool: grep]_

No visible "place" text in the live app — those matches are all `.replace()` / `window.location` in JS. Let me check the other files in case the mismatch is there.

_[tool: grep]_

The live app (`Stocktake App Deploy.dc.html`) already uses "location" throughout — its only "place" matches are `replace()`/`applyReplace` in code. Let me confirm there's truly no user-facing "place" left, checking uppercase labels and the concept word specifically.

_[tool: grep]_

Let me precisely scan the live app for any user-facing "place" word (excluding `replace`, `placeholder`, `location`).

_[tool: run_script]_

Found the one stray. Let me see the full line 434.

_[tool: read_file]_

_[tool: str_replace_edit]_

The live app already used "location" everywhere except one stray "place" in the Drive sync explainer — now fixed. The whole app reads "location(s)" consistently.

The older prototype files (`Stocktake Setup.dc.html`, `Stocktake App.dc.html`, `Stocktake App Blank.dc.html`) still say "places," but those aren't the live app, so I left them. Want me to update those too?

_[tool: ready_for_verification]_

Done — one stray "place" fixed in the live app's Drive sync note; everything else already read "location." Left the old prototype files untouched. Want those updated too?

## User

no

## Assistant

Sounds good.

## User

lines should be replaced with products

## Assistant

_[tool: grep]_

The commented element is the location-card count ("15 of 192 lines"), and this "lines" wording (meaning product rows) recurs across the counting UI. Replacing the user-facing count labels with "products" for consistency.

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Replaced the user-facing "lines" count wording with "products" across the counting UI — location cards, category/subcategory counts, clash and submit messages, and the totals labels. Internal variable names and CSV export code are untouched.

## User

remove text

## Assistant

_[tool: grep]_

_[tool: read_file]_

_[tool: str_replace_edit]_

Removed.

