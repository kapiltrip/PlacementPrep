param()

function Ensure-Tool($name) {
  if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
    Write-Host "Missing tool: $name" -ForegroundColor Yellow
    Write-Host "Install Icarus Verilog (iverilog, vvp) and re-run." -ForegroundColor Yellow
    exit 1
  }
}

Ensure-Tool iverilog
Ensure-Tool vvp

$ErrorActionPreference = 'Stop'

$build = Join-Path $PSScriptRoot 'build'
if (-not (Test-Path $build)) { New-Item -ItemType Directory -Path $build | Out-Null }

$srcs = Get-ChildItem -Recurse (Join-Path $PSScriptRoot 'src') -Filter *.v | ForEach-Object { $_.FullName }
$tbs  = Get-ChildItem -Recurse (Join-Path $PSScriptRoot 'tb') -Filter *tb.v

if ($tbs.Count -eq 0) {
  Write-Host "No testbenches found under tb/." -ForegroundColor Yellow
  exit 1
}

$fail = 0
foreach ($tb in $tbs) {
  $name = $tb.BaseName
  $out  = Join-Path $build ($name + '.out')
  Write-Host "Building $name" -ForegroundColor Cyan
  # Add tb root so includes like "common/assert.vh" work from any TB
  iverilog -g2012 -I (Join-Path $PSScriptRoot 'tb') -o $out $($tb.FullName) $srcs
  if ($LASTEXITCODE -ne 0) { $fail++ ; continue }
  Write-Host "Running  $name" -ForegroundColor Cyan
  vvp $out
  if ($LASTEXITCODE -ne 0) { $fail++ }
}

if ($fail -eq 0) { Write-Host "All tests passed" -ForegroundColor Green; exit 0 }
else { Write-Host "Some tests failed: $fail" -ForegroundColor Red; exit 2 }
