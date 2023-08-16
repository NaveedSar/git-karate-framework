@Regression
Feature: Add car to account

  Scenario: Validate add car to account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccount = callonce read('CreatAccont.feature')
    And print createAccount
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id
    And path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
      
       "make": "Toyota",
       "model": "Corolla",
       "year": "2023",
       "licensePlate": "AA786"
      }
      

      """
    When method post
    Then status 201
    And print response
