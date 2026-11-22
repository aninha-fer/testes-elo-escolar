
*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Test Cases ***
Cadastrar Novo Profissional
    Click Element    css:[data-testid="menu-profissionais"]
    Wait Until Element Is Visible    css:[data-testid="profissionais-novo"]
    Click Button    css:[data-testid="profissionais-novo"]
    Wait Until Element Is Visible    css:[data-testid="profissional-formulario-nome"]
    Input Text    css:[data-testid="profissional-formulario-nome"]    João Pedro Silva
    Click Element    css:[data-testid="profissional-formulario-funcao-professor"]
    Click Button    css:[data-testid="profissional-formulario-confirmar"]
    Wait Until Page Contains    João Pedro Silva
