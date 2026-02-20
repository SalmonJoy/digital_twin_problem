param(
  [string]$BaseUrl = "http://localhost:5000",
  [int]$HistoryCount = 10,
  [int]$WaitSeconds = 6
)

$ErrorActionPreference = "Stop"

$results = @()

function Add-Result {
  param(
    [string]$Name,
    [bool]$Pass,
    [string]$Details
  )

  $results += [PSCustomObject]@{
    Check = $Name
    Status = if ($Pass) { "PASS" } else { "FAIL" }
    Details = $Details
  }
}

function Invoke-CheckedGet {
  param([string]$Url)
  return Invoke-RestMethod -Method Get -Uri $Url -TimeoutSec 30
}

function Invoke-CheckedPost {
  param([string]$Url)
  return Invoke-RestMethod -Method Post -Uri $Url -TimeoutSec 60
}

try {
  $health = Invoke-CheckedGet "$BaseUrl/"
  Add-Result "Health endpoint" $true "Backend reachable"
} catch {
  Add-Result "Health endpoint" $false $_.Exception.Message
}

try {
  $start = Invoke-CheckedGet "$BaseUrl/start_iot"
  Add-Result "Start IoT" $true "IoT loop started"
} catch {
  Add-Result "Start IoT" $false $_.Exception.Message
}

Start-Sleep -Seconds $WaitSeconds

try {
  $an = Invoke-CheckedGet "$BaseUrl/sensor/anomalies"
  $ok = ($null -ne $an.sensor_data) -and ($null -ne $an.anomalies) -and ($null -ne $an.preventive_actions)
  Add-Result "Sensor anomalies schema" $ok "sensor_data/anomalies/preventive_actions check"
} catch {
  Add-Result "Sensor anomalies schema" $false $_.Exception.Message
}

try {
  $hist = Invoke-CheckedGet "$BaseUrl/get_historical_data?num_data=$HistoryCount"
  $count = if ($hist -is [System.Array]) { $hist.Count } else { 1 }
  Add-Result "Historical data" ($count -gt 0) "records=$count"
} catch {
  Add-Result "Historical data" $false $_.Exception.Message
}

try {
  $train = Invoke-CheckedPost "$BaseUrl/train"
  $ok = $null -ne $train.message
  Add-Result "Train endpoint" $ok "train response received"
} catch {
  Add-Result "Train endpoint" $false $_.Exception.Message
}

try {
  $pred = Invoke-CheckedGet "$BaseUrl/predict"
  $ok = ($null -ne $pred.predicted_latitude) -and ($null -ne $pred.predicted_longitude) -and ($null -ne $pred.predicted_altitude)
  Add-Result "Predict endpoint schema" $ok "predicted_latitude/longitude/altitude check"
} catch {
  Add-Result "Predict endpoint schema" $false $_.Exception.Message
}

try {
  $stop = Invoke-CheckedGet "$BaseUrl/stop_iot"
  Add-Result "Stop IoT" $true "IoT loop stopped"
} catch {
  Add-Result "Stop IoT" $false $_.Exception.Message
}

$results | Format-Table -AutoSize

$failed = ($results | Where-Object { $_.Status -eq "FAIL" }).Count
if ($failed -gt 0) {
  Write-Error "Smoke test failed: $failed checks failed."
  exit 1
}

Write-Host "Smoke test passed: all checks PASS."
exit 0
