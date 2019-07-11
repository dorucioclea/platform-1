# Startup

1. Create a service principal using one of the scripts (powershell or bash) this will create a service_principal file with relevant details - DON'T check this in.
2. Bootstrap tfscaffold using the following command replacing the following values with relevant values...
    1. -r uksouth                   -> -r region
    2. -p buying                    -> -p project
    3. --app-id 'some-app-id'       -> --app-id '<from_your_service_principal_file>'
    4. --password 'some-password'   -> --password '<from_your_service_principal_file>'
    5. --tenant 'some-tenant'       -> --tenant '<from_your_service_principal_file>'

``` powershell
docker run -v C:\git\my_project\tfscaffold\components\:/tfscaffold/components `
           -v C:\git\my_project\tfscaffold\etc\:/tfscaffold/etc `
           -v C:\git\my_project\tfscaffold\modules\:/tfscaffold/modules `
           -v C:\git\my_project\tfscaffold\plugin-cache\:/tfscaffold/plugin-cache `
tfscaffold -a apply -r uksouth -p demo --bootstrap `
--app-id 'some-app-id' `
--password 'some-password' `
--tenant 'some-tenant'
```

3. Plan (test) the components to validate they will do what they say they will using the following commands note you will need to apply the same substitutions (replacements) as in the bootstrap step. Also note that all that really changes is the -c component element of the command.

Keyvault

``` powershell
docker run -v C:\git\my_project\tfscaffold\components\:/tfscaffold/components `
           -v C:\git\my_project\tfscaffold\etc\:/tfscaffold/etc `
           -v C:\git\my_project\tfscaffold\modules\:/tfscaffold/modules `
           -v C:\git\my_project\tfscaffold\plugin-cache\:/tfscaffold/plugin-cache `
mikewinterbjss/tfscaffold -a plan -r uksouth -p buying -e dev -c keyvault `
--app-id 'some-app-id' `
--password 'some-password' `
--tenant 'some-tenant'
```

Vnet

``` powershell
docker run -v C:\git\my_project\tfscaffold\components\:/tfscaffold/components `
           -v C:\git\my_project\tfscaffold\etc\:/tfscaffold/etc `
           -v C:\git\my_project\tfscaffold\modules\:/tfscaffold/modules `
           -v C:\git\my_project\tfscaffold\plugin-cache\:/tfscaffold/plugin-cache `
mikewinterbjss/tfscaffold -a plan -r uksouth -p buying -e dev -c vnet `
--app-id 'some-app-id' `
--password 'some-password' `
--tenant 'some-tenant'
```

AKS

``` powershell
docker run -v C:\git\my_project\tfscaffold\components\:/tfscaffold/components `
           -v C:\git\my_project\tfscaffold\etc\:/tfscaffold/etc `
           -v C:\git\my_project\tfscaffold\modules\:/tfscaffold/modules `
           -v C:\git\my_project\tfscaffold\plugin-cache\:/tfscaffold/plugin-cache `
mikewinterbjss/tfscaffold -a plan -r uksouth -p buying -e dev -c aks `
--app-id 'some-app-id' `
--password 'some-password' `
--tenant 'some-tenant'
```

# Kubernetes

If you are using windows then use powershell and install the kubernetes cluster in docker.
If you are using macos :puke: then install and configure kubectl.
Also install the azure cli.

1. Log into the new aks cluster

``` powershell
az aks get-credentials --resource-group buying-aks-dev --name buying-aks-dev
```

# Helm

Install and configure helm

