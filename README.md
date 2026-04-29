# 🏭 Smart Factory Monitoring DevOps Platform

## 📌 Introduction

Ce projet est une simulation d’une plateforme industrielle moderne, inspirée des systèmes utilisés dans les usines ou les infrastructures énergétiques.

Dans ce type d’environnement, des capteurs collectent des données (température, pression, etc.) et les envoient vers des applications informatiques qui permettent de les analyser et de surveiller le système en temps réel.

L’objectif de ce projet est de reproduire ce fonctionnement à petite échelle, afin de mieux comprendre comment les systèmes industriels (OT) communiquent avec les systèmes informatiques (IT) dans une architecture moderne.

## 🎯 Objectif du projet

L’objectif de ce projet est de construire une plateforme complète capable de simuler un système industriel connecté.

Le projet permet de générer des données de capteurs, de les envoyer vers une API, puis de les collecter et de les surveiller en temps réel grâce à des outils de monitoring.

À travers cette réalisation, l’objectif est également de mettre en pratique une approche DevOps, en automatisant le déploiement, en utilisant des conteneurs et en orchestrant les services avec Kubernetes.


## 🧱 Architecture du projet

L’architecture de ce projet repose sur une chaîne simple qui représente le fonctionnement d’un système industriel connecté.

Les capteurs (simulés) génèrent des données et les envoient vers une API déployée dans un cluster Kubernetes. Cette API traite les données et expose des métriques via un endpoint dédié.

Prometheus collecte ensuite ces métriques automatiquement, puis Grafana permet de les visualiser sous forme de dashboards pour surveiller le système en temps réel.

L’ensemble des composants est orchestré avec Kubernetes, ce qui permet de gérer la communication entre services, la scalabilité et la résilience de l’application.

[Architecture Diagram](./img/Architecture.png)


## 📁 Structure du projet

Le projet est organisé de manière claire afin de séparer le code applicatif, l’infrastructure et l’automatisation.

```bash
.
├── app
│   ├── api
│   │   └── api.py
│   └── sensor
│       └── sensor.py
├── docker
│   ├── api.Dockerfile
│   └── sensor.Dockerfile
├── k8s
│   ├── api.yaml
│   ├── grafana.yaml
│   ├── namespace.yaml
│   ├── network-policy.yaml
│   ├── prometheus.yaml
│   ├── sensor.yaml
│   └── service.yaml
├── logs
├── monitoring
│   └── prometheus.yaml
├── scripts
│   ├── cleanup.sh
│   ├── deploy.sh
│   ├── install.sh
│   ├── test.sh
│   └── utils.sh
├── .env
├── .gitignore
└── README.md
```


## 📂 Rôle des dossiers

Chaque dossier du projet a un rôle spécifique afin de séparer clairement les responsabilités.

- **app/** : contient le code de l’application  
  → API (Flask) pour recevoir les données  
  → Sensor pour simuler les capteurs  

- **docker/** : contient les Dockerfiles pour construire les images des services  

- **k8s/** : contient tous les fichiers Kubernetes (déploiement, services, sécurité)  
  → définit comment l’application est exécutée et connectée dans le cluster  

- **monitoring/** : configuration de Prometheus  
  → permet de définir quelles métriques sont collectées  

- **scripts/** : scripts Bash pour automatiser les tâches  
  → déploiement, tests, nettoyage  
  → évite d’exécuter manuellement plusieurs commandes  

- **logs/** : stockage des logs (utilisé pour debug)  

- **.env** : variables d’environnement pour configurer l’application  



## ▶️ Exécution et tests

Le projet peut être lancé automatiquement à l’aide du script suivant :

```bash
./scripts/k8s.sh
```