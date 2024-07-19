#!/bin/sh
#SBATCH --partition=main
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=900M
#SBATCH --nodes=1
#SBATCH --err=slurm_%j.out
#SBATCH --out=slurm_%j.err

echo "Working directory (pwd): `pwd`"

srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 0 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 1 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 2 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 3 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 4 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 5 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 6 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 7 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 8 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 9 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 10 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 11 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 12 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 13 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 14 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 15 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 16 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 17 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 18 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 19 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 20 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 21 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 22 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 23 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 24 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 25 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 26 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 27 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 28 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 29 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 30 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 31 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 32 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 33 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 34 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 35 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 36 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 37 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 38 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 39 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 40 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 41 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 42 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 43 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 44 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 45 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 46 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 47 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 48 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 49 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 50 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 51 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 52 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 53 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 54 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 55 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 56 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 57 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 58 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 59 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 60 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 61 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 62 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 63 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 64 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 65 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 66 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 67 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 68 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 69 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 70 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 71 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 72 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 73 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 74 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 75 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 76 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 77 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 78 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 79 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 80 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 81 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 82 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 83 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 84 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 85 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 86 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 87 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 88 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 89 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 90 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 91 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 92 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 93 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 94 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 95 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 96 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 97 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 98 &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem=200M ./task.sh $1 99 &
wait
