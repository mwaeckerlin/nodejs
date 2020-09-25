# nodejs

Docker Image for Node.JS Projects.

You can set the server start file in `START`, otherwise it will search in this order:

 - ./index.js
 - ./main.js
 - ./start.js
 - ./server.js
 - dist/index.js
 - dist/main.js
 - dist/start.js
 - dist/server.js
 - build/index.js
 - build/main.js
 - build/start.js
 - build/server.js
 
