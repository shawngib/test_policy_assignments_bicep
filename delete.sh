for rgname in `az group list --query "[? contains(name,'-hub')][].{name:name}" -o tsv`; do
echo Deleting ${rgname}
az group delete -n ${rgname} --yes --no-wait
done

for rgname in `az group list --query "[? contains(name,'-operations')][].{name:name}" -o tsv`; do
echo Deleting ${rgname}
az group delete -n ${rgname} --yes --no-wait
done
