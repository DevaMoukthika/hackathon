*** Settings ***
Documentation     Search tests across different browsers
Resource         steps/search_steps.robot
Resource         ../keywords/search_keywords.robot

Test Template    Search In Browser

*** Variables ***
${SEARCH_TERM}    agile testing alliance

*** Test Cases ***                  Browser
Search in Chrome Browser           chrome
Search in Firefox Browser          firefox
Search in Edge Browser             edge

*** Keywords ***
Search In Browser
    [Arguments]    ${browser}
    Given I open browser    ${browser}
    When I navigate to google
    And I search for    ${SEARCH_TERM}
    Then search results should contain    ${SEARCH_TERM}
    [Teardown]    Close Browser