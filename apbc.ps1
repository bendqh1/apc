$files = Get-ChildItem "$PSScriptRoot\sentences\*.ps1"

Write-Host "Choose a sentence set:"
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$($i + 1). $($files[$i].BaseName)"
}

$choice = Read-Host "Enter number"

$selectedFile = $files[[int]$choice - 1]

# Load the selected sentence array
. $selectedFile.FullName

Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.SelectVoice("Microsoft David Desktop")

$synth.Rate = -4

$endTime = (Get-Date).AddMinutes(60)

while ((Get-Date) -lt $endTime) {

    $message = Get-Random -InputObject $sentences
    $synth.Speak($message)

    Start-Sleep -Seconds 240
}

$synth.Dispose()
