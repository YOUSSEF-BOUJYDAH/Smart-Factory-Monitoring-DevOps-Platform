# 🏭 Smart Factory Monitoring DevOps Platform

## 🎯 Objectif du projet

Ce projet a pour objectif de simuler une plateforme industrielle connectée, dans laquelle des capteurs génèrent des données envoyées vers une API pour être collectées, traitées et surveillées en temps réel.

Il permet de comprendre comment les systèmes industriels (OT) interagissent avec les systèmes informatiques (IT), tout en mettant en pratique une approche DevOps basée sur la containerisation, l’orchestration avec Kubernetes et le monitoring.

---

## 🧰 Environnement technique

Le projet s’appuie sur un environnement technique moderne, proche des standards utilisés en entreprise :

- **OS** : Linux (Ubuntu)
- **Langage** : Python (Flask)
- **Scripting** : Bash
- **Conteneurisation** : Docker
- **Orchestration** : Kubernetes (Minikube)
- **Monitoring** : Prometheus et Grafana

## 🧱 Architecture du projet

L’architecture de ce projet repose sur une chaîne simple qui représente le fonctionnement d’un système industriel connecté.

Les capteurs (simulés) génèrent des données et les envoient vers une API déployée dans un cluster Kubernetes. Cette API traite les données et expose des métriques via un endpoint dédié.

Prometheus collecte ensuite ces métriques automatiquement, puis Grafana permet de les visualiser sous forme de dashboards pour surveiller le système en temps réel.

L’ensemble des composants est orchestré avec Kubernetes, ce qui permet de gérer la communication entre services, la scalabilité et la résilience de l’application.

![Architecture Diagram](./img/Architecture.png)


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
