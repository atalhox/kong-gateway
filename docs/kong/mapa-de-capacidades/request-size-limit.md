# Request size limit

A funcionalidade de Limitação do Tamanho da Requisição do Kong Gateway, implementada pelo plugin `request size limiting`, permite definir um limite máximo para o tamanho das requisições HTTP/HTTPS que um serviço pode receber.

Esta funcionalidade é crucial para garantir a segurança e a eficiência do tráfego, prevenindo que requisições excessivamente grandes comprometam o desempenho do servidor ou exponham vulnerabilidades.

## Por que utilizar a Limitação do Tamanho da Requisição?

### Cenário infeliz

Imagine uma plataforma permita o upload de imagens para produtos. Sem uma limitação no tamanho das requisições, um usuário mal-intencionado pode tentar enviar arquivos extremamente grandes para sobrecarregar o servidor.

Isso pode levar a uma degradação significativa do desempenho, causando lentidão para outros usuários e potencialmente derrubando o serviço. Além disso, requisições muito grandes podem explorar falhas no processamento de arquivos, criando brechas de segurança.

### Caso Feliz

Consideremos uma aplicação crítica armazena registros em escala. Com a limitação do tamanho das requisições implementada, o sistema impede que uploads acidentais ou maliciosos de grandes arquivos causem interrupções.

Isso garante que os serviços críticos continuem funcionando sem problemas e que os dados sensíveis permaneçam protegidos. Além disso, a aplicação pode otimizar o uso de recursos, garantindo que a capacidade do servidor seja utilizada eficientemente, de acordo com o planejado.

## Como configurar a Limitação do Tamanho da Requisição via API?

Para configurar a limitação do tamanho da requisição no Kong via API, siga os passos abaixo:

Considere a configuração abaixo para limitar o tamanho das requisições de uma rota `request-size-limiting`:

```bash
curl -i -X POST http://localhost:8001/routes/request-size-limiting/plugins \
  --data name=request-size-limiting \
  --data config.allowed_payload_size=128
```

Neste exemplo, `config.allowed_payload_size` define o tamanho máximo permitido para a requisição em kilobytes.

Neste caso, 128KB. Quando ultrapassado o limite, você deve esperar um retorno como este:

```json
{
    "message": "Request size limit exceeded",
    "request_id": "4c9607649b53926a7cf83d285e5dd54e"
}
```

## Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: request-size-limiting  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: request-size-limiting
        config:
          allowed_payload_size: 128
          require_content_length: false
          size_unit: bytes
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kubernetes ingress

Crie um arquivo de configuração `request-size-limit.yaml`:

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: request-size-limiting-example
plugin: request-size-limiting
config:
  allowed_payload_size: 128
  require_content_length: false
```

Aplique as configurações:

```bash
kubectl apply -f request-size-limit.yaml
```

Anote o ingress com as configurações:

```bash
kubectl annotate ingress INGRESS_NAME konghq.com/plugins=request-size-limiting-example
```

### Via Kong Manager

![Request size limit](/kong-gateway/assets/gifs/kong/capacities/request-size-limiting.gif)

Mais detalhes podem ser obtidos da [documentação oficial Kong](https://docs.konghq.com/hub/kong-inc/request-size-limiting/).
