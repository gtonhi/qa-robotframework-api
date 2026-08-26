*** Settings ***
Documentation    Keywords que descrevem ações da API — o "Quando" e o "Então"
...              dos testes. Setup/Teardown técnico fica em hooks.robot.
Resource         ../variables/libraries_variables.robot
Resource         routes.robot

*** Keywords ***
Quando Eu Consultar Os Usuários
    [Documentation]    Executa GET /usuarios e guarda a resposta em ${RESPONSE},
    ...                 disponível pra qualquer keyword de verificação depois.
    ...                 expected_status=any evita que a própria biblioteca
    ...                 levante exceção em status não-2xx — quem decide se o
    ...                 status está certo é a keyword "Então", não a biblioteca.
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}    expected_status=any
    Set Suite Variable    ${RESPONSE}

Quando Eu Consultar Um Usuário Existente
    [Documentation]    Busca a lista de usuários, pega o ID do primeiro
    ...                 usuário retornado, e consulta esse usuário
    ...                 específico por GET /usuarios/{_id}. Guarda a
    ...                 resposta final (a do usuário específico) em
    ...                 ${RESPONSE}.
    ${lista}=    GET On Session    api    ${USUARIOS_PATH}    expected_status=any
    @{usuarios}=    Set Variable    ${lista.json()}[usuarios]
    ${primeiro_usuario}=    Set Variable    ${usuarios}[0]
    ${id_existente}=    Set Variable    ${primeiro_usuario}[_id]
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}/${id_existente}    expected_status=any
    Set Suite Variable    ${RESPONSE}

Quando Eu Consultar Um Usuário Com ID Inexistente
    [Documentation]    Executa GET /usuarios/{_id} com um ID que certamente
    ...                 não existe na base, pra validar o comportamento de erro.
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}/idInexistente123    expected_status=any
    Set Suite Variable    ${RESPONSE}

Quando Eu Filtrar Usuários Por Um Nome Existente
    [Documentation]    Busca a lista de usuários, pega o nome do primeiro
    ...                 usuário retornado, e filtra por esse nome via query
    ...                 param, pra validar que o filtro devolve resultado.
    ${lista}=    GET On Session    api    ${USUARIOS_PATH}    expected_status=any
    @{usuarios}=    Set Variable    ${lista.json()}[usuarios]
    ${primeiro_usuario}=    Set Variable    ${usuarios}[0]
    ${nome_existente}=    Set Variable    ${primeiro_usuario}[nome]
    &{parametros}=    Create Dictionary    nome=${nome_existente}
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}    params=${parametros}    expected_status=any
    Set Suite Variable    ${RESPONSE}

Quando Eu Filtrar Usuários Por Um Nome Inexistente
    [Documentation]    Filtra a lista de usuários por um nome que
    ...                 certamente não existe na base.
    &{parametros}=    Create Dictionary    nome=NomeCertamenteInexistente999
    ${RESPONSE}=    GET On Session    api    ${USUARIOS_PATH}    params=${parametros}    expected_status=any
    Set Suite Variable    ${RESPONSE}

Então A Chamada Deve Retornar ${status_code}
    [Documentation]    Confere o status code da última resposta guardada em
    ...                 ${RESPONSE}. Reutilizável em qualquer teste, de
    ...                 qualquer recurso.
    Should Be Equal As Integers    ${RESPONSE.status_code}    ${status_code}

Então A Resposta Deve Conter Quantidade E Lista De Usuários
    [Documentation]    Confere que o corpo da resposta tem a estrutura de
    ...                 contrato esperada: os campos "quantidade" e "usuarios".
    Dictionary Should Contain Key    ${RESPONSE.json()}    quantidade
    Dictionary Should Contain Key    ${RESPONSE.json()}    usuarios

Então A Resposta Deve Conter A Mensagem
    [Arguments]    ${mensagem}
    [Documentation]    Confere que o campo "message" do corpo da resposta
    ...                 bate com o texto esperado.
    Should Be Equal As Strings    ${RESPONSE.json()}[message]    ${mensagem}

Então A Resposta Deve Conter Ao Menos Um Usuário
    [Documentation]    Confere que a quantidade de usuários retornados é
    ...                 maior que zero — usado pra validar que um filtro
    ...                 encontrou resultado.
    Should Be True    ${RESPONSE.json()}[quantidade] > 0

Então A Resposta Deve Conter Uma Lista Vazia De Usuários
    [Documentation]    Confere que a quantidade retornada é zero e a lista
    ...                 de usuários está vazia — usado pra validar um filtro
    ...                 sem correspondência.
    Should Be Equal As Integers    ${RESPONSE.json()}[quantidade]    0
    Should Be Empty    ${RESPONSE.json()}[usuarios]