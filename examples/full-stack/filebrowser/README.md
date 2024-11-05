Note: To make the files uploaded/created in the `/data` dir broadly accessible, we added a service called `monitord` into the `fractal-filebrowser` container. This service uses `inotifywait` tool to check when a new file or dir is created within the `/data` folder, and modify its permission from 0644 to 0666.