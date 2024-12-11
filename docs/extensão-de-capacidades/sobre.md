# Plugins personalizados

Kong Gateway é um aplicativo Lua rodando em `Nginx` e distribuído junto com OpenResty, que é um pacote de módulos que estende o módulo `lua-nginx`.

Isto estabelece as bases para uma arquitetura modular, onde os plugins podem ser habilitados e executados em tempo de execução.

Basicamente, o Kong Gateway implementa abstração de banco de dados, roteamento e gerenciamento de plugins.

Os plug-ins podem residir em bases de código separadas e ser injetados em qualquer lugar do ciclo de vida da solicitação, tudo com algumas linhas de código.

O Kong fornece muitos plug-ins nativamente para se usar em suas implantações, estando disponíveis por tier `Free` e `Enterprise`, mas há uma série de plugins disponibilizados pela comunidade.

Mais informações sobre o desenvolvimento de plugins poderá ser encontrado nesta seção.
