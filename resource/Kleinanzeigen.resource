*** Settings ***
Library           Browser
Library           Collections
Library           Reserved
Variables         credentials.py


*** Keywords ***
Ebay Kleinanzeigen Oeffnen
    [Documentation]    Ruft eBay Kleinanzeigen auf
    New Page    https://www.ebay-kleinanzeigen.de/m-einloggen.html

User Anmelden Kleinanzeigen
    Kleinanzeigen.Nutzer Anmelden    ${PW_EK}    ${MAIL_EK}

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
    Click    ${element}
    Get Text    css=#extendBumpup > div > div.outcomemessage-success.l-container-row    contains    erfolgreich
    Click    id=extend-bumpup-cancel
    
    ### Code unten wäre schicker, funktioniert wg. Bug in Library aber nicht
    # ${classes}=    Get Classes    ${element}
    # ${is_active}=    evaluate  "is-disabled" not in ${classes}
    # IF    ${is_active}
    #     Click    ${element}
    # ELSE
    #     Log    ${element} nicht verlängerbar
    # END

