function Get-EXOMailboxFolderPermission {
    [CmdletBinding()]
    param(
        [switch]
        ${GroupMailbox},

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
        ${PrimarySmtpAddress})


    $uriRequest = New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "mailbox" -subset "mailboxfolder" -subsettype "MailboxFolderPermission"
    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes
}