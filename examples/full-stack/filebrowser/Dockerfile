FROM filebrowser/filebrowser:v2                                                      
COPY conf_files/filebrowser.db database.db        
COPY conf_files/filebrowser.json .filebrowser.json
RUN mkdir /data
ADD https://zenodo.org/records/10424292/files/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip /data
RUN unzip /data/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip -d /data
RUN rm /data/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip 
RUN rm -r /data/__MACOSX
RUN /filebrowser config set --auth.method=noauth  
RUN /filebrowser users update 1 --perm.admin=false
