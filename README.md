
# demo-splunk

**Déploiement automatisé d’une instance Splunk  sur Outscale**

Ce dépôt fournit un ensemble de scripts Terraform, Packer et Ansible pour déployer automatiquement une instance Splunk (standalone) sur l’infrastructure Outscale.
L’objectif est de faciliter le déploiement, la configuration et la mise à jour d’un environnement Splunk prêt à l’emploi.

---

## Table des matières
- [Prérequis](#prérequis)
- [Architecture](#architecture)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Variables de configuration](#variables-de-configuration)
- [Contribution](#contribution)
- [Licence](#licence)

---

## Prérequis

- Un compte Outscale avec des droits d’administration.
- Terraform (v1.0+)
- Packer (v1.7+)
- Ansible (v2.9+)


---

## Architecture

- **Packer** : Crée une image Outscale (OMI) préconfigurée avec Splunk.
- **Ansible** : Configure Splunk lors de la création de l'OMI.
- **Terraform** : Déploie l’infrastructure (instance, réseau, sécurité) sur Outscale.


---

## Installation

1. Cloner ce dépôt :
   ```bash
   git clone https://github.com/glorp-fr/demo-splunk.git
   cd demo-splunk
   ```


2. Déployer l’infrastructure avec Terraform :
   ```bash
   cd ../terraform
   terraform init
   terraform apply
   ```


---

## Utilisation

- Accéder à l’interface web de Splunk via l’IP publique de l’instance, sur le port 8000.
- Les identifiants par défaut sont définis dans le fichier user-seed.conf.


---
