class Emailer < ActionMailer::Base
   def invite_notification_new_user(sender, recipient, project)
     recipients recipient.email
     #bcc "pmanagr@gmail.com"
     from "pmanagr@gmail.com"
     subject "pManagr welcomes you!"
     sent_on Time.now
	   body :sender => sender, :recipient => recipient, :project => project, :token => recipient.login
     content_type "text/html"
   end

   def invite_notification(sender, recipient, project)
     recipients recipient.email
     from "pmanagr@gmail.com"
     subject sender.name + "wants you!"
     sent_on Time.now
	   body :sender => sender, :recipient => recipient, :project => project
     content_type "text/html"
   end

end
