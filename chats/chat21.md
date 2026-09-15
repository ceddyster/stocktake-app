# Redirect to finalized stocktake

_Started 2026-09-11 06:39 UTC_

---

## User

when I logged back in through Google. It brought up a new stocktake. Have it so if there is an finalised/closed stocktake from that admin, they automatically go back to that

## Assistant

_[tool: grep]_

_[tool: grep]_

_[tool: read_file]_

_[tool: grep]_

_[tool: read_file]_

_[tool: read_file]_

I've traced how login and finalised stocktakes work. One thing needs clarifying before I change the behaviour, and I've hit the usage limit for now.

How it works today: when an admin **closes/finalises** a stocktake, its counts snapshot moves to "Past stocktakes" (stored on the device), the current stocktake is wiped blank, and locations/products are kept for the next count. So logging back in lands you on a fresh/blank stocktake with the finished one tucked under "Past stocktakes."

"Go back to that" could mean two different things:

- **Reopen the finalised one in read-only review** — you land on the closed stocktake's figures automatically, and start a new count only when you choose to.
- **Resume it as the active count** — reopen it so you can keep editing/counting on it (un-close it).

Which do you want? (My default, if you don't say, is the first: on login, if that admin has a finalised stocktake, open the most recent one automatically instead of a blank new one.)

Heads up: I've reached the usage limit — say the word and I'll continue and make the change.

## User

Unfinalised or unsubmitted.

## Assistant

_[tool: grep]_

Understood — resume the in-progress (unfinalised/unsubmitted) stocktake on login instead of starting a blank one. I'll persist the admin's active stocktake code per account and re-open it at login.

_[tool: read_file]_

_[tool: str_replace_edit]_

## Assistant

_[tool: str_replace_edit]_

Now wire recovery into the login paths and record/clear the active code:

_[tool: str_replace_edit]_

_[tool: str_replace_edit]_

The post-finalise `save({})` would re-record the code (locations persist). Gate recording on actual progress:

_[tool: str_replace_edit]_

_[tool: ready_for_verification]_

Done. On login, the app now reopens the admin's active unfinalised/unsubmitted stocktake from the cloud instead of dropping them on a blank new one.

How it works:
- While an admin has counts, submissions, or a title in progress, their stocktake's code is saved against their account (per Google/email uid).
- After Google sign-in (and password sign-in), if this device isn't already on that stocktake, it fetches and reopens it straight to home.
- Once a stocktake is **closed/finalised**, that link is cleared, so a finished count won't get auto-reopened — only unfinalised/unsubmitted ones do.

Caveat: recovery relies on the saved account→code link on the device. If the browser fully clears storage (e.g. iOS evicting an inactive PWA), there's nothing left to recover from — that would need a server-side lookup by account, which isn't wired up. Say the word if you want me to add that.

Per your CLAUDE.md I haven't rebuilt the `deploy/` bundle — tell me when you're ready and I'll run the two-step build.

