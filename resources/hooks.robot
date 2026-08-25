*** Settings ***
Documentation    Keywords de setup/teardown — preparam e encerram o estado
...              necessário pros testes rodarem. É infraestrutura de ciclo
...              de vida, separada das keywords que descrevem ações (essas
...              ficam em keywords.robot).
Resource         ../variables/libraries_variables.robot


*** Keywords ***
Criar Sessão Da API
    [Documentation]    Abre a sessão HTTP usada por todos os testes da suíte.
    ...                 Chamada uma única vez, via Suite Setup.
    
    &{HEADERS}=           Create Dictionary    
    ...                   Content-Type=${CONTENT_TYPE}

    Create Session        alias=api    
    ...                   url=https://serverest.dev
    ...                   headers=${HEADERS}
    ...                   verify=${True}
    ...                   disable_warnings=1