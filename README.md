# img-okd-tools

This image can be used to run the `oc` client in a container. Don't forget to add RoleBindings to the ServiceAccount that will be used to run the container.

### Tools available in the container

* `oc` client as released by the OKD project
* `kubeconform` binary from [yannh/kubeconform](https://github.com/yannh/kubeconform/)
* `kubectl-paas` binary from [belastingdienst/opr-paas-cli](https://github.com/belastingdienst/opr-paas-cli)
* `jq`
* everything from `procps-ng`, like `watch`

For validation of Paas objects with kubeconform, we've also added the Paas CRD's to the image.
