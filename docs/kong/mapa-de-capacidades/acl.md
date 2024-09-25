# ACL

A ACL (Access Control List) no Kong Gateway é uma funcionalidade que permite controlar o acesso aos serviços e recursos de uma API, baseando-se em listas de controle de acesso.

Estas listas definem quais consumidores podem ou não acessar determinados recursos, garantindo uma camada adicional de segurança e controle sobre a exposição dos serviços.

A ACL é crucial para ambientes onde diferentes níveis de acesso precisam ser gerenciados com precisão, como em empresas que oferecem serviços para múltiplos clientes ou parceiros e necessitam segregar esses acessos de forma segura e eficiente.

## Por que usar a ACL?

### Cenário infeliz

Imagine uma API que se encontra sem a implementação de uma ACL.

Neste cenário, qualquer cliente autenticado pode acessar os serviços disponíveis na API, incluindo funcionalidades críticas que sejam disponíveis a apenas um grupo resumido.

### Cenário feliz

Cada cliente tem acesso restrito apenas aos serviços que lhe são permitidos, de acordo com as políticas definidas na lista de controle de acesso.

Um parceiro, por exemplo, pode ter acesso somente a funcionalidades específicas, como a visualização de relatórios de uso e a gestão de seus próprios usuários, sem poder modificar dados de outros parceiros ou acessar informações sensíveis.

Em um cenário feliz, mesmo que um parceiro mal-intencionado tente explorar a API, ele encontrará um impedimento para o acesso a funcionalidades não autorizadas, garantindo a segurança e a integridade dos dados e serviços da empresa de telecomunicações.

## Como implementar um ACL?

Restringir ou permitir o acesso a um serviço ou a uma rota adicionando consumidores a listas usando grupos de ACL arbitrários requer que um plugin de autenticação (como Basic Authentication, Key Authentication, OAuth 2.0 ou OpenID Connect) já tenha sido habilitado previamente.

### Via API administrativa

Esta seção irá apresentar como o plugin de ACL atua em conjunto com um modelo de autenticação. Considere um plugin do tipo `key-auth` já configurado.

#### Criação de consumer

Criando um consumidor:

```bash
curl -i -X POST <http://localhost:8001/consumers/> \
    --data "username=<consumer-name>"
```

Crie consumers dos tipos `dev`, `admin`.

#### Criação de group

Como criar um novo grupo:

```bash
curl -i -X POST http://localhost:8001/consumers/<consumer-name>/acls \
  --data "group=<group-name1, group-name2>"
```

Crie os grupos: `dev` e `admin`.

#### Adição do Plugin ACL a uma rota

```bash
curl --location 'http://localhost:8001/routes/<route-name>/plugins' \
--header 'accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "name": "acl",
    "instance_name": "<instance-name>",
    "config": {
        "allow": [
            "group1", 
            "group2"
        ],
        "hide_groups_header": true
    }
}'
```

Exemplo:

```bash
curl --location 'http://localhost:8001/routes/my-acl/plugins' \
--header 'accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "name": "acl",
    "instance_name": "plugin-acl-v1",
    "config": {
        "allow": [
            "dev", 
            "admin"
        ],
        "hide_groups_header": true
    }
}'
```

Intencionalmente para a nossa explicação foi permitido apenas o grupo `group-sales` para a nossa API. Desta forma veremos que somente os clientes autenticados (sales e admin) poderão consumir este recurso.

#### Consumindo a API

Considere nossa API anterior para a rota: `http://localhost:8001/routes/my-acl`. Consuma a API com a API Key configurada no plugin `Key Authentication`.

```bash
curl --location 'http://localhost:8000/my-acl' \
--header 'apikey: <api-key>'
```

Você verá que as API keys de `dev` e `admin` poderão consumir normalmente o recurso, enquanto outros terão um retorno similar a:

```json
{
    "message": "You cannot consume this service",
    "request_id": "769d897ecdca8a1e8e96c26d5a959866"
}
```

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
consumers:
  - username: dev
  - username: admin

acls:
  - consumer: dev
    group: dev
  - consumer: admin
    group: admin

plugins:
  - name: acl
    instance_name: plugin-acl-v1
    route: my-acl
    config:
      allow:
        - dev
        - admin
      hide_groups_header: true

  - name: key-auth
    route: my-acl
    config: {}
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kubernetes ingress

Crie um arquivo de configuração `acl.yaml`:

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: acl-example
plugin: acl
config:
  allow:

- group1
- group2
  hide_groups_header: true
```

Aplique as configurações:

```bash
kubectl apply -f acl.yaml
```

Anote o ingress com as configurações:

```bash
kubectl annotate ingress INGRESS_NAME konghq.com/plugins=acl-example
```

### Via Kong Manager

Exemplo de configuração do plugin ACL para uma rota previamente criada e autenticação por Key Auth:

![ACL](/kong-gateway/assets/gifs/kong/capacities/acl.gif)

Observação: este exemplo apresenta o cenário de captura do ACL. Para realizar a configuração correta, basta adicionar ao plugin o grupo criado para o consumer.

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/acl).
