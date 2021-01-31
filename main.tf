data "azurerm_kubernetes_cluster" "k8s" {
  name = var.k8s_clustername
  resource_group_name = var.k8s_resource_group_name
}

/* resource "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
} */

/* resource "helm_release" "tensorflow-notebook" {
  //repository = "${helm_repository.stable.metadata.0.name}"
  //repository = "https://kubernetes-charts.storage.googleapis.com"
  repository = "https://charts.helm.sh/stable"
  //repository = "https://charts.bitnami.com/bitnami"
  chart = "tensorflow-notebook" // if stable/ added, it will try to find stable/tesnor.. in repo, hence will not find
  name = "tensorflow-notebook"
  //version = var.chart_version
  values = [
    "${file("values.yaml")}"
  ]
  set {
    name  = "tensorboard.image.pullPolicy"
    value = "${var.tensorboard_image_pullPolicy}"
  }
  set {
    name  = "tensorboard.image.tag"
    value = "${var.tensorboard_image_tag}"
  }
  set {
    name  = "tensorboard.image.repository"
    value = "${var.tensorboard_image_repository}"
  }
} */

/* resource "helm_release" "redis_1" {
  name  = "redis"
  chart = "bitnami/redis"
} */

resource "helm_release" "selenium_1" {
  repository = "https://charts.helm.sh/stable"
  name  = "selenium"
  chart = "selenium"
  values = [
    "${file("values.yaml")}"
  ]
  set {
    name  = "chrome.replicas"
    value = 2
  }
  set {
    name  = "firefox.replicas"
    value = 1
  }
  set {
    name = "chrome.enabled"
    value = "true"
  }
  set {
    name = "firefox.enabled"
    value = "true"
  }
  set {
    name = "chrome.pullPolicy"
    value = "Always"
  }
  set {
    name = "firefox.pullPolicy"
    value = "Always"
  }
}