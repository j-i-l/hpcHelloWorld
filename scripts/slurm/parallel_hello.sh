#!/bin/bash
#SBATCH --job-name=hello-parallel
#SBATCH --array=0-2
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:10:00
#SBATCH --output=logs/%A_%a.out

module load apptainer

apptainer run \
  --env COURSE_ID=$SLURM_ARRAY_TASK_ID \
  --bind ./data/raw:/app/data/raw \
  --bind ./data/final:/app/data/final \
  env-sif_latest.sif \
  python scripts/say_hello.py
