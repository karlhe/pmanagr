Given /^I am not logged in$/ do
  visit "/logout"
end

Given /^I am logged in$/ do
  visit "/login"
  fill_in "login", :with => "quentin"
  fill_in "password", :with => "monkey"
  click_button "Log in"
end
