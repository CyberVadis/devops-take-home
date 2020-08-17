# DevOps Take Home Exercise

## Repository content
- Folder with sample frontend application written in Angular
- Folder with sample backend microservice written in .NET Core 2, C# and T-SQL

The application is intended to show a list of recent security incidents.
Security incidents from the database are presented first. Additional rows on the list are randomly generated.

## Your Job
The purpose of this exercise is to demonstrate how to setup the infrastructure in a deployed Azure environment ​using code​. You can use whatever tools you want to do this (Chef, Puppet, Terraform, etc.). A few caveats for how the application should be deployed:
* Frontend is publicly available
* Backend service is a microservice that is called by frontend but is not publicly accessible
* AzureSQL database should not be publicly accessible

Don’t worry about fancy DNS for any parts of the application, accessing it via IP or Azure DNS is fine. Feel free to use Azure PaaS Services(e.g. App Services).

What we expect in your deliverable:
- All the needed links to the actual infrastructure
- All the needed links to your code

## Purpose of the Exercise
The purpose of the exercise is to understand how you approach the problem, the decisions you make in the infrastructure, and your ability to use code to accomplish things.

Please timebox your effort to 2 to 4 hours. An incomplete solution is not failing the exercise.

## Backend preparation
Download [.NET Core 2.x SDK](https://www.microsoft.com/net/download/windows) and run:
```
build.ps1
```

Remember to initialize MS SQL Database using:
```
backend\sql\initialize-db.sql
```

Optionally you can containerize backend application using Docker for Windows:
```
docker-build.ps1
```

Docker and docker-compose configuration aren't complete so additional effort needs to taken to prepare these.



##################################################################################################################



## To run application locally.
Ensure that var baseURL in file frontend/main.bundle.js is pointing to backend url,
in this case var baseURL = 'http://localhost:8080/';
Change directory to backend
Run command: 
```
docker-compose up
```
Open in browser page: http://localhost
You can open swagger on: http://localhost:8080/swagger
To stop run command: 
```
docker-compose down
```

## To run application in Kubernetes claster


## Create azure cubernates claster, private docker registry, prepare and push images to registry
Login to Azure: 
```
az login
```
Change directory to infra
Run command: 
```
terraform apply
```

## Deploy applications and services

When claster is created, you can deploy application and create services by typing

```
kubectl apply -f app-deployment.yaml,app-service.yaml,db-deployment.yaml,db-service.yaml,web-deployment.yaml,web-service.yaml,db-deployment.yaml,db-claim0-persistentvolumeclaim.yaml
```

## Exposing app to public
Couse we don't know public ip of app, we have to check it by command
```
kubectl get services
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)          AGE
app          LoadBalancer   10.0.251.123   40.68.20.254    8080:30671/TCP   3h7m
db           ClusterIP      10.0.204.221   <none>          1433/TCP         82m
kubernetes   ClusterIP      10.0.0.1       <none>          443/TCP          6d4h
web          LoadBalancer   10.0.20.204    40.68.133.167   80:32064/TCP     3h7m
```
Then we hava to adjust var baseURL in file frontend/main.bundle.js is pointing to backend url,
in this case it will be app EXTERNALL-IP var baseURL = 'http://40.68.20.254:8080/';

Then we have to again run command:
```
kubectl apply -f app-deployment.yaml,app-service.yaml,db-deployment.yaml,db-service.yaml,web-deployment.yaml,web-service.yaml,db-deployment.yaml,db-claim0-persistentvolumeclaim.yaml
```

To check if docker images are deployd type:
```
kubectl get deployments
```
You shuld get result like this:
```
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
app    1/1     1            1           3h4m
db     1/1     1            1           3h4m
web    1/1     1            1           3h4m
```
Then you have to check sercices public IP
```
kubectl get services
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)          AGE
app          LoadBalancer   10.0.251.123   40.68.20.254    8080:30671/TCP   3h7m
db           ClusterIP      10.0.204.221   <none>          1433/TCP         82m
kubernetes   ClusterIP      10.0.0.1       <none>          443/TCP          6d4h
web          LoadBalancer   10.0.20.204    40.68.133.167   80:32064/TCP     3h7m
|```
Application is accessible on web external IP




