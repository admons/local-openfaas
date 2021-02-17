source "./wizard-utils.sh";

./clean.sh

if [[ -f "/usr/local/bin/arkade" || -f "$HOME/.arkade/bin" ]]; then
    echo "Arkade already installed"
else
    info_pause_exec "Install arkade" "curl -sLS https://dl.get-arkade.dev | sh"
fi

if [[ -f "/usr/local/bin/faas-cli" || -f "$HOME/.arkade/bin/faas-cli" ]]; then
    echo "Openfaas cli already installed"
else
    info_pause_exec "Install local openfaas CLI" "arkade get faas-cli"
fi

if [[ -f "/usr/local/bin/faas-cli" || -f "$HOME/.arkade/bin/faas-cli" ]]; then
    echo "KinD already installed"
else
    info_pause_exec "Install kind CLI" "arkade get kind"
fi

info_pause_exec "Update PATH env var to support 'faas-cli'" 'export PATH=$PATH:$HOME/.arkade/bin/'

section "Create a Cluster"

info_pause_exec "Run local docker registry", "docker run -d --restart=always -p \"5000:5000\" --name \"kind-registry\" registry:2"

info_pause_exec "Run local kind cluster", "kind create cluster --name openfaas-kind --config kind-config.yml"

info_pause_exec "Connect kind with local docker registry", 'docker network connect "kind" "kind-registry"'

section "Open Faas"

info_pause_exec "Install openfaas on the kubernetes cluster" "arkade install openfaas"

info_pause_exec "Wait for openfaas to be ready", "kubectl rollout status -n openfaas deploy/gateway"

sleep 3

info_pause_exec "Setup local docker registry as the default one instead of DockerHub", 'export OPENFAAS_PREFIX="localhost:5000"'

info_pause_exec "Login with openfaas-cli", 'kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode | faas-cli login --username admin --password-stdin'

info_pause_exec "Check", "faas-cli list"

section "General"

info_pause_exec "Add 'dockerhost' service to access my computer (i.e. local registry)", "kubectl apply -f dockerhost.yml"

info_pause_exec "Set 'openfaas-fn' as default kubectl namespace", "kubectl config set-context --current --namespace=openfaas-fn"
