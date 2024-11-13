# Kong

O **Kong Gateway** é uma solução robusta e altamente extensível para gerenciamento de APIs, projetado para lidar com grandes volumes de tráfego, oferecendo funcionalidades de controle, segurança e flexibilidade sobre as APIs expostas.

Ele atua como um middleware entre os consumidores de API e os serviços upstream, garantindo alta disponibilidade e protegendo os endpoints de API contra ameaças potenciais.

O Kong pode ser implantado on-premise, em nuvem ou em ambientes híbridos.

## Principais características

### Gerenciamento de Tráfego

O Kong permite roteamento inteligente de solicitações para diferentes serviços de backend e oferece balanceamento de carga, garantindo distribuição eficaz de requisições e maior desempenho das APIs.

### Segurança de API e Proteção de Endpoints

Com suporte nativo a plugins para autenticação, autorização e políticas de segurança, o Kong protege os endpoints expostos.

O Kong oferece robustos recursos de segurança, suportando autenticação, autorização, criptografia de dados em trânsito e proteção contra ataques DDoS.

Ele também permite integração com serviços de autenticação e autorização como OAuth2 e OpenID Connect.

### Monitoramento e observabilidade integrados

O Kong oferece integração com ferramentas de monitoramento como **Prometheus**, **Grafana** e **OpenTelemetry**, facilitando a captura de métricas e o monitoramento de logs e eventos.

### Plugins personalizados e extensão de capacidades

O Kong possui um ecossistema de plugins, permitindo extensões personalizadas de funcionalidades, como caching, limitação de taxa, políticas de segurança e transformação de mensagem.

Isso facilita a adaptação a diferentes requisitos de negócios e proporciona um controle total sobre o comportamento do gateway.

### Integração com Kubernetes e Microsserviços

Com integração nativa ao **Kubernetes**, o Kong pode atuar como um Ingress Controller, gerenciando APIs diretamente em ambientes Kubernetes e facilitando o controle de tráfego em arquiteturas de microsserviços.

## Vantagens do Kong Gateway para empresas

### Escalabilidade

Projetado para lidar com grandes volumes de tráfego, o Kong permite adicionar ou remover recursos conforme necessário sem interrupções, mantendo desempenho consistente independentemente do volume de requisições.

### Arquitetura Flexível e Extensível

Kong oferece flexibilidade e extensibilidade através de sua arquitetura de plugins. Além dos plugins disponíveis para funcionalidades como autenticação, limitação de taxa e caching, é possível desenvolver plugins personalizados para atender a necessidades específicas.

### Desempenho Otimizado para Alta Demanda

O Kong é conhecido pelo alto desempenho, suportando baixas latências e alto throughput, utilizando **NGINX** como base.

Isso assegura que as requisições de API sejam processadas rapidamente, oferecendo uma experiência de usuário final mais satisfatória.

### Comunidade ativa e suporte empresarial

Kong possui uma comunidade ativa e um suporte corporativo forte, com contribuições de desenvolvedores que enriquecem a ferramenta com novos plugins, atualizações e melhores práticas.

## Ambiente de instalação

Kong pode ser implementado em diversos ambientes, incluindo nuvens públicas, privadas e híbridas, além de instalações on-premise.

Sua flexibilidade permite adaptação a diferentes infraestruturas, integrando-se facilmente com serviços de backend e plataformas de orquestração de contêineres como Kubernetes.

## Modelos de Licenciamento do Kong Gateway

### Versão Enterprise

Inclui funcionalidades avançadas como suporte prioritário, ferramentas de análise de desempenho, integração com sistemas empresariais e suporte para ambientes de alta disponibilidade, sendo ideal para grandes empresas com requisitos complexos e de missão crítica.

Possui plugins que estão disponíveis apenas para esta versão.

### Kong Konnect

Kong Konnect é uma plataforma completa para gerenciamento do ciclo de vida de APIs, com monitoramento em tempo real, segurança avançada e um painel unificado para administração centralizada. Projetado para empresas que precisam de alta escalabilidade e disponibilidade.

### Open source

Ideal para pequenas empresas ou uso em ambientes de teste, oferecendo funcionalidades básicas para iniciar o gerenciamento de APIs.

Possui plugins similares ao enterprise desenvolvidos pela comunidade e há a disponinilidade de personalização de plugins.
