When /^I (?:have created|create) a task for "([^\"]*)" called "([^\"]*)"$/ do |projectname,taskname|
  visit path_to("the \"#{projectname}\" project page")
  click_link "new task"
  fill_in "name", :with => taskname
  fill_in "desc", :with => "Description for the task #{taskname}"
  select_datetime Time.now, :id_prefix => "task_start_time"
  select_datetime 1.day.from_now, :id_prefix => "task_due_by"
  click_button "create"
end

Then /^I should see "([^\"]*)" on the "([^\"]*)" project page$/ do |taskname,projectname|
  visit path_to("the \"#{projectname}\" project page")
  response.should contain(taskname)
end

When /^I add the "([^\"]*)" task "([^\"]*)" as a prerequisite for "([^\"]*)"$/ do |projectname,prereqname,taskname|
  visit path_to("the \"#{projectname}\" task \"#{taskname}\" page")
  click_link "add prerequisites"
  click_link "Add #{prereqname} as prerequisite"
end

Then /^the "([^\"]*)" task "([^\"]*)" should depend on "([^\"]*)"$/ do |projectname,taskname,prereqname|
  project = Project.find(:first, :conditions => { :name => projectname })
  task = project.tasks.find(:first, :conditions => { :name => taskname })
  prereq = project.tasks.find(:first, :conditions => { :name => prereqname })
  dependency = task.dependencies.find(:first, :conditions => { :prerequisite_id => prereq.id })
  dependency.should_not == nil
end

When /^I complete the "([^\"]*)" task "([^\"]*)"$/ do |projectname,taskname|
  visit path_to("the \"#{projectname}\" project page")
  click_link "Complete #{taskname}"
end

Then /^the "([^\"]*)" task "([^\"]*)" should be complete$/ do |projectname,taskname|
  project = Project.find(:first, :conditions => { :name => projectname })
  task = project.tasks.find(:first, :conditions => { :name => taskname })
  task.completed_at.should_not == nil  
end

