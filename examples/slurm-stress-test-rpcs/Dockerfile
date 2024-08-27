FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

RUN mkdir workdir
WORKDIR /workdir

COPY task.sh ./
RUN chmod +x task.sh
RUN mkdir dummy-output
COPY single_submit.sh ./
COPY many_submit.sh ./

CMD [ "tail", "-f" ]
