docker build -t thetkpark/multi-client:latest -t thetkpark/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thetkpark/multi-server:latest -t thetkpark/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thetkpark/multi-worker:latest -t thetkpark/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thetkpark/multi-client:latest
docker push thetkpark/multi-server:latest
docker push thetkpark/multi-worker:latest

docker push thetkpark/multi-client:$SHA
docker push thetkpark/multi-server:$SHA
docker push thetkpark/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=thetkpark/multi-client:$SHA
kubectl set image deployments/server-deployment server=thetkpark/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=thetkpark/multi-worker:$SHA
