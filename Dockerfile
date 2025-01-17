FROM ubuntu:20.04

# Set environment variables
ENV RUNNER_VERSION=2.317.0
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    jq \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Set the time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create a user for the runner
RUN useradd -m github-runner && \
    usermod -aG sudo github-runner && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/github-runner

# Download and extract the GitHub Actions runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Install additional dependencies
RUN sudo ./bin/installdependencies.sh

# Copy the startup script
COPY --chown=github-runner:github-runner start.sh .

RUN chmod +x start.sh

# Change ownership of the runner directory to the github-runner user
RUN chown -R github-runner:github-runner /home/github-runner

# Switch to the user
USER github-runner

# Set the entrypoint
ENTRYPOINT ["./start.sh"]