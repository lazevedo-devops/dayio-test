# Dayio Challenge

This repo contains a quickly way to full implement the components required by Dayio Challenge.

#### Usage

```code
chomd +x dayio.sh
./dayio.sh
```

After that we'll have the Applications installed at minikube cluster and acessible by minikube service command.

#### Accessing the services

Basically the ```minikube service command``` will create a local tunnel with random port for connect to the Kubernetes service desired.

Once the command executed will be opened your browser directly to the tunnel created, then you can just put the /path available and see Hello World message from application. 

**Development**

```code
minikube -n development service <SERVICE_NAME>
```

|Available Services|Port|Path|
|---|---|---|
|dayio-dev-userservice|8080|/user|
|dayio-dev-productervice|8080|/product|
|dayio-dev-orderservice|8080|/order|

**Production**

```code
minikube -n production service <SERVICE_NAME>
```

|Available Services|Port|Path|
|---|---|---|
|dayio-userservice|8080|/user|
|dayio-productervice|8080|/product|
|dayio-orderservice|8080|/order|

##### About the Shell Script

This script basically will perform automatically 3 big steps:

* Check software dependencies
* Create a minikube cluster
* Install the helm Charts for Dayio Applications

The Script also will let you know about each step executed and if you have some question or want to receive more informations you can go to the LogDir and check the complete output from the command executions.

The LogFile it's stored at ```/tmp/dayio-tes.log```

All that steps could be manually executed without problem, just going to the Script and copy/paste the commands (except the Echo ones).

#### Friendly Reminder

This full implementation is a abstraction to make faster the validation of other items developed for this challenge.
For detailed informations about each challenge's piece please check the README and /docs of this projects:

- NodeJS App, Dockerfile and Docker Images:
User Service: https://github.com/lazevedo-devops/dayio-userservice
Product Service: https://github.com/lazevedo-devops/dayio-productservice
Order Service: https://github.com/lazevedo-devops/dayio-orderservice

- Helm Charts (with all Kubernetes manifests as templates):
User Service: https://github.com/lazevedo-devops/dayio-userservice-chart
Product Service: https://github.com/lazevedo-devops/dayio-productservice-chart
Order Service: https://github.com/lazevedo-devops/dayio-orderservice-chart


#### Questions and Feedback?

Find me on the Linkedin as lazevedo-devops or feel free to contact me through mail lazevedo@darkscreen.io.