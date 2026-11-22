*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Keywords ***


*** Test Cases ***
Login com Sucesso    
    [Tags]    login
    Location Should Be    ${URL}/