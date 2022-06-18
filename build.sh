#!/bin/sh
VERS=$(jq -r .version package.json)
REGISTRY=ghcr.io/rgstephens
IMAGE=golf-strapi
K8S_DEPLOYMENT=strapi
K8S_NAMESPACE=strapi
#DOCKER_PLATFORMS=linux/arm64
DOCKER_PLATFORMS=linux/amd64
#DOCKER_PLATFORMS=linux/amd64,linux/arm64

echo Building ${REGISTRY}/${IMAGE}:${VERS}
if [ -z "$CR_PAT" ]; then
  echo "must set CR_PAT"
  exit 1
fi
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

# 6m build only amd
#time docker buildx build --platform linux/amd64 --output=type=registry --tag ${REGISTRY}/${IMAGE}:${VERS} --tag ${REGISTRY}/${IMAGE}:latest .
# 7:21m build time
time docker buildx build --platform ${DOCKER_PLATFORMS} --output=type=registry --tag ${REGISTRY}/${IMAGE}:${VERS} --tag ${REGISTRY}/${IMAGE}:latest .
EXITCODE=$?
echo EXITCODE: ${EXITCODE}
# time docker build -t ${REGISTRY}/${IMAGE}:${VERS} -t ${REGISTRY}/${IMAGE}:latest .
#docker push ghcr.io/rgstephens/golftrip.link --all-tags

#kubectl config use-context default
#kubectl rollout restart deploy ${K8S_DEPLOYMENT} -n ${K8S_NAMESPACE}

#docker pull ${REGISTRY}/${IMAGE}:latest