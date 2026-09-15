# Supabase auth setup — Stocktake

The app now shows a login screen on startup. Organisers sign in with **email/password** or **Google**; counters tap **"Just counting? Join with a code"** to bypass. This all talks to your existing Supabase project (`ijzuvrwcfipvsxbxginz`) using the anon key already inlined in the app — no new keys needed.

Do these steps in the Supabase dashboard before the login screen will actually work.

## 1. Email + password (2 minutes)

1. Dashboard → **Authentication → Providers → Email**.
2. Turn **Enable Email provider** on.
3. Turn **Confirm email** **OFF** (you chose "let them in immediately after signup"). With it off, creating an account logs the organiser straight in. If you leave it on, they'll get a confirmation email and can't sign in until they click the link.
4. Save.

That's it — "Create an account" and "Sign in" now work.

## 2. Google sign-in (more setup)

Google needs OAuth credentials from Google, then a redirect allow-list. It's fiddly; skip it if email/password is enough for now.

**a. Get Google credentials**
1. Go to <https://console.cloud.google.com> → APIs & Services → **Credentials**.
2. **Create credentials → OAuth client ID → Web application**.
3. Under **Authorized redirect URIs**, add:
   `https://ijzuvrwcfipvsxbxginz.supabase.co/auth/v1/callback`
4. Copy the **Client ID** and **Client secret**.

**b. Put them in Supabase**
1. Dashboard → **Authentication → Providers → Google** → enable it.
2. Paste the Client ID and Client secret. Save.

**c. Allow the app's return URLs**
1. Dashboard → **Authentication → URL Configuration**.
2. **Site URL:** `https://stocktakeapp.netlify.app`
3. **Redirect URLs** — add both:
   - `https://stocktakeapp.netlify.app`
   - `https://stocktakeapp.netlify.app/*`
   - (add `http://localhost:*` too if you test locally)

After a Google sign-in, Google bounces back to the app with the session in the URL; the app reads it and drops you on the home screen.

## Notes

- **Sessions persist.** Once signed in, the organiser stays signed in across reloads and app restarts until they tap **Log out** (side menu → Account). Local counts and setup are kept on log out — they reappear on next sign-in.
- **Nothing is gated for counters beyond admin actions.** A logged-out person can only reach the app by joining with a code; setup, editing places/products, reopening locations, clearing/starting a stocktake, finishing/exporting and Drive settings all require being signed in.
- The anon key in the app is safe to ship publicly — that's what it's for. Auth security comes from your provider settings and (later) row-level-security policies on the `stocktakes` table.
