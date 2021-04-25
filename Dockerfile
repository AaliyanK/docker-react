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
# Copy the result over from our previous FROM statement, in the /app/build folder
# Copy it to the /usr/share/nginx/html folder (can be found in docs)   
COPY --from=0 /app/build /usr/share/nginx/html

