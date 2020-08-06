variable "selenium_chart_version" {
  description = "Selenium chart version. More info: https://github.com/helm/charts/tree/master/stable/selenium"
  type        = string
  default     = "1.1.2"
}
variable "ui_service_type" {
  description = "Selenium hub service type"
  default     = "NodePort"
}
variable "chrome_replicas" {
  description = "Number of selenium chrome replicas"
  default     = 1
}

variable "chrome_tag" {
  description = "Version of chrome in selenium replicas"
  type        = string
  default     = "3.141.59"
}

variable "firefox_replicas" {
  description = "Number of selenium statefulset replica"
  default     = 1
}

variable "firefox_tag" {
  description = "Version of Firefox on the selenium replicas"
  type        = string
  default     = "3.141.59"
}

variable "hub_tag" {
  description = "tag"
  type        = string
  default     = "3.141.59"
}

variable "hub_javaOpts" {
  description = "javaOpts"
  type        = string
  default     = "-Xmx400m"
}

variable "chrome_javaOpts" {
  description = "javaOpts"
  type        = string
  default     = "-Xmx400m"
}

