# Deployment

Guia rápido de configuração e uso via Minikube

## Makefile

### Setup

Adiciona repositório e atualiza em ambiente local

```bash
make setup
```

### Namespace

Configura o namespace kong

```bash
make namespace
```

### Certificates

Cria e adiciona os certificados SSL no Kong via secret:

```bash
make certificates
```

### Install

Sobe instâncias Kong via Control e Data planes:

```bash
make install
```

### Full Install

Realiza todas as etapas anteriores.

```bash
make full-install
```

### Upgrade

Realiza o upgrade do Control e Data planes:

```bash
make upgrade
```

### Clean

Realiza a limpeza do ambiente:

```bash
make clean
```

### Watch

Verifica a subida dos pods:

```bash
make watch
```
