# Admin view cleanup

_Started 2026-09-10 14:15 UTC_

---

## User

Remove the option to view as counts rim admin view. This was for testing only.
Remove text at bottom of locations screen under grand total/close stocktake

## Assistant

_[tool: grep]_

_[tool: read_file]_

_[tool: grep]_

_[tool: read_file]_

Both edits:

_[tool: str_replace_edit]_

Both done: removed the "Switch to counter view" button from the admin menu and the helper text under Grand total / Close stocktake. Deploy folder not rebuilt per project rules.

Note: usage quota is at 90%.

_[tool: ready_for_verification]_

Done.

## User

Rebuild deploy

## Assistant

_[tool: super_inline_html]_

Now the inflate post-process:

_[tool: run_script]_

_[tool: show_html]_

_[tool: get_webview_logs]_

Deploy rebuilt: bundled `deploy/index.html`, then inflated all 3 compressed assets (0 remaining). No errors — ready to drag into Netlify.

