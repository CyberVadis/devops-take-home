docker stop devops-app-api-v0.1
docker rm devops-app-api-v0.1
docker run -d -p 8080:80 --name devops-app-api-v0.1 devops-app-api
docker ps