*** Settings ***
Resource         ../resources/hooks.robot
Resource         ../resources/keywords.robot
Suite Setup      Criar Sessão Da API

*** Test Cases ***
CT-001 - Validar consulta de usuários realizada com sucesso
    Quando Eu Consultar Os Usuários
    Então A Chamada Deve Retornar 200