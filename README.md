<div align="center">

# Twitter/X Media Downloader

**One-click downloading of images & videos from Twitter/X — with custom filenames, a download log, and a rewritten download queue.**

![version](https://img.shields.io/badge/version-0.3.4-1d9bf0)
[![license](https://img.shields.io/badge/license-MIT-brightgreen)](LICENSE)
![platform](https://img.shields.io/badge/userscript-Tampermonkey-333)

Maintained by **[ELO (Ghost999-dot)](https://github.com/Ghost999-dot)**

</div>

A patched build of the Twitter/X Media Downloader, maintained by **ELO (Ghost999-dot)** and hosted here so Tampermonkey keeps it up to date automatically. The download engine has been reworked for speed and reliability, and a small on-screen queue counter was added. Forked from [ShanksSU's original](https://github.com/ShanksSU/twitter-media-downloader).

---

## Table of contents

- [Features](#features)
- [Installation](#installation)
- [How auto-update works](#how-auto-update-works)
- [Usage](#usage)
  - [Download buttons](#download-buttons)
  - [Keyboard shortcut](#keyboard-shortcut)
  - [Download log (history)](#download-log-history)
  - [Settings](#settings)
- [Filename patterns](#filename-patterns)
  - [Tags](#tags)
  - [Date/time formatting](#datetime-formatting)
  - [Trimming the tweet text](#trimming-the-tweet-text)
  - [Examples](#examples)
- [What's patched in this build](#whats-patched-in-this-build)
- [Troubleshooting](#troubleshooting)
- [Privacy & safety](#privacy--safety)
- [Credits & license](#credits--license)

---

## Features

- **One-click download** of any tweet's media — photos (full `:orig` quality) and videos (highest-bitrate MP4 variant).
- Works on the **timeline, individual tweets, the media grid/tab, and per-image** in multi-image posts.
- **Custom filename patterns** with a visual tag builder or a free-form editor, plus a live preview.
- **Download log** — searchable table of what you've grabbed (thumbnail, user, type, size, post time, download time) with per-row "Go" and "Delete".
- **Duplicate protection** — tweets you've already downloaded are marked, and identical files are de-duplicated in-flight.
- **Auto-bookmark on download** (optional).
- **Configurable keyboard shortcut** (default `D`) to download whatever tweet you're hovering.
- **Light / dark theme** and **多language UI** (English / 日本語 / 简体中文 / 繁體中文).
- **Live on-screen queue counter** *(added in this build)*.
- **Rewritten download queue** *(this build)* — faster, and it no longer chokes after a single failed file.

---

## Installation

1. Install a userscript manager — [**Tampermonkey**](https://www.tampermonkey.net/) is recommended (Chrome, Edge, Firefox, Safari).
2. Click the raw script link below and Tampermonkey will offer to install it:

   ```
   https://raw.githubusercontent.com/Ghost999-dot/twitter-media-downloader/main/twitter-media-downloader.user.js
   ```

3. Confirm the install. Open [x.com](https://x.com), and a download arrow appears on tweets with media.

That's it — the script will keep itself updated from this repo (see below).

---

## How auto-update works

The script header declares:

```js
// @updateURL   https://raw.githubusercontent.com/Ghost999-dot/twitter-media-downloader/main/twitter-media-downloader.user.js
// @downloadURL https://raw.githubusercontent.com/Ghost999-dot/twitter-media-downloader/main/twitter-media-downloader.user.js
```

Tampermonkey periodically fetches that URL and, if its `@version` is **higher** than the installed one, updates silently. To pull an update **right now**:

> **Tampermonkey → Dashboard → Utilities → Check for userscript updates**

You can also lower the check interval in **Tampermonkey → Settings → Update** (set *Config mode* to *Advanced*).

---

## Usage

### Download buttons

| Where | What you get |
|-------|--------------|
| **Under a tweet** (next to the share button) | Downloads **all** media in that tweet. |
| **On each image** of a multi-image tweet | Hover an image → a download button appears bottom-right → grabs just that one. |
| **Media tab / grid** | A button overlays each media thumbnail. |

Button states: **arrow** = ready, **spinner** = working, **green check** = done, **gold** = already in your history, **red ✕** = failed (hover it for the reason, e.g. `API_ERROR`, `MEDIA_NOT_FOUND`).

### Keyboard shortcut

Hover a tweet and press **`D`** (configurable) to download it without clicking. Ignored while you're typing in an input box.

### Download log (history)

Click the **log button** (bottom-left of the page) to open the history modal:

- Thumbnail, user, type (or `Gallery` for multi-media), file size, post time, download time.
- **Go** opens the original tweet; **Delete** removes that entry.
- Header controls: **language**, **theme toggle**, **settings**, **clear all history**.

### Settings

Open history → gear icon. Options:

- **Remember download history** — keep the log (on by default).
- **Auto Bookmark on Download** — bookmarks the tweet when you download it.
- **Keyboard Shortcut** — the single key used to trigger a download on hover.
- **File Name Pattern** — see below.

---

## Filename patterns

Two editing modes (toggle in the settings dialog):

- **Tag Mode** — click chips to add fields, drag to reorder, joined by `_`.
- **Custom Mode** — type a free-form template mixing tags and literal text.

A **live preview** shows the resulting filename. The default is:

```
{user-name}(@{user-id})_{index}
```

### Tags

| Tag | Meaning |
|-----|---------|
| `{user-name}` | Display name |
| `{user-id}` | @handle |
| `{status-id}` | Tweet ID |
| `{date-time}` | Post time (UTC) |
| `{date-time-local}` | Post time (your local zone) |
| `{full-text}` | Tweet text (t.co links stripped) |
| `{fav-count}` | Like count |
| `{file-type}` | `photo` / `video` |
| `{file-name}` | Original filename from the CDN |
| `{media-count}` | Number of media items in the tweet |
| `{index}` | Position within the tweet (1-based) |
| `{rt-user-name}` | Retweeter's display name |
| `{rt-user-id}` | Retweeter's @handle |

Illegal filename characters are replaced automatically with look-alikes so nothing breaks on Windows.

### Date/time formatting

Add a format after a colon, e.g. `{date-time:YYYY-MM-DD_hhmmss}`:

| Token | Meaning | Token | Meaning |
|-------|---------|-------|---------|
| `YYYY` | 4-digit year | `hh` | hour (24) |
| `YY` | year | `mm` | minute |
| `MM` | month (01–12) | `ss` | second |
| `MMM` | month (JAN…) | `h2` | hour (12) |
| `DD` | day | `ap` | AM/PM |

Default when unspecified: `YYYYMMDD-hhmmss`.

### Trimming the tweet text

`{full-text:50}` caps the text at 50 characters.

### Examples

| Pattern | Result |
|---------|--------|
| `{user-name}(@{user-id})_{index}` | `Jingliu(@Jingliu_love)_1.jpg` |
| `{user-id}_{status-id}_{index}` | `Jingliu_love_20231011_1.jpg` |
| `{date-time:YYYY-MM-DD}_{user-id}_{index}` | `2026-09-26_Jingliu_love_1.jpg` |
| `[{fav-count}fav] {full-text:40}` | `[999fav] This is a sample tweet text-1.jpg` |

---

## What's patched in this build

Everything above is the original feature set. This fork changes the **download engine** and adds a **queue counter**:

### Rewritten `DownloadQueue`

The original queue permanently dropped to **one** concurrent download the first time any file failed or timed out — and never recovered for the rest of the session. This build:

- Runs **4 concurrent downloads** and **stays** there (a failure no longer throttles everything).
- **Retries with exponential backoff** (0.8s → 1.6s) instead of hammering instantly; the button only shows *failed* after retries are exhausted.
- **De-duplicates** identical `url + name` tasks.
- Exposes a **`.status`** getter.

> Concurrency is set in `new DownloadQueue(maxThread = 4)` — keep it between **3 and 5**; higher risks Twitter's media-CDN rate-limiting.

### Live on-screen queue counter

A small pill in the **bottom-right** of x.com shows `N downloading · M queued` while downloads are active, and hides itself when idle. No console needed.

### Console inspection

The app is exposed as `window.tmdApp`, so you can check state live:

```js
tmdApp.queue.status   // -> { queued: 8, active: 4, max: 4 }
```

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| **Update not pulling** | Run *Check for userscript updates* in Tampermonkey; confirm the hosted `@version` is higher than installed. |
| **Lots of red ✕ / timeouts** | You've likely hit the media-CDN rate limit — lower `maxThread` (e.g. to 3). |
| **`API_ERROR` on every download** | You're probably logged out of x.com, or the GraphQL query id in the script is stale — pull the latest version. |
| **Buttons don't appear** | x.com changed its markup; update the script, or reload the page. |

---

## Privacy & safety

- Your **download history and settings live inside Tampermonkey** (`GM_setValue`), not in this repo — publishing the script exposes nothing personal.
- The `Bearer` token in the script is Twitter's **public web-client guest token** (identical for everyone) — it is not a personal credential.

---

## Credits & license

- Maintained by **[ELO (Ghost999-dot)](https://github.com/Ghost999-dot)** — queue rewrite, live queue counter, and hosting.
- Forked from the original by **[ShanksSU](https://github.com/ShanksSU/twitter-media-downloader)**.
- Licensed under the **[MIT License](LICENSE)** — © 2026 ELO (Ghost999-dot); original portions © ShanksSU.
