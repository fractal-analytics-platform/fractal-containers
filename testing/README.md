Makefile target `run-demos-github` is used within the GitHub CI.

To run demos locally, and with a webclient, use
```bash
make run-demos
```
This will startup a database, a webclient, a SLURM cluster, and a fractal-server backend. Then it will trigger task collection for `fractal-tasks-core` (which can take a few minutes), and then define and run some workflows.
