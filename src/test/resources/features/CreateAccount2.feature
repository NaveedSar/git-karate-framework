Feature: Create account practice

  Background: setup test and valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def validToken = tokenFeature.response.token
    * def createAccount = callonce read('CreatAccont.feature')
    * def createAccoundId = createAccount.response.id

  Scenario: Vaidate create Account and add car
    Given path "//api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccoundId
    And request
      """
      {
      
        "make": "BMW",
        "model": "X5",
        "year": "2023",
        "licensePlate": "BMW123"
      }

      """
    When method post
    Then status 201
    And print response
