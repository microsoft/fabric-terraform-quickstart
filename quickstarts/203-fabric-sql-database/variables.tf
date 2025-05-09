variable "fabric_workspace_name" {
  description = "The name of workspace to be created."
  type        = string
}

variable "fabric_sql_database_name" {
  description = "The name of SQL database to be created."
  type        = string
}

variable "fabric_capacity_name" {
  description = "The existing Fabric Capacity name."
  type = string
}

variable "tenant_id" {
  description = "The tenant id."
  type = string
}

variable "client_id" {
  description = "The Application (client) ID."
  type = string
}

variable "client_certificate_file_path" {
  description = "The local path of the certificate which needs to pfx format."
  type = string
}

variable "client_certificate_password" {
  description = "The password of the certificate."
  type = string
}

variable "user_principal_id" {
  description = "principal_id is the user account object id."
  type = string
}
