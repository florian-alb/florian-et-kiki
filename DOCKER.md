# 🐳 Guide Docker - Configuration Simplifiée

Ce projet utilise **3 fichiers Docker Compose** différents selon votre besoin. Voici comment les utiliser.

---

## 📋 Les 3 Configurations

### 1. `docker-compose.dev.yml` - Développement Local ⭐ RECOMMANDÉ

**Quand l'utiliser ?** Développement local quotidien

**Ce qui tourne :**

- ✅ PostgreSQL (base de données users)
- ✅ MongoDB (base de données generations)
- ✅ Adminer (interface web PostgreSQL)
- ✅ Mongo Express (interface web MongoDB)

**Ce qui NE tourne PAS :**

- ❌ Frontend (vous le lancez manuellement avec `npm run dev`)
- ❌ API Gateway (vous le lancez manuellement)
- ❌ Users API (vous le lancez manuellement)
- ❌ Generations API (vous le lancez manuellement)

**Commandes :**

```bash
# Démarrer les bases de données
docker-compose -f docker-compose.dev.yml up -d

# Arrêter
docker-compose -f docker-compose.dev.yml down

# Voir les logs
docker-compose -f docker-compose.dev.yml logs -f
```

**Variables d'environnement :** Créez un fichier `.env.dev` (voir `env.dev.example`)

**Ports :**

- PostgreSQL: `localhost:5432`
- MongoDB: `localhost:27017`
- Adminer: `http://localhost:8082`
- Mongo Express: `http://localhost:8081`

---

### 2. `docker-compose.yml` - Tout Dockerisé

**Quand l'utiliser ?** Test complet avec tout dockerisé

**Ce qui tourne :**

- ✅ Frontend (Next.js)
- ✅ API Gateway
- ✅ Users API
- ✅ Generations API
- ✅ PostgreSQL
- ✅ MongoDB
- ✅ Adminer
- ✅ Mongo Express

**Commandes :**

```bash
# Démarrer tout
docker-compose up -d

# Rebuild et démarrer
docker-compose up -d --build

# Arrêter
docker-compose down

# Voir les logs d'un service spécifique
docker-compose logs -f users-api
```

**Variables d'environnement :** Créez un fichier `.env` (voir `env.example`)

**Ports :**

- Frontend: `http://localhost:3000`
- API Gateway: `http://localhost:4000`
- Users API: `http://localhost:5001`
- Generations API: `http://localhost:5002`
- PostgreSQL: `localhost:5432`
- MongoDB: `localhost:27017`
- Adminer: `http://localhost:8082`
- Mongo Express: `http://localhost:8081`

---

### 3. `docker-compose.staging.yml` - Production/Staging

**Quand l'utiliser ?** Déploiement staging ou production

**Ce qui tourne :** Tout (optimisé pour la production)

**Commandes :**

```bash
# Démarrer en staging
docker-compose -f docker-compose.staging.yml up -d --build

# Arrêter
docker-compose -f docker-compose.staging.yml down
```

**Variables d'environnement :** Créez un fichier `.env.staging` (voir `env.staging.example`)

---

## 🚀 Démarrage Rapide (Développement Local)

### Étape 1 : Créer votre fichier .env.dev

```bash
cp env.dev.example .env.dev
```

### Étape 2 : Démarrer les bases de données

```bash
docker-compose -f docker-compose.dev.yml up -d
```

### Étape 3 : Vérifier que les bases sont prêtes

```bash
# Vérifier PostgreSQL
docker exec postgres-dev pg_isready -U postgres

# Devrait afficher : postgres-dev:5432 - accepting connections
```

### Étape 4 : Configurer Prisma (Users API)

```bash
cd backend/users-api
npm install
npx prisma generate
npx prisma db push
```

### Étape 5 : Lancer vos APIs localement

**Terminal 1 - Users API:**

```bash
cd backend/users-api
npm run dev
```

**Terminal 2 - Generations API:**

```bash
cd backend/generations-api
npm run dev
```

**Terminal 3 - API Gateway:**

```bash
cd backend/api-gateway
npm run dev
```

**Terminal 4 - Frontend:**

```bash
cd frontend
npm run dev
```

---

## 🔧 Commandes Utiles

### Voir les conteneurs actifs

```bash
docker ps
```

### Nettoyer complètement Docker

```bash
# Attention : supprime TOUTES les données !
docker-compose -f docker-compose.dev.yml down -v
```

### Se connecter à PostgreSQL

```bash
docker exec -it postgres-dev psql -U postgres -d users_db
```

### Se connecter à MongoDB

```bash
docker exec -it mongo-dev mongosh
```

### Voir les logs d'un conteneur

```bash
docker logs -f postgres-dev
docker logs -f mongo-dev
```

---

## 🐛 Problèmes Courants

### L'API users ne se connecte pas à PostgreSQL

**Causes possibles :**

1. PostgreSQL n'est pas démarré
2. Mauvaise DATABASE_URL

**Solutions :**

```bash
# 1. Vérifier que postgres tourne
docker ps | grep postgres

# 2. Vérifier que postgres est prêt
docker exec postgres-dev pg_isready -U postgres

# 3. Vérifier votre DATABASE_URL
# Pour développement local : postgresql://postgres:postgres@localhost:5432/users_db
# Dans Docker : postgresql://postgres:postgres@postgres:5432/users_db

# 4. Recréer la base
cd backend/users-api
npx prisma db push --force-reset
```

### Le port 5432 est déjà utilisé

Si vous avez PostgreSQL installé localement :

```bash
# Option 1 : Arrêter le PostgreSQL local
brew services stop postgresql

# Option 2 : Changer le port dans .env.dev
POSTGRES_PORT=5433
```

### Mongo Express ne se connecte pas

```bash
# Vérifier les noms des conteneurs
docker ps

# Redémarrer mongo-express
docker-compose -f docker-compose.dev.yml restart mongo-express
```

---

## 📊 Interfaces Web

Une fois démarré avec `docker-compose.dev.yml` :

### Adminer (PostgreSQL) - http://localhost:8082

- **Système :** PostgreSQL
- **Serveur :** postgres-dev
- **Utilisateur :** postgres
- **Mot de passe :** postgres
- **Base de données :** users_db

### Mongo Express (MongoDB) - http://localhost:8081

- Accès direct, pas de login requis
- Base de données : generations-db

---

## 🎯 Recommandation

**Pour 90% du développement :**

1. Utilisez `docker-compose.dev.yml` pour les bases de données
2. Lancez vos APIs en local avec `npm run dev`
3. Plus rapide, plus simple, hot-reload fonctionnel

**Pour tester en conditions réelles :**

- Utilisez `docker-compose.yml`

**Pour déployer :**

- Utilisez `docker-compose.staging.yml`
