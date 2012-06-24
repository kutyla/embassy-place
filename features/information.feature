Feature: Information about Embassy Place
In order to increase revenue
Visitors need to learn about Embassy Place
And be able to ask for more information.

Scenario: A visitor want to learn about the features
  Given a visitor
  When she visits the features page
  Then she should see the features page
    And not see a 404 page

Scenario: A visitor wants to ask a question
  Given a visitor
  When she visits the contact page
    And asks a question
  Then she should see the homepage
    And see a success message

Scenario: A visitor can't ask a question
  Given a visitor
  When she visits the contact page
    And asks a question without a message
  Then she should see the contact page
    And see an error message
