# Caching

A funcionalidade de caching do Kong permite armazenar temporariamente respostas de solicitações de API, reduzindo a necessidade de recalcular ou buscar dados idênticos repetidamente.

Isso não só melhora a performance da API, mas também diminui a carga nos serviços backend, promovendo eficiência operacional e redução de custos.

O caching é configurável, permitindo definir critérios como duração do cache e condições de invalidação, garantindo que os dados sejam atuais e relevantes.

## Quando implementar o Caching do Kong?

A implementação do caching no Kong é especialmente útil em cenários de alto tráfego, onde a repetição de solicitações a serviços backend pode causar latência e sobrecarga de recursos.

Momentos de pico de acesso, como promoções sazonais ou recursos que possuem pouca variação do seu retorno são cenários interessantes para seu uso.

A adoção antecipada do caching durante a fase de design de uma arquitetura pode evitar problemas de performance à medida que a aplicação escala.

## Por que utilizar o Caching?

### Cenário infeliz

Um serviço não utilizava caching enfrentou problemas durante o lançamento de uma nova promoção. O aumento repentino no tráfego resultou em latência alta e respostas lentas, pois cada solicitação demandava processamento completo pelo backend.

A experiência do usuário foi prejudicada, levando a impactos nos pedidos de suporte.

### Cenário feliz

Durante uma outra promoção sazonal, o tráfego aumentou drasticamente.

Graças ao caching, a maioria das solicitações foram servidas diretamente do cache, resultando em tempos de resposta muito mais rápidos e redução significativa da carga nos servidores backend.

Isso permitiu uma experiência de usuário suave e responsiva, aumentando as conversões e as vendas. Além disso, a infraestrutura da empresa não precisou de expansões emergenciais e ajustes em timeout, economizando custos.

## Como configurar o Caching do Kong via API

Para configurar o caching no Kong via API, siga os passos abaixo:

### Via API administrativa

Exemplo de configuração:

```bash
curl --location 'http://admin-url:8001/routes/{route-id}/plugins' \
--header 'accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "name": "proxy-cache",
    "instance_name": "<instance-name>",
    "config": {
        "response_code": [
            200
        ],
        "request_method": [
            "GET",
            "HEAD"
        ],
        "content_type": [
            "text/plain",
            "application/json"
        ],
        "cache_ttl": 300,
        "strategy": "memory"
    }
}'
```

Observe os tempos de latência com e sem cache.

Sem cache

<div style="text-align: center;">
  <img src="/assets/img/gateway/kong/capacities/cache/caching-no-cache.png" alt="cors" width="700"/>
</div>

Com cache

<div style="text-align: center;">
  <img src="/assets/img/gateway/kong/capacities/cache/caching-with-cache.png" alt="cors" width="700"/>
</div>

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: my-route  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: proxy-cache
        instance_name: my-instance  # Substitua pelo nome da instância do plugin
        config:
          response_code:
            - 200
          request_method:
            - GET
            - HEAD
          content_type:
            - text/plain
            - application/json
          cache_ttl: 300
          strategy: memory
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kong Manager

Exemplo de configuração do plugin Proxy Cache para uma rota previamente criada:

![Caching](/kong-gateway/assets/gifs/kong/capacities/cache.gif)

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/proxy-cache).
