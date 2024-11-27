$subscription = ''
$resourceGroupName = ''
$logicAppName = ''
$workflowName = ''
$triggerName = ''

$workflowDetails = az rest --method post --uri https://management.azure.com/subscriptions/$subscription/resourceGroups/$resourceGroupName/providers/Microsoft.Web/sites/$logicAppName/hostruntime/runtime/webhooks/workflow/api/management/workflows/$workflowName/triggers/$triggerName/listCallbackUrl?api-version=2018-11-01

Write-Host $workflowDetails
            