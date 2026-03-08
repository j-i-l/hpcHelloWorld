# Struct E2: Apptainer container

Now that we have a well structured mini project it is time to create an appropriate environment for it.

> [!NOTE]
> In case you want to make sure to start this exercise with a good state of the project you can checkout the `stuct_exo_1` branch and start from there.

Container are a form of isolated environment we can design and use to run a codebase.
Their definition can - and in many cases should - be part of the project itself.

In therm of Separation of Concerns (SoC), a container definition is the definition of an environment and thus should neither reside in `scripts/`, nor in `src/` or `config/`.

_Ask yourself why not in `config/`?_

What complicates things slightly is that a container defines an environment that, in turn will also have to be run inside some other environment.
To keep a clear separation we move all container definitions into the `containers/` folder and we track them in our project.
 
_Ask yourself why is it OK to track container definitions but not `.env`?_

To get started with declaring apptainer containers we recommend you have a look at the [official documentation](https://apptainer.org/docs/user/latest/), alternatively you can also checkout the existing container definition in [T4D's pythonProject Template](https://github.com/j-i-l/pythonProject).

## Your Tasks

- Create the `containers/` folder and start with an new `.def` file in it: `containers/say_hello.def`.
- Define a container that installs your project along with all its dependencies using `uv`.
- Make sure the container can be used to run the script(s) under `scripts/`
- ... `--env-file` usage

**Bonus**:
Since our container definition is now part of the repository and verion-controlled like the rest, we can go ahead and build version specific container for our project.

But manually building a new container for each version and copying it around wherever we need it, is a strategy that is bound to fail.

Luckily CI/CD pipelines, a feature that is widely available on Git remote Services, can help us drastically here:

In fact, we can setup a CI/CD pipeline to build our Apptainer containers for us store them in a www-reachable container registry for us to fetch whenever and wherever we need them.

If you are completely new to CI/CD pipelines, we recommend having a look at [T4D's Course on CI/CD Workflows](ttps://t4d-gmbh.github.io/using-git-in-academia/content/ci-cd-workflows/source/content/index.html).
Alternatively, you can ask your favorite LLM for help, and it will get you going in no time!

You can also get inspiration from the CI/CD workflow script that builds and stores an Apptainer container in GitHubs registry [in the pythonProject Template](https://github.com/j-i-l/pythonProject/blob/main/.github/workflows/buildApptainerEnv.yml).
