#!/bin/bash

ORGANIZATION=$ORGANIZATION
REPOSITORY=$REPOSITORY
ACCESS_TOKEN=$ACCESS_TOKEN

REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/repos/${ORGANIZATION}/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/github-runner

./config.sh --url https://github.com/${ORGANIZATION}/${REPOSITORY} --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!