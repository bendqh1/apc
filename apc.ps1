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

# Selects the Microsoft David Desktop voice.
$synth.SelectVoice("Microsoft David Desktop")

# Sets the speech rate to 4 levels slower than the default.
$synth.Rate = -2

# Sets the time when the speech loop should stop, 60 minutes from now.
$endTime = (Get-Date).AddMinutes(60)

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
