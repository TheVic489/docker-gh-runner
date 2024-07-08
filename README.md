# GitHub Actions Runner

This is a Docker image for running GitHub Actions runners on a self-hosted runner.

## Usage
  
```bash
docker run -e ORGANIZATION=<your-org> -e REPOSITORY=<your-repo> -e ACCESS_TOKEN=<your-token> github-runner
```
