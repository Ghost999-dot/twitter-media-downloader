<#
  watch-and-push.ps1  --  keeps the hosted GitHub copy live with your PC.

  Run it once (double-click watch-and-push.cmd, or: powershell -ExecutionPolicy Bypass -File watch-and-push.ps1)
  and leave it running. Whenever twitter-media-downloader.user.js changes on disk, it:
     1. bumps the 4th "build" number in @version   (0.3.3 -> 0.3.3.1 -> 0.3.3.2 ...)
     2. commits the change
     3. pushes to origin (GitHub) so the raw URL Tampermonkey pulls is always current.

  The human version (0.3.3) only changes when YOU edit the @version line yourself;
  the build number is what makes Tampermonkey see a newer version on every save.
#>

# 'Continue' (not 'Stop'): git writes progress/warnings to stderr, and Windows PowerShell 5.1
# turns native stderr into terminating errors under 'Stop'. We check $LASTEXITCODE instead.
$ErrorActionPreference = 'Continue'
Set-Location -Path $PSScriptRoot
$FILE = 'twitter-media-downloader.user.js'
$POLL = 3   # seconds between checks

function Bump-Version {
    # Read/write as UTF-8 via .NET and touch ONLY the @version line, so multibyte characters
    # (zero-width chars, emoji, full-width spaces) in the script are preserved byte-for-byte.
    # (Get-Content/Set-Content default to ANSI in Windows PowerShell 5.1 and WOULD corrupt them.)
    $path = (Resolve-Path $FILE).Path
    $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    $m = [regex]::Match($text, '(?m)^(//\s*@version\s+)(\d+(?:\.\d+)*)([^\S\r\n]*)$')
    if (-not $m.Success) { return $null }
    $parts = $m.Groups[2].Value.Split('.')
    if ($parts.Count -ge 4) { $parts[3] = [string]([int]$parts[3] + 1) }
    else { $parts += '1' }
    $new = ($parts -join '.')
    $out = $text.Substring(0, $m.Index) + $m.Groups[1].Value + $new + $m.Groups[3].Value + $text.Substring($m.Index + $m.Length)
    [System.IO.File]::WriteAllText($path, $out, (New-Object System.Text.UTF8Encoding($false)))
    return $new
}

Write-Host "Watching $FILE  (Ctrl+C to stop)..." -ForegroundColor Cyan

while ($true) {
    Start-Sleep -Seconds $POLL
    # anything changed vs the last commit?  (skip when tree is clean)
    git diff --quiet -- $FILE 2>$null
    if ($LASTEXITCODE -eq 0) { continue }

    # wait for the file to settle so we don't commit a half-saved file
    $m1 = (Get-Item $FILE).LastWriteTimeUtc
    Start-Sleep -Seconds 1
    if ((Get-Item $FILE).LastWriteTimeUtc -ne $m1) { continue }   # still being written; try next cycle

    $v = Bump-Version
    git add $FILE | Out-Null
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    git commit -q -m "auto: live update $v ($stamp)" | Out-Null
    Write-Host "[$stamp] committed $v" -ForegroundColor Green

    git push -q origin main 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "           pushed to GitHub" -ForegroundColor DarkGray
    } else {
        Write-Host "           push FAILED (no origin remote or not logged in) - committed locally" -ForegroundColor Yellow
    }
}
