#!/bin/bash

# Detect OS type to decide on the sed -i syntax
case "$(uname)" in
  Darwin*) sed_i_opt=(-E -i '') ;;  # macOS
  *) sed_i_opt=(-E -i) ;;           # Linux
esac

echo -n "Enter GitHub username/org: "
read username

find . -type f -name '*.yaml' -exec sed "${sed_i_opt[@]}" s#https://github.com/[-_a-zA-Z0-9]+#https://github.com/${username}#g {} +
find . -type f -name '*.yaml' -exec sed "${sed_i_opt[@]}" s#ghcr.io/[-_a-zA-Z0-9]+#ghcr.io/${username}#g {} +

echo "Enter Argo CD destination name or server where applications will be deployed (e.g. in-cluster, https://kubernetes.default.svc)"
echo -n "Destination: "
read destination

if [[ $destination == https:* ]]; then
  sed -i.bak -E "s@^        (# )?server:.*@        server: ${destination}@g" argocd/appset.yaml
  sed -i.bak -E "s@^        (# )?name:.*@        # name: REPLACEME@g" argocd/appset.yaml
else
  sed -i.bak -E "s@^        (# )?name:.*@        name: ${destination}@g" argocd/appset.yaml
  sed -i.bak -E "s@^        (# )?server:.*@        # server: https://REPLACEME@g" argocd/appset.yaml
fi
rm -f argocd/appset.yaml.bak


# #!/bin/bash

# echo -n "Enter GitHub username/org: "
# read username

# find . -type f -name '*.yaml' -exec sed -E -i '' s#https://github.com/[-_a-zA-Z0-9]+#https://github.com/${username}#g {} +
# find . -type f -name '*.yaml' -exec sed -E -i '' s#ghcr.io/[-_a-zA-Z0-9]+#ghcr.io/${username}#g {} +

# echo "Enter Argo CD destination name or server where applications will be deployed (e.g. in-cluster, https://kubernetes.default.svc)"
# echo -n "Destination: "
# read destination

# if [[ $destination == https:* ]]; then
#   sed -i.bak -E "s@^        (# )?server:.*@        server: ${destination}@g" argocd/appset.yaml
#   sed -i.bak -E "s@^        (# )?name:.*@        # name: REPLACEME@g" argocd/appset.yaml
# else
#   sed -i.bak -E "s@^        (# )?name:.*@        name: ${destination}@g" argocd/appset.yaml
#   sed -i.bak -E "s@^        (# )?server:.*@        # server: https://REPLACEME@g" argocd/appset.yaml
# fi
# rm -f argocd/appset.yaml.bak
