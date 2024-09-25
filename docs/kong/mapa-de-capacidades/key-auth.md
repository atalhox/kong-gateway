# Key Auth

A funcionalidade Key Auth do Kong é um método de autenticação que permite que os serviços sejam protegidos por meio da verificação de uma chave de acesso.

Quando um cliente faz uma solicitação a um serviço protegido, ele deve incluir uma chave de autenticação na solicitação.

O Kong valida essa chave antes de encaminhar a solicitação para o serviço, garantindo que apenas clientes autorizados possam acessar o recurso.

## Por que usar Key Auth?

### Cenário infeliz

Antes da implementação, uma API sofria tentativas de acesso não autorizado por um backend interno, resultando em acesso não autorizado.

### Cenário feliz

Após a configuração do Key Auth, apenas os clientes com chaves de acesso válidas puderam fazer requisições, reduzindo drasticamente os incidentes de segurança e melhorando o monitoramento de consumo a partir das chaves de acesso.

## Como aplicar

### Como configurar via API

#### Adicionar o Plugin key-auth a uma Rota

O plugin key-auth pode ser associado a uma rota, serviço ou ao consumidor. Aqui está um exemplo de como adicionar o plugin a uma rota:

```bash
curl -i -X POST http://localhost:8001/routes/route-id/plugins \
  --data "name=key-auth"
```

Substitua `route-id` pelo ID ou nome da sua rota. Isso habilita a autenticação por chave para a rota.

Exemplo:

```bash
curl -i -X POST http://localhost:8001/routes/my-route/plugins \
  --data "name=key-auth"
```

#### Criar um Consumer

Agora, você precisa criar um consumidor (usuário) que poderá utilizar a chave para acessar os serviços.

```bash
curl -i -X POST http://localhost:8001/consumers/ \
  --data "username=consumer-name"
```

Substitua `consumer-name`pelo nome do consumidor.

Exemplo:

```bash
curl -i -X POST http://localhost:8001/consumers/ \
  --data "username=my-consumer"
```

#### Criar uma Chave de Autenticação para o Consumer

Depois de criar o consumidor, adicione uma chave de API para esse consumidor:

```bash
curl -i -X POST http://localhost:8001/consumers/consumer-name/key-auth \
  --data "key=custom-api-key"
```

Se não fornecer a chave (deixar o campo key em branco), o Kong gerará uma automaticamente.

Exemplo (com chave personalizada):

```bash
curl -i -X POST http://localhost:8001/consumers/my-consumer/key-auth \
  --data "key=my-secret-api-key"
```

Exemplo (geração automática da chave):

```bash
curl -i -X POST http://localhost:8001/consumers/my-consumer/key-auth
```

#### Consumir a API Usando a Key

Agora que o plugin key-auth está configurado e a chave foi gerada, você pode consumir a API passando a chave no cabeçalho da requisição.

```bash
curl -i -X GET http://localhost:8000/your-api-path \
  --header "apikey: your-api-key"
```

Exemplo:

```bash
curl -i -X GET http://localhost:8000/my-api \
  --header "apikey: my-secret-api-key"
```

Se a chave for válida, você terá acesso à API. Caso contrário, uma mensagem de erro será retornada.

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
consumers:
  - username: my-consumer

keyauth_credentials:
  - consumer: my-consumer
    key: my-secret-api-key

routes:
  - name: my-route
    plugins:
      - name: key-auth
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kubernetes ingress

#### Configuração Key Auth

Crie um arquivo de configuração `key-auth.yaml`:

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: key-auth-example
plugin: key-auth
config:
  key_names:
  - apikey
```

Aplique as configurações:

```bash
kubectl apply -f key-auth.yaml
```

Anote o ingress com as configurações:

```bash
kubectl annotate service SERVICE_NAME konghq.com/plugins=key-auth-example
```

#### Secret

Crie um arquivo de configuração `key-auth-secret.yaml`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: alex-key-auth
  labels:
    konghq.com/credential: key-auth
stringData:
  key: hello_world
```

Aplique as configurações:

```bash
kubectl apply -f key-auth-secret.yaml
```

#### Consumer

Crie um arquivo de configuração `key-auth-consumer.yaml`:

```yaml
kind: KongConsumer
metadata:
  name: alex
  annotations:
    kubernetes.io/ingress.class: kong
username: alex
credentials:
- alex-key-auth
```

Aplique as configurações:

```bash
kubectl apply -f key-auth-consumer.yaml
```

### Via Kong Manager

Exemplo de configuração do plugin Key-auth para uma rota previamente criada:

![Key Auth](/kong-gateway/assets/gifs/kong/capacities/key-auth.gif)

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/key-auth).
