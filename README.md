# 🌐 Java Spring Boot App DevSecOps Project

## 🚀 Overview
This project showcases the implementation of **DevSecOps practices** on a Java Spring Boot application. I designed and automated a **complete CI/CD pipeline** using Jenkins to streamline the deployment of the application.  

From **containerization to continuous delivery**, this project was built from scratch, including **pipeline scripting, Dockerization, Kubernetes deployment, ArgoCD GitOps automation**, and **SonarQube code analysis**.

---

## 🧩 Tech Stack & Tools Used

| Category | Tools / Technologies |
|-----------|----------------------|
| **Version Control** | <img src="https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png" width="22" align="center"/> **Git** &nbsp;&nbsp; <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="22" align="center"/> **GitHub** |
| **CI/CD Platform** | <img src="https://img.icons8.com/color/48/jenkins.png" width="22" align="center"/> **Jenkins** |
| **Containerization** | <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" width="25" align="center"/> **Docker** |
| **Container Registry** | <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" width="25" align="center"/> **Docker Hub** |
| **Infrastructure / Orchestration** | <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/kubernetes/kubernetes-plain.svg" width="25" align="center"/> **Kubernetes (Kind on Azure VM)** |
| **Deployment Automation** | <img src="https://argo-cd.readthedocs.io/en/stable/assets/argo.png" width="25" align="center"/> **ArgoCD** |
| **Pipeline Scripting** | <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/bash/bash-original.svg" width="25" align="center"/> **Shell Script (Bash)** |
| **Agent Setup** | <img src="https://img.icons8.com/color/48/azure-1.png" width="22" align="center"/> **Docker Agent on Azure VM** |
| **Code Security Analysis** | <img src="https://img.icons8.com/?size=512&id=98957&format=png" width="25" align="center"/> **SonarQube** |


---

## 📋 Project Workflow

### 1️⃣ Code Merge Trigger
When a developer merges changes into the `main` branch, the **Jenkins pipeline is automatically triggered** via GitHub webhooks.

### 2️⃣ Clean Workspace
The pipeline first **cleans the workspace**, removing old build files to ensure a fresh environment for the new build.

### 3️⃣ Build & Package
Using **Maven**, the project is compiled and packaged into a **JAR file**, creating the latest version of the application.

### 4️⃣ Static Code Analysis
I integrated **SonarQube** to perform static code analysis. The pipeline runs a SonarQube scan using a configured token and server URL to ensure code quality and highlight potential issues.

### 5️⃣ Docker Build & Push
The pipeline logs in to **Docker Hub** using secure credentials. It then builds a **Docker image** of the application with a version tag based on the current build number and pushes it to the Docker Hub repository.

### 6️⃣ Kubernetes Manifest Update
I wrote a **shell script (`update-k8s-manifest.sh`)** to automatically update Kubernetes manifest files with the latest Docker image. The pipeline executes this script to connect CI with CD seamlessly.

### 7️⃣ Deployment via ArgoCD
**ArgoCD** is configured to monitor the Kubernetes manifests. Once updated, ArgoCD automatically deploys the **latest version of the application** to the Kubernetes cluster.

---

## ⚙️ Project Setup & Infrastructure

- **Azure VMs:**  
  - VM 1: Jenkins server with **Docker agents** (to reduce compute cost).  
  - VM 2: Production VM running a **Kubernetes Kind cluster** and ArgoCD.  

- **Kubernetes Kind Cluster Installation:**  
  [Kind Quick Start Guide](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)  

- **ArgoCD Installation:**  
  [ArgoCD Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)  

- **Jenkins Installation:**  
  [Official Jenkins Docs](https://www.jenkins.io/doc/book/installing/linux/)  
  - Deployed on **port 8080**  
  - Configured **system credentials** for GitHub, Docker, and SonarQube securely  

- **SonarQube Setup:**  
  - Docker LTS Community Edition  
  - Command used:
  ```bash
  docker run -it -d --name SonarQubeServer -p 9000:9000 sonarqube:lts-community
