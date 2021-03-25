*** Settings ***
Library           Browser
Library           DateTime
Library           Collections
Library           Reserved
Task Setup        Ebay Kleinanzeigen Oeffnen
Variables         credentials.py


*** Tasks ***
Verlaengere Alle Auslaufende Inserate
    Nutzer Anmelden    ${PW}    ${MAIL}
    Anzeigen Verlaengern


*** Keywords ***
Ebay Kleinanzeigen Oeffnen
    [Documentation]    Ruft eBay Kleinanzeigen in neuem Browser auf
    New Browser    firefox    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    https://www.ebay-kleinanzeigen.de/m-einloggen.html

Nutzer Anmelden
    [Documentation]    Meldet Nutzer bei eBay Kleinanzeigen an
    [Arguments]    ${pw}    ${mail}
    Type Text    id=login-email    ${mail}
    Type Secret    id=login-password    ${pw}
    Click    id=login-submit
    Get Text    id=user-email    contains    ${mail}

Anzeigen Verlaengern
    [Documentation]    Sucht alle verlängern-Buttons und klickt sie wenn aktiv
    @{links}    Get Elements    .managead-listitem-action-extend
    FOR    ${index}    ${element}    IN ENUMERATE    @{links}
        Anzeige Verlaengern    ${element}
    END

Anzeige Verlaengern
    [Documentation]    Klicke verlängern Button wenn er aktiv ist
    [Arguments]    ${element}
    ${classes}=    Get Classes    ${element}
    ${is_active}=    evaluate  "is-disabled" not in ${classes}
    IF    ${is_active}
        Click    ${element}
    ELSE
        Log    ${element} nicht verlängerbar
    END

