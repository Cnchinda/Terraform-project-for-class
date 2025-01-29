
variable "instance_type" {
  type        = string
  description = "Instance type for ecs instances"
}

variable "instance_class" {
  type        = string
  description = "(optional) describe your variable"
}

variable "app1_instance" {
  type        = number
  description = "list the number of instances needed for app1"
  default     = "2"
}

variable "app2_instance" {
  type        = number
  description = "list the number of instances needed for app2"
  default     = "2"
}

variable "registration_app_instance" {
  type        = number
  description = "list the number of instances needed for registration app"
  default     = "2"
}

variable "username" {
  type        = string
  description = "(optional) describe your variable"
}

variable "port" {
  type        = number
  description = "(optional) describe your variable"
  default     = 3306
}

variable "db_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "webappdb" # MUST HAVE THIS NAME
}