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
