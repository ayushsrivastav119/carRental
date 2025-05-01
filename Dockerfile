# Stage 1: Build React app
FROM node:18 as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve using Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Copy default Nginx config (optional but recommended)
# COPY nginx.conf /etc/nginx/nginx.conf  ← if you need custom config

EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
