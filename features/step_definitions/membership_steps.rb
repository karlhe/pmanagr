When /^I invite "([^\"]*)" to "([^\"]*)"$/ do |user, project|
  visit path_to("the \"#{project}\" project page")
  click_link "invite members"
  click_link "Invite #{user}"
end

When /^I request to join "([^\"]*)"$/ do |projectname|
  visit path_to("the \"#{projectname}\" project page")
  click_link "join project"
end

When /^I (accept|reject) the "([^\"]*)" invitation$/ do |action,projectname|
  visit dashboard_path
  if action == "accept"
    click_link "accept #{projectname} invitation"
  elsif action == "reject"
    click_link "reject #{projectname} invitation"
  else
    return false
  end
end

When /^I (accept|reject) "([^\"]*)" (?:into|from) "([^\"]*)"$/ do |action,membername,projectname|
  visit path_to("the \"#{projectname}\" project page")
  click_link "manage members"
  if action == "accept"
    click_link "accept #{membername}"
  elsif action == "reject"
    click_link "remove #{membername}"
  else
    return false
  end
end

Then /^it should add "([^\"]*)" to "([^\"]*)" as a "([^\"]*)"$/ do |username,projectname,level|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  user = User.find(:first, :conditions => { :name => username })
  membership = memberships.find(:first, :conditions => { :user_id => user.id })
  membership.should_not == nil
  membership.level.should == level
end


Then /^it should add me to "([^\"]*)" as a request member$/ do |projectname|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  membership = memberships.find(:first, :conditions => { :user_id => current_user.id })
  membership.should_not == nil
  membership.level.should == "request"
end


Then /^it should add "([^\"]*)" to "([^\"]*)" as a pending member$/ do |username, projectname|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  user = User.find(:first, :conditions => { :name => username })
  membership = memberships.find(:first, :conditions => { :user_id => user.id })
  membership.should_not == nil
  membership.level.should == "pending"
end

Then /^I (should|should not) be a member of "([^\"]*)"$/ do |state,projectname|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  membership = memberships.find(:first, :conditions => { :user_id => current_user.id })
  if state == "should"
    membership.should_not == nil
  elsif state == "should not"
    membership.should == nil
  else
    return false
  end  
end

Then /^"([^\"]*)" should not be a member of "([^\"]*)"$/ do |username,projectname|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  user = User.find(:first, :conditions => { :name => username })
  membership = memberships.find(:first, :conditions => { :user_id => user.id })
  membership.should == nil
end

Then /^I should be a "([^\"]*)" for "([^\"]*)"$/ do |level, projectname|
  memberships = Project.find(:first, :conditions => { :name => projectname }).memberships
  membership = memberships.find(:first, :conditions => { :user_id => current_user.id })
  membership.level.should == level
end
