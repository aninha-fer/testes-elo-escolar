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
    Wait Until Element Is Visible    id:login-title    10s


Pesquisar Usuário Pelo E-mail
    Abrir Sistema e Fazer Login
    Click Element    css:[data-testid="menu-usuarios"]
    Wait Until Location Contains    /usuarios
    Input Text    css:[data-testid="usuarios-busca"]    anafer.digital@gmail.com
    Wait Until Page Contains    anafer.digital@gmail.com