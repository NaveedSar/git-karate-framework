@Regression
Feature: Get all plan code

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def getToken = result.response.token

  Scenario: Verify to get all plan code
    And path "/api/plans/get-all-plan-code"
		And header Authorization = "Bearer " + getToken
    When method get
    And status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
