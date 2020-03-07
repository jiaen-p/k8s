docker build -t jiaenpan/multi-client:latest -t jiaenpan/multi-client:$SHA ./client/Dockerfile ./client
docker build -t jiaenpan/multi-server:latest -t jiaenpan/multi-server:$SHA ./server/Dockerfile ./server
docker build -t jiaenpan/multi-worker:latest -t jiaenpan/multi-worker:$SHA ./worker/Dockerfile ./worker
# Built images and tag them twice, with latest and with git head hash, and push both to docker hub
docker push jiaenpan/multi-client:latest
docker push jiaenpan/multi-server:latest
docker push jiaenpan/multi-worker:latest

docker push jiaenpan/multi-client:$SHA
docker push jiaenpan/multi-server:$SHA
docker push jiaenpan/multi-worker:$SHA

# Force update to the latest SHA to the cluster 
kubectl apply -f ./k8s
kubectl set image deployment/multi-client-deployment client=jiaenpan/multi-client:$SHA
kubectl set image deployment/multi-server-deployment server=jiaenpan/multi-server:$SHA
kubectl set image deployment/multi-worker-deployment worker=jiaenpan/multi-worker:$SHA