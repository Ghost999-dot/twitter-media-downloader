// ==UserScript==
// @name         Twitter/X Media Downloader (LOCAL DEV loader)
// @namespace    https://github.com/ShanksSU/twitter-media-downloader
// @version      1.0.0
// @description  Loads the real script straight from your PC on every page load — instant live editing, no GitHub round-trip, no version bump. Enable Tampermonkey's "Allow access to file URLs" for this to work.
// @match        https://twitter.com/*
// @match        https://x.com/*
// @grant        GM_setValue
// @grant        GM_getValue
// @grant        GM_download
// @grant        GM_addStyle
// @require      file:///C:/Users/miche/coding%20thingy/twitter-media-downloader/twitter-media-downloader.user.js
// ==/UserScript==

// This file has NO code of its own. Everything comes from the @require above, which points at
// the working copy on disk. Save the .user.js, reload x.com, and you're running the latest —
// no waiting on Tampermonkey's update poll. Use this while developing; use the GitHub-hosted
// install for the "real"/shareable version that auto-updates from the web.
