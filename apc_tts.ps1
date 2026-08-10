param($sentences)

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
