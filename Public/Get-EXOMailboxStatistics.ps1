function Get-EXOMailboxStatistics {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [guid]
        ${ExchangeGuid},

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [guid]
        ${DatabaseGuid},

        [switch]
        ${Archive},

        [switch]
        ${IncludeSoftDeletedRecipients},

        [string[]]
        ${Properties},

        [Microsoft.Exchange.Management.RestApiClient.GetExoMailboxStatistics+PropertySet[]]
        ${PropertySets},

        [Parameter(ParameterSetName = 'Identity', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]
        ${Identity},

        [Parameter(ParameterSetName = 'Identity', ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[a-zA-Z0-9!#$%*+\-/?^_`.{|}~]+@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,4}')]
        [string]
        ${UserPrincipalName},

        [Parameter(ParameterSetName = 'Identity', ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[a-zA-Z0-9!#$%*+\-/?^_`.{|}~]+@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,4}')]
        [string]
        ${PrimarySmtpAddress})
    $uriRequest = New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "mailbox" -subset "Exchange.GetMailboxStatistics()"
    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes
}