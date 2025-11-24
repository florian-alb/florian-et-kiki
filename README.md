# Architecture Microservices

Projet d'architecture microservices avec TypeScript et Express.

## 📁 Structure

```
├── api-gateway/     # Gateway principal (port 3000)
├── public-api/      # API publique (port 5050)
└── private-api/     # API privée (port 5555)
```

## 🚀 Installation

```bash
# Installer les dépendances pour chaque service
cd api-gateway && pnpm install
cd ../public-api && pnpm install
cd ../private-api && pnpm install
```

## 💻 Lancer le projet

Ouvrir 3 terminaux :

**Terminal 1 - API Gateway**

```bash
cd api-gateway
pnpm dev
```

**Terminal 2 - Public API**

```bash
cd public-api
pnpm dev
```

**Terminal 3 - Private API**

```bash
cd private-api
pnpm dev
```

## 📍 Routes disponibles

### Via API Gateway (http://localhost:3000)

- `GET /` - Status du gateway
- `GET /public/*` - Proxy vers Public API
- `GET /private/*` - Proxy vers Private API

### Public API (http://localhost:5050)

- `GET /` - Status
- `GET /users` - Liste des utilisateurs

### Private API (http://localhost:5555)

- `GET /` - Status
- `GET /admin` - Données admin

## 🧪 Tester

```bash
# Via le gateway
curl http://localhost:3000/public/users
curl http://localhost:3000/private/admin

# Directement
curl http://localhost:5050/users
curl http://localhost:5555/admin
```

## 🛠️ Stack

- TypeScript
- Express
- http-proxy-middleware
- tsx (dev)
