FROM filebrowser/filebrowser:v2                                                      
COPY conf_files/filebrowser.db database.db        
COPY conf_files/filebrowser.json .filebrowser.json
RUN mkdir -p /data/images
RUN mkdir -p /data/zarrs
ADD https://zenodo.org/records/10424292/files/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip /data/zarrs
RUN unzip /data/zarrs/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip -d /data/zarrs
RUN rm /data/zarrs/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip 
RUN rm -r /data/zarrs/__MACOSX
RUN /filebrowser config set --auth.method=noauth  
RUN /filebrowser users update 1 --perm.admin=false
