*** Settings ***
Documentation    Keywords que descrevem ações da API — o "Quando" e o "Então"
...              dos testes. Setup/Teardown técnico fica em hooks.robot.
Resource         ../variables/libraries_variables.robot
Resource         routes.robot

*** Keywords ***
Quando eu consultar os usuários
    [Documentation]    Executa GET /usuarios e guarda a resposta em ${RESPONSE},
    ...                 disponível pra qualquer keyword de verificação depois.
    ...                 expected_status=any evita que a própria biblioteca
    ...                 levante exceção em status não-2xx — quem decide se o
    ...                 status está certo é a keyword "Então", não a biblioteca.
    ${RESPONSE}=    GET On Session    alias=api    
    ...                               url=${USUARIOS_PATH}    
    ...                               expected_status=any

    Set Suite Variable    ${RESPONSE}

Quando eu consultar um usuário existente
    [Documentation]    Busca a lista de usuários, pega o ID do primeiro
    ...                 usuário retornado, e consulta esse usuário
    ...                 específico por GET /usuarios/{_id}. Guarda a
    ...                 resposta final (a do usuário específico) em
    ...                 ${RESPONSE}.
    
    ${lista}=       GET On Session    alias=api    
    ...                               url=${USUARIOS_PATH}    
    ...                               expected_status=any

    @{usuarios}=    Set Variable    ${lista.json()}[usuarios]
    ${primeiro_usuario}=    Set Variable    ${usuarios}[0]
    ${id_existente}=    Set Variable    ${primeiro_usuario}[_id]

    ${RESPONSE}=    GET On Session    alias=api    
    ...                               url=${USUARIOS_PATH}/${id_existente}
    ...                               expected_status=any

    Set Suite Variable    ${RESPONSE}

Quando eu consultar um usuário com ID inexistente
    [Documentation]    Executa GET /usuarios/{_id} com um ID que certamente
    ...                 não existe na base, pra validar o comportamento de erro.

    ${RESPONSE}=    GET On Session    alias=api    
    ...                               url=${USUARIOS_PATH}/idInexistente123    
    ...                               expected_status=any

    Set Suite Variable    ${RESPONSE}

Então a chamada deve retornar ${status_code}
    [Documentation]    Confere o status code da última resposta guardada em
    ...                 ${RESPONSE}. Reutilizável em qualquer teste, de
    ...                 qualquer recurso.

    Should Be Equal As Integers    ${RESPONSE.status_code}    ${status_code}

Então a resposta deve conter quantidade e lista de usuários
    [Documentation]    Confere que o corpo da resposta tem a estrutura de
    ...                 contrato esperada: os campos "quantidade" e "usuarios".

    Dictionary Should Contain Key    ${RESPONSE.json()}    quantidade
    Dictionary Should Contain Key    ${RESPONSE.json()}    usuarios

Então a resposta deve conter a mensagem
    [Arguments]    ${mensagem}
    [Documentation]    Confere que o campo "message" do corpo da resposta
    ...                 bate com o texto esperado.

    Should Be Equal As Strings    ${RESPONSE.json()}[message]    ${mensagem}