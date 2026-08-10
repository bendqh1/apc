Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.SelectVoice("Microsoft David Desktop")

# Slowest speech speed
$synth.Rate = -4

$sentences = @(
    "Do a single table cleaning task"
    "If you can't do several table cleaning taks simultaneously, start and do only one now"
    "Get your ass up and start cleaning your table by doing at least one table cleaning task"
    "If you haven't already, it's a darn goood time to start cleaning your table"
    "You must clean your working table always, to have a clear, non heavy working environment, so if your table is messy, clean at least one thing from it now"
)

# Maximum runtime: 60 minutes
$endTime = (Get-Date).AddMinutes(60)

while ((Get-Date) -lt $endTime) {

    # Pick and speak immediately
    $message = Get-Random -InputObject $sentences
    $synth.Speak($message)

    # Wait 2 minutes before the next message
    Start-Sleep -Seconds 240
}

$synth.Dispose()
