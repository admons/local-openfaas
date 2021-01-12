source "./wizard-utils.sh";

section "Removing cluster from previous runs (only if exists)"

if [ "$(docker ps --filter name=kind-registry --quiet)" != "" ]; then
    info_pause_exec "Remove 'kind-registry' docker" "docker rm kind-registry --force";
fi

if [ "$(docker ps --filter name=openfaas-kind-control-plane --quiet)" != "" ]; then
    info_pause_exec "Remove 'openfaas-kind' cluster" "kind delete cluster --name openfaas-kind";
fi
