#!/bin/bash

echo -e "Kursnamen eingeben: "
read kurs


kubectl create namespace $kurs

kubectl apply -f storageclass.yaml -n $kurs

helm install ngshare ngshare/ngshare -n $kurs -f config_ngshare.yaml

helm install jupyterhub jupyterhub/jupyterhub -n $kurs --version 1 --values config_jupyterhub.yaml


echo -e "Der Proxy ist unter über die IP der Node unter folgendem Port erreichbar:\n"
kubectl get svc -n $kurs | grep -e "NAME" -e "proxy-public" 
