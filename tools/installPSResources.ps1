# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
param(
    [ValidateSet("PSGallery", "CFS")]
    [string]$PSRepository = "PSGallery"
)

if ($PSRepository -eq "CFS" -and -not (Get-PSResourceRepository -Name CFS -ErrorAction SilentlyContinue)) {
    Register-PSResourceRepository -Name CFS -Uri "https://pkgs.dev.azure.com/powershell/PowerShell/_packaging/PowerShellGalleryMirror/nuget/v3/index.json"
}

# NOTE: Due to a bug in Install-PSResource with upstream feeds, we have to
# request an exact version. Otherwise, if a newer version is available in the
# upstream feed, it will fail to install any version at all.
Install-PSResource -Verbose -TrustRepository -RequiredResource  @{
    InvokeBuild = @{
        version = "5.12.1"
        repository = $PSRepository
    }
    platyPS = @{
        version = "0.14.2"
        repository = $PSRepository
    }
    Pester = @{
        version = "5.7.1"
        repository = $PSRepository
    }
    "Microsoft.PowerShell.SecretManagement" = @{
        version = "1.1.2"
        repository = $PSRepository
    }
}
