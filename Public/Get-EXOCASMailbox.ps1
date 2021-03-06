function Get-EXOCASMailbox {
    [CmdletBinding(DefaultParameterSetName = 'Anr')]
    param(
        [ValidateNotNullOrEmpty()]
        [string]
        ${Filter},

        [Parameter(ParameterSetName = 'Anr')]
        [ValidateLength(3, 5120)]
        [string]
        ${Anr},

        [ValidateNotNullOrEmpty()]
        [string]
        ${OrganizationalUnit},

        [string[]]
        ${Properties},

        [Microsoft.Exchange.Management.RestApiClient.GetExoCasMailbox+PropertySet[]]
        ${PropertySets},

        [switch]
        ${ProtocolSettings},


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
        New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "Casmailbox" 
    }
    else { 
        New-ExoURL -ParameterList $PSBoundParameters -endpoint "CasMailbox"
    }
    if ($PSBoundParameters.ProtocolSettings) { $uriRequest = "$($uriRequest)&PropertySet=ProtocolSettings" }

    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes

}

