# Hidden product visibility issue

_Started 2026-08-29 03:52 UTC_

---

## User

When in a location. If a product is hidden as it's category/sub category is hidden, if you search and enter a count, that item gets shown

## Assistant

_[tool: grep]_

_[tool: read_file]_

_[tool: grep]_

_[tool: read_file]_

This is the keypad commit. I'll un-hide the counted item's category/subcategory for that location whenever a count is entered against it.

_[tool: str_replace_edit]_

Done. Now when you count a product that was hidden (its category/sub-category switched off as "not stocked here"), the app treats that as proof it's stocked here and reveals its category/sub-category once you clear the search.

One note: since hiding works at the category/sub-category level (there's no per-item hide), un-hiding also reveals that group's siblings — the mechanism can't reveal a single line on its own.

_[tool: ready_for_verification]_

Change is in the live app. Let me know if you'd rather it un-hide only the exact sub-category (not the whole category) when a category-level hide is what's covering the item.

## User

Can we have it so it doesn't show the whole category's list of products, just that category name and the item that was counted

## Assistant

_[tool: read_file]_

_[tool: grep]_

_[tool: read_file]_

Now I'll switch from un-hiding the whole category to a per-item reveal.

_[tool: str_replace_edit]_

Now update `isHidden` in the list render to respect the per-item reveal:

_[tool: str_replace_edit]_

Now the counted line surfaces on its own under its category/sub header, and the rest of that hidden group stays hidden.

_[tool: ready_for_verification]_

Done — counting a hidden line now reveals only that line under its category/sub-category header, leaving the rest of the group hidden.

