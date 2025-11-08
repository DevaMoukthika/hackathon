*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${CREDENTIALS_FILE}    ${CURDIR}/../data/credentials.json

*** Keywords ***
Given I have valid credentials
    ${creds}=    Load JSON From File    ${CREDENTIALS_FILE}
    Set Suite Variable    ${USERNAME}    ${creds['username']}
    Set Suite Variable    ${PASSWORD}    ${creds['password']}
    Set Suite Variable    ${EMAIL}    ${creds['email']}

When I call login endpoint
    Create Session    api    ${BASE_URL}
    ${payload}=    Create Dictionary    username=${USERNAME}    email=${EMAIL}    password=${PASSWORD}
    ${headers}=    Create Request Headers
    ${resp}=    Post On Session    api    ${Endpoint_URL}    json=${payload}    headers=${headers}   
    Set Suite Variable    ${RESPONSE}    ${resp}

Then response status should be ${status}
    ${code}=    Evaluate    ${RESPONSE}.status_code
    Should Be Equal As Integers    ${code}    ${status}

And token should be present
    ${data}=    Evaluate    ${RESPONSE}.json()
    Should Contain    ${data}    token
    Set Suite Variable    ${TOKEN}    ${data['token']}
