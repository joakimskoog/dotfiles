function Splash {
    # User@Host
    $userHost = "$($env:USERNAME.ToLower())@$($env:COMPUTERNAME.ToLower())"
    Write-Output $userHost
    Write-Output ('-' * $userHost.Length)

    # OS
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    Write-Info "OS" $os

    # Host
    $hostModel = (Get-CimInstance Win32_ComputerSystem).Model
    Write-Info "Host" $hostModel

    # CPU
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $cpuName = $cpu.Name
    $cpuMaxClockGHz = [math]::Round($cpu.MaxClockSpeed / 1000, 2)
    Write-Info "CPU" "$cpuName @ $cpuMaxClockGHz GHz"

    # GPU
    $gpus = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name
    foreach ($gpu in $gpus) {
        Write-Info "GPU" $gpu
    }

    # Memory
    $mem = Get-CimInstance Win32_OperatingSystem
    $totalMemGB = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
    $usedMemGB = [math]::Round(($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / 1MB, 2)
    $memPercent = [math]::Round(($usedMemGB / $totalMemGB) * 100, 2)
    Write-Info "Memory" "$usedMemGB / $totalMemGB GB ($memPercent%)"

    # Disk
    $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, @{Name="UsedGB";Expression={[math]::Round(($_.Size - $_.FreeSpace)/1GB,2)}}, @{Name="TotalGB";Expression={[math]::Round($_.Size/1GB,2)}}
    foreach ($d in $disks) {
        $percentUsed = [math]::Round(($d.UsedGB / $d.TotalGB) * 100, 2)
        Write-Info "Disk $($d.DeviceID)" "$($d.UsedGB) / $($d.TotalGB) GB ($percentUsed%)"
    }

    # Battery
    $battery = Get-CimInstance Win32_Battery
    if ($battery) {
        Write-Info "Battery" "$($battery.EstimatedChargeRemaining)%"
    } else {
        Write-Info "Battery" "N/A"
    }

    # Locale
    $locale = Get-Culture
    Write-Info "Locale" "$($locale.Name) - $($locale.DisplayName)"
}

function Write-Info($label, $value) {
    $labelPadded = $label.PadRight(8)

    # Check if the value contains a percentage
    if ($value -match "\d+(\.\d+)?%") {
        $percentMatch = [regex]::Match($value, "\d+(\.\d+)?%")
        $beforePercent = $value.Substring(0, $percentMatch.Index)
        $percentText = $percentMatch.Value
        $afterPercent = $value.Substring($percentMatch.Index + $percentText.Length)  # Keep trailing chars

        # Write label in yellow
        Write-Host "${labelPadded}:" -ForegroundColor Yellow -NoNewline
        # Write value before percent in default color
        Write-Host " $beforePercent" -NoNewline
        # Write percent in green
        Write-Host "$percentText" -ForegroundColor Green -NoNewline
        # Write remaining text after percent
        Write-Host "$afterPercent"
    } else {
        # Write label in yellow and value in default color
        Write-Host "${labelPadded}:" -ForegroundColor Yellow -NoNewline
        Write-Host " $value"
    }
}

clear
Splash

echo "`nStarting bootstrap..."

if(-not (Get-Command git -ErrorAction SilentlyContinue)) {
    echo "Installing git..."
    # Install Git for windows because Git is not preinstalled on Windows
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements --silent --no-upgrade 1> $null

    # Refresh the PATH so we can use Git in the current session
    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
}

$repo = "https://github.com/joakimskoog/.dotfiles.git"
$repoBranch = "rework"
$repoFolder = "$HOME/.dotfiles"
if (-not (Test-Path -Path $repoFolder -PathType Container)) {
    echo "Cloning from $repo into $repoFolder"
    git clone $repo $repoFolder *> $null

    if ($repoBranch -ne "main") {
        Push-Location $repoFolder
        git fetch origin $repoBranch *> $null
        git checkout $repoBranch *> $null
        Pop-Location
    }
}

echo "Configuring dotfiles..."
. $HOME/.dotfiles/install.ps1
echo "Configuration done!"
