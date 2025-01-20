# Control plane

O Control Plane (Plano de Controle) é uma das partes fundamentais da arquitetura do Kong Gateway, especialmente em ambientes que utilizam o modelo de implantação híbrido ou distribuído. Ele desempenha um papel crucial no gerenciamento centralizado de configurações e na coordenação de outros componentes do sistema.

O Control Plane é responsável por:

- Gerenciar Configurações: Centraliza a configuração de serviços, rotas, plugins e certificados SSL.

- Distribuir Configurações: Propaga essas configurações para os Data Planes (Planos de Dados), que são os responsáveis por processar o tráfego de API em tempo de execução.

- Garantir Consistência: Mantém a consistência das configurações em múltiplos Data Planes, mesmo em ambientes geograficamente distribuídos.

## Como Funciona

O Control Plane se comunica com os Data Planes usando o protocolo mTLS (Mutual TLS) para garantir segurança. A comunicação ocorre de maneira unidirecional:

1. O administrador faz alterações de configuração no Control Plane.
2. O Control Plane distribui essas configurações para os Data Planes.
3. Os Data Planes aplicam as configurações para gerenciar o tráfego de API.

Dessa forma, o Control Plane atua como o cérebro do sistema, enquanto os Data Planes executam as instruções recebidas.

## Componentes Associados

### Banco de Dados

O Control Plane utiliza um banco de dados (como PostgreSQL) para armazenar todas as configurações relacionadas a serviços, rotas e plugins.

No modelo de "Traditional Deployment", o Control Plane e o Data Plane compartilham acesso ao mesmo banco de dados.

### Kong Admin API

A interface de gerenciamento usada para configurar o Control Plane.

Pode ser acessada diretamente para criar, ler, atualizar e excluir configurações.

### Certificados de Segurança

O Control Plane usa certificados SSL/TLS para autenticar e proteger a comunicação com os Data Planes.

## Modelos de Implantação

### Traditional Deployment

Tanto o Control Plane quanto o Data Plane compartilham o mesmo banco de dados.

Simples de configurar, mas menos escalável em grandes ambientes.

### Hybrid Deployment

O Control Plane e os Data Planes são separados. O Control Plane distribui configurações aos Data Planes por meio de um canal seguro.

Ideal para arquiteturas distribuídas e de alta disponibilidade.

## Benefícios do Control Plane

- Centralização: Todas as configurações são gerenciadas de maneira centralizada, facilitando o controle e a auditoria.

- Escalabilidade: Permite escalar os Data Planes independentemente do Control Plane, atendendo a diferentes volumes de tráfego.

- Segurança: A comunicação entre Control Plane e Data Planes é protegida por mTLS, garantindo integridade e confidencialidade.

- Flexibilidade: Oferece suporte a vários modelos de implantação, permitindo que as empresas escolham a abordagem mais adequada às suas necessidades.

## Considerações Importantes

- Resiliência: O Control Plane não precisa estar disponível 100% do tempo para que os Data Planes processem o tráfego. As configurações já propagadas permanecem ativas no Data Plane, mesmo que o Control Plane fique offline temporariamente.

- Latência: Alterações de configuração podem levar alguns segundos para serem propagadas aos Data Planes em ambientes distribuídos.

- Manutenção: Atualizações e mudanças no Control Plane devem ser planejadas cuidadosamente para evitar interrupções no fluxo de trabalho.

## Cenários de Uso

- Ambientes Multi-Cloud: Onde Data Planes estão localizados em diferentes regiões geográficas ou provedores de nuvem.

- Segurança e Conformidade: Configurações centralizadas facilitam a aplicação de políticas de segurança e a conformidade com regulamentações como, LGPD, GDPR ou HIPAA.

- Alta Disponibilidade: Ambientes que requerem failover automático e continuidade do tráfego de API.
