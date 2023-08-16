@Regression
Feature: Delete an exicting account

  Background: setup test and valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeature = callonce read('GenerateToken.feature')
    And print tokenFeature
    * def validToken = tokenFeature.response.token
    * def createAccount = callonce read('creatAccont.feature')
    And print createAccount
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id

  Scenario: Validate delete an exicting account
    And path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"

  Scenario: Validate delete an account that is not exist
    And path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = "12311"
    When method delete
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id 12311 not exist"
