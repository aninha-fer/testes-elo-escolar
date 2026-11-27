*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../resources/comum.resource
Test Setup    Abrir Sistema e Fazer Login
Test Teardown    Close Browser

*** Keywords ***
Cancelar Matricula em Oficina Se Existir
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[aria-label="Abrir detalhes de Luisa Santos"]
    Click Element    css:[aria-label="Abrir detalhes de Luisa Santos"]
    Wait Until Element Is Visible    css:[data-testid="aluno-aba-oficinas"]
    Click Button    css:[data-testid="aluno-aba-oficinas"]
    Wait Until Element Is Visible    css:[data-testid="aluno-oficinas-inscrever"]    10s
    ${matricula_existe}=    Run Keyword And Return Status
    ...    Element Should Be Visible    css:[data-testid="oficina-inscricao-11"]
    IF    ${matricula_existe}
        Click Button    css:[data-testid="oficina-inscricao-11-cancelar"]
        Click Button    css:[data-testid="oficina-cancelar-inscricao-confirmar"]
        Wait Until Element Is Not Visible    css:[data-testid="oficina-cancelar-inscricao-confirmar"]
        Log    Matrícula da oficina encontrada e cancelada.
    ELSE
        Log    Matrícula da oficina não encontrada; cancelamento ignorado.
    END

Matricula em oficina
    Cancelar Matricula em Oficina Se Existir
    Wait Until Element Is Visible    css:[data-testid="aluno-oficinas-inscrever"]
    Click Button    css:[data-testid="aluno-oficinas-inscrever"]
    Wait Until Element Is Visible    css:[data-testid="oficina-11-selecionar"]    10s
    Click Element    css:[data-testid="oficina-11-selecionar"]
    Click Button    css:[data-testid="oficinas-selecao-confirmar"]
    Wait Until Element Is Not Visible    css:[data-testid="oficinas-selecao-confirmar"]    

Garantir Frequencia na Quarta Feira
    Wait Until Element Is Visible    css:[data-testid="aluno-editar"]    30s
    Click Button    css:[data-testid="aluno-editar"]
    Wait Until Element Is Visible    css:[data-testid="aluno-formulario-frequencia-3"]    30s
    ${quarta_selecionada}=    Get Element Attribute    css:[data-testid="aluno-formulario-frequencia-3"]    aria-pressed
    IF    '${quarta_selecionada}' == 'false'
        Click Button    css:[data-testid="aluno-formulario-frequencia-3"]
        Click Button    css:[data-testid="aluno-formulario-confirmar"]
    ELSE
        Click Button    css:[data-testid="aluno-formulario-cancelar"]
    END
    Wait Until Element Is Not Visible    css:[data-testid="aluno-formulario"]    60s

Abrir Novo Atendimento
    Wait Until Element Is Visible    css:[data-testid="aluno-atendimentos-novo"]    30s
    Click Button    css:[data-testid="aluno-atendimentos-novo"]
    Wait Until Page Contains Element    css:[data-testid="atendimento-formulario-modalidade"] option[value="1"]    30s
    Wait Until Element Is Enabled    css:[data-testid="atendimento-formulario-modalidade"]    30s
    Select From List By Value           css:[data-testid="atendimento-formulario-modalidade"]    1
    List Selection Should Be            css:[data-testid="atendimento-formulario-modalidade"]    1
    Wait Until Element Is Enabled    id:atendimento-profissional    30s
    Click Button    id:atendimento-profissional
    Wait Until Element Is Visible    css:[data-testid="atendimento-formulario-profissional-opcao-1"]    30s
    Click Button    css:[data-testid="atendimento-formulario-profissional-opcao-1"]
    Wait Until Page Contains Element    css:[data-testid="atendimento-formulario-duracao"] option[value="50"]    30s
    Select From List By Value           css:[data-testid="atendimento-formulario-duracao"]    50
    List Selection Should Be            css:[data-testid="atendimento-formulario-duracao"]    50

Garantir Atendimento em 16 de Dezembro as 10h
    ${atendimento_existe}=    Get Element Count    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]][contains(., '16/12/2026') and contains(., '10:00')]
    IF    ${atendimento_existe}
        Element Should Contain    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]]    10:00
        Log    Atendimento de 16/12/2026 às 10h encontrado; cadastro ignorado.
    ELSE
        Abrir Novo Atendimento
        Input Text    id:data-inicio    16/12/2026
        Input Text    id:hora-inicio    10:00
        Checkbox Should Not Be Selected    css:[data-testid="atendimento-formulario-recorrente"]
        Wait Until Element Is Enabled    css:[data-testid="atendimento-formulario-confirmar"]    30s
        Click Button    css:[data-testid="atendimento-formulario-confirmar"]
        Wait Until Element Is Not Visible    css:[data-testid="atendimento-formulario"]    60s
        Wait Until Element Contains    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]]    16/12/2026    60s
        Element Should Contain    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]]    10:00
    END

*** Test Cases ***
Cadastrar Novo Aluno
    [Tags]    aluno    positivo
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[data-testid="alunos-novo"]    10s
    Click Button    css:[data-testid="alunos-novo"]
    Input Text    id:nome-aluno    Luisa Santos
    Click Element    css:[data-testid="aluno-formulario-turno-manha"]
    Click Element    css:[data-testid="aluno-formulario-frequencia-todos"]
    Click Button    css:[data-testid="aluno-formulario-confirmar"]
    Wait Until Element Is Visible    css:[aria-label="Notificações"]
    Element Text Should Be    css:[aria-label="Notificações"]    Aluno cadastrado com sucesso.

