# 🌐 Java Spring Boot App DevSecOps Project

## 🚀 Overview
This project showcases the implementation of **DevSecOps practices** on a Java Spring Boot application. I designed and automated a **complete CI/CD pipeline** using Jenkins to streamline the deployment of the application.  

From **containerization to continuous delivery**, this project was built from scratch, including **pipeline scripting, Dockerization, Kubernetes deployment, ArgoCD GitOps automation**, and **SonarQube code analysis**.

---
## 🛠️ Tech Stack

<table>
  <tr>
    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/git" width="48" alt="Git"/><br/>
      <strong>Git</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/github" width="48" alt="GitHub"/><br/>
      <strong>GitHub</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/jenkins" width="48" alt="Jenkins"/><br/>
      <strong>Jenkins</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/docker" width="48" alt="Docker"/><br/>
      <strong>Docker</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/docker" width="48" alt="Docker Hub"/><br/>
      <strong>Docker Hub</strong>
    </td>
  </tr>

  <tr>
    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/kubernetes" width="48" alt="Kubernetes"/><br/>
      <strong>Kubernetes (Kind)</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/argo/icon/color/argo-icon-color.png" width="48" alt="Argo CD"/><br/>
      <strong>Argo CD</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/sonarqube" width="48" alt="SonarQube"/><br/>
      <strong>SonarQube</strong>
    </td>

    <td align="center" width="140" valign="middle">
      <img src="https://cdn.simpleicons.org/groovy" width="48" alt="Groovy"/><br/>
      <strong>Groovy</strong>
    </td>

    <td align="center" width="140" valign="middle">


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
