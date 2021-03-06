function Get-EXORecipient {
    [CmdletBinding(DefaultParameterSetName = 'Anr')]
    param(
        [Parameter(ParameterSetName = 'Anr')]
        [ValidateLength(3, 5120)]
        [string]
        ${Anr},

        [ValidateNotNullOrEmpty()]
        [string]
        ${Filter},

        [ValidateNotNullOrEmpty()]
        [string]
        ${OrganizationalUnit},

        [string[]]
        ${Properties},

        [Microsoft.Exchange.Management.RestApiClient.GetExoRecipient+PropertySet[]]
        ${PropertySets},

        [switch]
        ${IncludeSoftDeletedRecipients},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${RecipientType},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${RecipientTypeDetails},

        [string]
        ${RecipientPreviewFilter},

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
        ${PrimarySmtpAddress},

        [Microsoft.Exchange.Management.RestApiClient.Unlimited[uint32]]
        ${ResultSize})

    $uriRequest = if ($PsCmdlet.ParameterSetName -eq 'Identity') {
        New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "Recipient" 
    }
    else { 
        New-ExoURL -ParameterList $PSBoundParameters -endpoint "Recipient"
    }
    
    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes

}