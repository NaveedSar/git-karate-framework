@Smoke
Feature: Security Token Tests

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Generate valid token with valid username ans password
    #Prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario: Validate token with inavlid username
    And request {"username": "supervisors","password": "tek_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: Login with valid user invalid password
    And request {"username": "supervisor", "password": "tek_supervisors"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
