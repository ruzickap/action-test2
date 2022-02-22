# Test

Code:

```bash
PACKER_LATEST_VERSION="$(curl -s https://checkpoint-api.hashicorp.com/v1/check/packer | jq -r -M '.current_version')"
curl "https://releases.hashicorp.com/packer/${PACKER_LATEST_VERSION}/packer_${PACKER_LATEST_VERSION}_linux_amd64.zip" --output /tmp/packer_linux_amd64.zip
```

