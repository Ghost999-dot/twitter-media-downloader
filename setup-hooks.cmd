@echo off
REM ============================================================================
REM  One-time setup: activate the repo's tracked git hooks for THIS clone.
REM
REM  core.hooksPath is LOCAL git config -- it is NOT version-controlled, so it
REM  must be set once per clone. This points git at .githooks\, enabling the
REM  pre-commit hook that auto-bumps the userscript @version so Tampermonkey
REM  always sees a newer version at the raw GitHub URL.
REM
REM  Double-click this file, or run:  setup-hooks.cmd
REM ============================================================================
cd /d "%~dp0"
git config core.hooksPath .githooks
if errorlevel 1 (
  echo FAILED - is this a git repo and is git on PATH?
) else (
  echo Hooks activated. core.hooksPath =
  git config core.hooksPath
)
pause
