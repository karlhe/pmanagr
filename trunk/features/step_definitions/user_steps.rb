Given /^I am not logged in$/ do
  visit logout_path
end

Given /^I am logged in$/ do
  visit login_path
  fill_in "login", :with => "quentin"
  fill_in "password", :with => "monkey"
  click_button "Log in"
end

Given /^(?:there exists )?a user called "([^\"]*)"$/ do |myname|
  visit signup_path
  fill_in "login", :with => myname.gsub(' ','').downcase
  fill_in "name", :with => myname
  fill_in "email", :with => myname.gsub(' ','').downcase + "@email.com"
  fill_in "password", :with => "monkey"
  fill_in "confirm password", :with => "monkey"
  click_button "Sign up"
end

Given /^I am logged in as "([^\"]*)"$/ do |myname|
  visit login_path
  fill_in "login", :with => myname.gsub(' ','').downcase
  fill_in "password", :with => "monkey"
  click_button "Log in"
end
