class Emailer < ActionMailer::Base
   def contact(recipient)
     recipients recipient.email
     subject "subject"
     #bcc "pmanagr@gmail.com"
     from "pmanagr@gmail.com"
     subject "pManagr welcomes you!"
     sent_on Time.now
	   body :account => recipient, :title => "TITLE", :message => "MESSAGE"
   end
end
