# Define o namespace
NAMESPACE=kong

# Regra para construir o ConfigMap para cada diretório de plugins
build:
	@for dir in js/* lua/*; do \
		if [ -d "$$dir" ]; then \
			dir_name=$$(basename $$dir); \
			configmap_name=kong-plugin-$$dir_name; \
			echo "Criando ConfigMap para o diretório: $$configmap_name"; \
			kubectl create configmap $$configmap_name \
				--from-file=$$dir/ \
				--namespace $(NAMESPACE); \
		fi; \
	done
