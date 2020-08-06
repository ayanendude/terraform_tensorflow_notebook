# https://www.terraform.io/docs/providers/kubernetes/index.html
provider "kubernetes" {
  config_path = "/Users/ayanendu_de/.kube/config"
}

# https://www.terraform.io/docs/providers/helm/index.html
provider "helm" {
  kubernetes {
    config_path = "/Users/ayanendu_de/.kube/config"
  }
}

provider "template" {
}

