# build phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
# we are only copying the build folder which is the end
# result on "npm run build", and deleting everything else
# by starting this new phase from nginx and copying over
# the build folder.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# default command for nginx is to start it, so we do not 
# need to explicitly start it.
