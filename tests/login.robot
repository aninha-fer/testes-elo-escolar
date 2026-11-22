*** Settings ***
Library     SeleniumLibrary
Test Setup    Abrir Sistema
Test Teardown    Close Browser

*** Variables ***
${URL}    https://elo-escolar-ten.vercel.app
${BROWSER}    chrome
${USUARIO_ADMIN_VALIDO}    admin@teste.com
${SENHA_VALIDA}    Admin1234

*** Keywords ***
Abrir Sistema
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Fazer Login
    [Arguments]    ${usuario}    ${senha}
    Input Text    id:login-email    ${usuario}
    Input Password    id:login-senha    ${senha}
    Click Button    css:[data-testid="login-entrar"]

*** Test Cases ***
Login com Sucesso    
    [Tags]    login
    Wait Until Element is Visible     id:login-title     10s
    Fazer Login    ${USUARIO_ADMIN_VALIDO}    ${SENHA_VALIDA}
    Wait Until Location Is     ${URL}/
    Location Should Be    ${URL}/