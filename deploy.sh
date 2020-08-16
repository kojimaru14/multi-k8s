docker build -t lyugaloki/multi-client:latest -t lyugaloki/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t lyugaloki/multi-server:latest -t lyugaloki/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t lyugaloki/multi-worker:latest -t lyugaloki/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push lyugaloki/multi-client:latest
docker push lyugaloki/multi-server:latest
docker push lyugaloki/multi-worker:latest

docker push lyugaloki/multi-client:$GIT_SHA
docker push lyugaloki/multi-server:$GIT_SHA
docker push lyugaloki/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lyugaloki/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=lyugaloki/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=lyugaloki/multi-worker:$GIT_SHA