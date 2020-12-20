variable "chart_version" {
  description = "Rensorflow_notebook chart version. More info: https://github.com/helm/charts/tree/master/stable/tensorflow-notebook"
  type        = string
  default     = "0.1.3"
}
variable "service_type" {
  description = "tensorflow_notebook service type"
  default     = "NodePort"
}
variable "tensorboard_image_pullPolicy" {
  description = "Image pull policy"
  default     = "Always"
}
variable "tensorboard_image_tag" {
  description = "TensorFlow Development image tag"
  type        = string
  default     = "latest"
}
variable "tensorboard_image_repository" {
  description = "TensorFlow Development image repo"
  type        = string
  default     = "tensorflow/tensorflow"
}
variable "subscription_id" {
  description = "subscription_id"
  type        = string
}

variable "tenant_id" {
  description = "tenantid"
  type        = string
}

variable "client_id" {
  description = "client_id"
  type        = string
}

variable "client_secret" {
  description = "client_secret"
  type        = string
}
variable "k8s_clustername" {
  description = "k8s_clustername"
  type        = string
  default     = "aks1"
}
variable "k8s_resource_group_name" {
  description = "k8s_resource_group_name"
  type        = string
  default     = "dev_rg_aks"
}