# PowerShell helper to install deps and run Robot tests
Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $here
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
robot --outputdir reports tests/suites
$report = Join-Path $here 'reports\report.html'
If (Test-Path $report) { Start-Process $report }
Pop-Location
