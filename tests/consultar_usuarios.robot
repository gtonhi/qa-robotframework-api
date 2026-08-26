*** Settings ***
Resource         ../resources/hooks.robot
Resource         ../resources/keywords.robot
Suite Setup      Criar Sessão Da API

*** Test Cases ***
CT-001 - Validar consulta de usuários realizada com sucesso
    Quando eu consultar os usuários
    Então a chamada deve retornar 200

CT-002 - Validar consulta de usuários retornando estrutura esperada no corpo
    Quando eu consultar os usuários
    Então a chamada deve retornar 200
    Então a resposta deve conter quantidade e lista de usuários

CT-003 - Validar consulta de usuário por ID existente
    Quando eu consultar um usuário existente
    Então a chamada deve retornar 200

CT-004 - Validar consulta de usuário por ID inexistente
    Quando eu consultar um usuário com ID inexistente
    Então a chamada deve retornar 400
    Então a resposta deve conter a mensagem    Usuário não encontrado