FROM filebrowser/filebrowser:v2
RUN apk update
RUN apk add inotify-tools openrc
COPY check_file.sh /usr/check_file.sh
COPY monitord /etc/init.d/monitord
RUN chmod +x /usr/check_file.sh
RUN chmod +x /etc/init.d/monitord
COPY conf_files/filebrowser.db database.db
COPY conf_files/filebrowser.json .filebrowser.json
RUN mkdir -p /branding/img/icons
ADD conf_files/favicon-16x16.png branding/img/icons
ADD conf_files/favicon-32x32.png branding/img/icons
ADD conf_files/logo.svg branding/img
RUN /filebrowser config set --auth.method=noauth
RUN /filebrowser config set --branding.name "Fractal FilweBrowser" --branding.files "/branding" --branding.disableExternal
RUN /filebrowser users update 1 --perm.admin=false
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
