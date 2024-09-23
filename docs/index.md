# Introdução

Esta documentação fornece uma visão abrangente sobre API Gateways e sua importância no ambiente corporativo. As ferramentas de API Gateway são equipadas com um robusto conjunto de funcionalidades, seja nativamente ou por meio de extensões, que facilitam a gestão de APIs em grande escala.

Além disso, esta documentação também explorará diferentes ferramentas de API Gateway, cada uma com suas próprias funcionalidades e características únicas. Cada ferramenta poderá possuir uma nomenclatura específica para funcionalidades de Gateways que poderão ser encontradas aqui pelos nomes mais comumente vistos no mercado.

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

![Topologia](/assets/img/topologias/integracao-gateway.png)
