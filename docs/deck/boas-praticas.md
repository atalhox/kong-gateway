# Boas práticas

## Uso de scripts

Sempre garanta que você tenha apenas um processo decK em execução. Vários processos se sobrepõem e podem corromper a configuração do Kong.

Não misture a configuração declarativa do decK com cURL ou qualquer outro script.

Ou gerencie a configuração com o decK, ou gerencie com seu próprio script Misturar os dois no mesmo conjunto de dados é trabalhoso e propenso a erros.

## Implantação distribuída

Se você tiver uma instalação muito grande, poderá dividir sua configuração em subconjuntos menores

## Versões

Sempre use uma versão complementar do decK e do Kong Gateway. Sempre use uma versão específica do decK em produção para obter a configuração declarativa.

Se você atualizar para uma nova versão do decK ou do Kong Gateway, teste as alterações com segurança em um ambiente de homologação primeiro.

## Criptografia

O decK não gerencia a criptografia de informações confidenciais. O arquivo de estado armazena as chaves privadas de seus certificados e credenciais de consumidores em texto simples.

Tenha cuidado em como e onde você armazena esse arquivo para evitar violações de segurança.

Sempre armazene as informações confidenciais em um formato criptografado e forneça uma versão em texto simples delas somente quando necessário.

Se você tiver muitos consumidores em seu banco de dados, não os exporte ou gerencie usando o decK.

A configuração declarativa é destinada apenas para configuração de entidade e não é destinada para dados do usuário final, que podem facilmente crescer para centenas de milhares ou milhões de registros.

## CI

Sempre execute um comando diff antes de executar uma sincronização para garantir que a alteração esteja correta

Adote uma prática de [configuração orientada por CI](https://docs.konghq.com/deck/1.40.x/guides/ci-driven-configuration/).

## Autenticação

Sempre proteja a API administrativa do Kong com um método de autenticação confiável

## Desenvolvimento

Não escreva o arquivo de estado manualmente para evitar erros. Prefira a API administrativa do Kong para configurar o Kong Gateway pela primeira vez e, em seguida, exporte a configuração para um arquivo de configuração declarativa

Quaisquer alterações subsequentes devem ser feitas editando manualmente o arquivo e enviando a alteração via CI.

Se você estiver fazendo uma alteração maior, faça a alteração no Kong Gateway primeiro e, em seguida, exporte o novo arquivo.

Em seguida, você pode diferenciar os dois arquivos de estado para revisar as alterações que estão sendo feitas.

## Cronjob

Configure um cronjob para executar um diff periodicamente para garantir que o banco de dados do Kong Gateway esteja sincronizado com o arquivo de estado verificando seus repositórios Git.

Dispare um alerta se o decK detectar um desvio na configuração
