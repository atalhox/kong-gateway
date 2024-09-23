# Services

Um Service no Kong representa um serviço upstream (de backend) que será acessado por meio do Kong.

Essencialmente, é uma abstração que define o serviço real que responde às solicitações HTTP ou HTTPS. Um Service contém informações como o URL de destino, portas e outras configurações relevantes.

No contexto de negócios, isso significa que você pode gerenciar e configurar como o tráfego é direcionado para os seus serviços de backend de forma centralizada e eficiente, garantindo uma experiência de usuário final mais confiável e consistente.

## Por que usar Services?

Utilizar Services no Kong oferece inúmeros benefícios como a centralização da gestão dos serviços de backend, facilitando a manutenção e a atualização.

Há melhoras em segurança ao controlar como e quando os serviços são acessados, controlado por políticas.

Além disso, aumenta a eficiência operacional, permitindo a configuração e o roteamento inteligente do tráfego, otimizando a performance e a escalabilidade dos serviços.

## Como configurar um Service?

Para configurar um Service no Kong, você precisa definir as informações do serviço upstream, como o URL de destino, portas e outras configurações específicas.

Isso geralmente é feito por meio da API de administração do Kong ou através de um arquivo de configuração.

Após definir o Service, você pode associá-lo a uma ou mais Routes, garantindo que as solicitações sejam direcionadas corretamente.

A configuração pode ser ajustada conforme necessário para responder a mudanças nas necessidades de tráfego ou nos requisitos de segurança, garantindo uma operação contínua e eficiente.

### Via API administrativa

Configuração de um serviço backend

```bash
curl -i -X POST http://admin-url:8001/services \
  --header "Content-Type: application/json" \
  --data '{
  "name": "complete-service",
  "url": "http://example.com",
  "retries": 5,
  "connect_timeout": 3000,
  "write_timeout": 3000,
  "read_timeout": 3000,
  "protocol": "http",
  "host": "example.com",
  "port": 80,
  "path": "/api",
  "tags": ["example-tag"],
  "client_certificate": "YOUR_CERTIFICATE_ID"
  }'
```

Um service **somente poderá ser acessado se tiver um route associado a ele** e não poderá ser removido se ainda houver um route associado.

### Via decK

Exemplo de configuração:

```bash
_format_version: "1.1"
services:
- name: complete-service
  url: http://example.com
  retries: 5
  connect_timeout: 3000
  write_timeout: 3000
  read_timeout: 3000
  protocol: http
  host: example.com
  port: 80
  path: /api
  tags:
  - example-tag
  client_certificate:
    id: YOUR_CERTIFICATE_ID
```

- Observação: mais detalhes sobre como configurar o decK na seção do decK.

### Via Kong Manager

Exemplo de configuração de service:
![Grafana](/kong-gateway/assets/gifs/kong/integrations/grafana.gif)

Mais detalhes podem ser obtidos da [documentação oficial](https://docs.konghq.com/gateway/latest/key-concepts/services/).
