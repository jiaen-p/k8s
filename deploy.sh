docker build tag "$DOCKER_USERNAME"/multi-client:latest tag "$DOCKER_USERNAME"/multi-client:$SHA ./client/Dockerfile ./client
docker build tag "$DOCKER_USERNAME"/multi-server:latest tag "$DOCKER_USERNAME"/multi-server:$SHA ./server/Dockerfile ./server
docker build tag "$DOCKER_USERNAME"/multi-worker:latest tag "$DOCKER_USERNAME"/multi-worker:$SHA ./worker/Dockerfile ./worker
# Built images and tag them twice, with latest and with git head hash, and push both to docker hub
docker push "$DOCKER_USERNAME"/multi-client:latest
docker push "$DOCKER_USERNAME"/multi-server:latest
docker push "$DOCKER_USERNAME"/multi-worker:latest

docker push "$DOCKER_USERNAME"/multi-client:$SHA
docker push "$DOCKER_USERNAME"/multi-server:$SHA
docker push "$DOCKER_USERNAME"/multi-worker:$SHA

# Force update to the latest SHA to the cluster 
kubectl apply -f ./k8s
kubectl set image deployments/multi-client-deployment client="$DOCKER_USERNAME"/multi-client:$SHA
kubectl set image deployments/multi-server-deployment server="$DOCKER_USERNAME"/multi-server:$SHA
kubectl set image deployments/multi-worker-deployment worker="$DOCKER_USERNAME"/multi-worker:$SHA