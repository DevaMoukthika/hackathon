param(
    [string]$Browser = "chrome"
)

Write-Host "Running Robot Framework tests (Browser: $Browser)"

# Install requirements (optional - comment out if you manage env differently)
python -m pip install -r requirements.txt

# Convert feature(s) to robot (example: convert all .feature files in tests/features)
Get-ChildItem -Path tests/features -Filter *.feature | ForEach-Object {
    $in = $_.FullName
    $outName = "$($_.BaseName).robot"
    $out = Join-Path -Path tests/converted -ChildPath $outName
    python tools/feature_to_robot.py $in $out
}

# Run Robot tests
robot --variable BROWSER:$Browser -d reports tests/converted

if (Test-Path -Path reports\report.html) {
    Write-Host "Opening report in Chrome..."
    Start-Process "chrome.exe" -ArgumentList (Resolve-Path reports\report.html)
} else {
    Write-Host "Report not found under reports\report.html. Check reports folder for output files."    
}
