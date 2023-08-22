@Regression
Feature: update existing car

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccount = callonce read('CreatAccont.feature')
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id

  Scenario: Add car to exisitng account
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
      
      "make": "Toyota",
      "model": "Camry",
      "year": "2020",
      "licensePlate": "TL123"
      }
      """
    When method post
    Then status 201
    And assert response.make =="Toyota"
    * def carId = response.id

    And path "/api/accounts/update-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
       {
           "id": "#(carId)",
          "make": "Toyota",
          "model": "Rav4",
          "year": "2020",
          "licensePlate": "AL786"
          }

      """
    When method put
    Then status 202
    And print response
    And assert response.make =="Toyota"
    And assert response.year == "2020"
