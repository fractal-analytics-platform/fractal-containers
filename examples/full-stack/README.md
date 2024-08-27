Startup with one of these commands
```bash
docker compose up
docker compose up --detach
```

Check status as in
```console
$ docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS                    PORTS                                                                                       NAMES
fd46b95f6adf   full-stack-web         "docker-entrypoint.s…"   6 minutes ago   Up 21 seconds             0.0.0.0:5173->5173/tcp, :::5173->5173/tcp                                                   fractal-web
c056c8ccaf88   full-stack-slurm       "bash run_server.sh"     6 minutes ago   Up 26 seconds (healthy)   0.0.0.0:6817-6818->6817-6818/tcp, :::6817-6818->6817-6818/tcp, 22/tcp, 0.0.0.0:8000->8000/tcp, :::8000->8000/tcp   slurm
50d398902bd8   postgres:15.4-alpine   "docker-entrypoint.s…"   8 minutes ago   Up 32 seconds (healthy)   5432/tcp, 0.0.0.0:5433->5433/tcp, :::5433->5433/tcp                                                                fractal-db
```

Tear down with
```bash
$ docker compose down
[+] Running 5/5
 ✔ Container server-config     Removed                                                                                  0.0s 
 ✔ Container fractal-web       Removed                                                                                 10.1s 
 ✔ Container slurm             Removed                                                                                 10.3s 
 ✔ Container fractal-db        Removed                                                                                  0.1s 
 ✔ Network full-stack_fractal  Removed                                                                                  0.2s
```
