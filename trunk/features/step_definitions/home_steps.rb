Then /^it should have a link to public projects$/ do
  response_body.should have_selector "a[href='#{projects_path}']"
end
