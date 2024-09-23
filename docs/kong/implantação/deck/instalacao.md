# Instalação

## Pré-requisitos

- **Docker** instalado ;
- Acesso ao **Kong Admin API** ;

## Docker

```bash
docker pull kong/deck
```

### Variáveis de ambiente

- **KONG_ADMIN_URL**: URL da API Admin do Kong (ex: <http://localhost:8001>).
- **KONG_ADDR**: Endereço do Kong (se estiver usando HTTPS, utilize https://).

## Standard

A versão mais recente da instalação pode ser vista na [documentação oficial](https://docs.konghq.com/deck/latest/installation/).

```bash
curl -sL https://github.com/kong/deck/releases/download/v1.40.2/deck_1.40.2_linux_amd64.tar.gz -o deck.tar.gz
tar -xf deck.tar.gz -C /tmp
sudo cp /tmp/deck /usr/local/bin/
```
