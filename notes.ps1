Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.SelectVoice("Microsoft David Desktop")

# Slowest speech speed
$synth.Rate = -5

$sentences = @(
    "Treat five notes, come on, start treating five notes"
    "Have you started treating five notes already? If not, then do it now"
    "You have to treat about five notes an hours, but if you can, make it 10 notes instead"
    "If you haven't already start treating at least five notes"
)

# Maximum runtime: 60 minutes
$endTime = (Get-Date).AddMinutes(60)

while ((Get-Date) -lt $endTime) {

    # Pick and speak immediately
    $message = Get-Random -InputObject $sentences
    $synth.Speak($message)

    # Wait 2 minutes before the next message
    Start-Sleep -Seconds 120
}

$synth.Dispose()
