setup: 
	helm repo add kong https://charts.konghq.com
	helm repo update

secrets:
	kubectl create namespace kong

certificates:
	openssl ecparam -name secp384r1 -genkey -noout -out tls.key
	openssl req -new -x509 -nodes -key tls.key -out tls.crt -days 1095 -subj "/CN=kong_clustering"
	kubectl create secret tls kong-cluster-cert --cert=./tls.crt --key=./tls.key -n kong

install: 
	helm install kong-cp kong/kong -n kong --values ./values-cp.yaml
	helm install kong-dp kong/kong -n kong --values ./values-dp.yaml

full-install: setup secrets certificates install

clean: 
	kubectl delete namespace kong

test:
	kubectl get pods -n kong
