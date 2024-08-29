This example shows how to submit an arbitrary number of mock jobs, each one iterating over an arbitrary number of images.

# Instructions

1. After running
```bash
docker compose build
docker compose up
```
you have a `fractal-server` service on http://localhost:8000 and a fractal-web client at http://localhost:5173 (credentials: admin@fractal.xy/1234).

2. From the `client` subfolder (on the host machine):
```bash
./0_setup_venv.sh
./1_setup_user_and_tasks.
```
after a few seconds, a bunch of tasks will be visible at http://localhost:5173/v2/tasks.

3. Tweak `NUM_PROJECTS` and `NUM_IMAGES` in `2_prepare_submissions.sh`, and then
```bash
./2_prepare_submissions.sh
```

4. The previous step prepares a temporary file for submitting jobs, to be run as
```bash
./3_submit_jobs.sh
```

5. You can now look at Fractal jobs at http://localhost:5173/v2/jobs, or you can monitor SLURM jobs via
```bash
docker exec slurm squeue
```
