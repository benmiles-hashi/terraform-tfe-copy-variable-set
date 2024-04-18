variable "orgname" {
  default = "ben-miles-org"
}
variable "vs_source" {
  type = string
  description = "Name of source variable set to copy"
}
variable "vs_target" {
  default = "VariableSetCopy"
  description = "Name of target variable set to create"
}
variable "token" {
  description = "TFE token"
}