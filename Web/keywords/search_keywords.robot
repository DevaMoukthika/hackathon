*** Settings ***
Documentation     Keywords for performing searches across different browsers
Library    SeleniumLibrary
Library    ../resources/driver_manager.py
Variables  ../data/search_locators.py

*** Variables ***
${GOOGLE_URL}    https://www.google.com

*** Keywords ***
Open Search Browser
    [Arguments]    ${browser}
    ${path}=    Install Driver    ${browser}
    Open Browser    ${GOOGLE_URL}    ${browser}
    Maximize Browser Window
    # Handle cookie consent if it appears
    ${cookie_status}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${SearchPage.ACCEPT_COOKIES}    timeout=5s
    Run Keyword If    ${cookie_status}    Click Element    ${SearchPage.ACCEPT_COOKIES}

Navigate To Google
    Go To    ${GOOGLE_URL}
    Wait Until Element Is Visible    ${SearchPage.SEARCH_INPUT}    timeout=10s

Perform Search
    [Arguments]    ${search_term}
    Input Text    ${SearchPage.SEARCH_INPUT}    ${search_term}
    Press Keys    ${SearchPage.SEARCH_INPUT}    RETURN
    Wait Until Element Is Visible    ${SearchPage.SEARCH_RESULTS}    timeout=10s

Verify Search Results
    [Arguments]    ${expected_term}
    Wait Until Element Is Visible    ${SearchPage.ALL_RESULTS}    timeout=10s
    Page Should Contain    ${expected_term}
    # Verify at least one result is visible
    ${count}=    Get Element Count    ${SearchPage.SEARCH_RESULTS}
    Should Be True    ${count} > 0    msg=No search results found