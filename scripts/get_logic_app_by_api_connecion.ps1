function Get-ConsumptionLogicApp {
	param (
		$apiConnectionId
	)
	
	$logicAppList = Get-AzLogicApp
	$result = @()
	
	foreach ($logicApp in $logicAppList) {
		$connections = $logicApp.Parameters | ConvertTo-JSON

		if ($connections.ToLower().Contains($apiConnectionId.ToLower())) {
			$result += $logicApp.Id
		}
	}
	return ,$result
}

function Get-StandardLogicApp {
	param (
		$apiConnectionId
	)
	
	$siteList = Get-AzWebApp 
	$standardLogicAppList = $siteList | Where-Object { $_.Kind.Contains("workflowapp") }

	$result = @()
	foreach ($standardLogicApp in $standardLogicAppList) {
		$uri = "https://management.azure.com/$($standardLogicApp.Id)/workflowsconfiguration/connections/?api-version=2018-11-01"
		
		$response = Invoke-AzRestMethod -Method Get -Uri $uri
		if ($response.Content.ToLower().Contains($apiConnectionId.ToLower())) {	
			$result += $standardLogicApp.Id
		}
		Start-Sleep -Seconds 1
	}
	
	return ,$result
}

function Get-LogicApps {
	param(
		$apiConnectionId
	)
	
	$consumptionResult = Get-ConsumptionLogicApp -apiConnectionId $apiConnectionId 
	$standardResult = Get-StandardLogicApp -apiConnectionId $apiConnectionId
	
	Write-Host "Found $($consumptionResult.length) consumption Logic Apps"
	$consumptionResult | Format-List
	
	Write-Host "Found $($standardResult.length) standard Logic Apps"
	$standardResult | Format-List
}

$subscriptionId = "<subscription id>"
Set-AzContext -Subscription $subscriptionId
	
$apiConnectionId = "<api connection's resource id>"
Get-LogicApps -apiConnectionId $apiConnectionId
