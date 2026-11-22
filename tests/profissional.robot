
*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Test Cases ***
Cadastrar Novo Profissional
    Click Element    css:[data-testid="menu-profissionais"]
    Wait Until Element Is Enabled    css:[data-testid="profissionais-novo"]
    Click Button    css:[data-testid="profissionais-novo"]
    Wait Until Element Is Visible    id:profissional-nome    10s
    Input Text    id:profissional-nome    João Pedro Silva
    Click Element    xpath=//label[.//input[@data-testid="profissional-formulario-funcao-professor"]]
    Click Button    css:[data-testid="profissional-formulario-confirmar"]
    Wait Until Page Contains    João Pedro Silva
