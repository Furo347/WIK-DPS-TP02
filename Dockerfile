FROM node:20-alpine
COPY . /app
WORKDIR /app
RUN npm install 
RUN ["npm", "run" , "build"]

#Prod Container
FROM node:20-buster
COPY --from=0 /app/build/index.js /prod/index.js
RUN ["useradd", "-m", "-s", "/bin/sh", "florentin"]
WORKDIR /prod
RUN chown -R florentin:florentin /prod
USER florentin
EXPOSE 8080
CMD node index.js