*** Settings ***
Documentation    Centraliza as Libraries usadas no projeto. Outros arquivos importam
...              este arquivo como Resource em vez de declarar cada Library
...              individualmente — quando uma nova dependência entrar (ex:
...              validação de schema com JSONLibrary), ela é adicionada aqui
...              uma única vez, em vez de em cada arquivo de teste.

Library          RequestsLibrary
Library          Collections