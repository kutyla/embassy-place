Feature: Posts on various topics
In order to increase traffic to the site
Updates will be made to the site via posts.

Scenario: Viewing posts
  Given a visitor
  When she visits the posts page
  Then she should see the posts page
    And she should not see a 404 page

Scenario: Viewing a post
  Given a visitor
    And a post
  When she visits the post page
  Then she should see the post page
    And she should not see a 404 page
