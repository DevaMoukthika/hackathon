*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../variables/vars.robot

*** Test Cases ***
Login via API
    [Tags]    smoke
    Given I have valid credentials
    When I call login endpoint
    Then response status should be 200
    And token should be present
