*** Settings ***
Library  RequestsLibrary
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Library  Collections



***keywords***

Test CREATE/READ/UPDATE/DELETE user
# create new user
   Create Session    alias=ServeRest   url=https://serverest.dev/
   ${header}    Create Dictionary  accept=application/json  Content-Type=application/json

  ${response}  POST On Session  alias=ServeRest  url=/usuarios   headers=${header}  data={"nome":"Jaime Lopes", "email":"jaime.lopes1981@gmail.com","password":"Jaime_2000","administrador":"true"}
  ${user_id}  Set Variable   ${response.json()['_id']}
   Log To Console  ${user_id}


# Read user 
  ${response}  GET On Session  alias=ServeRest  url=/usuarios/${user_id}
  ${return_get}   Set Variable   ${response.json()}
  Log To Console    ${return_get}

# Update user
  ${response}  PUT On Session   alias=ServeRest  url=/usuarios/${user_id}   headers=${header}  data={"nome":"Jaime Almeida", "email":"jaime.ingles2008@gmail.com","password":"Jaime_2008","administrador":"true"}
  ${return_put}   Set Variable   ${response.json()}
  Log To Console    ${return_put} 

# Read user - confirmation of update
  ${response}  GET On Session  alias=ServeRest  url=/usuarios/${user_id}
  ${return_get}   Set Variable   ${response.json()}
  Log To Console    ${return_get}

# Delete user
    DELETE On Session  alias=ServeRest  url=/usuarios/${user_id}

  Delete All Sessions