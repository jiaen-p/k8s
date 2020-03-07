docker build -t "$DOCKER_USERNAME"/multi-client:latest -t "$DOCKER_USERNAME"/multi-client:$SHA ./client
docker build -t "$DOCKER_USERNAME"/multi-server:latest -t "$DOCKER_USERNAME"/multi-server:$SHA ./server
docker build -t "$DOCKER_USERNAME"/multi-worker:latest -t "$DOCKER_USERNAME"/multi-worker:$SHA ./worker
# Built images and tag them twice, with latest and with git head hash, and push both to docker hub
docker push "$DOCKER_USERNAME"/multi-client:latest
docker push "$DOCKER_USERNAME"/multi-server:latest
docker push "$DOCKER_USERNAME"/multi-worker:latest

docker push "$DOCKER_USERNAME"/multi-client:$SHA
docker push "$DOCKER_USERNAME"/multi-server:$SHA
docker push "$DOCKER_USERNAME"/multi-worker:$SHA

# Force update to the latest SHA to the cluster 
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client="$DOCKER_USERNAME"/multi-client:$SHA
kubectl set image deployments/server-deployment server="$DOCKER_USERNAME"/multi-server:$SHA
kubectl set image deployments/worker-deployment worker="$DOCKER_USERNAME"/multi-worker:$SHA