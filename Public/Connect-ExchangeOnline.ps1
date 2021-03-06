function Connect-ExchangeOnline {
    [CmdletBinding()]
    param(
        [Parameter(Position = 4)]
        [string]
        ${DelegatedOrganization},

        [Parameter(Position = 5)]
        [string]
        ${ExchangeRefreshToken},

        [Parameter(Position = 6)]
        [string]
        ${UPN},

        [Parameter(Position = 7)]
        [string]
        ${Prefix},

        [Parameter(Position = 8)]
        [string[]]
        ${CommandName},

        [Parameter(Position = 9)]
        [switch]
        ${showbanner}
    )

    if ($showbanner) {
        Write-Host @"
        ----------------------------------------------------------------------------
        The module allows access to all existing remote PowerShell (V1) cmdlets in addition to the 9 new, faster, and more reliable cmdlets.
        
        |--------------------------------------------------------------------------|
        |    Old Cmdlets                    |    New/Reliable/Faster Cmdlets       |
        |--------------------------------------------------------------------------|
        |    Get-CASMailbox                 |    Get-EXOCASMailbox                 |
        |    Get-Mailbox                    |    Get-EXOMailbox                    |
        |    Get-MailboxFolderPermission    |    Get-EXOMailboxFolderPermission    |
        |    Get-MailboxFolderStatistics    |    Get-EXOMailboxFolderStatistics    |
        |    Get-MailboxPermission          |    Get-EXOMailboxPermission          |
        |    Get-MailboxStatistics          |    Get-EXOMailboxStatistics          |
        |    Get-MobileDeviceStatistics     |    Get-EXOMobileDeviceStatistics     |
        |    Get-Recipient                  |    Get-EXORecipient                  |
        |    Get-RecipientPermission        |    Get-EXORecipientPermission        |
        |--------------------------------------------------------------------------|        

"@ -ForegroundColor Yellow
    }
    $script:baseurl = "https://outlook.office365.com/adminapi/beta/$($DelegatedOrganization)"
    $ErrorActionPreference = "stop"
    Write-Verbose "Connecting to Exchange Online using the Secure Application Model."
    Write-Verbose "Retrieving Tokens."
    try {
        $EOToken = New-PartnerAccessToken -ApplicationId 'a0c73c16-a7e3-4564-9a95-2bdf47383716'-RefreshToken $ExchangeRefreshToken -Scopes 'https://outlook.office365.com/.default' -Tenant $DelegatedOrganization
    }
    catch {
        throw "Could not generate Secure Application Model token to logon: $($_.Exception.Message)"
    }
    try {
        Write-Verbose "Converting Tokens in headers"
        $Script:EOHeadertoken = "Bearer $($EOToken.AccessToken)"
        $credential = New-Object System.Management.Automation.PSCredential($upn, (convertto-securestring $Script:EOHeadertoken -AsPlainText -Force))
        Write-Verbose "Logging in"
        $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://ps.outlook.com/powershell-liveid?DelegatedOrg=$($DelegatedOrganization)&BasicAuthToOAuthConversion=true" -Credential $credential -Authentication Basic -AllowRedirection
    }
    catch {
        throw "Could not create PSRemoting session to server: $($_.Exception.Message)"
    }
    try {
        if ($null -eq $PSboundparameters.CommandName) {
            if ($null -eq $PSboundparameters.Prefix) { Import-Module (Import-PSSession $session -AllowClobber) -Global } else { Import-Module (Import-PSSession $session -AllowClobber -Prefix $PSboundparameters.Prefix) -Global }
        }
        else {
            if ($null -eq $PSboundparameters.Prefix) { Import-Module (Import-PSSession $session -AllowClobber -CommandName $CommandName) -Global } else { Import-Module (Import-PSSession $session -AllowClobber -CommandName $CommandName -Prefix $PSboundparameters.Prefix) -Global }
        }
    }
    catch {
        throw "Could not import PSSession: $($_.Exception.Message)"
    }

}