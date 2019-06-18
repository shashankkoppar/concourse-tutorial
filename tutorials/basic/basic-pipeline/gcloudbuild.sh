#!/bin/bash
set -eu

echo "${GCLOUD_SERVICE_ACCOUNT_KEY_FILE}" >> sa.json
gcloud auth activate-service-account --key-file=sa.json
cd resource-tutorial/tutorials/miscellaneous/docker-images/example-gradle
gcloud builds submit --tag=eu.gcr.io/sre-tooling/gradle-example2 --no-cache
gcloud container clusters get-credentials tooling --zone europe-west1-d --project sre-tooling
kubectl apply -f deploy.yaml
