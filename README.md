# ami-amazon-linux2
Step to deploy

1. Make sure packer is installed
2. Make sure connectivity established from your local to AWS ( aws sts get-caller-identity)

to build

1. packer version
2. packer validate al2-hardened.json
3. packer build al2-hardened.json
