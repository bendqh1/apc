Anti Procrastination by Context (APC).

A PowerShell program which helps fight procrastination.

Cloned from the cloud each time anew, [as with Git](https://github.com/bendqh1/windows/blob/main/powershell/git.md).

## Installation

Download the launcher to your preferred folder on Windows and run it.<br>
It will do a Temporary Download, Run, Delete (TDRD) operation for the script.

## Notes

* Choose an option by typing its number and then hit <kbd>Enter</kbd>.
* If <kbd>Ctrl</kbd>+<kbd>C</kbd> doesn't stop the script, the speech synthesizer may be blocking the PowerShell process while `Speak()` is running.
* The script runs by a timeout, but if a sentence is still being spoken when the timeout meets, `System.Speech.SpeechSynthesizer.Speak()`, then the script should end after that sentence finishes.

### Launcher notes

* `--depth 1` makes it a shallow clone, so Git downloads only the current state rather than the repository's entire history.
