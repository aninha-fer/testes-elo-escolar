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
    Element Should Contain    css:[role="alert"]    O atendimento em ${proxima_segunda} coincide com a oficina
    Element Should Contain    css:[role="alert"]    08:15
    Element Should Be Visible    css:[data-testid="atendimento-formulario-confirmar"]
