# Request transform

O Request Transform é uma funcionalidade do Kong Gateway que permite modificar, adicionar ou remover dados das requisições HTTP antes que elas sejam encaminhadas para os serviços de backend.

Essa capacidade de transformação pode incluir a manipulação de cabeçalhos, parâmetros de consulta, corpo da requisição e outras partes da mensagem HTTP.

## Por quê utilizar?

A transformação de requisições é crucial para garantir que as solicitações que chegam aos seus serviços backend estejam no formato correto e contenham as informações necessárias para um processamento eficiente e seguro.

Isso pode ser particularmente útil em cenários onde há uma necessidade de compatibilidade entre diferentes sistemas ou quando é necessário filtrar e sanitizar dados para evitar vulnerabilidades de segurança.

### Cenário Infeliz

Um e-commerce implementou um serviço de pagamentos legado que não envia algumas informações necessárias ao funcionamento da nova arquitetura.

No entanto, o serviço mais moderno não consegue processar informações que não contenham atributos e cabeçalhos na requisição

Como resultado, algumas tentativas de pagamento falham, causando perda de vendas e frustração dos clientes. O mecanismo de transformação de requisições seria uma solução rápida e eficiente para esse problema.

### Cenário Feliz

O e-commerce está migrando seu sistema de backend para um novo provedor de API que requer um formato de requisição diferente do utilizado atualmente.

Usando a funcionalidade de Request Transform do Kong, a equipe de desenvolvimento configurou rapidamente as transformações necessárias, assegurando que todas as requisições sejam adaptadas ao novo formato sem necessitar de modificações no código do frontend.

Isso resultou em uma transição suave e sem interrupções no serviço, com o mínimo de atritos.

O Request Transform é particularmente benéfico para aplicações que interagem com múltiplos serviços de backend, especialmente aquelas que operam em ambientes complexos onde diferentes sistemas e serviços utilizam formatos e protocolos variados.

## Como implementar?

### Via API administrativa

Exemplo de configuração:

```bash
curl -X POST http://localhost:8001/routes/{routeName|Id}/plugins \
   --header "accept: application/json" \
   --header "Content-Type: application/json" \
   --data '
   {
 "name": "request-transformer",
 "config": {
   "remove": {
     "headers": [
       "x-toremove"
    ],
     "querystring": [
       "qs-old-name:qs-new-name",
       "qs2-old-name:qs2-new-name"
     ],
     "body": [
       "formparam-toremove",
       "formparam-another-one"
     ]
   },
   "replace": {
     "body": [
       "body-param1:new-value-1",
       "body-param2:new-value-2"
     ]
   },
   "rename": {
     "headers": [
       "header-old-name:header-new-name",
       "another-old-name:another-new-name"
     ],
     "querystring": [
       "qs-old-name:qs-new-name",
       "qs2-old-name:qs2-new-name"
     ],
     "body": [
       "param-old:param-new",
       "param2-old:param2-new"
     ]
   },
   "add": {
     "headers": [
       "x-new-header:value",
       "x-another-header:something"
     ],
     "querystring": [
       "new-param:some_value",
       "another-param:some_value"
     ],
     "body": [
       "new-form-param:some_value",
       "another-form-param:some_value"
     ]
   }
 }
}
```

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
    plugins:
      - name: request-transformer
        enabled: true
        instance_name: sample-request_transform-v1
        config:
          add:
            body:
              - a_brand_new_attribute:i'm added by kong request transform plugin
            headers:
              - X-Custom-Header:I didn't exist before kong request transform plugin
            querystring: []
          append:
            body: []
            headers: []
            querystring: []
          http_method: null
          remove:
            body:
              - a_future_removed_attribute
            headers: []
            querystring: []
          rename:
            body: []
            headers: []
            querystring: []
          replace:
            body:
              - a_future_updated_attribute:10000.00
            headers: []
            querystring: []
            uri: null
        protocols:
          - grpc
          - grpcs
          - http
          - https
        tags:
          - sample
          - request transform
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kubernetes ingress

Crie um arquivo de configuração `request-transform.yaml`:

```yaml
kind: KongPlugin
metadata:
  name: request-transformer-example
plugin: request-transformer
config:
  remove:
    headers:
    - x-toremove
    - x-another-one
    querystring:
    - qs-old-name:qs-new-name
    - qs2-old-name:qs2-new-name
    body:
    - formparam-toremove
    - formparam-another-one
  replace:
    body:
    - body-param1:new-value-1
    - body-param2:new-value-2
  rename:
    headers:
    - header-old-name:header-new-name
    - another-old-name:another-new-name
    querystring:
    - qs-old-name:qs-new-name
    - qs2-old-name:qs2-new-name
    body:
    - param-old:param-new
    - param2-old:param2-new
  add:
    headers:
    - x-new-header:value
    - x-another-header:something
    querystring:
    - new-param:some_value
    - another-param:some_value
    body:
    - new-form-param:some_value
    - another-form-param:some_value
```

Aplique as configurações:

```bash
kubectl apply -f request-transform.yaml
```

Anote o ingress com as configurações:

```bash
kubectl annotate ingress INGRESS_NAME konghq.com/plugins=request-transformer-example
```

### Via Kong Manager

![Request transform](/kong-gateway/assets/gifs/kong/capacities/request-transform.gif)

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/request-transformer).
