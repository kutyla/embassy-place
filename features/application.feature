Feature: An application for Embassy Place
In order to generate revenue
Users must be able to visit the site

Scenario: The application has a homepage
  Given there is a web application
    And a visitor
  When she visits the homepage
  Then she should see the homepage
    And she should not see a 404 page
