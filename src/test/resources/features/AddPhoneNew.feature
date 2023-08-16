@Regression
Feature: Create account and add phone

  Background: setup test and valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccount = callonce read('CreatAccont.feature')
    And print createAccount
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id

  Scenario: Verify create account and add phone
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "786",
      "phoneTime": "Morning",
      "phoneType": "Cell"
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == phoneNumber
