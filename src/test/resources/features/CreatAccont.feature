@Regression
Feature: create account

  Scenario: Verify creating account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeature = callonce read('GenerateToken.feature')
    And print tokenFeature
    * def validToken = tokenFeature.response.token
    And path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    # calling java class in feature file to generate random email each time we run the code
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
       "id": 0,
       "email": "#(autoEmail)",
       "firstName": "Davids",
       "lastName": "Johns",
       "title": "Mr.",
       "gender": "MALE",
       "maritalStatus": "MARRIED",
       "employmentStatus": "Software Tester",
       "dateOfBirth": "1977-01-05",
       "new": true
       }

      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    #Given path "/api/accounts/delete-account"
    #And header Authorization = "Bearer " + validToken
    #And param primaryPersonId = response.id
    #When method delete
    #Then status 200
    #And print response
    #And assert response == "Account Successfully deleted"
