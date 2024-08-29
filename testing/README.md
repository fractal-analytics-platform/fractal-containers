Makefile targets `run-demos-v2-github` and `run-demos-v1-github` are used within the GitHub CI (as in `make run-demos-v2-github`).

To run v2 demos locally, and with a webclient, use
```bash
make run-demos-v2
```
This will startup a database, a webclient, a SLURM cluster, and a
fractal-server backend. Then it will trigger task collection for
`fractal-tasks-core` (which can take a few minutes), and then define and run
some workflows.
