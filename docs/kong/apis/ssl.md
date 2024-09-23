# SSL

Para o uso de OAuth 2.0 no Kong, mesmo que localmente, é necessária a configuração do protocolo https. Este guia irá apoiá-los nesta configuração.

## Gerar Certificados SSL

Se você ainda não possui certificados SSL, pode gerá-los usando OpenSSL.

```bash
openssl req -x509 -newkey rsa:2048 -keyout keytmp.pem -out cert.pem -days 365
```

Responda às perguntas adequadamente para gerar seu certificado auto-assinado. Com a senha escolhida em mãos, rode o comando abaixo:

```bash
openssl rsa -in keytmp.pem -out key.pem
```

## Configurar Certificados no Kong

```bash
curl -i -X POST <http://localhost:8001/certificates> --form "cert=@/path/to/server.crt" --form "key=@/path/to/server.key"
```

Certifique-se de substituir /path/to/server.crt e /path/to/server.key pelos caminhos corretos para os seus arquivos de certificado e chave privada.

## Configurar o Listener do Kong para HTTPS

Você precisa configurar o Kong para ouvir na porta HTTPS.

Isso pode ser feito editando o arquivo de configuração do Kong ou passando as variáveis de ambiente apropriadas.

### Editar o arquivo de configuração

Abra o arquivo kong.conf, configurado em `/etc/kong` e adicione ou modifique as seguintes linhas:

```text
admin_listen = 0.0.0.0:8444 ssl
proxy_listen = 0.0.0.0:8443 ssl
```

## Reiniciar o Kong

Após fazer essas mudanças, reinicie o Kong para aplicar as configurações:

```bash
kong restart
```

Verifique se o Kong está ouvindo na porta HTTPS e se o certificado está configurado corretamente, consumindo a rota do seu serviço.

Mais detalhes podem ser obtidos [aqui](https://support.konghq.com/support/s/article/How-to-setup-Kong-to-serve-an-SSL-certificate-for-API-requests).
