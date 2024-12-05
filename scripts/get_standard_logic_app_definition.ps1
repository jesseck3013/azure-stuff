# This script is supposed to get a standard logic app's json definition with a given run id.
# The output will be stored in a workflow.json file in the current directory.

# Please enter the value of the parameters below
$subscriptionId = ""
$resourceGroupName = ""
$logicAppName = ""
$workflowName = ""
$runId = ""

function Get-History {
	 param (
	 	$subscriptionId,
		$resourceGroupName,
		$logicAppName,
		$workflowName,
		$runId
	 )
	 $uri = "https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Web/sites/${logicAppName}/hostruntime/runtime/webhooks/workflow/api/management/workflows/${workflowName}/runs/${runId}?api-version=2024-04-01"

	 $resp = Invoke-AzRestMethod -Method Get -Uri $uri
	 $history = $resp.Content | ConvertFrom-Json
	 $versionId = $history.properties.workflow.name	 
	 Write-Output $versionId
}

function Get-Workflow-Definition {
	 param (
	 	$versionId
	 )
	 $uri = "https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Web/sites/${logicAppName}/hostruntime/runtime/webhooks/workflow/api/management/workflows/${workflowName}/versions/${versionId}?api-version=2024-04-01"

	 $resp = Invoke-AzRestMethod -Method Get -Uri $uri
	 $versionInfo = $resp.Content | ConvertFrom-Json
	 $definition = $versionInfo.properties.definition | ConvertTo-JSON -depth 100

	 Write-Output $definition
}

$versionId = Get-History
$workflowDefinition = Get-Workflow-Definition -versionId $versionId
Set-Content -Value $workflowDefinition -Path ./workflow.json
