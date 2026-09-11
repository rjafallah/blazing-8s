# Blazing 8s 🃏

Jeu de cartes multijoueur en ligne, temps réel, inspiré du Uno/Blazing 8s classique. Application web full-stack développée en équipe de 4 selon Scrum, de la conception de la base de données jusqu'au déploiement automatisé.

## Le jeu

Soyez le premier à vider votre main en jouant une carte de même couleur ou valeur que celle du dessus de la défausse. Des cartes spéciales (inversion de sens, blocage, échange de main) rendent chaque partie imprévisible.

## Fonctionnalités

- Inscription, connexion et classement général des joueurs, persistés en base
- Salon d'attente (lobby) avec rafraîchissement en temps réel
- Jeu synchronisé entre tous les joueurs via WebSocket — chaque action est immédiatement répercutée sur tous les écrans, sans rechargement
- Chat intégré en cours de partie, persisté en base pour survivre aux reconnexions
- Gestion des déconnexions : si un joueur quitte, son tour est automatiquement passé et la partie continue
- Support multi-appareils sur réseau local

## Architecture

```
Frontend (React)  ⇄  WebSocket / REST  ⇄  Backend (Spring Boot)  ⇄  MySQL
```

**Backend** — Spring Boot 4, avec :
- 8 entités JPA/Hibernate (`Player`, `Game`, `GamePlayer`, `GameTurn`, `Card`, `Deck`, `Ranking`, `Message`) et un schéma MySQL entièrement maîtrisé (`ddl-auto=none`, script `init.sql`)
- WebSocket (JSR 356) pour la synchronisation temps réel du jeu et du chat, plutôt que du polling HTTP
- Pattern DTO pour découpler les entités JPA de ce qu'expose l'API REST
- Contrôleurs REST pour l'authentification, le lobby, le jeu et le classement

**Frontend** — React 18 (Vite), avec gestion de session via `localStorage` et un client WebSocket dédié pour la synchronisation en temps réel.

## DevOps

- **Conteneurisation** complète avec Docker et Docker Compose (3 conteneurs : MySQL, backend, frontend)
- **Pipeline CI/CD Jenkins** : compilation Maven, exécution des tests JUnit, publication des rapports de test, build des images Docker, et déploiement automatisé

```
Compilation → Tests JUnit → Package → Build Docker → Déploiement
```

## Stack technique

**Backend** : Spring Boot 4, Spring Data JPA, Spring WebSocket, Hibernate, MySQL, Maven
**Frontend** : React 18, Vite
**DevOps** : Docker, Docker Compose, Jenkins, JUnit

## Lancer le projet en local

```bash
docker-compose up -d
```

- Frontend : http://localhost:5173
- Backend : http://localhost:8080
- MySQL : port 3307 (mappé sur le 3306 du conteneur)

## Équipe

Projet développé en équipe de 4 selon la méthodologie Scrum, dans le cadre du parcours Génie Logiciel — ENSEEIHT.
