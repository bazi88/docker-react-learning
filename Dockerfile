FROM node:alpine as build-stage 

WORKDIR '/front-end'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx

COPY --from=build-stage /front-end/build/ /usr/share/nginx/html
COPY --from=build-stage /front-end/nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
