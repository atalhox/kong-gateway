# Kong Gateway

O Kong Gateway é uma solução robusta e extensível para o gerenciamento de APIs, projetada para lidar com grandes volumes de tráfego.

Ele oferece funcionalidades avançadas para controle, segurança e flexibilidade, atuando como middleware entre os consumidores de API e os serviços upstream. Suas implementações podem ser feitas on-premise, na nuvem ou em ambientes híbridos.

## Principais Características

### Gerenciamento de Tráfego

#### Roteamento Inteligente

Direciona solicitações para diferentes serviços de backend

#### Balanceamento de Carga

Garante distribuição eficiente de requisições para maior desempenho

### Segurança de API

#### Proteção de Endpoints

Plugins nativos para autenticação, autorização e políticas de segurança

#### Integrações

Suporte a padrões como OAuth2 e OpenID Connect, além de criptografia e proteção contra ataques DDoS

### Monitoramento e Observabilidade

#### Integração com Ferramentas

Compatível com Prometheus, Grafana e OpenTelemetry para métricas e logs

### Plugins e Extensibilidade

#### Ecossistema de Plugins

Recursos como caching, limitação de taxa e transformação de mensagens

#### Personalização

Desenvolvimento de plugins específicos para requisitos empresariais

### Integração com Kubernetes

Atua como Ingress Controller, gerenciando APIs e facilitando controle de tráfego em arquiteturas de microsserviços.

## Vantagens do Kong Gateway para Empresas

### Escalabilidade

Projeta-se para suportar grandes volumes de tráfego, com adição ou remoção de recursos sem interrupções.

### Arquitetura Flexível e Extensível

Adaptação a diferentes infraestruturas com suporte nativo e extensões via plugins.

### Desempenho

#### Alta Performance

Baseado no NGINX, com latências reduzidas e alto throughput

### Comunidade e Suporte

Comunidade ativa, contribuições frequentes e suporte empresarial confiável.

## Modelos de Licenciamento

### Open Source

Disponível como pacote de código aberto, a versão do Kong oferece funcionalidades essenciais de um API Gateway, incluindo plugins da comunidade.

É uma solução robusta para quem precisa de um gerenciamento básico de APIs com um conjunto de recursos amplamente utilizados, sem custos adicionais.

#### Vantagens

- **Custo Zero:** A versão Open Source é totalmente gratuita, tornando-a uma excelente opção para pequenas empresas, startups e ambientes de teste.

- **Funcionalidades Essenciais:** Oferece recursos fundamentais de um API Gateway, como roteamento de tráfego, balanceamento de carga, autenticação e autorização, entre outros.

- **Plugins Comunitários:** Acesso a uma grande variedade de plugins desenvolvidos pela comunidade, que podem ser usados para estender as funcionalidades do Kong.

- **Gerenciamento Flexível:** Pode ser gerenciado através da Admin API do Kong, do Kong Manager Open Source ou utilizando configurações declarativas (YAML), oferecendo flexibilidade na administração.

- **Documentação e Suporte da Comunidade:** A comunidade ativa oferece suporte e contribuições constantes, além de uma documentação completa e constantemente atualizada.

- **Escalabilidade:** Embora não ofereça todos os recursos avançados da versão Enterprise, o Kong Open Source ainda é escalável e pode ser utilizado em diversos cenários, desde pequenas implementações até ambientes de maior porte.

#### Desvantagens

- **Falta de Controle Granular (RBAC):** A versão Open Source não inclui recursos de controle de acesso baseado em função (RBAC), o que significa que você terá que contar com controle de acesso externo, como firewalls, proxies ou autenticação básica, para gerenciar quem pode acessar a Admin API ou o Kong Manager.

- **Suporte Limitado:** Enquanto a versão Enterprise conta com suporte oficial e serviços de SLA, a versão Open Source depende do suporte da comunidade, o que pode ser um desafio em ambientes críticos.

- **Funcionalidades Avançadas Restritas:** Recursos como suporte a múltiplos ambientes, gerenciamento de consumidores, plugins de segurança avançados e algumas integrações, como por exemplo vaults, estão disponíveis apenas na versão Enterprise.

- **Falta de Garantias de Alta Disponibilidade e Failover:** A versão Open Source não oferece garantias de alta disponibilidade ou failover automático, recursos essenciais em ambientes de produção críticos.

### Enterprise

API Gateway com funcionalidade adicional. Apesar de ser uma versão corporativa, pode ser utilizado em versão Free, sem o uso de licença.

#### RBAC

Uma das funcionalidades adicionais do Kong Enterprise é o controle de acesso baseado em função (RBAC - Role-Based Access Control), essencial para gerenciar permissões de forma granular, assegurando que diferentes usuários e sistemas tenham apenas os acessos necessários.

- **Usuários e Grupos:** Cada usuário pode ser associado a funções ou grupos com permissões específicas.
- **Funções (Roles):** Definem os conjuntos de permissões que determinam o que os usuários podem acessar ou modificar.
- **Permissões:** Controles específicos atribuídos às funções, como leitura, escrita ou execução em recursos do Kong, incluindo serviços, rotas, plugins, etc.
- **Tokens:** Geração de tokens de acesso para autenticar e autorizar solicitações de APIs administrativas.

### Kong Konnect

Plataforma completa para o ciclo de vida de APIs, com monitoramento em tempo real e painel centralizado.

## Ambientes Compatíveis

Nuvens públicas, privadas, híbridas e on-premise

Integração nativa com Kubernetes para maior controle de tráfego e suporte a arquiteturas modernas.
