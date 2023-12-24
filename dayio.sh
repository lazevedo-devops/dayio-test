#!/bin/bash

#Create a Log Dir
LOGDIR="/tmp/dayio-test.log"
test -f $LOGDIR || touch $LOGDIR
echo "- Starting Dayio Script."
echo "If you have some question you can go to the LOG File at /tmp/dayio-test.log and view the command outputs"
echo "     =>  Start of Logs from Dayio Script Execution at `date +%Y/%m/%d-%T`" >> $LOGDIR

#Check Required apps
REQUIRED="minikube helm kubectl docker"
echo "- Checking software Dependencies"
for app in $REQUIRED;
do
    if ! command -v $app &> /dev/null
    then
        echo "$app could not be found"
        exit 1
    fi
done
echo "- Required Softwares OK"

#Checking if there's a Minikube cluster named as dayio and running
export STATUS=`minikube status -p dayio | grep apiserver | cut -d : -f 2`

#Minikube installation and basic configuration
echo "- Checking if there's a existent minikube cluster called dayio"
if [ $STATUS == "Running" ];
then
    echo "dayio running" &> /dev/null
    echo "- There's already minikube installed. No necessary to create a new one"
else
    echo "Creating a minikube cluster" >> $LOGDIR
    echo "- Creating a new minikube cluster named dayio"
    minikube start --nodes 2 -p dayio >> $LOGDIR
    minikube addons enable ingress -p dayio >> $LOGDIR
    minikube addons enable ingress-dns -p dayio >> $LOGDIR
    wait 60s
    echo "- Minikube cluster created"
fi

#Helm Chart Applications
echo "- Starting Helm Charts Implementation"
echo "- Installing User Service Chart"
git clone https://github.com/lazevedo-devops/dayio-userservice-chart.git -q
cd dayio-userservice-chart/
helm upgrade --install --atomic dayio-userservice --namespace development --create-namespace --kube-context=dayio -f development.yaml . >> $LOGDIR
helm upgrade --install --atomic dayio-userservice --namespace production --create-namespace --kube-context=dayio -f production.yaml . >> $LOGDIR
echo "- User Service chart installed with successful"
cd ../ && rm -Rf dayio-userservice-chart/ 
echo "- Installing Product Service Chart"
git clone https://github.com/lazevedo-devops/dayio-productservice-chart.git -q
cd dayio-productservice-chart/
helm upgrade --install --atomic dayio-productservice --namespace development --create-namespace --kube-context=dayio -f development.yaml . >> $LOGDIR
helm upgrade --install --atomic dayio-productservice --namespace production --create-namespace --kube-context=dayio -f production.yaml . >> $LOGDIR
echo "- Product Service chart installed with successful"
cd ../ && rm -Rf dayio-productservice-chart/ 
echo "- Installing Order Service Chart"
git clone https://github.com/lazevedo-devops/dayio-orderservice-chart.git -q
cd dayio-orderservice-chart/
helm upgrade --install --atomic dayio-orderservice --namespace development --create-namespace --kube-context=dayio -f development.yaml . >> $LOGDIR
helm upgrade --install --atomic dayio-orderservice --namespace production --create-namespace --kube-context=dayio -f production.yaml . >> $LOGDIR
echo "- Order Service chart installed with successful"
cd ../ && rm -Rf dayio-orderservice-chart/
echo "- All Applications was successfully installed, and accessible through minikube service command"
exit 0  