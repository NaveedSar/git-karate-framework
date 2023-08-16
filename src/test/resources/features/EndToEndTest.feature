Feature: Create account and add the details

  Background: setup test and token
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def validToken = tokenFeature.response.token
    * def createAccount = callonce read('CreatAccont.feature')
    * def createAccountId = createAccount.response.id

  Scenario: Validate create account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    And request
      """
      {
       "email": "#(autoEmail)",
       "firstName": "David",
       "lastName": "John",
       "title": "Mr.",
       "gender": "MALE",
       "maritalStatus": "MARRIED",
       "employmentStatus": "Tester",
       "dateOfBirth": "1994-05-11",
       "new": true
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail

  Scenario: validate add phone to created account
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def autoPhone = dataGenerator.getPhoneNumber()
    And request
      """
      {
      
      "phoneNumber": "#(autoPhone)",
      "phoneExtension": "789",
      "phoneTime": "Morning",
      "phoneType": "Cell"
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == autoPhone

  Scenario: Validate add address to account
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
      
      "addressType": "789 main Street",
      "addressLine1": "305",
      "city": "Chantily",
      "state": "VA",
      "postalCode": "20152",
      "countryCode": "2014",
      "current": true
      }

      """
    When method post
    Then status 201
    And print response

  Scenario: Validate add car to account
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
      
      "make": "Toyota",
      "model": "Rav4",
      "year": "2023",
      "licensePlate": "AL786"
      }

      """
    When method post
    Then status 201
    And print response

  Scenario: Validate delete existing account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
