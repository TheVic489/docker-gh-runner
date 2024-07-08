# GitHub Actions Runner

This is a Docker image for running GitHub Actions runners on a self-hosted runner.

## Usage
  
```bash
docker run \
    --detach \
    --env ORGANIZATION=<YOUR-GITHUB-ORGANIZATION> \
    --env ACCESS_TOKEN=<YOUR-GITHUB-ACCESS-TOKEN> \
    --env REPOSITORY=<YOUR-GITHUB-REPOSITORY> \
    --env REG_TOKEN=<YOUR-GITHUB-TOKEN> \
    --name runner \
    github-runner
```
