## Description
This repository is created to demonstrate how we can deploy application on k8s cluster 
with Jenkins, Terraform and Helm. Intention is to showcase minimum viable product. Customizations 
are encouraged as required. 

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| chart_version | Tensorflow chart version. More info: https://github.com/helm/charts/tree/master/stable/tensorflow-notebook | string | `0.1.3` | no |
| tensorboard_image_pullPolicy | Tensorboard image pullPolicy | string | `Always` | no |
| tensorboard_image_tag | TensorFlow Development image tag | string | `latest` | no |
| tensorboard_image_repository | TensorFlow Development image repo | string | `tensorflow/tensorflow` | no |
| service_type | The kubernetes service type | string | `NodePort` | no |


## Probable error you may face
1.  Default user forbidden to perform tasks in kubernetes cluster.

    ### Error:
    I received below error when performing "terraform apply".
    Error: rpc error: code = Unknown desc = configmaps is forbidden: User "system:serviceaccount:kube-system:default" cannot list resource "configmaps" 
    in API group "" in the namespace "kube-system"

    ### Reason: 
    Default user in kube-system namespace does not have required permissions. 
    
    ### Resolution: 
    To make it simple, I added cluster-admin role to default id using yaml below.

```
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
    name: default
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: cluster-admin
    subjects:
    - kind: ServiceAccount
    name: default
    namespace: kube-system
```

2.  Deploy does not finish. 

    ### Error:
    Terraform apply shows "..still creating.." till timeout. Although the 
    release is created and working as expected.

    ### Reason: 
    Helm 2 to Helm 3 migration. And terraform provider used is Helm 2 supportive.
    Terraform was creating helm 2 release. Kubernetes cluster was trying to find 
    helm 3 release and not getting it. As a result, terraform was thinking release 
    is not yet created and never finishing.
    
    ### Resolution: 
    Follow instructions mentioned in below pages. Converting releases and 
    cleaning up configuration willbe required.
    https://github.com/helm/helm-2to3
    https://helm.sh/blog/migrate-from-helm-v2-to-helm-v3/

3.  Helm list does not show release.

    ### Error:
    helm list does not show release althogh release is deployed and
    pods are working. 

    ### Reason: 
    Same as point 2.

    ### Resolution:
    Same as point 2.

4.  Cluster out of resource.

    ### Error:
    Terraform is trying to created pods, but pods are throwing below error.
    2 Insufficient cpu, 2 Insufficient memory.

    ### Reason: 
    Cluster has limited memory and cpu. By default, chart tries to craete with
    .5 cpu and 500 MiB memory. Multiple of these may exhaust cluster.
    
    ### Resolution: 
    Add resource limit.
