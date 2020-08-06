resource "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "tensorflow-notebook" {
  repository = "${helm_repository.stable.metadata.0.name}"
  chart = "tensorflow-notebook"
  name = "tensorflow-notebook"
  version = "${var.chart_version}"
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
}