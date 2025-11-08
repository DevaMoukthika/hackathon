*** Settings ***
Library    SeleniumLibrary
Library    ../resources/driver_manager.py
Variables  ../data/credentials.py
Variables  ../data/locators.py

*** Keywords ***
Prepare Driver
    [Arguments]    ${browser}=${DEFAULT_BROWSER}
    ${path}=    Install Driver    ${browser}
    Log    Installed driver at ${path}

Open Login Page
    [Arguments]    ${browser}=${DEFAULT_BROWSER}
    Prepare Driver    ${browser}
    Open Browser    ${BASE_URL}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains Element    ${LoginPage.USERNAME_FIELD}    timeout=10s

Submit Valid Credentials
    Input Text    ${LoginPage.USERNAME_FIELD}    ${USERNAME}
    Input Text    ${LoginPage.PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LoginPage.LOGIN_BUTTON}
    # adjust the wait/check as per your application
    Wait Until Page Contains Element    ${Dashboard.WELCOME_MESSAGE}    timeout=10s

Verify Dashboard Visible
    Page Should Contain Element    ${Dashboard.WELCOME_MESSAGE}
    Element Should Be Visible    ${Dashboard.NAVIGATION_MENU}

Close Browser
    Close Browser
