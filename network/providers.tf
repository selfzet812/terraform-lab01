provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Project     = "lab01"
      Environment = "Dev"
      ManagedBy   = "terraform"
    }
  }
}



