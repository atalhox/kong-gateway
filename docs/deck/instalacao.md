# Guia de Instalação do deck

O `deck` (Declarative Configuration CLI for Kong) é uma ferramenta usada para gerenciar a configuração do Kong Gateway de forma declarativa. Este guia cobre a instalação via Docker e a instalação padrão diretamente no sistema.

## Pré-requisitos

- **Docker**: Se optar pela instalação via container Docker.

## Instalação do deck via Docker

A forma mais rápida de iniciar o `deck` é utilizando o Docker. Isso permite que você utilize o `deck` sem precisar configurar o binário diretamente no seu sistema.

### Baixar a Imagem Docker

Para baixar a imagem do `deck`, execute:

```bash
docker pull kong/deck
```

### Configurar Variáveis de Ambiente

Para que o deck se comunique com a API Admin do Kong, você deve configurar as seguintes variáveis de ambiente:

```bash
KONG_ADMIN_URL: URL da API Admin do Kong ## <http://localhost:8001>).
KONG_ADDR: Endereço do Kong. Se estiver usando HTTPS, inclua https://
```

Exemplo de configuração:

```bash
export KONG_ADMIN_URL="http://localhost:8001"
export KONG_ADDR="https://localhost:8444"
```

### Executar o deck com Docker

Com as variáveis configuradas, execute o deck no Docker substituindo`<command>` pelo comando desejado (por exemplo, deck ping, deck sync, etc.):

```bash
docker run --rm -e KONG_ADMIN_URL kong/deck <command>
```

## Instalação Padrão do deck

Caso prefira instalar o deck diretamente no seu sistema, siga as instruções abaixo. Essa opção é especialmente útil para quem deseja executar o deck sem utilizar containers.

### Baixar e Extrair o deck

Baixe a versão mais recente do deck para o seu sistema. Exemplo para sistemas Linux com a versão 1.40.2:

```bash
curl -sL <https://github.com/kong/deck/releases/download/v1.40.2/deck_1.40.2_linux_amd64.tar.gz> -o deck.tar.gz
tar -xf deck.tar.gz -C /tmp
```

### Mover o Binário para o Diretório de Sistema

Após extrair o arquivo, mova o binário do deck para um diretório no PATH, como /usr/local/bin, para que ele possa ser executado globalmente:

```bash
sudo cp /tmp/deck /usr/local/bin/
```

### Verificar Instalação

Para confirmar que o deck foi instalado corretamente, verifique a versão:

```bash
deck version
```

Se o comando retornar a versão do deck, a instalação foi bem-sucedida.

### Atualizações

Para garantir que você está usando a versão mais recente do deck, consulte a [documentação oficial do deck](https://docs.konghq.com/deck/latest/) para instruções de instalação e versões atualizadas.
