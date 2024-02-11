# AWS ECS Keycloak :key:
The Terraform and Dockerfile needed to run [Keycloak](https://www.keycloak.org/) in [Fargate](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html).  This is based on [@sibinnediyoram](https://github.com/sibinnediyoram)'s [Medium post](https://medium.com/cloudnloud/run-keycloak-in-amazon-ecs-3487f3352563).

This is still a work in progress and needs more testing.

## Setup
Easiest way to get started is with a [VS Code devcontainer](https://code.visualstudio.com/docs/devcontainers/tutorial) or [GitHub Codespace](https://github.com/features/codespaces) as it has the tools you'll need installed.

1. Set values in `./terragrunt/env/dev/env_vars.hcl`
2. Build the Docker image:
```bash
docker build -t keycloak:latest -f docker/Dockerfile .
```
2. Run the following:
```bash
cd terragrunt/env/dev

# Create the ECR
terragrunt init
terragrunt apply --target=aws_ecr_repository.keycloak

# Get the Docker login an push commands for the new ECR from the console and push your Keycloak image
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/keycloak:latest"

# Finish creating the infrastructure
terragrunt apply
```

## Architecture
1. This creates an ECS Fargate cluster with a single keyclock service running.
1. The database is an Aurora MySQL Serverless V2 cluster with an RDS proxy to handle connection pooling.
1. This is fronted by an ALB with a single listener and target group.
1. The VPC has two public subnets (with the ALB) and two private subnets (with the ECS Fargate cluster and RDS proxy).

## Add another environment
Copy the `./terragrunt/env/dev` directory and update `env_vars.hcl` file with new values.
