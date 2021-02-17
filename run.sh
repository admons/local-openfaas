./install.sh

section "Create a new function"

info_pause_exec "Pull templates", "faas-cli template pull"

info_pause_exec "See list of templates", "faas-cli new --list"

info_pause_exec "Create new node js v12 function", "faas-cli new hello-world --lang node12"

info_pause_exec "Edit new handler function", "open ./hello-world/handler.js"

step "Save changes"

info_pause_exec "Build, push and deploy", "faas-cli up -f ./hello-world.yml"

info_pause_exec "Wait for openfaas to be ready", "kubectl rollout status -n openfaas-fn deploy/hello-world"

info_pause_exec "See results", "curl --header 'Content-Type: application/json' --data '{\"a\": 1}' http://localhost:8080/function/hello-world"

step "Make more changes"

info_pause_exec "Build, push and deploy", "faas-cli up -f ./hello-world.yml"

info_pause_exec "Wait for openfaas to be ready", "kubectl rollout status -n openfaas-fn deploy/hello-world"

info_pause_exec "See new results", "curl --header 'Content-Type: application/json' --data '{\"a\": 1}' http://localhost:8080/function/hello-world"

section "Dashbaord"

info_pause_exec "Add grafana", "kubectl -n openfaas run --image=stefanprodan/faas-grafana:4.6.3 --port=3000 grafana"

info_pause_exec "Wait for pod to start", "kubectl -n openfaas get pods -w"

info_pause_exec "Port forward to expose locally", "kubectl port-forward pod/grafana 3000:3000 -n openfaas &"

sleep 3

info_pause_exec "Open browser", "open http://127.0.0.1:3000/dashboard/db/openfaas"
