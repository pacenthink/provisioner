# provisioner 

This repo is used to provision infrastructure for the HashiStack.

## provision.sh

This is the entrypoint for all executed tasks.

### Pre-requisites

```shell
yum -y update
yum -y install git
```

### Usage

```
git clone https://github.com/pacenthink/provisioner
cd provisioner
./provision.sh [proxy | worker | master]
```