param(
  [switch]$SkipInstall,
  [switch]$Build
)

$ErrorActionPreference = "Stop"

$rootDir = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$frontendDir = Join-Path $rootDir "software\Frontend\dt_frontend"

if (-not (Test-Path $frontendDir)) {
  throw "Frontend directory not found: $frontendDir"
}

Set-Location $frontendDir

if (-not $SkipInstall) {
  Write-Host "Installing frontend dependencies..."
  npm install
}

if ($Build) {
  Write-Host "Building frontend..."
  npm run build
  exit $LASTEXITCODE
}

Write-Host "Starting frontend on default CRA port..."
npm start
