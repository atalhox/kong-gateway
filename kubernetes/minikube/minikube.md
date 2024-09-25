# Minikube

## Start

Inicia um cluster local do Kubernetes utilizando o Minikube. Esse comando cria e configura uma máquina virtual ou contêiner local onde o cluster do Kubernetes será executado.

```bash
minikube start [opções]
```

Principais opções:

**--cpus**: Define o número de CPUs para a VM.
Exemplo: `minikube start --cpus=4`

**--memory**: Define a quantidade de memória RAM para a VM.
Exemplo: `minikube start --memory=4096`

**--driver**: Especifica o driver que será utilizado (ex.: docker, virtualbox, hyperkit).
Exemplo: `minikube start --driver=docker`

**--kubernetes-version**: Define a versão do Kubernetes a ser usada.
Exemplo: `minikube start --kubernetes-version=v1.23.0`

**--addons**: Instala add-ons junto ao cluster.
Exemplo: `minikube start --addons=ingress,dashboard`

## Delete

Remove completamente o cluster do Minikube, apagando a VM, as configurações e os volumes associados ao cluster do Kubernetes. Útil para limpar o ambiente ou recriar um cluster do zero.

```bash
minikube delete [opções]
```

Principais opções:

**--all**: Remove todos os clusters do Minikube no ambiente.
Exemplo: `minikube delete --all`

**--purge**: Remove também os arquivos de configuração e de cache.
Exemplo: `minikube delete --purge`

## Dashboard

Abre o dashboard web do Kubernetes para o cluster em execução no Minikube. O dashboard oferece uma interface gráfica para visualizar e gerenciar recursos do Kubernetes, como Pods, Deployments, Services, etc.

```bash
minikube dashboard [opções]
```

Principais opções:

**--url**: Em vez de abrir o navegador automaticamente, retorna apenas a URL do dashboard para que você possa acessá-lo manualmente.
Exemplo: `minikube dashboard --url`

## Tunnel

O comando `minikube tunnel` cria um túnel que permite acessar serviços no Minikube com tipo de serviço `LoadBalancer` diretamente a partir do host.

Normalmente, `LoadBalancer` no Kubernetes é utilizado para expor um serviço para **fora do cluster**, mas no caso do Minikube (que roda em um ambiente local), ele não oferece suporte nativo a LoadBalancer, uma vez que não há uma infraestrutura de cloud gerenciando isso.

Quando você usa o comando, ele cria esse suporte ao LoadBalancer, fornecendo **IPs locais** para os serviços e permitindo que você acesse os serviços diretamente do seu ambiente local, como se fosse em um ambiente de produção.

Principais funções do minikube tunnel:

1. Cria IPs externos para serviços tipo LoadBalancer.
2. Necessita de permissões administrativas para modificar as rotas de rede.
3. Funciona em segundo plano até ser interrompido.

Por exemplo, ao rodar o comando minikube tunnel:

1. O Minikube configurará as rotas de rede para que você possa acessar os serviços expostos pelo LoadBalancer.
2. O Kubernetes alocará um IP público para o serviço LoadBalancer, acessível pelo seu host.

## Testando o serviço localmente

### Minikube Tunnel

A [documentação oficial](https://docs.konghq.com/gateway/latest/install/kubernetes/proxy/) sugere que você obtenha o proxy IP. Porém, se você tentar fazer isso localmente sem possuir IPs externos para o data plane

você obterá um resultado indesejável.

Neste caso, exponha primeiramente o serviço através do `minikube tunnel`.

```bash
minikube tunnel
```

### Exponha o serviço da API administrativa  

Execute `kubectl port-forward` para configurar o encaminhamento de porta e acessar a API administrativa:

```bash
kubectl port-forward -n kong service/kong-cp-kong-admin 8001
```

### Crie um serviço e rota de mock via API administrativa

```bash
curl localhost:8001/services -d name=mock -d url="<http://httpbin.org>"
curl localhost:8001/services/mock/routes -d "paths=/mock"
```

### Obtenha o IP do proxy

Como obter o `PROXY IP`:

```bash
PROXY_IP=$(kubectl get service --namespace kong kong-dp-kong-proxy -o jsonpath='{range .status.loadBalancer.ingress[0]}{@.ip}{@.hostname}{end}')
```

### Consuma a API

Faça uma solicitação HTTP para o seu $PROXY_IP:

```bash
curl $PROXY_IP/mock/anything
```

O resultado esperado é similar a:

```bash
{
  "args": {},
  "data": "",
  "files": {},
  "form": {},
  "headers": {
    "Accept": "*/*",
    "Host": "httpbin.org",
    "User-Agent": "curl/7.81.0",
    "X-Amzn-Trace-Id": "Root=1-66f457b0-289e4ebf58de27665bd4875a",
    "X-Forwarded-Host": "127.0.0.1",
    "X-Forwarded-Path": "/mock/anything",
    "X-Forwarded-Prefix": "/mock",
    "X-Kong-Request-Id": "adac232fb6308b69cca1717d7a639b06",
    "Z-Forwarded-For": "AAAAAAAAAA"
  },
  "json": null,
  "method": "GET",
  "origin": "xxx.xxx.xx.xxx, xxx.xxx.xx.xxx",
  "url": "http://127.0.0.1/anything"
}
```
