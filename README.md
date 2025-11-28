# SEO FACILE DE OUF

**Plateforme SaaS d'automatisation de contenu SEO pour e-commerçants, basée sur une architecture Microservices.**

## 📖 À propos du projet

Ce projet est un SaaS B2B conçu pour aider les e-commerçants (Shopify, WooCommerce) à rédiger des fiches produits optimisées pour le référencement (SEO) en quelques secondes grâce à l'Intelligence Artificielle.

Contrairement aux solutions classiques de rédaction manuelle, cette application permet de générer, stocker et gérer des centaines de descriptions uniques et optimisées.

### 🎯 Pourquoi cet outil ?

La rédaction de fiches produits est la tâche la plus chronophage et la moins aimée des e-commerçants :

1.  **Le problème du temps :** Rédiger une bonne fiche prend 20 à 60 minutes. Pour une boutique de 100 produits, cela représente des semaines de travail.
2.  **Le problème du SEO :** Sans optimisation sémantique, une boutique est invisible sur Google.
3.  **Le problème du coût :** Embaucher des rédacteurs coûte cher.

**Notre solution :** Une interface simple où le marchand rentre ses mots-clés, et notre moteur asynchrone génère un contenu vendeur et optimisé SEO instantanément.

### Concurrence:

- https://describely.ai/
- https://www.kaatalog.ai/
- https://shopifast.io/landing

## 🛠 Stack Technique

- **TypeScript** - Typage statique
- **Express** - Framework web
- **MongoDB** - Base de données NoSQL
- **Mongoose** - ODM pour MongoDB
- **http-proxy-middleware** - Proxy pour API Gateway
- **tsx** - Exécution TypeScript avec hot-reload
- **Docker** - Conteneurisation
- **pnpm** - Gestionnaire de paquets

Ce projet met en œuvre une architecture **Microservices** moderne et typée :

- **Backend :** Node.js avec **Express** & **TypeScript**.
- **Communication :** Messaging asynchrone avec **RabbitMQ**.
- **Persistence Hybride (Polyglot Persistence) :**
  - **PostgreSQL + Prisma :** Données relationnelles critiques (Utilisateurs, Auth, Crédits, Tokens Shopify).
  - **MongoDB + Mongoose :** Données non structurées (Historique des générations IA, Logs, Contenu riche).
- **Intelligence Artificielle :** OpenAI API (GPT-5) + Claude (sonnet 4.5)
- **Frontend :** Next.js / React.

Voici une version **courte, simple et adaptée à un README** :

## 🧠 Justification des choix techniques

### **TypeScript**

TypeScript apporte une sécurité de typage.Il permet de réduire les erreurs, améliore la maintenabilité et permet un partage cohérent des modèles entre backend et frontend. Il offre une base plus fiable que JavaScript.

---

### **RabbitMQ**

RabbitMQ est utilisé comme broker de messages pour gérer les tâches longues (génération IA).
Il permet un traitement **asynchrone**, une bonne **scalabilité**, et une gestion propre des files d’attente et des _workers_ sans bloquer l’API principale.

---

### **Persistence Hybride : MongoDB + PostgreSQL**

- **PostgreSQL** : idéal pour les données critiques, structurées et relationnelles (authentification, crédits, intégrations Shopify…).
- **MongoDB** : parfait pour les données flexibles et volumineuses comme les contenus générés par l’IA.

Cette approche _polyglot persistence_ permet d’utiliser chaque base pour ce qu’elle fait le mieux et optimise performances + coût.

---

### **Next.js**

Next.js est choisi pour son écosystème moderne, son rendu serveur (SSR) et sa simplicité.
Next offre un excellent DX, un routage intégré et une intégration naturelle avec TypeScript et React.
Contrairement à Angular, Next est plus adapté pour notre projet car moins lourd et structurant pour un projet "simple".

---

### **GPT-5 et Claude (via API IA)**

L’application utilise GPT-5 et Claude Sonnet pour générer des descriptions produits riches et optimisées SEO.
Claude est meilleur dans la rédaction "humaine" et sera prévilégié pour les descriptions longues. Nous utiliserons GPT-5 pour les taches de mise en forme, et de rédaction plus courte (slugs, meta-titres, baslises alt) car moins cher.

## 📁 Schéma d'infrastructure

## 🚀 Installation

Le projet comprend un script `setup.sh` à la racine du projet qui permet d'initialiser le projet et configurer les variables d'environnement.

```bash
chmod +x setup.sh
./setup.sh
```

Le script va :

- ✅ Créer le fichier `.env` à la racine (pour Docker Compose) depuis `env.example`
- ✅ Créer les fichiers `.env` pour chaque microservice
- ✅ Installer toutes les dépendances avec `pnpm`

**Note :** Les fichiers `.env` ne sont PAS versionnés (dans `.gitignore`). Seul `env.example` est commité comme template.

## 💻 Lancer le projet

### Option 1 : Avec Docker (Recommandé)

```bash
docker-compose up --build
```

Tous les services démarrent automatiquement avec hot-reload !

### Option 2 : En local (développement)

Ouvrir 3 terminaux :

**Terminal 1 - API Gateway (port 3000)**

```bash
cd backend/api-gateway && pnpm dev
```

**Terminal 2 - Generations API (port 5002)**

```bash
cd backend/generations-api && pnpm dev
```

**Terminal 3 - Users API (port 5001)**

```bash
cd backend/users-api && pnpm dev
```

## 📍 Routes disponibles

### Via API Gateway (http://localhost:3000)

- `GET /` - Status du gateway
- `GET /generation/*` - Proxy vers Generations API
- `GET /users/*` - Proxy vers Users API

### Generations API (http://localhost:5002)

- `GET /` - Status
- `GET /generation` - Liste des générations (MongoDB)

### Users API (http://localhost:5001)

- `GET /` - Status

## 🧪 Tester

```bash
# Via le gateway
curl http://localhost:3000/generation/
curl http://localhost:3000/users/

# Directement
curl http://localhost:5002/
curl http://localhost:5001/
```

## 🗄️ MongoDB

### Avec MongoDB Compass (Recommandé)

1. Téléchargez [MongoDB Compass](https://www.mongodb.com/try/download/compass)
2. Connectez-vous à : `mongodb://localhost:27017`
3. Accédez à la base `generations-db`

### Avec CLI

```bash
mongosh mongodb://localhost:27017/generations-db
```

## 🔧 Configuration

Les variables d'environnement sont dans les fichiers `.env` de chaque service.
Des fichiers `.env.example` sont fournis comme templates.

### Variables importantes :

- `PORT` - Port d'écoute du service
- `MONGO_URI` - URI de connexion MongoDB
- `GENERATIONS_API_URL` - URL de l'API Generations (pour le gateway)
- `USERS_API_URL` - URL de l'API Users (pour le gateway)

## 📝 Notes

- En **Docker** : Les services utilisent les noms de conteneurs (`http://generations-api:5002`)
- En **local** : Les services utilisent `localhost` (`http://localhost:5002`)
- Le script `setup.sh` configure automatiquement les `.env` pour Docker
