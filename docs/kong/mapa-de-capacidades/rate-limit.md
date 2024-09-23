# Rate Limit

Rate Limiting é uma técnica utilizada para controlar o número de solicitações que um usuário pode fazer a um serviço em um determinado período.

No contexto do Kong, uma API Gateway, esta funcionalidade ajuda a proteger os serviços contra abusos, como ataques DDoS (Distributed Denial of Service), garantindo que os recursos sejam distribuídos de maneira justa entre todos os usuários.

## Quando Deveria Ser Utilizado o Rate Limiting?

Rate Limiting deve ser utilizado em situações onde há a necessidade de controlar o acesso aos recursos da API para evitar abusos e garantir a qualidade do serviço.

Isso é particularmente importante durante eventos de alta demanda, como promoções de vendas, lançamentos de produtos ou períodos de alta carga sazonal.

Por exemplo, durante uma Black Friday, uma plataforma de e-commerce deve usar Rate Limiting para evitar que bots sobrecarreguem a API com solicitações excessivas, garantindo que todos os clientes reais tenham uma experiência de compra satisfatória.

## Por Quê Utilizar o Rate Limiting?

### Cenário Infeliz

Considere um cenário onde a empresa não implementou Rate Limiting.

Durante um ataque DDoS, milhares de solicitações são enviadas para a API, sobrecarregando os servidores e tornando os serviços indisponíveis para os clientes legítimos.

Isso não apenas afeta a experiência do usuário, mas também pode resultar em perdas financeiras significativas e danos à reputação da empresa.

A ausência de Rate Limiting impede que o sistema se proteja automaticamente contra abusos, resultando em uma falhas de serviço durante um momento crítico.

### Cenário Feliz

Agora imagine uma plataforma de e-commerce durante uma grande promoção. Sem Rate Limiting, a API poderia ser sobrecarregada por bots ou usuários mal-intencionados fazendo um grande número de solicitações em um curto período.

Isso poderia resultar em lentidão ou indisponibilidade do serviço para todos os usuários.

Com Rate Limiting, o administrador pode definir limites que garantem que nenhum usuário ou bot faça mais solicitações do que o permitido, mantendo a API estável e disponível para todos.

Os clientes conseguem realizar suas compras sem problemas, e a empresa mantém sua reputação intacta.

## Como Implementar Rate Limiting?

### Via API administrativa

Considere uma rota chamada `my-route`:

```bash
curl -i -X POST http://localhost:8001/routes/my-route/plugins \
  --data name=rate-limiting \
  --data config.second=5 \
  --data config.minute=30 \
  --data config.hour=900
```

Esta configuração acabou de definir que para esta rota teremos permitidas 5 requisições por segundo, 30 por minuto e 900 requisições por hora.

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: my-route  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: rate-limiting
        config:
          second: 5
          minute: 30
          hour: 900
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kong Manager

<div style="text-align: center;">
  <img src="/assets/gifs/kong/capacities/rate-limit.gif" alt="rate-limit" width="700"/>
</div>

Mais detalhes podem ser obtidos da [documentação oficial Kong](https://docs.konghq.com/hub/kong-inc/rate-limit/).
