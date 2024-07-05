Set-ExecutionPolicy Bypass -Scope Process -Force;

# This function updates the AzureRM module
function Update-AzureRM {
    
    Install-Module -Name Az -Force -AllowClobber -Scope AllUsers -AcceptLicense    
    Write-Host "AzureRM module has been updated successfully."

}

# This function updates the GitHub CLI
function Update-GitHubCLI {
    # Check if GitHub CLI is installed
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        # Update GitHub CLI
        winget upgrade --id GitHub.cli -e --silent --accept-package-agreements --accept-source-agreements
        Write-Host "GitHub CLI has been updated successfully."
    }
    else {
        Write-Host "GitHub CLI is not installed. Installing it now."
        winget install --id GitHub.cli -e --silent --accept-package-agreements --accept-source-agreements
    }
}

# This function updates the Azure Developer CLI
function Update-AzureDeveloperCLI {
    # Check if Azure Developer CLI is installed
    if (Get-Command azd -ErrorAction SilentlyContinue) {
        # Update Azure Developer CLI
        winget upgrade --id Microsoft.Azd -e --silent --accept-package-agreements --accept-source-agreements
        Write-Host "Azure Developer CLI has been updated successfully."
    }
    else {
        Write-Host "Azure Developer CLI is not installed. Installing it now."
        winget install --id Microsoft.Azd -e --silent --accept-package-agreements --accept-source-agreements
    }
}

function Update-DotNet {
    Write-Host "Start to update .NET"
    dotnet workload update
    Write-Host "End to update .NET"
}

function Install-WinGet {
    # Check if WinGet is installed
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "WinGet is already installed."
    }
    else {
        Write-Host "WinGet is not installed. Installing it now."
        $scriptUrl = "https://raw.githubusercontent.com/Evilazaro/MicrosoftDevBox/main/Tasks/winget/main.ps1"

        Invoke-RestMethod -Uri $scriptUrl | Invoke-Expression
    }
}

# This function updates all the dependencies
function Update-Dependencies {
    Install-WinGet
    Update-DotNet    
    Update-AzureRM
    Update-GitHubCLI
    Update-AzureDeveloperCLI
}

# The main function that updates all dependencies

Update-Dependencies
