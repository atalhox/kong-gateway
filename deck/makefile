# Diretório onde os arquivos de versão são armazenados
RELEASES_DIR := releases

# Nome do arquivo base para o dump
DUMP_FILE_BASE := kong

# Nome do arquivo base para o sync
SYNC_FILE_BASE := kong

# Função para obter a versão mais recente
latest_version := $(shell ls $(RELEASES_DIR)/$(DUMP_FILE_BASE)-v*.yaml 2>/dev/null | sort -V | tail -n 1 | sed -e 's/.*-v\(.*\)\.yaml/\1/')

# Se não houver versão mais recente, definir como vazio
ifneq ($(latest_version),)
  last_sync_file := $(RELEASES_DIR)/$(SYNC_FILE_BASE)-v$(latest_version).yaml
else
  last_sync_file := $(RELEASES_DIR)/$(SYNC_FILE_BASE)-default.yaml  # ou outro valor padrão
endif

# Função para calcular a próxima versão patch
next_patch_version := $(shell echo $(latest_version) | awk -F. '{printf("v%d.%d.%d\n", $$1, $$2, $$3+1)}')

# Nome do novo arquivo de dump
new_dump_file := $(RELEASES_DIR)/$(DUMP_FILE_BASE)-$(next_patch_version).yaml

# Função para obter o arquivo mais recente para lint
latest_dump_file := $(shell ls $(RELEASES_DIR)/$(DUMP_FILE_BASE)-v*.yaml 2>/dev/null | sort -V | tail -n 1)

# Comandos do Makefile
ping: 
	deck gateway ping

convert: 
	deck file openapi2kong --spec swagger.json --output-file kong.yaml    

validate: 
	deck gateway validate kong.yaml

diff:
	deck gateway diff kong.yaml

dump: 
	deck gateway dump --output-file $(new_dump_file)

lint:
	@if [ -n "$(latest_dump_file)" ]; then \
	    echo "Linting $(latest_dump_file)..."; \
	    deck file lint -s $(latest_dump_file) ./ruleset/ruleset-custom.yaml; \
	else \
	    echo "No dump file found for linting."; \
	    exit 1; \
	fi

sync: 
	@if [ -f $(last_sync_file) ]; then \
	    echo "Syncing with $(last_sync_file)..."; \
	    deck gateway sync $(last_sync_file); \
	else \
	    echo "No sync file found for the latest version."; \
	    exit 1; \
	fi

merge: 
	deck file merge -o merged.yaml kong.yaml new-config.yaml

render:
	deck file render -o render.yaml kong.yaml new-config.yaml

kic: 
	deck file kong2kic -s kong.yaml -o kic-config.yaml

kic-all:
	@mkdir -p $(OUTPUT_DIR)  # Criar diretório de saída se não existir
	@for spec in $(SPEC_DIR)/*.json; do \
	    base_name=$$(basename $$spec .json); \
	    output_file=$(OUTPUT_DIR)/$(OUTPUT_FILE_BASE)-$$base_name-kic.yaml; \
	    echo "Convertendo $$spec para $$output_file em formato KIC..."; \
	    deck file kong2kic --spec $$spec --output-file $$output_file; \
	done

reset: 
	deck gateway reset
