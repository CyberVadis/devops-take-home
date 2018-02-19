docker stop devops-app-api-ps
docker rm devops-app-api-ps
docker run -d -p 8080:80 -p 1433:1433 --name devops-app-api-ps devops-app-api
docker ps
