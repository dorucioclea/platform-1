az.cmd login

$subscriptionId = ""

if ([string]::IsNullOrEmpty($subscriptionId)) {
    $subscriptionId = Read-Host -Prompt "Enter subscription Id."

    if ([string]::IsNullOrEmpty($subscriptionId)) {
        Write-Error "Subscription Id cannot be empty."
        exit
    }
}

az.cmd account set --subscription $subscriptionId

$servicePrincipalTerraformFile = "service_principal"

if (Test-Path -Path $servicePrincipalTerraformFile) {
    Write-Error "Service principal data already exists please delete it."
    exit
}

# Create the service principal
$result = az.cmd ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subscriptionId"

# We need the appId and password
if ($result -match "appId") {
    # If we get this far it was successful
    $appId = $($result -match "appId").Split(":")[1]
    $appId = $appId.Replace(',', '')
    $appId = $appId.Replace('"', '')
    $appId = $appId.Trim()

    $password = $($result -match "password").Split(":")[1]
    $password = $password.Replace(',', '')
    $password = $password.Replace('"', '')
    $password = $password.Trim()

    $tenant = $($result -match "tenant").Split(":")[1]
    $tenant = $tenant.Replace(',', '')
    $tenant = $tenant.Replace('"', '')
    $tenant = $tenant.Trim()
}

Add-Content -Path $servicePrincipalTerraformFile -Value "--subscription-id '$subscriptionId'"
Add-Content -Path $servicePrincipalTerraformFile -Value "--app-id '$appId'"
Add-Content -Path $servicePrincipalTerraformFile -Value "--password '$password'"
Add-Content -Path $servicePrincipalTerraformFile -Value "--tenant '$tenant'"
Add-Content -Path $servicePrincipalTerraformFile -Value ""
Add-Content -Path $servicePrincipalTerraformFile -Value "# To delete the service principal"
Add-Content -Path $servicePrincipalTerraformFile -Value "# az ad sp delete --id '$appId' --subscription '$subscriptionId'"
