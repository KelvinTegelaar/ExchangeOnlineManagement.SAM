# ExchangeOnlineManagement.SAM
See https://www.cyberdrain.com/automating-with-powershell-faster-exchange-powershell-commands/ for more information.

This is a PowerShell module that was created out of the ExchangeOnline module, to give partners access to the faster cmdlets, and Exchange Online Management easily with PowerShell

# Installation instructions

This module has been published to the PowerShell Gallery. Use the following command to install:  

    install-module ExchangeOnlineManagement.SAM

# Usage

For connecting using the Secure Application Model, you can use the following code:

```powershell
Connect-ExchangeOnline -DelegatedOrganization "Delegate.onmicrosoft.com" -ExchangeRefreshToken "YourVerylongRefreshToken" -UPN "A-Valid-UPN"   
```

If you wish to see the banner to discovery the new commands, you can connect using the following code:

```powershell
Connect-ExchangeOnline -DelegatedOrganization "Delegate.onmicrosoft.com" -ExchangeRefreshToken "YourVerylongRefreshToken" -UPN "A-Valid-UPN" -ShowBanner
```

The module also directly connects you to the Exchange Online environment by creating a remote session. This session can have any prefix you want by executing the following code:
```powershell
Connect-ExchangeOnline -DelegatedOrganization "Delegate.onmicrosoft.com" -ExchangeRefreshToken "YourVerylongRefreshToken" -UPN "A-Valid-UPN" -ShowBanner -prefix "exchangeonline"
```


# Contributions

Feel free to send pull requests or fill out issues when you encounter them. I'm also completely open to adding direct maintainers/contributors and working together! :) I'd love if we could make this into a huge help for our entire community.

# Future plans

Version 0.5 includes all things I required for myself, if you need a feature, shoot me a feature request :)
