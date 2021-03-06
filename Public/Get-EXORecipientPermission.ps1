function Get-EXORecipientPermission {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'Identity')]
        [string]
        ${Trustee},

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'Identity')]
        [System.Collections.Generic.HashSet[Microsoft.Exchange.Management.AdminApiProvider.RecipientAccessRight]]
        ${AccessRights},

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
        New-ExoURL -identity ($PSBoundParameters.GetEnumerator() | ForEach-Object { $_.value }  | Select-Object -First 1) -endpoint "Recipient" -ParameterList @{'$expand' = 'RecipientPermission' ; '$select' = 'RecipientPermission' }
    }
    else { 
        New-ExoURL -endpoint "Recipient" -ParameterList @{'$expand' = 'RecipientPermiss3ion' ; '$select' = 'RecipientPermission' }
    }
    $mailboxes = New-GraphRequest -uri $uriRequest
    return $mailboxes
}