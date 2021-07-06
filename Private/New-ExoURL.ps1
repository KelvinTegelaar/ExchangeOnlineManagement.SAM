function New-ExoURL {
    [CmdletBinding()]
    param(
        [string]$identity,
        [string]$subset,
        [string]$subsettype,
        [String]$endpoint,
        [hashtable]$ParameterList

    )
    Write-Verbose "Generating EXO URL"
    Write-Verbose "Parameters for exo URL:"
    Write-Verbose $PSBoundParameters.GetEnumerator()
    $nvCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
    $uriRequest = if ($null -eq $PSBoundParameters.identity) {
        if ($PSBoundParameters.ParameterList) { $PSBoundParameters.ParameterList.GetEnumerator() | ForEach-Object { $nvcollection.add($_.Key, $_.Value) } }
        [System.UriBuilder]"$script:baseurl/$endpoint" 
    }
    else {
        if ($PSBoundParameters.ParameterList) { $PSBoundParameters.ParameterList.GetEnumerator() | ForEach-Object { $nvcollection.add($_.Key, $_.Value) } }
        $email = ($identity -split ':' | Select-Object -First 1)
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($email)
        $base64IdentityParam = [Convert]::ToBase64String($Bytes)
        if (($identity -split ':') -gt 1 -and $subsettype -in @("MailboxFolderPermission", "MailboxFolderStatistics")) {
            $subsetfolder = $identity -split ':' | select-object -Last 1
            if ($subsetfolder -eq $email) { $subsetfolder = '\' }
            $Bytes = [System.Text.Encoding]::UTF8.GetBytes($subsetfolder)
            $subsetparam = [Convert]::ToBase64String($Bytes)
            [System.UriBuilder]"$script:baseurl/$($endpoint)('$base64IdentityParam')/$($subset)('$subsetparam')/$subsettype" 
            $nvcollection.add('IsUsingMailboxFolderId', $true)
        }
        else { 
            if ($subsettype -eq "Exchange.GetMailboxFolderStatistics") { $subsettype = "$($subsettype)(folderscope=Exchange.ElcFolderType'All')" }
            [System.UriBuilder]"$script:baseurl/$($endpoint)('$base64IdentityParam')/$($subset)/$($subsettype)" 
        }
        $nvcollection.add('IsEncoded', $true)
    }
    $uriRequest.Query = $nvCollection.ToString()
    return $uriRequest.uri.OriginalString
}