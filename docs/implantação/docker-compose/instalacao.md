# Guia de instalação

## Visão Geral

Este guia fornece instruções para instalar o Kong Gateway usando o Docker Compose para a topologia `standalone`.

O Kong é uma plataforma extensível para gerenciamento de APIs que permite controle, segurança e observabilidade de serviços e microsserviços.

## Pré-requisitos

Antes de começar, certifique-se de que você tenha os seguintes componentes instalados em seu ambiente:

- **Docker** (v19.03 ou superior)
- **Docker Compose** (v1.27.0 ou superior)

### Instruções para Instalação do Docker e Docker Compose

Caso você não tenha o Docker instalado, siga as instruções oficiais para instalá-lo:

- Docker: [Instruções de instalação](https://docs.docker.com/get-docker/)
- Docker Compose: [Instruções de instalação](https://docs.docker.com/compose/install/)

## Procedimento de Instalação

### Configuração Inicial

Configure o seu arquivo `docker-compose.yaml` e `Makefile` conforme [repositório oficial](https://github.com/Kong/docker-kong/tree/master/compose).

#### Implantação DB-less (Sem banco de dados)

Execute o seguinte comando para iniciar uma versão do Kong que não utiliza banco de dados:

```bash
docker-compose up -d
```

> **Observação**: Esta implantação é limitada em comparação com a versão que utiliza um banco de dados, devido à falta de suporte para alguns plugins do Kong.

#### Implantação com PostgreSQL

Diferente do modelo acima, esta configuração faz o uso do banco de dados.

No mesmo diretório onde você criou o arquivo `docker-compose.yml`, execute o seguinte comando para subir os serviços:

```bash
make kong-postgres
```

Este comando irá:

- Subir um banco de dados PostgreSQL;
- Executar as migrações do banco de dados necessárias para o Kong;
- Iniciar o Kong Gateway.

### Verificação do status do Kong

Após a execução dos containers, você pode verificar se o Kong está funcionando corretamente acessando o endpoint administrativo:

```bash
curl -i <http://localhost:8001>
```

Se o Kong estiver funcionando corretamente, você deverá ver uma resposta com o status 200 OK.

### Testando o Proxy do Kong

Agora que o Kong está instalado e funcionando, você pode testar o proxy do Kong. Use o seguinte comando para verificar:

```bash
curl -i <http://localhost:8000>
```

Se configurado corretamente, você verá a resposta padrão do Kong indicando que nenhum serviço foi configurado no gateway ainda.

### Parando os Containers

Para parar os containers, execute no diretório do `docker-compose.yaml`:

```bash
docker-compose down
```
