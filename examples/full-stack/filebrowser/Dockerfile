FROM filebrowser/filebrowser:v2                   
                                                  
COPY conf_files/filebrowser.db database.db        
COPY conf_files/filebrowser.json .filebrowser.json
                                                  
RUN /filebrowser config set --auth.method=noauth  

