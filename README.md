# Twitter/X Media Downloader (patched)

A patched build of the Twitter/X media downloader userscript, hosted here so Tampermonkey
auto-updates from GitHub.

## Install (auto-updating)

Add this URL as a new userscript in Tampermonkey (it will keep itself updated):

```
https://raw.githubusercontent.com/Ghost999-dot/twitter-media-downloader/main/twitter-media-downloader.user.js
```

Tampermonkey checks for updates on its own schedule; to pull immediately use
**Tampermonkey → Dashboard → Utilities → Check for userscript updates**.

## What's patched vs. the original

- **DownloadQueue** rewritten: 4 concurrent downloads, no permanent throttle after a failure,
  exponential-backoff retry, duplicate-task skipping, and a `.status` getter.
- **Live on-screen queue badge** (bottom-right of x.com) showing `N downloading / M queued`.
- `window.tmdApp` exposed for console inspection (`tmdApp.queue.status`).

## Live editing workflow

Two ways to develop against this:

1. **Auto-push to GitHub (this repo).** Run `watch-and-push.cmd` and leave it open. Every time
   you save `twitter-media-downloader.user.js`, it bumps the build number in `@version`,
   commits, and pushes. Tampermonkey then picks it up on its next update check.

2. **Instant local reload (no GitHub round-trip).** Install `dev-local.user.js` instead, and
   enable Tampermonkey's *Allow access to file URLs*. It `@require`s the file straight off disk,
   so every save shows up on the next x.com reload. Use this while actively tweaking.

## Files

| File | Purpose |
|------|---------|
| `twitter-media-downloader.user.js` | the script (the product) |
| `dev-local.user.js` | file:// loader for instant local live-editing |
| `watch-and-push.ps1` / `.cmd` | save-triggered auto bump + commit + push |
