*** Settings ***
Resource    ../../keywords/login_keywords.robot

*** Keywords ***
Given I open the login page
    [Arguments]    ${browser}=${DEFAULT_BROWSER}
    Open Login Page    ${browser}

When I submit valid credentials
    Submit Valid Credentials

Then I should see dashboard
    Verify Dashboard Visible
    Close Browser
