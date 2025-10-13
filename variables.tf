variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"

  validation {
    condition = contains([
      "us-east-1", "us-east-2", "us-west-1", "us-west-2",
      "af-south-1", "ap-east-1", "ap-south-1", "ap-south-2",
      "ap-southeast-1", "ap-southeast-2", "ap-southeast-3", "ap-southeast-4",
      "ap-northeast-1", "ap-northeast-2", "ap-northeast-3",
      "ca-central-1", "ca-west-1",
      "eu-central-1", "eu-central-2", "eu-west-1", "eu-west-2", "eu-west-3",
      "eu-north-1", "eu-south-1", "eu-south-2",
      "il-central-1", "mx-central-1",
      "me-south-1", "me-central-1",
      "sa-east-1",
      "us-gov-east-1", "us-gov-west-1"
    ], var.region)

    error_message = "Invalid region."
  }
}

variable "instance_type" {
  description = "The type of instance to deploy"
  default     = "t2.micro"

  validation {
    condition = contains([
      "t2.micro", "t2.small",
      "t3.micro", "t3.small", "t3.medium",
      "t4g.micro", "t4g.small", "t4g.medium",
      "m5.large", "m5.xlarge"
    ], var.instance_type)

    error_message = "Invalid instance type."
  }
}
