# Request termination

A funcionalidade do plugin `Request Termination` permite o encerramento de uma solicitação HTTP antes de ser encaminhada para o serviço backend. Isto pode ser útil em diversos cenários, incluindo manutenção de segurança e controle de tráfego.

Como vantagens, o plugin pode ser configurado para retornar diferentes códigos de status HTTP, cabeçalhos personalizados e um corpo de resposta customizado.

## Por Que Utilizar Request Termination?

Durante períodos de manutenção programada, o plugin pode ser usado para retornar uma mensagem específica aos clientes informando sobre a indisponibilidade temporária do serviço.

Para APIs que requerem controle de acesso rigoroso, o plugin pode ser configurado para terminar requisições de clientes não autorizados, retornando um código de status 403 (Forbidden) ou 401 (Unauthorized).

O plugin pode ser usado para garantir o cumprimento de políticas de uso, terminando requisições que não estão em conformidade com os termos de serviço. Por exemplo, ele pode bloquear requisições de regiões geográficas específicas onde o serviço não está disponível.

Para proteger recursos sensíveis que só devem ser acessados por determinados usuários ou durante períodos específicos, o plugin pode terminar requisições fora dessas condições, aumentando a segurança dos dados.

Se uma vulnerabilidade de segurança for descoberta, o plugin pode ser rapidamente configurado para bloquear requisições que exploram essa vulnerabilidade até que uma correção definitiva seja implementada, protegendo o sistema contra ataques.

Quando novas funções estão em fase beta e devem ser acessadas apenas por um grupo seleto de usuários, o plugin pode terminar requisições de usuários não autorizados, controlando o acesso e coleta de feedback de maneira mais segura e organizada.

O plugin pode ser usado para terminar requisições específicas e retornar respostas personalizadas baseadas em determinadas condições, como horários de funcionamento ou eventos especiais. Isso permite uma comunicação mais precisa e contextualizada com os usuários.

## Como configurar o plugin

### Via API administrativa

Considere a configuração de uma rota chamada `request-termination`. A configuração do plugin pode ser feita como a abaixo.

```shell
    curl -X POST http://localhost:8001/routes/request-termination/plugins \
    -d "name=request-termination"  \
    -d "config.status_code=403" \
    -d "config.message=This route is temporarily unavailable."
```

Neste exemplo, estamos configurando o plugin para retornar um código de status HTTP 403 com a mensagem `This service is temporarily unavailable.` para todas as solicitações para a rota especificada.

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: request-termination  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: request-termination
        config:
          status_code: 403
          message: "This route is temporarily unavailable."
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kubernetes ingress

Crie um arquivo de configuração `request-termination.yaml`:

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: request-termination
plugin: request-termination
config:
  status_code: 403
  message: "This route is temporarily unavailable."
```

Aplique as configurações:

```bash
kubectl apply -f request-size-limit.yaml
```

Anote o ingress com as configurações:

```bash
kubectl annotate service SERVICE_NAME konghq.com/plugins=request-termination-example
```

### Via Kong Manager

Exemplo de configuração do plugin `Request Termination` para uma rota previamente criada:

![Request termination](/kong-gateway/assets/gifs/kong/capacities/request-termination.gif)

## Forward Proxy plugin

O plugin `Request Termination` não será executado se o plugin `Forward Proxy` estiver habilitado.

O plugin `Forward Proxy` tem prioridade mais alta que o plugin `Request Termination`. Quando executado, a solicitação é encaminhada de acordo com a configuração desse plugin.

Se precisar alterar esse comportamento, você deverá configurar o plug-in Request Termination para ser executado antes do plug-in Forward Proxy usando `Dynamic Plugin Ordering` (disponível para a versão enterprise).

Mais detalhes na [documentação oficial](https://docs.konghq.com/hub/kong-inc/request-termination).
