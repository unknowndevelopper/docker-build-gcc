#!/usr/bin/env bash

set -e
set -u
API_URL="https://api.github.com"
REPO_NAME=myTarballsBuiltWithTravis
REPO_URL="$API_URL/repos/unknowndevelopper/$REPO_NAME"
AUTH_HEADER="Authorization: token $github_api_token"
ASSET_FILE=$1
ASSET_NAME=$(basename $ASSET_FILE)

TAG=1.0
echo Release from tag $TAG
RELEASE_ID=$(curl -s -H "$AUTH_HEADER" $REPO_URL/releases/tags/$TAG | jq  '.id')
echo RELEASE_ID=$RELEASE_ID

echo
echo List current assets for the release
curl -s -H "$AUTH_HEADER" $REPO_URL/releases/$RELEASE_ID | jq '.assets|.[]|.name'
echo

echo get its asset id if exist of asset $ASSET_NAME
ASSET_ID=$(curl -s -H "$AUTH_HEADER" $REPO_URL/releases/$RELEASE_ID| jq ".assets|.[]|select( .name | contains(\"$ASSET_NAME\"))|.id")
echo ASSET_ID=$ASSET_ID

echo
echo Delete Asset $ASSET_ID
curl -v -X DELETE -H "$AUTH_HEADER" $REPO_URL/releases/assets/$ASSET_ID

echo
echo Upload $ASSET_NAME
UPLOAD_URL=https://uploads.github.com/repos/unknowndevelopper/$REPO_NAME/releases/$RELEASE_ID/assets
curl -v -X POST -H "$AUTH_HEADER" -H "Content-Type: application/octet-stream" \
     --data-binary @$ASSET_FILE "$UPLOAD_URL?name=$ASSET_NAME"


