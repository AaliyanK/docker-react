# Build phase
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .  
# The folder with prod assets, will have the path: /app/build
# This is the folder that will be copied, and is what we care about
RUN npm run build 

# Run phase, use nginx image and copy over result of npm build
# This FROM statement will terminate the node FROM statement
FROM nginx
# Expose is for developers, we should read this and know that
# the container needs to be mapped to port 80
# EBS will look at EXPOSE and use it as a port to get mapped
EXPOSE 80 
# Copy the result over from our previous FROM statement, in the /app/build folder
# Copy it to the /usr/share/nginx/html folder (can be found in docs)   
COPY --from=0 /app/build /usr/share/nginx/html

