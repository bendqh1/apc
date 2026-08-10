$files = Get-ChildItem "$PSScriptRoot\*.txt"

for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$($i + 1). $($files[$i].BaseName)"
}

$choice = Read-Host "Choose"

$sentences = @(Get-Content $files[[int]$choice - 1].FullName)

& "$PSScriptRoot\tts.ps1" -sentences $sentences
