module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/i
      root_path
    when /(the|my) dashboard/i
      dashboard_path
    when /public projects/i
      projects_path
    when /the "([^\"]*)" project page/i
      project_path(Project.find(:first, :conditions => { :name => $1 }))
    when /the "([^\"]*)" manage members page/i
      project_memberships_path(Project.find(:first, :conditions => { :name => $1 }))
    when /the "([^\"]*)" task "([^\"]*)" page/i
      project = Project.find(:first, :conditions => { :name => $1 })
      task = project.tasks.find(:first, :conditions => { :name => $2 })
      project_task_path(project,task)
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
