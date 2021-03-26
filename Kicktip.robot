*** Settings ***
Library           Browser
Library           Tipper
Variables         credentials.py
Suite Setup       Initialisieren


*** Tasks ***
Alle Spiele Tippen
    Abendplanung Tippen
    Heideletzlingen Tippen


*** Keywords ***
Abendplanung Tippen
    Tipprunde Tippen    abendplanung123

Heideletzlingen Tippen
    Tipprunde Tippen    heideletzlingen

Tipprunde Tippen
    [Arguments]    ${runde}
    Go To    https://www.kicktipp.de/${runde}/tippabgabe
    ${tipptabelle}=    Get Element    id=tippabgabeSpiele
    ${text}=     Get Text    ${tipptabelle}
    
    @{tipps}=    Tippaldatgames    ${text}
    @{fields}=   Get Elements      xpath=//input[contains(@id,"Tipp")]

    FOR    ${index}    ${element}    IN ENUMERATE    @{fields}
        Log    ${index}: ${element}
        Type Text    ${element}    ${tipps}[${index}]
    END
    Take Screenshot    ${tipptabelle}
    Click    //*[@id="tippabgabeForm"]/div/div/div/input
    

Kicktipp Oeffnen
    [Documentation]    Ruft Kicktipp in neuem Browser auf
    New Browser    firefox    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    https://www.kicktipp.de/abendplanung123/tippabgabe

Falk Anmelden
    [Documentation]     Mit Falks Nutzerdaten anmelden
    Nutzer Anmelden    ${PW_KT}    ${MAIL}

Nutzer Anmelden
    [Documentation]    Meldet Nutzer an
    [Arguments]    ${pw}    ${mail}
    Type Text    id=kennung    ${mail}
    Type Secret    id=passwort    ${pw}
    Click    text=Anmelden
    Click    id=accept-choices
    Get Text    css=.messagebox.success    contains       Sie wurden erfolgreich eingeloggt

Initialisieren
    Kicktipp Oeffnen
    Falk Anmelden