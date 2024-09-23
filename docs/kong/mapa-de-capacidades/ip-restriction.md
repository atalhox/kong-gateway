# IP Restriction

A restrição de IPs no Kong Gateway é uma funcionalidade que permite controlar o acesso a serviços baseados em regras de endereços IP.

Ela pode ser usada para permitir ou negar solicitações de IPs específicos ou intervalos de IPs, aumentando a segurança e garantindo que apenas usuários ou sistemas autorizados possam acessar determinados serviços.

## Por que utilizar a Restrição de IP?

### Cenário infeliz

Um atacante descobre uma vulnerabilidade no sistema e começa a fazer solicitações automatizadas de IPs diversos, sobrecarregando o serviço e tirando-o do ar.

Isso resulta na queda do serviço, manutenção e custos adicionais para mitigar o ataque e recuperar os serviços, impactando diretamente na experiência do usuário e incidentes de segurança.

### Cenário feliz

Por outro lado, considere uma cenário em que utiliza-se a restrição de IP no Kong Gateway para proteger suas APIs críticas. Apenas IPs de redes internas e parceiros de negócios confiáveis são permitidos.

Um dia, uma tentativa de ataque DDoS é detectada, mas como os IPs dos atacantes não estão na lista permitida, o ataque é automaticamente bloqueado. A operação continua sem interrupções, a confiança dos clientes é mantida e os custos de mitigação de ataques são drasticamente reduzidos.

A restrição de IP garante que apenas acessos legítimos possam ocorrer, protegendo os ativos da empresa.

## Como configurar a Restrição de IP?

O plugin de IP Restriction opera adicionando endereços IP a listas brancas e negras configuradas pelo administrador.

Quando uma solicitação é recebida, o Kong verifica o IP de origem contra essas listas. Se o IP estiver na lista negra, o acesso é bloqueado imediatamente.

Se estiver na lista branca, o acesso é permitido.

Caso o IP não esteja em nenhuma lista, o comportamento pode ser configurado conforme a política de segurança desejada, seja bloqueando por padrão ou permitindo o acesso.

Para configurar a restrição de IP no Kong Gateway, siga os passos abaixo:

### Via API administrativa

```bash
curl -i -X POST http://admin-url:8001/routes/{route-id}/plugins \
  --data name=ip-restriction \
  --data 'config.whitelist={allowed-ip-1},{allowed-ip-2}' \
  --data 'config.blacklist={unallowed-ip-1},{unallowed-ip-2}'
```

### Via decK

Adicione as seguintes configurações em sua config decK.

```yaml
routes:
  - name: my-route  # Substitua pelo nome ou ID da sua rota
    plugins:
      - name: ip-restriction
        config:
          whitelist:
            - allowed-ip-1
            - allowed-ip-2
          blacklist:
            - unallowed-ip-1
            - unallowed-ip-2
```

Para implantar as configurações:

```bash
deck gateway sync <deck-config.yaml>
```

### Via Kong Manager

![IP Restriction](/kong-gateway/assets/gifs/kong/capacities/ip-restriction.gif)

Mais detalhes podem ser obtidos da [documentação oficial Kong](https://docs.konghq.com/hub/kong-inc/ip-restriction/).
