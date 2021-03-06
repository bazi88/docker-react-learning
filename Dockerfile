FROM node:14.0.0 as build-stage 

WORKDIR '/front-end'

RUN npm install npm@6.14.6 -g

RUN rm -rf /build && rm -rf /node_modules && npm cache clean --force  

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx

COPY --from=build-stage /front-end/build/ /usr/share/nginx/html
COPY --from=build-stage /front-end/nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
