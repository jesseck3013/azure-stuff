$parameters = @{
    Token = (az account get-access-token | ConvertFrom-Json).accessToken
    LogicApp = '<logic-app-name>'
    ResourceGroup = '<Azure-resource-group-name>'
    SubscriptionId = $SubscriptionId
    Verbose = $true
}

Get-LogicAppTemplate @parameters | Out-File C:\template.json