# Configuração do Prometheus no Kong

Para configurar o Prometheus para coletar métricas do Kong com SSL habilitado, você precisará garantir que o endpoint do Kong esteja configurado para suportar HTTPS e que o Prometheus possa se conectar a esse endpoint.

## Ativar o Plugin do Prometheus no Kong

Ative o plugin Prometheus no Kong como anteriormente descrito, certificando-se de que está usando o endpoint HTTPS:

```bash
curl -i -X POST https://localhost:8444/plugins \
  --cacert /path/to/cert.pem \
  --data "name=prometheus"
```

## Configurar o Prometheus para Coletar Métricas do Kong via HTTPS

Atualize o arquivo de configuração do Prometheus (prometheus.yml) para usar HTTPS ao coletar métricas do Kong. Certifique-se de incluir a configuração de tls_config para que o Prometheus use o certificado apropriado.

```yaml
scrape_configs:

- job_name: 'kong'
    scheme: https
    tls_config:
      ca_file: /path/to/cert.pem
      cert_file: /path/to/cert.pem
      key_file: /path/to/key.pem
    static_configs:
  - targets: ['localhost:8444']
```

## Reinicie o Prometheus

Reinicie o Prometheus para aplicar as mudanças.

```bash
systemctl restart prometheus
```
