*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/comum.resource
Test Teardown    Close Browser

*** Test Cases ***

Login com Sucesso
    [Tags]    login    positivo
    Abrir Sistema
    Wait Until Element Is Visible    id:login-title    60s
    Fazer Login    ${USUARIO_ADMIN_VALIDO}    ${SENHA_VALIDA}
    Wait Until Location Is    ${URL}/    10s

Login sem Sucesso
    [Tags]    login    negativo
    Abrir Sistema
    Wait Until Element Is Visible    id:login-title    60s
    Fazer Login    ${USUARIO_ADMIN_VALIDO}    ${SENHA_INVALIDA}
    Wait Until Element Is Visible    css:[aria-label="Notificações"]
    Element Text Should Be    css:[aria-label="Notificações"]    E-mail ou senha inválidos.


Pesquisar Usuário Pelo E-mail
    Abrir Sistema e Fazer Login
    Click Element    css:[data-testid="menu-usuarios"]
    Wait Until Element Is Visible    css:[data-testid="usuarios-busca"]
    Input Text    css:[data-testid="usuarios-busca"]    admin@teste.com
    Wait Until Page Contains    Robot Framework