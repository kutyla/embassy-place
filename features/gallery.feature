Feature: Gallery Slideshow
In order to generate interest in the apartments
The visitors
Should be able to browse images.

Background:
  Given a visitor
  When she visits the gallery page


Scenario: A visitor wants to see the apartments
  Then she should see the gallery page
    And not see a 404 page

Scenario: See the gallery
  Then she should see a gallery

# Scenario: Browse the gallery
#   Then she should see all the photos