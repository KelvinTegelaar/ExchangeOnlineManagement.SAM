function Get-EXOMailbox {
    [CmdletBinding(DefaultParameterSetName = 'Anr')]
    param(
        [Parameter(ParameterSetName = 'Anr')]
        [ValidateLength(3, 5120)]
        [string]
        ${Anr},

        [ValidateNotNullOrEmpty()]
        [string]
        ${Filter},

        [string[]]
        ${Properties},

        [switch]
        ${SoftDeletedMailbox},

        [switch]
        ${InactiveMailboxOnly},

        [switch]
        ${Archive},

        [switch]
        ${IncludeInactiveMailbox},

        [string]
        ${MailboxPlan},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${RecipientTypeDetails},

        [Parameter(ParameterSetName = 'Identity', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]
        ${Identity},

        [Parameter(ParameterSetName = 'Identity', ValueFromPipelineByPropertyName = $true)]
        [System.Nullable[guid]]
        ${ExternalDirectoryObjectId},

        [Parameter(ParameterSetName = 'Identity', ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[a-zA-Z0-9!#$%*+\-/?^_`.{|}~]+@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,4}')]
        [string]
        ${UserPrincipalName},

        [Parameter(ParameterSetName = 'Identity', ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[a-zA-Z0-9!#$%*+\-/?^_`.{|}~]+@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,4}')]
        [string]
        ${PrimarySmtpAddress}
    )

    $uriRequest = if ($PsCmdlet.ParameterSetName -eq 'Identity') {
        New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "mailbox" 
    }
    else { 
        New-ExoURL -ParameterList $PSBoundParameters -endpoint "Mailbox"
    }

    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes
}