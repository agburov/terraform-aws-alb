variable "tcp80" {
  default     = "80"
  description = "Allow tcp port 80"
}

variable "tcp22" {
  default     = "22"
  description = "Allow tcp port 22 for debugging"
}

variable "tcp0" {
  default     = "0"
  description = "Allow all traffic"
}
