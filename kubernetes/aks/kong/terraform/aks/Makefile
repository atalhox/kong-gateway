.PHONY: setup namespace certificates install build upgrade clean watch

setup: 
	helm repo add kong https://charts.konghq.com
	helm repo update

namespace:
	kubectl create namespace kong

gen-certs:
	openssl ecparam -name secp384r1 -genkey -noout -out tls.key
	openssl req -new -x509 -nodes -key tls.key -out tls.crt -days 1095 -subj "/CN=kong_clustering"

install: 
	helm install kong-cp kong/kong -n kong --values ./values-cp.yaml
	helm install kong-dp kong/kong -n kong --values ./values-dp.yaml

build: setup namespace certificates

upgrade:
	helm upgrade kong-cp kong/kong -n kong --values ./values-cp.yaml
	helm upgrade kong-dp kong/kong -n kong --values ./values-dp.yaml

clean: 
	kubectl delete namespace kong

watch:
	watch kubectl get pods -n kong
