# HPC Exo 2: Minimal HPC Workflow

Now we have everything set up to transition from some interactive test-runs to asynchronous batch job submissions, enabling scalable execution on an HPC cluster.
With the setup at hand a strict separation between environment, configuration, code, and data is maintained when integrating the container environment, configuration data, and mapped storage paths.

The execution script, `scripts/say_hello.py`, imports functions from our `exohw` package (SoC Pillar 3) and requires a configuration file path (SoC Pillar 2) and an output directory (SoC Pillar 4).
It is designed to read these from the environment variables `CONFIG_PATH` and `OUTPUT_DIR` that default to your standard locations, `./config/` and `./data/final/` which we can bind to any location on the cluster upon runtime of the container (SoC Pillar 1).

### Epilog

#### Your Tasks:
- Build an open-source Apptainer container to execute the script in (see previous exercises).
- Decide the storage locations for intermediary data and final output data.
- (Optionally) declare the `OUTPUT_DIR` and the `CONFIG_PATH` environment variable paths to set the paths **inside** the container. Ensure your script accesses the `config/hello_to.json` configuration file inside the container runtime.
- Write your Slurm submission script:
  - Adapt the `scripts/slurm/submit_template.sh` script to request 1 CPU, 4GB of memory, and 10 minutes of runtime.
  - Utilize the `apptainer exec` command to run the specific script.
  - Supply the `--env-file .env` flag to inject the defined parameters securely.
  - Apply the `--bind` parameter (multiple times) to mount the host file-system data directories, ensuring the container writes to the persistent output location.

### Execution

#### Your Tasks:
- Submit your job using the `sbatch` command.
- Check the status of your queued or running job.
- Modify the Slurm script to execute the container directly from the Container Registry (e.g., GitHub Container Registry) rather than utilizing the local `.sif` file, which enables better reproducibility.
- Update the execution command to reference the remote URI: `apptainer exec docker://ghcr.io/<repository-owner>/<repository-name>:<tag> ...`.
- Store the authentication credentials required to pull the image in the `.env` file as `APPTAINER_DOCKER_USERNAME` and `APPTAINER_DOCKER_PASSWORD`, and inject them securely.

  _NOTE 1_: Apptainer [accepts the usage of docker credentials](https://apptainer.org/docs/user/main/docker_and_oci.html#environment-variables)
  _NOTE 2_: GitHub accepts the authentication via the `DOCKER_USERNAME` and `DOCKER_PASSWORD` variables, simply make sure that:
  - `DOCKER_USERNAME`: Your GitHub username (or organization name)
  - `DOCKER_PASSWORD`: A Personal Access Token (PAT) with appropriate scopes (not your GitHub password)

### Prolog

#### Your Tasks:
- Verify the output text file is written to the correct persistent location.
- Remove unused scratch data to clean the environment.
- Remove the local container binary (`.sif`).

#### Hints & Best Practices:

* Interim and final data are not distinguished in this minimal example; data is written directly to the permanent output location.
* Content submitted directly in the project repository (e.g., `config/*`) is present inside the container.
  Relative paths, such as `./config`, are evaluated relative to the execution location inside the container.
* The `apptainer exec` command is utilized for specific script execution.
* The `--env-file` option injects environment variables into the container runtime.
* The `--bind` option mounts a location from the host filesystem inside the container.
* Job status checking is performed via `squeue -u <username>` or `sacct -u <username>`. Extra formatting options can be appended, e.g., `--format=JobID,JobName,State,ExitCode`.
