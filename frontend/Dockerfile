# ---- Étape 1 : build statique de l'application React ----
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# Chemins relatifs : c'est Nginx qui route /api et /ws vers le backend
ARG VITE_API_URL=/api
ARG VITE_WS_URL=/ws
ENV VITE_API_URL=$VITE_API_URL VITE_WS_URL=$VITE_WS_URL
RUN npm run build

# ---- Étape 2 : serveur Nginx léger ----
FROM nginx:1.27-alpine
# Adresse du backend, injectée au démarrage dans le template
ENV BACKEND_URL=http://backend:8080
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80