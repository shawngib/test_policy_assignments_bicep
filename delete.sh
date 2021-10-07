for subscription in `az account list --query "[? contains(name,'ASCII')][].id" -o tsv`; do
    az account set --subscription $subscription
        for rgname in `az group list --query "[? contains(name,'$1')][].{name:name}" -o tsv`; do
        echo Deleting ${rgname}
        az group delete -n ${rgname} --yes --no-wait
        done
        for setting in `az monitor diagnostic-settings subscription list --query "value[? contains(@.name, '$1')].name" -o tsv`; do
            echo Deleting ${setting}
            az monitor diagnostic-settings delete --name $setting --resource "/subscriptions/${subscription}"
        done    
done
az account set --subscription $2