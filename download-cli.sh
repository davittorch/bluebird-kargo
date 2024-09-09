#!/bin/bash

if [ -z "$1" ]; then
  echo "./download-cli.sh /usr/local/bin/kargo"
  exit 1
fi

# Get the latest version tag from GitHub
version=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/akuity/kargo/releases/latest))

# Get OS and architecture
os=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)

# Map architecture names
if [[ "$arch" == "x86_64" ]]; then
  arch="amd64"
elif [[ "$arch" == "aarch64" ]]; then
  arch="arm64"
else
  echo "Unsupported architecture: $arch"
  exit 1
fi

# Construct the download URL
download_url=https://github.com/akuity/kargo/releases/download/${version}/kargo-${os}-${arch}

# Download the binary
echo "Downloading kargo from: ${download_url}"
curl -L -o ${1} ${download_url}

# Check if the download was successful
if [ $? -ne 0 ]; then
  echo "Failed to download kargo."
  exit 1
fi

# Make the downloaded file executable
chmod +x ${1}
echo "kargo downloaded and installed to ${1}"




# #!/bin/bash

# if [ -z "$1" ]; then
#   echo "./download-cli.sh /usr/local/bin/kargo"
#   exit 1
# fi

# version=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/akuity/kargo/releases/latest))
# os=$(uname -s | tr '[:upper:]' '[:lower:]')
# arch=$(uname -m)
# download_url=https://github.com/akuity/kargo/releases/download/${version}/kargo-${os}-${arch}

# curl -L -o ${1} ${download_url}
# chmod +x ${1}
