# Topologias

## Visão Geral

O Kong Gateway oferece diferentes topologias de implantação para atender a diversas necessidades de escalabilidade, performance e gerenciamento.

Neste documento, exploramos as topologias **Standalone** e **Hybrid**, destacando suas características, casos de uso e principais diferenças.

## Topologias de Implantação

### Standalone

A topologia **Standalone** é a configuração mais básica do Kong, ideal para ambientes simples ou de desenvolvimento, onde não há necessidade de separar o gerenciamento do tráfego e a execução de configurações.

#### Características

- A execução ocorre em um único nó, sem necessidade de separação de control plane e data plane.
- Simplificada, com todos os serviços e plugins em um único processo.
- Ideal para ambientes de teste ou desenvolvimento.

#### Casos de Uso

- Ambientes de desenvolvimento e testes locais.
- Pequenas aplicações ou quando a performance e alta disponibilidade não são prioritárias.

#### Vantagens

- Configuração simplificada e fácil de gerenciar.
- Menor consumo de recursos.

#### Desvantagens

- Limitada para ambientes de produção complexos.
- Sem separação de control plane e data plane, o que limita a escalabilidade e o gerenciamento centralizado.

### Hybrid

A topologia **Hybrid** é projetada para ambientes de produção mais complexos, permitindo uma configuração distribuída e escalável.

Nesta configuração, há uma clara separação entre o **Control Plane (CP)** e o **Data Plane (DP)**, permitindo o gerenciamento centralizado das configurações.

#### Características

- **Control Plane (CP):** Responsável pela configuração e gerenciamento centralizado. As alterações de configuração do gateway são propagadas para os Data Planes.
- **Data Plane (DP):** Responsável pelo processamento das requisições dos clientes. Os DPs consomem a configuração enviada pelo CP, mas não possuem informações de configuração diretamente.
- Comunicação entre CP e DP ocorre através do **mTLS** para garantir segurança e confiabilidade.

#### Casos de Uso

- Ambientes de produção com alta demanda.
- Necessidade de escalabilidade horizontal, permitindo que múltiplos Data Planes processem o tráfego simultaneamente.
- Requer um ambiente de gerenciamento centralizado.

#### Vantagens

- Alta escalabilidade e capacidade de lidar com grandes volumes de tráfego.
- Centralização no Control Plane facilita o gerenciamento e a aplicação de políticas de segurança.
- Isolamento das requisições (DP) das configurações (CP), garantindo maior performance.

#### Desvantagens

- Configuração mais complexa, exigindo maior conhecimento para implementação e gerenciamento.
- Consome mais recursos, pois exige uma infraestrutura dedicada para CP e DP.
- Requer configuração de mTLS para comunicação segura entre CP e DP.

## Comparação entre Standalone e Hybrid

| Aspecto                 | Standalone                                     | Hybrid                                   |
|-------------------------|------------------------------------------------|------------------------------------------|
| **Separação de Funções** | Não há separação entre CP e DP                 | CP e DP separados                         |
| **Complexidade de Configuração** | Simples                                    | Moderada a alta                          |
| **Escalabilidade**      | Limitada                                       | Alta                                     |
| **Casos de Uso**        | Desenvolvimento e testes locais                | Produção de larga escala                 |
| **Consumo de Recursos** | Baixo                                          | Moderado a alto                          |
| **Segurança de Comunicação** | Não necessário                              | Necessita mTLS entre CP e DP             |

### Microgateway
