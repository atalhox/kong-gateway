# Routes

Uma Route no Kong é uma definição que conecta um serviço a uma solicitação de cliente. Ao configurar uma Route, você especifica como as solicitações HTTP devem ser endereçadas para os serviços adequados no seu backend.

Isso inclui a definição de critérios como:

- método HTTP;
- cabeçalhos;
- caminho de URL;
- hosts.

Em termos simples, uma rota atua como um mapeamento entre o que o cliente solicita e onde essa solicitação deve ser encaminhada no backend.

No contexto de negócios, essa capacidade garante que as solicitações dos clientes sejam tratadas de maneira eficiente e direcionadas ao serviço correto, aumentando a confiabilidade e a satisfação do cliente.

## Por que usar Routes?

A utilização de rotas permite uma gestão mais granular e flexível do tráfego de rede, garantindo que cada solicitação seja processada pelo serviço mais apropriado.

Além disso, facilita a implementação de políticas de segurança e conformidade, ao assegurar que apenas solicitações válidas sejam encaminhadas aos serviços internos.

Finalmente, otimiza a performance e a escalabilidade do sistema, permitindo uma distribuição equilibrada de carga entre diferentes serviços, o que é crucial para manter a qualidade do serviço em um setor tão competitivo.

## Como configurar uma Route no Kong?

Para configurar uma Route no Kong, você precisa definir os critérios de roteamento, que podem incluir métodos HTTP, cabeçalhos, caminhos de URL e hosts.

Isso geralmente é feito por meio da API de administração do Kong ou API administrativa.

A configuração de métodos específicos em uma rota no Kong permite que os desenvolvedores definam quais métodos HTTP (como GET, POST, PUT, DELETE, etc.) são permitidos em uma determinada rota.

Isso adiciona uma camada de controle e segurança, garantindo que apenas os métodos desejados possam ser utilizados para interagir com os endpoints específicos da API. Essa configuração ajuda a prevenir acesso indevido e operações não autorizadas em recursos protegidos.

### Via API administrativa

Exemplo de configuração:

```bash
curl -i -X POST \
  --url http://admin-url:8001/routes \
  --data '{
    "hosts": ["api.exemplo.com"],
    "paths": ["/caminho-exemplo"],
    "methods": ["GET", "POST"],
    "protocols": ["http", "https"],
    "strip_path": true,
    "preserve_host": false,
    "service": {
      "id": "id_do_seu_servico"
    }
  }'
```

### Via decK

Exemplo de configuração:

```bash
_format_version: "1.1"
routes:
- name: example-route
  hosts:
  - api.exemplo.com
  paths:
  - /caminho-exemplo
  methods:
  - GET
  - POST
  protocols:
  - http
  - https
  strip_path: true
  preserve_host: false
  service:
    id: id_do_seu_servico
```

- Observação: mais detalhes sobre como configurar o decK na seção do decK

### Via Kong Manager

Exemplo de configuração de rota:
![Routes](/docs/assets/gifs/kong/capacities/routes.gif)

### Fallback route

Um bom caso de uso é a criação de um endpoint `/` responsável por lidar com o tráfego de endpoints inexistentes.

Esta rota é chamada de catch-all e atua como um endpoint que serve a todas as rotas não definidas, podendo trazer uma mensagem de exceção adequada(para configurar uma mensagem personalizada, utilize o plugin `request termination`).

Mais detalhes sobre a configuração de rotas, serviços e seus parâmetros podem ser vistas na [documentação oficial](https://docs.konghq.com/gateway/latest/get-started/services-and-routes/).
