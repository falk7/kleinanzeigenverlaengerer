# kleinanzeigenverlaengerer 

Robot Framework Suite, die Ebay Kleinanzeigen Inserate verlängert und bei Kicktipp Spiele tippt

# installation instructions

`pip install -r requirements.txt`
for information about browser library and how to initialize it see https://github.com/MarketSquare/robotframework-browser

create credentials.py with your login information

```
MAIL_EK = "ebaykleinanzeigen@mail.com"
PW_EK = "ebaykleinanzeigenpasswort"

MAIL_KT = "kicktipp@mail.com"
PW_KT = "kicktipp_passwort"
```