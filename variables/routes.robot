*** Variables ***
# Centraliza os paths dos endpoints da API ServeRest. Se um endpoint mudar,
# corrige-se aqui uma vez só — nenhuma keyword ou teste tem o path hardcoded.
# Novos endpoints entram aqui conforme forem sendo testados (não antes).

${USUARIOS_PATH}    /usuarios