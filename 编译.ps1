# Seer (d:\go) compile script
# Usage:
#   .\编译.ps1              # build once -> test\gameserver_yyyy-MM-dd_HHmm.exe
#   .\编译.ps1 -Release     # build with -ldflags "-s -w"
#   .\编译.ps1 -Watch       # watch .go files and rebuild on change
#   .\编译.ps1 -Clean      # remove test\*.exe
#   .\编译.ps1 -Clean -Release  # clean then release build

param(
    [switch]$Watch,
    [switch]$Clean,
    [switch]$Release
)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
if (-not $root) { $root = Get-Location }
Set-Location $root

$OutDir = "test"
$CmdPath = "./cmd/gameserver"

function Build {
    if (-not (Test-Path $OutDir)) {
        New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
    }
    $ts = Get-Date -Format "yyyy-MM-dd_HHmm"
    $out = Join-Path $OutDir "gameserver_$ts.exe"
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Building -> $out" -ForegroundColor Cyan
    $args = @("-o", $out, $CmdPath)
    if ($Release) {
        go build -ldflags "-s -w" @args
    } else {
        go build @args
    }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] OK: $out" -ForegroundColor Green
        return $true
    } else {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Build failed" -ForegroundColor Red
        return $false
    }
}

function Clean-Out {
    if (-not (Test-Path $OutDir)) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] (no $OutDir)" -ForegroundColor Gray
        return
    }
    $exes = Get-ChildItem -Path $OutDir -Filter "gameserver_*.exe" -ErrorAction SilentlyContinue
    foreach ($f in $exes) {
        Remove-Item $f.FullName -Force
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Removed $($f.Name)" -ForegroundColor Yellow
    }
    if ($exes.Count -eq 0) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] No gameserver_*.exe in $OutDir" -ForegroundColor Gray
    }
}

if ($Clean) {
    Clean-Out
}

if ($Watch) {
    Write-Host "Watch mode: .go changes trigger rebuild (Ctrl+C to stop)" -ForegroundColor Yellow
    Build | Out-Null
    $lastHash = $null
    while ($true) {
        Start-Sleep -Seconds 2
        $files = Get-ChildItem -Path $root -Recurse -Include "*.go" -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notmatch "\\vendor\\" }
        $hash = ($files | Get-FileHash -Algorithm MD5 -ErrorAction SilentlyContinue).Hash -join ""
        if ($null -ne $lastHash -and $hash -ne $lastHash) {
            Build | Out-Null
        }
        $lastHash = $hash
    }
} elseif (-not $Clean) {
    Build
}
