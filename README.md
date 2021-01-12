# Local OpenFaaS environment

This repo has a script creates and configure the following

1. Local `Docker Registry` named registry-kind:5000 ([docker-hub registry](https://hub.docker.com/_/registry))
2. Local k8s cluster (using [kind](https://kind.sigs.k8s.io/))
3. [OpenFaaS](https://www.openfaas.com/) platform installed on the k8s cluster above
4. OpenFaaS Cli

### Run
##### Create k8s cluster and OpenFaaS
```bash
./run.sh
```
##### Cleanup
```bash
./clea.sh
```

#### Additional information
* The local k8s cluster is configured to download images from the local docker registry from section 1
* It installs [arkade](https://github.com/alexellis/arkade) to install `kind` and `openfaas-cli`
* It adds a `dockerhost` pod that gives a way to communicate from within the k8s cluster to your local machine (localhost)

## Have fun! 😎
