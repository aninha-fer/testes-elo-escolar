*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}    https://elo-escolar-ten.vercel.app
${BROWSER}    chrome
${USUARIO_ADMIN_VALIDO}    admin@teste.com
${SENHA_VALIDA}    Admin1234
${SENHA_INVALIDA}    Naovaientrar

*** Keywords ***
Abrir Sistema
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Fazer Login
    [Arguments]    ${usuario}    ${senha}
    Input Text    id:login-email    ${usuario}
    Input Password    id:login-senha    ${senha}
    Click Button    css:[data-testid="login-entrar"]
Abrir Sistema e Fazer Login
    Abrir Sistema
    Wait Until Element is Visible     id:login-title     60s
    Fazer Login    ${USUARIO_ADMIN_VALIDO}    ${SENHA_VALIDA}
    Wait Until Location Is     ${URL}/    10s