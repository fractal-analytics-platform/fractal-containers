FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1
RUN apt update
RUN apt install slurmdbd -y   

COPY slurmdbd.conf /etc/slurm/
COPY slurm.conf /etc/slurm/
RUN chmod 600 /etc/slurm/slurmdbd.conf

COPY service_start.sh service_start.sh
RUN chmod +x service_start.sh

CMD [ "sh", "-c", "./service_start.sh && tail -f"]


