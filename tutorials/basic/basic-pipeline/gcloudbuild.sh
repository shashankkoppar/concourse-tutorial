#!/bin/bash
env
set -eu
cat /Users/shashank/Downloads/sre-tooling-5add44bce09f.json
cat ${GCLOUD_SERVICE_ACCOUNT_KEY_FILE}
echo "${GCLOUD_SERVICE_ACCOUNT_KEY_FILE}" >> sa.json
gcloud auth activate-service-account --key-file=sa.json
cd resource-tutorial/tutorials/miscellaneous/docker-images/docker
gcloud builds submit --tag=eu.gcr.io/sre-tooling/hello-world-example
gcloud container clusters get-credentials tooling --zone europe-west1-d --project sre-tooling

kubectl run hello-world --image=eu.gcr.io/sre-tooling/hello-world-example
