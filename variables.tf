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