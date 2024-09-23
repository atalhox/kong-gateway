# Response Transform

A funcionalidade de transformação de respostas no Kong permite modificar o conteúdo das respostas HTTP antes que elas sejam enviadas de volta ao cliente.

Isso pode envolver a reestruturação do JSON, a substituição de palavras ou frases, a adição de metadados ou a sanitização de dados sensíveis.

Por exemplo, uma API que retorna dados financeiros pode usar essa funcionalidade para mascarar informações sensíveis como números de conta antes de enviar a resposta ao cliente final.

## Por que utilizar?

### Cenário Infeliz

Um serviço de pagamento retorna dados de transações sem mascarar os detalhes dos cartões de crédito coloca os dados sensíveis dos usuários em risco.

Um cliente mal-intencionado poderia interceptar essas respostas e usar as informações para fraudes. Sem a transformação de respostas, a empresa pode enfrentar consequências legais e uma perda significativa de confiança dos clientes.

### Cenário Feliz

Considere agora que no cenário anterior foram removidas todas as informações sigilosas do usuário. Em termos de compliance e segurança da informação, a arquitetura se encontra protegida e garante a sua conformidade.

## Como configurar a Transformação de Resposta?

A implementação da transformação de request no Kong será feita através do plugin `Request Transform`.

### Via API administrativa

Exemplo de configuração:

```bash
curl -X POST http://localhost:8001/services/{serviceName|Id}/plugins \
   --header "accept: application/json" \
   --header "Content-Type: application/json" \
   --data '
   {
 "name": "response-transformer",
 "config": {
   "remove": {
     "headers": [
       "x-toremove",
       "x-another-one"
     ],
     "json": [
       "json-key-toremove",
       "another-json-key"
     ]
   },
   "add": {
     "headers": [
       "x-new-header:value",
       "x-another-header:something"
     ],
     "json": [
       "new-json-key:some_value",
       "another-json-key:some_value"
     ],
     "json_types": [
       "string",
       "boolean",
       "number"
     ]
   },
   "append": {
     "headers": [
       "x-existing-header:some_value",
       "x-another-header:some_value"
     ]
   }
 }
}
```

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
services:
  - name: your-service-name  # Substitua pelo nome ou ID do seu serviço
    plugins:
      - name: response-transformer
        enabled: true
        config:
          remove:
            headers:
              - x-toremove
              - x-another-one
            json:
              - json-key-toremove
              - another-json-key
          add:
            headers:
              - x-new-header:value
              - x-another-header:something
            json:
              - new-json-key:some_value
              - another-json-key:some_value
            json_types:
              - string
              - boolean
              - number
          append:
            headers:
              - x-existing-header:some_value
              - x-another-header:some_value
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kong Manager

<div style="text-align: center;">
  <img src="/assets/gifs/kong/capacities/response-transform.gif" alt="response-transform" width="800"/>
</div>

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/response-transformer).
