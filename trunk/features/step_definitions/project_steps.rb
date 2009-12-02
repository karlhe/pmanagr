Given /^I own a (public|private) project called "([^\"]*)"$/ do |publicity,name|
  return_path = current_url
  visit new_project_path
  fill_in "name", :with => name
  fill_in "desc", :with => "A description for #{name}."
  if publicity == "public"
    check "public"
  else
    uncheck "public"
  end
  select_datetime Time.now, :id_prefix => "project_start_time"
  select_datetime 5.days.from_now, :id_prefix => "project_due_by"
  click_button "create"
  visit return_path
end

When /^I create a (public|private) project called "([^\"]*)"$/ do |publicity,name|
  visit new_project_path
  fill_in "name", :with => name
  fill_in "desc", :with => "A description for #{name}."
  if publicity == "public"
    check "public"
  else
    uncheck "public"
  end
  select_datetime Time.now, :id_prefix => "project_start_time"
  select_datetime 5.days.from_now, :id_prefix => "project_due_by"
  click_button "create"
end

When /^I destroy a project called "([^\"]*)"$/ do |name|
  visit path_to("the \"#{name}\" project page")
  click_link "delete project", :javascript => false
end

Then /^the project "([^\"]*)" should not exist$/ do |name|
  project = Project.find(:first, :conditions => { :name => name })
  project.should == nil
end


Then /^"([^\"]*)" (should|should not) appear in (.+)$/ do |name, should, page|
  visit path_to(page)
  if should == "should"
    response.should contain(name)
  else
    response.should_not contain(name)
  end
end
