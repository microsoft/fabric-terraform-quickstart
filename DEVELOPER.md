# Developer Guide <!-- omit in toc -->

- [Development Environment](#development-environment)
  - [Dev Container development](#dev-container-development)
    - [Prerequisites](#prerequisites)
    - [Opening the Dev Container](#opening-the-dev-container)
  - [Local development](#local-development)
    - [Requirements](#requirements)

## Development Environment

Depends on your preferences you can use pre-configured development environment with Dev Container or your machine directly.

### Dev Container development

Dev Container is the **preferred** way for contribution to the project.

The [Dev Container](https://containers.dev/) feature in Visual Studio Code creates a consistent and isolated development environment. A Dev Container is a Docker container that has all the tools and dependencies needed to work with the codebase. You can open any folder inside the container and use VS Code's full feature set, including IntelliSense, code navigation, debugging, and extensions.

#### Prerequisites

To use the Dev Container in this repo, you need to have the following prerequisites:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in VS Code.

#### Opening the Dev Container

Once you have the prerequisites, you can follow these steps to open the repo in a Dev Container:

1. Clone or fork this repo to your local machine.
1. Open VS Code and press F1 to open the command palette. Type `Remote-Containers: Open Folder in Container...` and select it.
1. Browse to the folder where you cloned or forked the repo and click "Open".
1. VS Code will reload and start building the Dev Container image. This may take a few minutes depending on your network speed and the size of the image.
1. When the Dev Container is ready, you will see "Dev Container: Fabric Terraform Quickstarts" in the lower left corner of the VS Code status bar. You can also open a new terminal (Ctrl+Shift+`) and see that you are inside the container.
1. You can now edit, run, debug, and test the code as if you were on your local machine. Any changes you make will be reflected in the container and in your local file system.

> [!NOTE]
> To work with the repository you will need to verify or configure your GIT credentials, you can do it as follows in the dev Container terminal:

- Verify Git user name and email:

```shell
git config --list
```

You should see your username and email listed, if they do not appear or you want to change them you must establish them following the step below, (to quit the "git config" mode type "q").

- Change or set your Git username and email in the Dev Container:

```shell
git config --global user.name "Your Name"
git config --global user.email "your.email@address"
```

> [!NOTE]
> If you logging to docker container's shell outside the VS Code, in order to work with git repository, run the following commands:

```shell
export SSH_AUTH_SOCK=$(ls -t /tmp/vscode-ssh-auth* | head -1)
export REMOTE_CONTAINERS_IPC=$(ls -t /tmp/vscode-remote-containers-ipc* | head -1)
```

For more information about Dev Containers, you can check out the [Dev Container documentation](https://code.visualstudio.com/docs/devcontainers/containers) and [sharing Git credentials with your container](https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials).

### Local development

Dev Container is the **preferred** way for contribution to the project. It contains all necessary tools and configuration that is ready to start corking on the code without thinking on development environment setup.

Local development is still possible on Windows, Linux and macOS, but requires additional step to setup development environment.

> [!NOTE]
> Treat all instructions, commands or scripts in `Local development` section as examples. Depending on your local environment and configuration, the final commands or script may vary.

#### Requirements

| Tool                                                                             | Version      | Purpose                                                                                                                                                                | Notes                                                                                                                                                                 |
|----------------------------------------------------------------------------------|--------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Git](https://git-scm.com/downloads)                                             | `>= 2.49.0`  | Version Control System                                                                                                                                                 |                                                                                                                                                                       |
| [Go](https://go.dev/doc/install)                                                 | `>= 1.24.3`  | GoLang based tests                                                                                                                                                     | We recommend you to use Go version manager [go-nv/goenv](https://github.com/go-nv/goenv/blob/master/INSTALL.md) `goenv install 1.24.3`                                |
| [Python](https://www.python.org/)                                                | `>= 3.13`    | Runtime for Python-based tools                                                                                                                                         |                                                                                                                                                                       |
| [NodeJS](https://nodejs.org/)                                                    | `>= 22`      | Runtime for Node-based tools                                                                                                                                           |                                                                                                                                                                       |
| [PIPX](https://pipx.pypa.io/)                                                    | `>= 1.7.1`   | Running Python tools in isolated environments.                                                                                                                         |                                                                                                                                                                       |
| [Task](https://taskfile.dev/installation)                                        | `>= 3.43.3`  | Task runner                                                                                                                                                            |                                                                                                                                                                       |
| [Terraform](https://developer.hashicorp.com/terraform/downloads)                 | `>= 1.12.0`  | Purpose                                                                                                                                                                | We recommend you to use Terraform version manager [tfutils/tfenv](https://github.com/tfutils/tfenv/blob/master/README.md). `tfenv install 1.12.0`, `tfenv use 1.12.0` |
| [TFlint](https://github.com/terraform-linters/tflint)                            | `>= 0.57.0`  | Terraform linter that checks Terraform configurations for errors, potential bugs, and stylistic or best-practice violations.                                           |                                                                                                                                                                       |
| [Actionlint](https://github.com/rhysd/actionlint)                                | `>= 1.7.7`   | GitHub Workflows linter                                                                                                                                                |                                                                                                                                                                       |
| [act](https://github.com/nektos/act)                                             | `>= 0.2.77`  | Purpose                                                                                                                                                                |                                                                                                                                                                       |
| [GitHub CLI](https://cli.github.com/)                                            | `>= 2.72.0`  | Purpose                                                                                                                                                                |                                                                                                                                                                       |
| [golangci-lint](https://golangci-lint.run/)                                      | `>= 2.1.6`   | GoLang code linter                                                                                                                                                     |                                                                                                                                                                       |
| [govulncheck](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck)              | `>= 1.1.4`   | Static application security testing (SAST) tool for GoLang                                                                                                             |                                                                                                                                                                       |
| [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)             | `>= 0.18.1`  | Markdown linter                                                                                                                                                        |                                                                                                                                                                       |
| [markdown-table-formatter](https://github.com/nvuillam/markdown-table-formatter) | `>= 1.6.1`   | Markdown table formatter                                                                                                                                               |                                                                                                                                                                       |
| [Gitleaks](https://gitleaks.io/)                                                 | `>= 8.26.0`  | Static application security testing (SAST) tool designed to detect and prevent secrets from being committed to Git repositories1.                                      |                                                                                                                                                                       |
| [Trivy](https://trivy.dev/)                                                      | `>= 0.62`    | Static application security testing (SAST) tool designed to find vulnerabilities (CVE) and misconfigurations (IaC) across code, artifacts, container images, and more. |                                                                                                                                                                       |
| [Checkov](https://www.checkov.io/)                                               | `>= 3.2.424` | Static application security testing (SAST) tool designed to find vulnerabilities (CVE) and misconfigurations (IaC) across code, artifacts, and more.                   |                                                                                                                                                                       |
| [CSpell](https://cspell.org/)                                                    | `>= 9.0.1`   | Spell checker for documentation                                                                                                                                        |                                                                                                                                                                       |
| [CodeSpell](https://github.com/codespell-project/codespell)                      | `>= 2.4.1`   | Spell checker for source code                                                                                                                                          |                                                                                                                                                                       |
| [Lychee](https://lychee.cli.rs/)                                                 | `>= 0.18.1`  | Link checker                                                                                                                                                           |                                                                                                                                                                       |
| [YAMLlint](https://yamllint.readthedocs.io/)                                     | `>= 1.37.1`  | YAML linter                                                                                                                                                            |                                                                                                                                                                       |
