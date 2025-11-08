*** Settings ***
Documentation     Login feature tests using Gherkin-style syntax
Resource         steps/login_steps.robot
Resource         ../keywords/login_keywords.robot

Force Tags       login    smoke

*** Test Cases ***
Successful login
    [Documentation]    Verify user can log in with valid credentials
    Given I open the login page
    When I submit valid credentials
    Then I should see dashboard

*** Keywords ***
# If needed, you can add more test-specific keywords here