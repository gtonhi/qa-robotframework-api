*** Settings ***
Resource         ../resources/hooks.robot
Resource         ../resources/keywords.robot
Suite Setup      Criar Sessão Da API

*** Test Cases ***
CT-001 - Validar consulta de usuários realizada com sucesso
    Quando Eu Consultar Os Usuários
    Então A Chamada Deve Retornar 200

CT-002 - Validar consulta de usuários retornando estrutura esperada no corpo
    Quando Eu Consultar Os Usuários
    Então A Chamada Deve Retornar 200
    Então A Resposta Deve Conter Quantidade E Lista De Usuários

CT-003 - Validar consulta de usuário por ID existente
    Quando Eu Consultar Um Usuário Existente
    Então A Chamada Deve Retornar 200

CT-004 - Validar consulta de usuário por ID inexistente
    Quando Eu Consultar Um Usuário Com ID Inexistente
    Então A Chamada Deve Retornar 400
    Então A Resposta Deve Conter A Mensagem    Usuário não encontrado

CT-005 - Validar filtro de usuários por nome existente
    Quando Eu Filtrar Usuários Por Um Nome Existente
    Então A Chamada Deve Retornar 200
    Então A Resposta Deve Conter Ao Menos Um Usuário

CT-006 - Validar filtro de usuários por nome inexistente
    Quando Eu Filtrar Usuários Por Um Nome Inexistente
    Então A Chamada Deve Retornar 200
    Então A Resposta Deve Conter Uma Lista Vazia De Usuários