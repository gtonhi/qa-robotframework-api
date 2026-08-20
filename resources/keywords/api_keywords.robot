*** Settings ***
Documentation    Keywords genéricas de infraestrutura HTTP, reutilizadas por todos
...              os módulos de teste. Aqui não entra nenhuma regra de negócio de
...              um recurso específico (usuários, produtos, etc.) — isso fica nos
...              arquivos de keywords de cada recurso, em resources/keywords/.
Resource         ../../variables/libraries_variables.robot

*** Keywords ***
Criar Sessão Da API
    [Documentation]    Abre a sessão HTTP "api", reutilizada durante toda a suíte
    ...                 via Suite Setup. Evita reconectar a cada request.
    Create Session    api    ${BASE_URL}