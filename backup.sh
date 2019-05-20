#!/bin/bash -e

set -e

gcloud auth activate-service-account ${SERVICE_ACCOUNT_EMAIL} \
  --key-file ${SERVICE_ACCOUNT_KEY_FILE} \
  --project ${SERVICE_ACCOUNT_PROJECT}



echo "creating ${FILEPATH}"
PGPASSWORD=${POSTGRES_SERVICE_PASSWORD} pg_dump -h ${POSTGRES_SERVICE_HOST} -U ${POSTGRES_SERVICE_USER} ${POSTGRES_SERVICE_DATABASE} | gzip | gsutil cp - gs://${SERVICE_ACCOUNT_STORAGE_BUCKET}/$1/
