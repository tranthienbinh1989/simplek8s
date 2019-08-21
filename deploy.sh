docker build -t tranthienbinh/multi-client:latest -t tranthienbinh/multi-client:$SHA -f  ./client/Dockerfile ./client
docker build -t tranthienbinh/multi-server:latest -t tranthienbinh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tranthienbinh/multi-worker:latest -t tranthienbinh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tranthienbinh/multi-client:latest
docker push tranthienbinh/multi-server:latest
docker push tranthienbinh/multi-worker:latest

ocker push tranthienbinh/multi-client:$SHA
docker push tranthienbinh/multi-server:$SHA
docker push tranthienbinh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tranthienbinh/multi-server:$SHA
kubectl set image deployments/client-deployment client=tranthienbinh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tranthienbinh/multi-worker:$SHA