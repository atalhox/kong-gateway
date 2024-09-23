# CORS

CORS, ou Cross-Origin Resource Sharing, é um mecanismo que permite que recursos restritos em uma página web sejam solicitados a partir de outro domínio fora do domínio ao qual o recurso pertence.

No Kong, a funcionalidade CORS é implementada através de um plugin que facilita a configuração e o gerenciamento dessas permissões de forma centralizada e segura.

Isso é essencial para aplicações web modernas que frequentemente precisam acessar APIs e serviços hospedados em diferentes domínios.

## Por que utilizar CORS no Kong?

### Cenário Infeliz

Um gateway Kong sem a correta configuração de CORS permitiu que requisições maliciosas fossem feitas a partir de domínios não confiáveis. Isso permitiu que houvesse vazamento de dados sensíveis e abriu caminho para uma série de ataques de CSRF (Cross-Site Request Forgery).

Com a implementação do CORS no Kong, poderia ter sido possível definir quais domínios são confiáveis, prevenindo acessos não autorizados e protegendo informações confidenciais.

### Cenário Feliz

Um exemplo positivo do uso da funcionalidade CORS é através de e-commerce que utiliza uma API centralizada para gerenciar o inventário e o processamento de pagamentos.

O frontend da aplicação é hospedado em um domínio diferente do backend da API e ao implementar o CORS no Kong, os desenvolvedores podem configurar permissões específicas que permitem que o frontend acesse os endpoints necessários sem comprometer a segurança.

Com isso, os usuários podem navegar e fazer compras sem interrupções, resultando em uma experiência de usuário fluida e segura.

## Via API administrativa

Você pode habilitar o CORS para uma rota específica usando o seguinte comando:

``` bash
curl -X POST http://kong:8001/routes/{route_id}/plugins \
    --data "name=cors" \
    --data "config.origins=*" \
    --data "config.methods=GET,POST" \
    --data "config.headers=Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.credentials=true" \
    --data "config.max_age=3600" \
    --data "config.preflight_continue=false"
```

Substitua `{route_id}` pelo ID ou nome da rota para a qual você deseja habilitar o CORS.

Assim como a rota, épossívelconfigurar para um serviço.

## Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: my-route  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: cors
        config:
          origins: "*" # Substitua por origins permitidas
          methods:
            - GET
            - POST
          headers:
            - Accept
            - Accept-Version
            - Content-Length
            - Content-MD5
            - Content-Type
            - Date
            - X-Auth-Token
          exposed_headers:
            - X-Auth-Token
          credentials: true
          max_age: 3600
          preflight_continue: false
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

## Via Kong Manager

Exemplo de configuração do plugin CORS para uma rota previamente criada:

<div style="text-align: center;">
  <img src="/assets/gifs/kong/capacities/cors.gif" alt="cors" width="700"/>
</div>

## Verificando a configuração do CORS

Para verificar se o CORS foi configurado corretamente, acesse a rota para a qual o plugin foi habilitado pelo navegador.

Acesse por origens permitidas e não permitidas em sua configuração.

Sucesso:

![Requisição bem sucedida](/assets/img/gateway/kong/capacities/cors/success.png)

Erro de CORS:

![Requisição mal sucedida](/assets/img/gateway/kong/capacities/cors/error.png)

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/cors).
