*** Settings ***
Library           Browser

*** Keywords ***
Initialisieren
    Browser Oeffnen

Browser Oeffnen
    [Documentation]    Ruft neuen Browser auf
    New Browser    firefox    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}

