*** Settings ***
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api/
${CREDENTIALS_FILE}    ${CURDIR}/../data/credentials.json
${Endpoint_URL}    /login
${TOKEN}    Test Bearer Token
${Get_headers}  {Authorization=Bearer ${TOKEN}, x-api-key=reqres-free-v1}

*** Keywords ***
Create Request Headers
    ${headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN}
    ...    x-api-key=reqres-free-v1
    [Return]    ${headers}