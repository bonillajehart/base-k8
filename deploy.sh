docker build -t seriousbob/multi-client:latest -t seriousbob/multi-client:$SHA  -f ./client/Dockerfile.dev ./client
docker build -t seriousbob/multi-server:latest -t seriousbob/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t seriousbob/multi-worker:latest -t seriousbob/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push seriousbob/multi-client:latest
docker push seriousbob/multi-client:$SHA

docker push seriousbob/multi-server:latest
docker push seriousbob/multi-server:$SHA

docker push seriousbob/multi-worker:latest
docker push seriousbob/multi-worker:$SHA

kubectl apply -f k8
kubectl set image deployments/server-deployment server=seriousbob/multi-server:$SHA
kubectl set image deployments/client-deployment client=seriousbob/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=seriousbob/multi-worker:$SHA