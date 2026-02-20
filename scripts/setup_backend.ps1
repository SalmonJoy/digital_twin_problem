param(
  [switch]$Run
)

$ErrorActionPreference = "Stop"

$rootDir = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$backendDir = Join-Path $rootDir "software\Backend"

if (-not (Test-Path $backendDir)) {
  throw "Backend directory not found: $backendDir"
}

Set-Location $backendDir

function New-BackendVenv {
  $candidates = @(
    @("python", "-m", "venv", ".venv"),
    @("py", "-3.11", "-m", "venv", ".venv"),
    @("py", "-3.10", "-m", "venv", ".venv"),
    @("py", "-3.9", "-m", "venv", ".venv"),
    @("py", "-m", "venv", ".venv")
  )

  foreach ($cmd in $candidates) {
    try {
      & $cmd[0] $cmd[1..($cmd.Length - 1)]
      if ($LASTEXITCODE -eq 0) {
        return
      }
    } catch {
      # try next candidate
    }
  }

  throw "Could not create backend venv. Install Python 3.9-3.11 and retry."
}

if (-not (Test-Path ".venv\Scripts\python.exe")) {
  Write-Host "Creating backend virtual environment..."
  New-BackendVenv
}

$venvPython = Join-Path $backendDir ".venv\Scripts\python.exe"
if (-not (Test-Path $venvPython)) {
  throw "Venv python not found at $venvPython"
}

Write-Host "Installing backend dependencies..."
& $venvPython -m pip install --upgrade pip
& $venvPython -m pip install -r requirements.txt

Write-Host "Backend setup complete."
Write-Host "Start backend manually with:"
Write-Host "  $venvPython main_backend.py"

if ($Run) {
  Write-Host "Starting backend now..."
  & $venvPython main_backend.py
}
