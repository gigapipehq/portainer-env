# Portainer Nginx Template

This repository contains a Portainer application template to deploy a simple Nginx container. The container serves a custom HTML page and exposes a port that can be defined during deployment.

## Prerequisites

- Docker must be installed on your machine. If you don't have it, follow the official installation guide for your operating system: [Get Docker](https://docs.docker.com/get-docker/).

## How to Install and Use

### Step 1: Install Portainer

We will install the Portainer Community Edition (CE) which will manage your local Docker environment.

First, create a volume for Portainer to store its data:

```bash
docker volume create portainer_data
```












