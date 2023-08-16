@Regression
Feature: Add address to account

  Scenario: Validate add address to account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccount = callonce read('CreatAccont.feature')
    And print createAccount
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id
    And path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
      
      "addressType": "7821 Main Street",
      "addressLine1": "APT#502",
      "city": "Aldie",
      "state": "VA",
      "postalCode": "20111",
      "countryCode": "1234",
      "current": true
      }
      

      """
    When method post
    Then status 201
    And print response
