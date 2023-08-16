@Regression
Feature: verify account

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def validToken = result.response.token

  Scenario: Verify account by sending valid user id
    Then path "/api/accounts/get-account"
    And header Authorization = "Bearer " + validToken
    # we use * def to create a variable to re use the object
    * def existingId = 9603
    And param primaryPersonId = existingId
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == existingId

  Scenario: Verify primary person id that not exist
    Then path "//api/accounts/get-account"
    # we use * def to create a variable to re use the object
    * def excistingId = 121556
    And param primaryPersonId = excistingId
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id 121556 not found"
