# =========================
# Settings
# =========================

$sessionMinutes = 60
$pauseSeconds = 10
# $pauseSeconds = Get-Random -Minimum 5 -Maximum 11 # It's 11 instead of 10 because of exclusiveness

# =========================
# Choose sentence list
# =========================

$files = Get-ChildItem "$PSScriptRoot\sentences\*.txt"

for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$($i + 1). $($files[$i].BaseName)"
}

$choice = Read-Host "Choose"
$sentences = @(Get-Content $files[[int]$choice - 1].FullName)

# =========================
# Choose voice
# =========================

Add-Type -AssemblyName System.Speech

$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer

$voices = @($synth.GetInstalledVoices() | ForEach-Object {
    $_.VoiceInfo
})

for ($i = 0; $i -lt $voices.Count; $i++) {
    Write-Host "$($i + 1). $($voices[$i].Name) [$($voices[$i].Culture)]"
}

$voiceChoice = Read-Host "Choose voice"

$voiceName = $voices[[int]$voiceChoice - 1].Name

$synth.SelectVoice($voiceName)
$synth.Rate = -2

# =========================
# Speak until timeout
# =========================

$endTime = (Get-Date).AddMinutes($sessionMinutes)

while ((Get-Date) -lt $endTime) {

    $message = Get-Random -InputObject $sentences

    # Speak the sentence completely.
    $synth.Speak($message)

    # Wait between sentences.
    if ((Get-Date) -lt $endTime) {
        Start-Sleep -Seconds $pauseSeconds
    }
}

$synth.Dispose()

Write-Host ""
Write-Host "Script finished."
