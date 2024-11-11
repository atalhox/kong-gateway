RELEASE_DIR=./deck/releases
DUMP_DIR=./deck/dumps

setup: 
	helm repo add kong https://charts.konghq.com
	helm repo update

namespace:
	kubectl create namespace kong

certificates:
	openssl ecparam -name secp384r1 -genkey -noout -out tls.key
	openssl req -new -x509 -nodes -key tls.key -out tls.crt -days 1095 -subj "/CN=kong_clustering"
	kubectl create secret tls kong-cluster-cert --cert=./tls.crt --key=./tls.key -n kong

install: 
	helm install kong-cp kong/kong -n kong --values ./values-cp.yaml
	helm install kong-dp kong/kong -n kong --values ./values-dp.yaml

deploy: dump
	@LAST_RELEASE=$(shell ls -t $(RELEASE_DIR) | head -1) && \
	deck gateway sync $(RELEASE_DIR)/$$LAST_RELEASE --kong-addr=http://admin.kong.local:80

dump: 
	mkdir -p $(DUMP_DIR) && \
	DUMP_FILE=$(DUMP_DIR)/dump-$(shell date +%Y%m%d%H%M%S).yaml && \
	deck gateway dump --format yaml  --kong-addr=http://admin.kong.local:80 > $$DUMP_FILE && \
	echo "Dump created at: $$DUMP_FILE" 

full-install: setup namespace certificates install # port-forward + deploy

tunnel: 
	minikube tunnel

port-forward: 
	kubectl port-forward -n kong service/kong-cp-kong-admin 8001 & \
	kubectl port-forward -n kong service/kong-cp-kong-manager 8002 &

kill: 
	pkill -f 'kubectl port-forward'

upgrade:
	helm upgrade kong-cp kong/kong -n kong --values ./values-cp.yaml
	helm upgrade kong-dp kong/kong -n kong --values ./values-dp.yaml

clean: 
	kubectl delete namespace kong

watch:
	watch kubectl get pods -n kong
