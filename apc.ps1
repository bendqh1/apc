# Gets all .txt files located in the same folder as this script.
$files = Get-ChildItem "$PSScriptRoot\sentences\*.txt"

# Loops through each text file and keeps track of its index.
for ($i = 0; $i -lt $files.Count; $i++) {
    # Displays the file number and filename without the .txt extension.
    Write-Host "$($i + 1). $($files[$i].BaseName)"
}

# Asks the user to choose a file by entering its number.
$choice = Read-Host "Choose"

# Reads all lines from the selected text file into the $sentences array.
$sentences = @(Get-Content $files[[int]$choice - 1].FullName)

# Loads the Windows System.Speech assembly so text-to-speech can be used.
Add-Type -AssemblyName System.Speech

# Creates a new text-to-speech synthesizer.
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# Gets all voices installed on this Windows system.
$voices = @($synth.GetInstalledVoices() | ForEach-Object {
    $_.VoiceInfo
})

# Displays the available voices.
for ($i = 0; $i -lt $voices.Count; $i++) {
    Write-Host "$($i + 1). $($voices[$i].Name) [$($voices[$i].Culture)]"
}

# Asks the user to choose a voice.
$voiceChoice = Read-Host "Choose voice"

# Selects the chosen voice.
$synth.SelectVoice($voices[[int]$voiceChoice - 1].Name)

# Sets the speech rate to some level slower than the default (0).
$synth.Rate = -2

# Sets the time when the speech loop should stop.
$endTime = (Get-Date).AddMinutes(1)

# Keeps running until the current time reaches the end time.
while ((Get-Date) -lt $endTime) {
    # Randomly selects one sentence from the selected text file.
    $message = Get-Random -InputObject $sentences

    # Speaks the randomly selected sentence aloud.
    $synth.Speak($message)

    # Waits 120 seconds before speaking again.
    Start-Sleep -Seconds 240
}

# Releases the speech synthesizer and its resources.
$synth.Dispose()

# Prevent the finalization of the script from closing the window AND prevent Ctrl+C from closing the window
try {
    Start-Reminder
}
finally {
    Write-Host ""
    Write-Host "Script finished or was interrupted."
    Read-Host "Press Enter to close"
}
