@Regression
Feature: Add phone to account

  Scenario: Validate add phone to account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeature = callonce read('GenerateToken.feature')
    And print tokenFeature
    * def validToken = tokenFeature.response.token
    * def createAccount = callonce read('CreatAccont.feature')
    And print createAccount
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id
    And path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      
      
        "phoneNumber": "#(phoneNumber)",
      	"phoneExtension": "786",
      	"phoneTime": "Morning",
      	"phoneType": "Mobile"
      	}
      	
      """
    When method post
    Then status 201
    And print response
    And assert phoneNumber == phoneNumber
