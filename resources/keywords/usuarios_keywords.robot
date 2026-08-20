*** Settings ***
Documentation    Keywords específicas do recurso /usuarios da API ServeRest.
...              Este é o equivalente, em testes de API, ao padrão Page Object
...              usado em testes web: cada chamada HTTP fica encapsulada numa
...              keyword com nome de negócio, e o teste em si não conhece
...              detalhes de URL, verbo HTTP ou payload.
Resource         api_keywords.robot
Resource         ../../variables/routes.robot

*** Keywords ***
Consultar Todos Os Usuários
    [Documentation]    Executa GET /usuarios e devolve a resposta completa
    ...                 (status, corpo, headers) para quem chamou decidir o que validar.
    
    ${response}=    GET On Session    api    ${USUARIOS_PATH}
    RETURN    ${response}