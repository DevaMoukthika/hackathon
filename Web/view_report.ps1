# Opens the newest Robot Framework HTML report (report.html or output.html) in Chrome
$reports = Get-ChildItem -Path reports -Recurse -Include report.html,output.html,output.xml -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending
if ($reports -and $reports.Count -gt 0) {
    $file = $reports[0].FullName
    Write-Host "Opening report: $file"
    Start-Process "chrome.exe" -ArgumentList (Resolve-Path $file)
} else {
    Write-Host "No report files found in reports/ folder. Run tests first."
}
