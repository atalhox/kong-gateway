# Declarative Kong CLI

O `deck` (Declarative Configuration CLI for Kong) é uma ferramenta que permite gerenciar a configuração de uma instância do Kong de maneira declarativa, com arquivos de configuração YAML.

Esse modelo declarativo facilita o versionamento, backup e restauração das configurações do Kong, simplificando a gerência de ambientes complexos.

## Pré-requisitos

Para utilizar o `deck`, você precisará de:

- Uma instância do Kong Gateway rodando (Community ou Enterprise).
- Go 1.17 ou superior (para compilar o `deck` caso prefira instalá-lo diretamente do código).
- Docker.

## Como Funciona o deck

O deck usa um arquivo YAML para descrever a configuração completa do Kong Gateway. Com o deck, você pode:

- Exportar a configuração atual do Kong para um arquivo YAML.
- Aplicar um arquivo de configuração YAML ao Kong para criar ou atualizar recursos.
- Realizar backup e restauração de configurações.
- Estrutura de Configuração do deck

Um arquivo deck.yaml pode conter:

- Configurações de serviços e rotas.
- Configurações de plugins.
- Configurações de consumidores e credenciais.

Exemplo básico de um arquivo deck.yaml:

```yaml
_format_version: "1.1"
services:

- name: example-service
    url: <http://example.com>
    routes:
  - name: example-route
        paths:
    - /example
plugins:
- name: rate-limiting
    config:
      minute: 20
      hour: 500
consumers:
- username: example-consumer
    credentials:
  - key-auth: my-api-key
```

Para mais informações, consulte a [documentação oficial do deck](https://docs.konghq.com/deck/latest/).

## Casos de uso

### Versionamento de Configurações  

O deck permite gerenciar configurações de forma declarativa, facilitando o controle de versões dos recursos do Kong.

Mudanças nas configurações poderão ser rastreadas, revisadas e revertidas conforme necessário, o que é útil em equipes que seguem práticas de DevOps.

### Automação de Deploys  

Automatizar a implantação de configurações em diferentes ambientes, como desenvolvimento, testes e produção é um processo facilitado com o uso do deck.

Arquivos YAML podem ser usados em pipelines CI/CD para garantir que o ambiente de produção receba as configurações exatas necessárias.

### Backup e Restauração de Configurações  

Através do deck, é possível exportar toda a configuração de um Kong Gateway em funcionamento para um arquivo YAML, o que serve como backup.

Esse backup pode ser restaurado rapidamente em caso de falhas ou ao migrar para uma nova instância.

### Gerenciamento de Ambientes Complexos  

Em ambientes onde múltiplas instâncias do Kong são usadas (por exemplo, em ambientes híbridos ou multinuvem), o deck permite gerenciar todas as configurações de forma centralizada e uniforme.

Isso ajuda a garantir consistência entre diferentes instâncias do Kong.

### Auditoria e Conformidade  

Usar arquivos YAML declarativos com o deck facilita auditorias de configuração e ajuda a garantir que a configuração do Kong esteja em conformidade com padrões de segurança e requisitos regulamentares.

### Migração de Configurações  

Com o deck, é possível exportar as configurações de uma instância do Kong e aplicá-las a outra, facilitando migrações de ambiente ou atualizações entre versões do Kong Gateway.

### Facilidade de Gerenciamento em Equipes  

O deck permite que equipes trabalhem de maneira colaborativa no gerenciamento do Kong, usando sistemas de controle de versão como Git para armazenar e compartilhar as configurações YAML, simplificando o trabalho em equipe.

Esses casos de uso tornam o deck uma ferramenta valiosa para empresas que buscam consistência, eficiência e controle no gerenciamento de suas configurações do Kong Gateway.
