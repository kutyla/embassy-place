Feature: Site sessions
In order to verify content authors
The application must authenticate users.

Scenario: The user logs in
  Given a user
  When she logs in
  Then she should see a success message
    And not see an error message

Scenario: The user logs in with no email
  Given a user
  When she logs in with no email
  Then she should see an error message
    And not see a success message

Scenario: The user logs in with an incorrect email
  Given a user
  When she logs in with an incorrect email
  Then she should see an error message
    And not see a success message

Scenario: The user logs in with no password
  Given a user
  When she logs in with no password
  Then she should see an error message
    And not see a success message

Scenario: The user logs in with incorrect password
  Given a user
  When she logs in with an incorrect password
  Then she should see an error message
    And not see a success message