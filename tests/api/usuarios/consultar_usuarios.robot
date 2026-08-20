*** Settings ***
Documentation    Testes de consulta (GET) do recurso /usuarios da API ServeRest.
...
...              Por que começar por um GET público? Porque não depende de
...              autenticação nem de estado criado por outro teste — é o menor
...              caso possível para validar que a infraestrutura (sessão HTTP,
...              variáveis de ambiente, keywords) está funcionando antes de
...              subir a complexidade para POST/PUT/DELETE e autenticação.

Resource         ../../../resources/keywords/api_keywords.robot
Resource         ../../../resources/keywords/usuarios_keywords.robot
Resource         ../../../variables/environments/dev.robot

Suite Setup      Criar Sessão Da API

*** Test Cases ***
Deve Retornar Status 200 Ao Consultar Usuários
    [Documentation]    Teste de fumaça (smoke test): só confirma que o endpoint
    ...                 está no ar e responde com sucesso. É o primeiro nível
    ...                 de confiança antes de validar o conteúdo da resposta.
    [Tags]    api    usuarios    smoke
    ${response}=    Consultar Todos Os Usuários
    Should Be Equal As Integers    ${response.status_code}    200

Deve Retornar Uma Lista De Usuários No Corpo Da Resposta
    [Documentation]    Teste de contrato mínimo: valida que as chaves
    ...                 esperadas existem no corpo da resposta, sem ainda
    ...                 validar tipos e formatos (isso vem depois, com
    ...                 validação de schema).
    [Tags]    api    usuarios    contrato
    ${response}=    Consultar Todos Os Usuários
    Dictionary Should Contain Key    ${response.json()}    quantidade
    Dictionary Should Contain Key    ${response.json()}    usuarios