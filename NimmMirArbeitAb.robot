*** Settings ***
Resource    resource/Kicktip.resource
Resource    resource/Kleinanzeigen.resource
Resource    resource/Base.resource

Suite Setup    Initialisieren


*** Tasks ***
Ebay Kleinanzeigen Inserate verlängern
    Ebay Kleinanzeigen Oeffnen
    User Anmelden Kleinanzeigen
    Anzeigen Verlaengern

Kicktipp Spiele Tippen
    Kicktipp Oeffnen
    User Anmelden Kicktipp
    Heideletzlingen Tippen
    Abendplanung Tippen
