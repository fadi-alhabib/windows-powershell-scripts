Set-Location -Path "E:\Programming"

# Get the list of folders in the current working directory
$folders = Get-ChildItem -Directory | Select-Object -ExpandProperty Name

# Initialize the selected index
$selectedIndex = 0

# ANSI escape codes for colors
$colorGray = [char]27 + "[90m"
$colorCyan = [char]27 + "[96m"
$colorGreen = [char]27 + "[92m"
$colorReset = [char]27 + "[0m"

# Emojis
$emojiCheck = [char]0x2714
$emojiFolder = "[FOLDER]"
$emojiOpenFolder = "[OPEN_FOLDER]"

# Function to display the options with colors and emojis
function ShowOptions {
    for ($i = 0; $i -lt $folders.Length; $i++) {
        $folderName = $folders[$i]
        if ($i -eq $selectedIndex) {
            Write-Host ("$colorGreen[$emojiCheck] $emojiOpenFolder $folderName$colorReset")
        }
        else {
            Write-Host ("$colorGray[ ] $emojiFolder $folderName$colorReset")
        }
    }
}

# Show the initial options
Clear-Host
Write-Host "$colorCyan Select a folder to navigate to:$colorReset"
ShowOptions

# Loop to handle user input
while ($true) {
    $key = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    if ($key.VirtualKeyCode -eq 38) {
        # Up arrow
        $selectedIndex = [Math]::Max(0, $selectedIndex - 1)
    }
    elseif ($key.VirtualKeyCode -eq 40) {
        # Down arrow
        $selectedIndex = [Math]::Min($folders.Length - 1, $selectedIndex + 1)
    }
    elseif ($key.VirtualKeyCode -eq 13) {
        # Enter key
        # User selected an option, exit the loop
        break
    }
    
    # Clear the console and show the updated options
    Clear-Host
    Write-Host "$colorCyan Select a folder to navigate to:$colorReset"
    ShowOptions
}

# Get the selected folder
$selectedFolder = $folders[$selectedIndex]

# Change the current working directory to the selected folder
Set-Location -Path $selectedFolder






