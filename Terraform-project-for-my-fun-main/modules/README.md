# operational-enviroment-networking-tf

This module deploys vpc and all it's components with infrastructure Best practices.

# Usage

```
module "vpc" {
  source = "git::https://gitlab.com/kojibello/operational-enviroment-networking-tf.git"

  component_name = "testing-module"  
  vpc_cidr = "10.0.0.0/16"
  availability_zone = ["us-east-1a", "us-east-1b"]
  public_subnetcidr = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
  private_subnetcidr = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  database_subnetcidr = ["10.0.51.0/24", "10.0.53.0/24", "10.0.55.0/24"]
}
```

```
"Authenticate into aws"


export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_DEFAULT_REGION="your-region"  # e.g., us-east-1

```

