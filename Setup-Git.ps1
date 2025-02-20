######
#
# Setup-Git.ps1
#
# fdcastel@gmail.com
#
###

function Reload-Path {
    # Updates current session PATH reading the most updated one from Registry
    $env:Path =  (Get-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Session Manager\Environment').Path + ';' + `
                 (Get-ItemProperty 'HKCU:\Environment').Path
}

# Stop on any error
$ErrorActionPreference = 'Stop'

# Install Beyond Compare
choco install beyondcompare -y

# Install Git
choco install git -y --params "'/NoGuiHereIntegration /NoShellHereIntegration'"
Reload-Path

# Configure Git
git config --global user.email "camargo@discworld.com.br"
git config --global user.name "Tiago Pierezan Camargo"

# Install TortoiseGit
choco install tortoisegit -y

# Configure TortoiseGit / Beyond Compare integration
New-ItemProperty HKCU:\Software\TortoiseGit -Force -Name Diff  -PropertyType String -Value '"C:\Program Files\Beyond Compare 4\BComp.exe" %base %mine /title1=%bname /title2=%yname /leftreadonly' | Out-Null
New-ItemProperty HKCU:\Software\TortoiseGit -Force -Name Merge -PropertyType String -Value '"C:\Program Files\Beyond Compare 4\BComp.exe" %mine %theirs %base %merged /title1=%yname /title2=%tname /title3=%bname /title4=%mname' | Out-Null
