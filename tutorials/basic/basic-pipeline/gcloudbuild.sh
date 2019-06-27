#!/bin/bash
set -eu

echo "${GCLOUD_SERVICE_ACCOUNT_KEY_FILE}" >> sa.json
gcloud auth activate-service-account --key-file=sa.json
gcloud config set project sre-tooling
gcloud config set builds/use_kaniko True
cd resource-tutorial/tutorials/miscellaneous/docker-images/example-gradle
gcloud builds submit --tag=eu.gcr.io/sre-tooling/gradle-example2 --no-cache
gcloud components install kubectl
gcloud container clusters get-credentials tooling --zone europe-west1-d --project sre-tooling
CURRENT_CONTEXT=$(kubectl config current-context)
kubernetes-deploy kaniko $CURRENT_CONTEXT --template-dir=.
stern -n kaniko --exclude-container istio-proxy gradle-deployment
