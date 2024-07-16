preamble = """#!/bin/sh
#SBATCH --partition=main
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=2100M
#SBATCH --nodes=1
#SBATCH --err=slurm_%j.out
#SBATCH --out=slurm_%j.err

echo \"Working directory (pwd): `pwd`\"
"""

num_sruns = 100
srun_lines = [
    (
        "srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK "
        f"--mem=500M ./task.sh $1 {ind} &"
    )
    for ind in range(num_sruns)
]
srun_lines.append("wait")
srun_block = "\n".join(srun_lines)

script_contents = f"{preamble}\n{srun_block}\n"
with open("single_submit.sh", "w") as f:
    f.write(script_contents)
