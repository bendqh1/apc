trap {
    Write-Host ""
    Write-Host "Script interrupted."
    Read-Host "Press Enter to close"
    exit
}

# Gets all .txt files.
$files = Get-ChildItem "$PSScriptRoot\sentences\*.txt"

for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$($i + 1). $($files[$i].BaseName)"
}

$choice = Read-Host "Choose"

$sentences = @(Get-Content $files[[int]$choice - 1].FullName)

Add-Type -AssemblyName System.Speech

$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer

$voices = @($synth.GetInstalledVoices() | ForEach-Object {
    $_.VoiceInfo
})

for ($i = 0; $i -lt $voices.Count; $i++) {
    Write-Host "$($i + 1). $($voices[$i].Name) [$($voices[$i].Culture)]"
}

$voiceChoice = Read-Host "Choose voice"

$synth.SelectVoice($voices[[int]$voiceChoice - 1].Name)

$synth.Rate = -2

$endTime = (Get-Date).AddMinutes(1)

while ((Get-Date) -lt $endTime) {
    $message = Get-Random -InputObject $sentences

    $synth.Speak($message)

    Start-Sleep -Seconds 30
}

$synth.Dispose()

Write-Host ""
Write-Host "Script finished."
Read-Host "Press Enter to close"
