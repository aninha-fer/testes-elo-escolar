*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Test Cases ***
Criar turma regular
    Click Element    css:[data-testid="menu-turmas"]
    Wait Until Element Is Visible    css:[data-testid="turmas-nova"]
    Click Button    css:[data-testid="turmas-nova"]
    Input Text    id:turma-nome    Turma teste
    Wait Until Page Contains Element    css:#turma-ano option[value="2"]    10s
    Select From List By Value           id:turma-ano    2
    List Selection Should Be            id:turma-ano    2
    Scroll Element Into View    id:turma-sala
    Select From List By Value           id:turma-sala    5
    List Selection Should Be            id:turma-sala    5
    Input Text    id:turma-vagas    15
    Click Button    css:[data-testid="turma-formulario-profissional-1"]
    Click Button    css:[data-testid="turma-formulario-confirmar"]
    Wait Until Element Is Visible    css:[aria-label="Notificações"]
    Element Text Should Be    css:[aria-label="Notificações"]    Turma cadastrada com sucesso.

Criar oficina
    Click Element    css:[data-testid="menu-turmas"]
    Wait Until Element Is Visible    css:[data-testid="turmas-tipo-oficina"]
    Click Element    css:[data-testid="turmas-tipo-oficina"]
    Click Button    css:[data-testid="turmas-nova"]
    Input Text    id:turma-nome    Oficina teste
    Wait Until Page Contains Element    css:#turma-horario option[value="08:15"]    10s
    Select From List By Value           id:turma-horario    08:15
    List Selection Should Be            id:turma-horario    08:15
    Click Button    css:[data-testid="turma-formulario-dias-semana-1"]
    Wait Until Page Contains Element    css:#turma-sala option[value="4"]
    Select From List By Value           id:turma-sala    4
    List Selection Should Be            id:turma-sala    4
    Input Text    id:turma-vagas    10
    Click Button    css:[data-testid="turma-formulario-profissional-1"]
    Click Button    css:[data-testid="turma-formulario-confirmar"]
    Wait Until Element Is Visible    css:[aria-label="Notificações"]
    Element Text Should Be    css:[aria-label="Notificações"]    Oficina cadastrada com sucesso.