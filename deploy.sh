docker build -t giuntalio/multi-client:latest -t giuntalio/multi-client:$SHA ./client/Dockerfile ./client
docker build -t giuntalio/multi-server:latest -t giuntalio/multi-server:SHA ./server/Dockerfile ./server
docker build -t giuntalio/multi-worker:latest -t giuntalio/multi:worker:SHA ./worker/Dockerfile ./worker

docker push giuntalio/multi-client:latest
docker push giuntalio/multi-server:latest
docker push giuntalio/multi-worker:latest 

docker push giuntalio/multi-client:$SHA
docker push giuntalio/multi-server:$SHA
docker push giuntalio/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=giuntalio/multi-server:$SHA
kubectl set image deployments/client-deployment client=giuntalio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=giuntalio/multi-worker:$SHA
