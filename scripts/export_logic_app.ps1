Connect-AzAccount

$context = Get-AzContext

$subscription = $context.Subscription

$laList = Get-AzLogicApp

New-Item -Path ./la_templates -ItemType Directory

foreach ($la in $laList) {
    $filePath = "./la_templates/" + $la.Name + ".json"
    Write-Host "Exporting workflow definition of " + $la.Name
    Set-Content -Path $filePath -Value $la.Definition.ToString()
}
