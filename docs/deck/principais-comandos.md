# Principais comandos

A seguir estão os principais comandos do decK utilizados para gerenciar configurações no Kong Gateway, muito úteis para uma esteira e automação de implantação.

Estes comandos permitem desde a validação de arquivos de configuração até operações avançadas como sync, diff, e merge de arquivos.

## Ping

Verifica a conectividade com o Kong Gateway.

```bash
deck gateway ping
```

Retorno:

```bash
Successfully connected to Kong!
Kong version:  3.7.1
```

## Convert spec

Converte um arquivo Swagger/OpenAPI em um arquivo compatível com o Kong Gateway.

```bash
deck file openapi2kong --spec <input-file> --output-file <output.yaml>
```

Exemplo:

```bash
deck file openapi2kong --spec swagger.json --output-file petstore.yaml    
```

## Validate

Valida um arquivo de configuração YAML para verificar erros de sintaxe ou conformidade.

```bash
deck gateway validate <config-file.yaml> # api administrativa

deck file validate <config-file.yaml> # api administrativa
```

Exemplo:

```bash
deck gateway validate petstore.yaml
```

O retorno de um erro na configuração como um parâmetro com erro de sintaxe `h=st` será similar ao exemplo a seguir:

```bash
Error: 1 errors occurred:
        reading file petstore.yaml: validating file content: 1 errors occurred:
        validation error: object="localhost", err=services.0: Additional property h=st is not allowed
```

## Diff

Compara as configurações no Kong Gateway com o arquivo local e exibe as diferenças.

```bash
deck gateway diff <config-file.yaml> 
```

Exemplo:

```bash
deck gateway diff petstore.yaml
```

Retorno de uma deleção de rota:

```bash
deleting route swagger-petstore_addpet
Summary:
  Created: 0
  Updated: 0
  Deleted: 1
```

## Dump

Exporta toda a configuração atual do Kong Gateway para um arquivo YAML.

```bash
deck gateway dump --output-file <output-file.yaml>
```

Exemplo:

```bash
deck gateway dump --output-file kong.yaml
```

## File lint

Valida um arquivo de estado YAML contra um conjunto de regras personalizadas.

```bash
deck file lint -s <state-file.yaml> <ruleset-file.yaml>
```

Exemplo:

```bash
deck file lint -s kong.yaml ruleset.yaml
```

Retorno exemplo:

```bash
Linting Violations: 3
Failures: 0

[warn][1:1] OpenAPI host `schemes` must be present and non-empty array: `schemes`, is missing and is required
[info][1:1] OpenAPI `host` must be present and a non-empty string: `host` must be set
[warn][1:1] no servers defined for the specification
```

## Deploy (Sync)

Aplica as configurações de um arquivo local no Kong Gateway, sincronizando as alterações.

```bash
deck gateway sync <deck-config.yaml>
```

Exemplo:

```bash
deck gateway sync petstore.yaml
```

Será exibido linha as configurações atualizadas(Routes, services, etc.).

```plain-text
Summary:
  Created: 21
  Updated: 0
  Deleted: 20
```

## Merge

Combina dois ou mais arquivos de configuração em um único arquivo de saída.

```bash
deck file merge -o merged.yaml <file1.yaml> <file2.yaml>
```

Exemplo:

```bash
deck file merge -o merged.yaml kong.yaml petstore.yaml
```

## Render

Renderiza arquivos YAML com variáveis e templates, gerando um novo arquivo com as variáveis resolvidas.

```bash
deck file render -o render.yaml <file1.yaml> <file2.yaml>
```

Exemplo:

```bash
deck file render -o render.yaml kong.yaml petstore.yaml
```

## Convert to KIC

Converte um arquivo YAML do Kong Gateway para um formato compatível com o Kubernetes Ingress Controller (KIC).

```bash
deck file kong2kic -s <state-file.yaml> -o <kic.yaml>
```

Exemplo:

```bash
deck file kong2kic -s kong.yaml -o kic.yaml
```

## Reset

Restaura o Kong Gateway removendo toda a configuração atual.

```bash
deck gateway reset
```

**Atenção: Este comando deleta toda a configuração do Kong. É altamente recomendável realizar um dump das configurações atuais antes de executar este comando.**
