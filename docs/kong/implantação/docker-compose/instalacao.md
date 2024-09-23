# Instalação

## Visão Geral

Este guia fornece instruções para instalar o Kong Gateway usando o Docker Compose. O Kong é uma plataforma extensível para gerenciamento de APIs que permite controle, segurança e observabilidade de serviços e microserviços.

## Pré-requisitos

Antes de começar, certifique-se de que você tenha os seguintes componentes instalados em seu ambiente:

- **Docker** (v19.03 ou superior)
- **Docker Compose** (v1.27.0 ou superior)

### Instalação do Docker e Docker Compose

Caso você não tenha o Docker instalado, siga as instruções oficiais para instalá-lo:

- Docker: [Instruções de instalação](https://docs.docker.com/get-docker/)
- Docker Compose: [Instruções de instalação](https://docs.docker.com/compose/install/)

## Passo a Passo

### Criar um arquivo `docker-compose.yml`

Crie um diretório para o projeto e dentro dele um arquivo chamado `docker-compose.yml`.O arquivo de referência do kong oficial pode ser encontrado [neste repositório](https://github.com/Kong/docker-kong).

Observe que o comando `docker-compose up -d` irá subir uma versão mais limitada do kong, sem o banco de dados.

### Subir os containers

No mesmo diretório onde você criou o arquivo docker-compose.yml, execute o seguinte comando para subir os serviços:

```bash
make kong-postgres
```

Este comando irá:

- Subir o banco de dados PostgreSQL.
- Executar as migrações do banco de dados necessárias para o Kong.
- Iniciar o Kong Gateway.

### Verificar se o Kong está rodando

Após a execução dos containers, você pode verificar se o Kong está funcionando corretamente acessando o endpoint administrativo:

```bash
curl -i <http://localhost:8001>
```

Se o Kong estiver funcionando corretamente, você deverá ver uma resposta com o status 200 OK.

### Testar o Proxy do Kong

Agora que o Kong está instalado e funcionando, você pode testar o proxy do Kong. Use o seguinte comando para verificar:

```bash
curl -i <http://localhost:8000>
```

Se configurado corretamente, você verá a resposta padrão do Kong indicando que nenhum serviço foi configurado no gateway ainda.

### Passos Adicionais

#### Configuração de Plugins e Serviços

Agora que o Kong está ativo, você pode configurar rotas, serviços e aplicar plugins de segurança, autenticação, etc., usando a API administrativa do Kong em <http://localhost:8001>

#### Parar e Remover os Containers

Para parar os containers, execute:

```bash
docker-compose down
```

Isso removerá os containers, mas manterá os dados do banco de dados no volume persistente criado.

#### Configuração Postgres externo

Alterando-se as variáveis de ambiente, pode-se fazer uso de um banco postgres.

- **KONG_PG_HOST**: Substitua ${KONG_PG_HOST:-external-db-host} pelo endereço do seu banco de dados PostgreSQL externo. Pode ser um nome de host ou um endereço IP, como db.example.com ou 192.168.1.100.

- **Remoção do serviço db**: Remova o serviço, pois o banco será externo.

- **Password File**: Certifique-se de que o arquivo de segredo que contém a senha do PostgreSQL esteja disponível localmente e seja corretamente montado.

Ao rodar o Docker Compose, certifique-se de que as variáveis de ambiente estejam definidas corretamente. Um exemplo de arquivo `.env` poderia ser:

```bash
KONG_DATABASE=postgres
KONG_PG_HOST=db.example.com
KONG_PG_USER=kong
KONG_PG_DATABASE=kong
KONG_DOCKER_TAG=kong:3.7.1
```

Essas configurações direcionam o Kong para se conectar ao banco de dados PostgreSQL externo.

## Componentes

### Proxy

O Proxy é a funcionalidade principal do Kong, responsável por encaminhar solicitações entre clientes e seus serviços, aplicando políticas configuradas através de rotas e serviços.

- **Encaminhamento de Solicitações**: O Kong recebe as solicitações dos clientes e as direciona para os serviços apropriados, baseando-se em regras de roteamento.

- **Aplicação de Plugins**: Realiza transformações, autenticações, monitoramento e outras funcionalidades conforme as rotas e serviços configurados.

- **Suporte a SSL/TLS**: O proxy pode ser configurado para suportar conexões seguras via SSL.

Portas Padrão

- **Porta HTTP**: 8000
- **Porta HTTPS**: 8443

Exemplo de Roteamento
Uma solicitação pode ser roteada da seguinte forma:

1. Cliente realiza um GET para <http://localhost:8000/request>
2. O Kong redireciona a solicitação para o serviço configurado em <http://example.com/request>

### Admin API

A Admin API do Kong permite a configuração e o gerenciamento de todas as entidades dentro do Kong Gateway.

Ela é o ponto central para interagir diretamente com o Kong para criar, listar, atualizar e deletar recursos, como APIs, serviços, rotas e consumidores.

Endereço Padrão

- **Porta HTTP**: 8001
- **Porta HTTPS**: 8444

#### Comandos Comuns

Listar serviços:

```bash
curl -i <http://localhost:8001/services>
```

Criar um novo serviço:

```curl -i -X POST <http://localhost:8001/services> \
  --data name=my-service \
  --data url='<http://example.com>'
```

Atualizar um serviço existente:

```bash
curl -i -X PATCH <http://localhost:8001/services/my-service> \
  --data url='<http://example.org>'
```

Deletar um serviço:

```bash
curl -i -X DELETE <http://localhost:8001/services/my-service>
```

### Kong Manager

O Kong Manager é a interface gráfica para gerenciar e monitorar o Kong Gateway.

Ele proporciona uma experiência mais acessível para a administração do Kong sem a necessidade de interações com a linha de comando.

- **Interface Visual**: Interface fácil de usar para gerenciar serviços, rotas, plugins e consumidores.

- **Gestão de Plugins**: Facilita a instalação e a configuração de plugins.

Endereço Padrão:

- **Porta HTTP**: 8002
- **Porta HTTPS**: 8445
