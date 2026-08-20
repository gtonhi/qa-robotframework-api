# QA Robot Framework — API

Portfólio de automação de testes de API usando Robot Framework e RequestsLibrary,
contra a API pública ServeRest (serverest.dev) — feita pela comunidade DevQA
especificamente para prática de automação de testes.

## Arquitetura

.
├── tests/api/usuarios/             # Casos de teste
├── resources/keywords/             # Keywords reutilizáveis (equivalente a Page Objects)
├── variables/
│   ├── environments/               # dev.robot, hom.robot
│   ├── libraries_variables.robot   # Todas as Libraries, importadas uma vez só
│   └── routes.robot                # Paths dos endpoints, centralizados
├── .github/workflows/              # Pipelines de CI (dev.yml, homologacao.yml)
└── results/                        # Relatórios (não versionado)

## Como rodar localmente

pip install -r requirements.txt
robot --outputdir results tests/api/

## Pipelines

| Workflow | Quando roda | Ambiente |
|---|---|---|
| dev.yml | push/PR na branch develop | dev |
| homologacao.yml | push na main | homologação |