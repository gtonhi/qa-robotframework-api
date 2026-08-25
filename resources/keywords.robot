*** Settings ***
Documentation    Keywords que descrevem ações da API — o "Quando" e o "Então"
...              dos testes. Setup/Teardown técnico fica em hooks.robot.
Resource         ../variables/libraries_variables.robot
Resource         routes.robot

*** Keywords ***
Quando Eu Consultar Os Usuários
    [Documentation]    Executa GET /usuarios e guarda a resposta em ${RESPONSE},
    ...                 disponível pra qualquer keyword de verificação depois.
    
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}
    Set Suite Variable    ${RESPONSE}

Então A Chamada Deve Retornar ${status_code}
    [Documentation]    Confere o status code da última resposta guardada em
    ...                 ${RESPONSE}. Reutilizável em qualquer teste, de
    ...                 qualquer recurso.

    Should Be Equal As Integers    ${RESPONSE.status_code}    ${status_code}