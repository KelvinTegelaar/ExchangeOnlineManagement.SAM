function New-GraphRequest ($uri) {
    $headers = @{ "Authorization" = $script:EOHeadertoken }
    Write-Verbose "Using $($uriRequest) as url"
    $nextURL = $uriRequest
    $ReturnedData = do {
        $Data = (Invoke-RestMethod -Uri $nextURL -Method GET -Headers $headers)
        if ($data.value) { $data.value } else { ($Data) }
        $nextURL = $data.'@odata.nextLink'
    } until ($null -eq $NextURL)
    return $ReturnedData   
}