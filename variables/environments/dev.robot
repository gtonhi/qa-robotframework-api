*** Variables ***
# ServeRest só disponibiliza uma instância pública (não tem dev/homolog separados).
# Mantemos o BASE_URL igual em dev.robot e hom.robot de propósito: o objetivo aqui
# é praticar o PADRÃO de separar configuração por ambiente, que é o que você vai
# precisar quando testar uma aplicação real com deploys distintos por ambiente.
${BASE_URL}    https://serverest.dev