*** Settings ***
Library   Browser
Library    DateTime
Library    Collections
Library    Reserved

Test Setup     Ebay Kleinanzeigen oeffnen

*** Variables ***
${pw}=    meinPasswort
${mail}=    meineMail@fake.com

*** Tasks ***
Verlaengere alle Anzeigen
    Nutzer anmelden    ${pw}
    Anzeigen verlaengern 
    
*** Keywords ***
Ebay Kleinanzeigen oeffnen
    [Documentation]    Ruft eBay Kleinanzeigen in neuem Browser auf
    New Browser    firefox    headless=true
    # New Context    viewport={'width': 1920, 'height': 1080} 
    New Page       https://www.ebay-kleinanzeigen.de/m-einloggen.html

Nutzer anmelden
    [Documentation]    Meldet Nutzer bei eBay Kleinanzeigen an
    [Arguments]    ${pw}
    Type Text        id=login-email        ${mail}
    Type Secret      id=login-password     ${pw}
    Click            id=login-submit
    Get Text    id=user-email    contains     ${mail}

Anzeigen verlaengern 
    [Documentation]     Sucht alle verlängern-Buttons und klickt sie
    @{links}     Get Elements    .managead-listitem-action-extend
    FOR    ${index}    ${element}    IN ENUMERATE    @{links}
        Log    ${index}: ${element}
        ${classes}=    Get Classes    ${element}
        ${is_active}=     List Should Not Contain Value    ${classes}    value

        IF         ${is_active}
            Click    ${element}
        ELSE
            Log    ${element} nicht verlängerbar
        END

    END


# Anzeigen verlaengern
#     [Arguments]    ${limit}
#     @{list}=    Browser.Get Elements    css=.manageaditem
#     FOR    ${index}    ${element}    IN ENUMERATE    @{list}
        
#         Log    ${index}: ${element}
#         ${enddate}=    Browser.Get Text    ${element} > .manageaditem-main > .manageaditem-ad > .list > li > .managead-listitem-enddate
#         ${enddate}=    Convert Date    ${enddate}    date_format=%d.%m.%Y
#         ${deadline}=   Subtract Time From Date    ${enddate}    ${limit}
#         ${today}=    DateTime.Get Current Date
        
#         ${difference}=    Subtract Date From Date    ${deadline}    ${today}
       

#     END
