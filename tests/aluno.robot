*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Test Cases ***
Cadastrar Novo Aluno
    [Tags]    aluno    positivo
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[data-testid="alunos-novo"]    10s
    Click Button    css:[data-testid="alunos-novo"]
    Input Text    id:nome-aluno    Luisa Santos
    Click Element    css:[data-testid="aluno-formulario-turno-manha"]
    Click Element    css:[data-testid="aluno-formulario-frequencia-1"]
    Click Button    css:[data-testid="aluno-formulario-confirmar"]
    Wait Until Page Contains    Luisa Santos    10s


Cadastrar Aluno Sem Nome
    [Tags]    aluno    negativo
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[data-testid="alunos-novo"]    10s
    Click Button    css:[data-testid="alunos-novo"]
    Click Element    css:[data-testid="aluno-formulario-turno-manha"]
    Click Element    css:[data-testid="aluno-formulario-frequencia-1"]
    Click Button    css:[data-testid="aluno-formulario-confirmar"]
    Element Should Be Focused    id:nome-aluno

