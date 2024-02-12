# AWS ECS Keycloak :key:
The Terraform and Dockerfile needed to run [Keycloak](https://www.keycloak.org/) in [Fargate](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html).  This is based on [@sibinnediyoram](https://github.com/sibinnediyoram)'s [Medium post](https://medium.com/cloudnloud/run-keycloak-in-amazon-ecs-3487f3352563).

## Setup
Easiest way to get started is with a [VS Code devcontainer](https://code.visualstudio.com/docs/devcontainers/tutorial) or [GitHub Codespace](https://github.com/features/codespaces) as it has the tools you'll need installed.

1. Set values in `./terragrunt/env/dev/env_vars.hcl`.
1. Set your AWS account ID and region in the `Makefile`.
1. Run the following:
```bash
make setup
```

## Architecture
1. This creates an ECS Fargate cluster with a single keyclock service running.
1. The database is an Aurora MySQL Serverless V2 cluster with an RDS proxy to handle connection pooling.
1. This is fronted by an ALB with a single listener and target group.
1. The VPC has two public subnets (with the ALB) and two private subnets (with the ECS Fargate cluster and RDS proxy).

## GitHub Actions
Uncomment the `pull_request` and `push` event triggers in the `.github/workflows/terraform_*.yml` workflows to enable GitHub Actions.  You will need to set the [repository variables](https://docs.github.com/en/actions/learn-github-actions/variables) below and have [GitHub OIDC auth setup in the AWS account](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services):
```bash
AWS_TF_APPLY_ROLE_ARN # OIDC role ARN for the Terraform apply action
AWS_TF_PLAN_ROLE_ARN  # OIDC role ARN for the Terraform plan action
AWS_REGION            # The region to deploy to
```

## Add another environment
Copy the `./terragrunt/env/dev` directory and update `env_vars.hcl` file with new values.
