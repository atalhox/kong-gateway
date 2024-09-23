# Visão geral

Prometheus é uma ferramenta de monitoramento e alerta de sistemas open-source, amplamente utilizado devido às suas capacidades avançadas de coleta de métricas e monitoramento em tempo real.

A seguir estão algumas razões pelas quais o Prometheus é utilizado:

## Coleta de Métricas

Prometheus coleta métricas de várias fontes de dados em intervalos configuráveis. Isso inclui métricas de infraestrutura, aplicações e serviços.

## Modelo de Dados

Utiliza um modelo de dados de séries temporais, onde os dados são armazenados como métricas rotuladas com pares de chave-valor. Isso facilita consultas e agregações complexas.

## Consulta e Análise

Possui uma linguagem de consulta poderosa chamada PromQL (Prometheus Query Language), que permite explorar e analisar dados de forma eficiente.

## Alerting

Integra-se com o Alertmanager para definir e gerenciar regras de alerta baseadas nas métricas coletadas. Isso permite configurar alertas avançados e enviar notificações quando determinadas condições são atendidas.

## Autossuficiência

Prometheus é autossuficiente, ou seja, ele armazena os dados localmente e não depende de armazenamento remoto, o que simplifica a implementação e reduz a latência.

## Escalabilidade

Escala bem em ambientes de grande porte devido ao seu design eficiente e à capacidade de lidar com grandes volumes de dados.

## Ecossistema Rico

Possui um ecossistema robusto com muitos exportadores e integrações disponíveis para diversas tecnologias e plataformas (como Kubernetes, Docker, sistemas operacionais, bancos de dados, etc.)

## Suporte à Visualização

Prometheus se integra facilmente com ferramentas de visualização como Grafana, permitindo a criação de dashboards detalhados para visualização de métricas.
