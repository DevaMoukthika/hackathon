*** Settings ***
Resource    ../../keywords/search_keywords.robot

*** Keywords ***
I open browser
    [Arguments]    ${browser}
    Open Search Browser    ${browser}

I navigate to google
    Navigate To Google

I search for
    [Arguments]    ${search_term}
    Perform Search    ${search_term}

Search results should contain
    [Arguments]    ${expected_term}
    Verify Search Results    ${expected_term}