Cadastrar Aluno Sem Nome
    [Tags]    aluno    negativo
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[data-testid="alunos-novo"]    10s
    Click Button    css:[data-testid="alunos-novo"]
    Click Element    css:[data-testid="aluno-formulario-turno-manha"]
    Click Element    css:[data-testid="aluno-formulario-frequencia-1"]
    Click Button    css:[data-testid="aluno-formulario-confirmar"]
    Element Should Be Focused    id:nome-aluno

Sobreposição de atendimento com oficina
    [Tags]    atendimento    conflitos
    Matricula em oficina
    Wait Until Element Is Visible    css:[data-testid="oficina-inscricao-11-cancelar"]    10s
    Element Should Be Visible    css:[data-testid="oficina-inscricao-11-cancelar"]
    Wait Until Element Is Visible    css:[data-testid="aluno-aba-atendimentos"]    10s
    Click Button    css:[data-testid="aluno-aba-atendimentos"]
    Click Button    css:[data-testid="aluno-atendimentos-novo"]
    Wait Until Page Contains Element    css:[data-testid="atendimento-formulario-modalidade"] option[value="1"]    10s
    Select From List By Value           css:[data-testid="atendimento-formulario-modalidade"]    1
    List Selection Should Be            css:[data-testid="atendimento-formulario-modalidade"]    1
    Click Button    id:atendimento-profissional
    Click Button    css:[data-testid="atendimento-formulario-profissional-opcao-1"]
    ${hoje}=    Get Current Date    result_format=datetime
    ${proxima_segunda}=    Evaluate    ($hoje + datetime.timedelta(days=7 - $hoje.weekday())).strftime('%d/%m/%Y')    modules=datetime
    Input Text    id:data-inicio    ${proxima_segunda}
    Input Text    id:hora-inicio    08:00
    Wait Until Page Contains Element    css:[data-testid="atendimento-formulario-duracao"] option[value="50"]    10s
    Select From List By Value           css:[data-testid="atendimento-formulario-duracao"]    50
    List Selection Should Be            css:[data-testid="atendimento-formulario-duracao"]    50
    Click Button    css:[data-testid="atendimento-formulario-confirmar"]
    Wait Until Element Is Visible    css:[role="alert"]    15s
    Element Should Contain    css:[role="alert"]    Conflitos de agenda identificados.
    Element Should Be Visible    css:[data-testid="atendimento-formulario-confirmar"]

Conflito em sessão posterior da recorrência
    [Tags]    aluno    atendimento    conflitos    recorrente    negativo
    Wait Until Element Is Visible    css:[data-testid="menu-alunos"]    30s
    Click Element    css:[data-testid="menu-alunos"]
    Wait Until Element Is Visible    css:[aria-label="Abrir detalhes de Luisa Santos"]    30s
    Click Element    css:[aria-label="Abrir detalhes de Luisa Santos"]
    Garantir Frequencia na Quarta Feira
    Wait Until Element Is Visible    css:[data-testid="aluno-aba-atendimentos"]    30s
    Click Button    css:[data-testid="aluno-aba-atendimentos"]
    Wait Until Element Is Visible    css:[data-testid="aluno-atendimentos-novo"]    30s
    Wait Until Page Does Not Contain Element    css:[role="status"]    60s
    Garantir Atendimento em 16 de Dezembro as 10h
    ${atendimentos_antes}=    Get Text    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]]
    Abrir Novo Atendimento
    Input Text    id:data-inicio    02/12/2026
    Input Text    id:hora-inicio    10:00
    Wait Until Element Is Visible    xpath=//input[@data-testid="atendimento-formulario-recorrente"]/following-sibling::label    30s
    Click Element    xpath=//input[@data-testid="atendimento-formulario-recorrente"]/following-sibling::label
    Checkbox Should Be Selected    css:[data-testid="atendimento-formulario-recorrente"]
    Wait Until Element Is Visible    css:[data-testid="atendimento-formulario-dias-semana-3"]    30s
    Click Button    css:[data-testid="atendimento-formulario-dias-semana-3"]
    Wait Until Element Is Visible    id:data-termino    30s
    Input Text    id:data-termino    31/12/2026
    Wait Until Element Is Enabled    css:[data-testid="atendimento-formulario-confirmar"]    30s
    Click Button    css:[data-testid="atendimento-formulario-confirmar"]
    Wait Until Element Is Visible    css:[role="alert"]    60s
    Element Should Contain    css:[role="alert"]    Conflitos de agenda identificados.
    Element Should Contain    css:[role="alert"]    16/12/2026
    Element Should Be Visible    css:[data-testid="atendimento-formulario-confirmar"]
    Reload Page
    Wait Until Element Is Visible    css:[data-testid="aluno-aba-atendimentos"]    60s
    Click Button    css:[data-testid="aluno-aba-atendimentos"]
    Wait Until Element Is Visible    css:[data-testid="aluno-atendimentos-novo"]    30s
    Wait Until Page Does Not Contain Element    css:[role="status"]    60s
    ${atendimentos_depois}=    Get Text    xpath=//section[.//*[@data-testid="aluno-atendimentos-novo"]]
    Should Be Equal    ${atendimentos_depois}    ${atendimentos_antes}    Nenhuma sessão da recorrência deve ser gravada, e o atendimento prévio deve permanecer.
