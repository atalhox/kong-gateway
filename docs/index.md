# API Gateway

Esta documentação fornece uma visão abrangente sobre API Gateways e sua importância no ambiente corporativo.

As ferramentas de API Gateway são equipadas com um robusto conjunto de funcionalidades, seja nativamente ou por meio de extensões, que facilitam a gestão de APIs em grande escala.

Além disso, esta documentação também explorará diferentes ferramentas de API Gateway, cada uma com suas próprias funcionalidades e características únicas.

Cada ferramenta poderá possuir uma nomenclatura específica para funcionalidades de Gateways que poderão ser encontradas aqui pelos nomes mais comumente vistos no mercado.

## O que são API Gateways?

O API Gateway é uma ferramenta poderosa que serve como um intermediário entre os clientes e os serviços de back-end.

Através de uma interface unificada para serviços, o Gateway permite que os clientes acessem suas funcionalidades sem precisar de um maior detalhamento da implementação destes serviços.

## Por que utilizar um API Gateway?

O API Gateway fornece uma camada de abstração entre os clientes e seus serviços. Ele permite que os desenvolvedores encapsulem a complexidade interna dos seus serviços e exponham APIs de forma transparente aos clientes.

Além disso, ele fornece recursos adicionais como autenticação, autorização, limitação de taxa, balanceamento de carga e logging, reduzindo a complexidade de sua implementação.

## Onde implantar o API Gateway?

O API Gateway é geralmente implementado na borda da rede, agindo como o ponto de entrada para todas as solicitações de API vindas de clientes externos.

No entanto, ele também pode ser usado internamente para gerenciar a comunicação entre serviços.

## Como um API Gateway funciona?

O API Gateway recebe uma solicitação de um cliente, determina para qual serviço a solicitação deve ser encaminhada, encaminha a solicitação para esse serviço e, em seguida, retorna a resposta do serviço ao cliente.

Ele também pode modificar a solicitação ou a resposta, ou acionar outras ações ou políticas com base em regras pre-definidas.

## Capacidades

Em sua maioria, os gateways possuem funcionalidades integradas que operam de forma nativa, no entanto, outras capacidades podem ser expandidas e até mesmo personalizadas através do uso de políticas, extensões ou plugins.

## Kong Gateway

O Kong Gateway é uma solução robusta e altamente extensível para gerenciamento de APIs, com funcionalidades que permitem maior controle, segurança e flexibilidade sobre as APIs expostas. Ele oferece uma arquitetura flexível e pode ser implantado em várias infraestruturas, seja on-premise, em nuvem ou em ambientes híbridos.

### Características

#### Gerenciamento de Tráfego

Kong permite roteamento inteligente de solicitações para diferentes serviços de backend, além de oferecer balanceamento de carga, permitindo uma distribuição eficaz de requisições.

#### Segurança

Com suporte nativo a plugins para autenticação, autorização e políticas de segurança, o Kong ajuda a proteger os endpoints expostos.

Também é possível integrar com serviços de autenticação como OAuth2 e OpenID Connect.

#### Monitoramento e Observabilidade

O Kong oferece integração com ferramentas de monitoramento como Prometheus, Grafana e OpenTelemetry, o que facilita a captura de métricas e o monitoramento de logs e eventos.

#### Plugins

Um dos pontos fortes do Kong é seu ecossistema de plugins, permitindo extensões customizadas de funcionalidades, como caching, limitação de taxa, políticas de segurança, transformação de payload e muito mais.

Isso facilita a adaptação do Kong a diferentes requisitos de negócios.

#### Suporte ao Kubernetes

Com sua capacidade de integração nativa com Kubernetes, o Kong pode atuar como um Ingress Controller, permitindo o gerenciamento de APIs diretamente no ambiente Kubernetes e facilitando o controle de tráfego em ambientes de microsserviços.
