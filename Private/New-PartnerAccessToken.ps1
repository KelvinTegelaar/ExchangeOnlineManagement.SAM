function New-PartnerAccessToken {
    #With special thanks to Luke Whitelock
    param (
        [String]$ApplicationId,
        [String]$RefreshToken,
        [String]$Scopes,
        [string]$Tenant
    )
    $AuthBody = @{
        client_id     = $ApplicationId
        scope         = $Scopes
        refresh_token = $RefreshToken
        grant_type    = "refresh_token"
    }
    try {
        $ReturnCred = (Invoke-RestMethod -uri "https://login.microsoftonline.com/$Tenant/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Method POST -Body $AuthBody -ErrorAction stop)
    }
    catch {
        Write-Error "Authentication Error Occured $_"
    }
    $ParsedCred = @{
        AccessToken = $ReturnCred.Access_Token
    }
    Return $ParsedCred
}
