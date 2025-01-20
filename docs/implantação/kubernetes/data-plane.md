# Data plane

O Data Plane (Plano de Dados) é a parte do Kong Gateway responsável por processar o tráfego de API em tempo de execução. Ele atua como a camada operacional da arquitetura, implementando as políticas configuradas pelo Control Plane e garantindo que as solicitações sejam gerenciadas de maneira eficiente e segura.

O Data Plane é projetado para:

- Gerenciar o Tráfego de API: Processar solicitações e respostas entre clientes e backends.

- Aplicar Políticas: Implementar políticas configuradas, como autenticação, autorização, limitação de taxa, cache e transformação de solicitações.

- Registrar Logs e Métricas: Coletar dados operacionais sobre o tráfego de API, que podem ser enviados para ferramentas de monitoramento como Grafana, Prometheus ou ELK Stack.

## Como Funciona

O Data Plane é configurado para operar com base nas instruções recebidas do Control Plane. Ele não gerencia configurações diretamente, mas aplica as regras e políticas definidas. O fluxo típico de operação do Data Plane é:

1. Receber solicitações de clientes (por exemplo, chamadas de API).
2. Validar as solicitações com base nas políticas configuradas (como autenticação).
3. Direcionar as solicitações para os serviços backend correspondentes.
4. Transformar e enviar respostas de volta para os clientes, se necessário.

## Componentes Associados

### Proxy

Principal componente do Data Plane, responsável pelo roteamento de solicitações e pela aplicação de políticas configuradas.

### Plugins

Executam funcionalidades adicionais, como autenticação, análise de tráfego e limitação de taxa, diretamente no Data Plane.

### Cache

O Data Plane pode utilizar cache interno para melhorar o desempenho, armazenando temporariamente respostas ou verificações de autenticação.

### Certificados SSL

Permitem conexões seguras entre clientes e o Data Plane, bem como entre o Data Plane e backends.

## Modelos de Implantação

### Traditional Deployment

- O Data Plane acessa diretamente o banco de dados compartilhado com o Control Plane.

- Configurações são recuperadas diretamente do banco, o que simplifica a operação, mas limita a escalabilidade.

### Hybrid Deployment

- O Data Plane não acessa o banco de dados diretamente.

- Configurações são propagadas do Control Plane para o Data Plane usando mTLS.

- Mais adequado para arquiteturas distribuídas e de alta disponibilidade.

## Benefícios do Data Plane

- Desempenho: O processamento local de políticas e plugins garante baixa latência.

- Escalabilidade: Vários Data Planes podem ser implantados em paralelo para atender a grandes volumes de tráfego.

- Isolamento: A separação entre Control Plane e Data Plane melhora a segurança e a estabilidade operacional.

- Resiliência: Continua operando com as configurações propagadas mesmo que o Control Plane fique temporariamente indisponível.

## Considerações Importantes

- Sincronização: É fundamental garantir que o Data Plane receba as configurações mais recentes do Control Plane.

- Manutenção: Atualizações no Data Plane devem ser cuidadosamente planejadas para evitar interrupções no tráfego de API.

- Monitoramento: O Data Plane deve ser integrado a sistemas de monitoramento para rastrear desempenho, erros e uso.

## Cenários de Uso

- Edge Gateways: Onde o Data Plane é implantado próximo aos clientes para reduzir a latência.

- Regiões Distribuídas: Em ambientes multi-cloud ou multi-região, cada região pode ter um Data Plane dedicado para atender localmente às solicitações.

- APIs de Alta Performance: Em que o tráfego precisa ser roteado rapidamente e políticas complexas devem ser aplicadas em tempo real.
