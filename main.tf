resource "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "selenium" {
  repository = "${helm_repository.stable.metadata.0.name}"
  chart = "selenium"
  name = "selenium"
  version = "${var.selenium_chart_version}"
  values = [
    "${file("values.yaml")}"
  ]
  set {
    name  = "chrome.replicas"
    value = "${var.chrome_replicas}"
  }
  set {
    name  = "firefox.replicas"
    value = "${var.firefox_replicas}"
  }
  set {
    name  = "chrome.tag"
    value = "${var.chrome_tag}"
  }
    set {
    name  = "firefox.tag"
    value = "${var.firefox_tag}"
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
  set {
    name = "hub.tag"
    value = "${var.hub_tag}"
  }
  set {
    name = "hub.javaOpts"
    value = "${var.hub_javaOpts}"
  }
  set {
    name = "chrome.javaOpts"
    value = "${var.chrome_javaOpts}"
  }
  set {
    name = "firefox.javaOpts"
    value = "${var.chrome_javaOpts}"
  }
}