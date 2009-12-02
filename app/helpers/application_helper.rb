# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def showtime(dt)
    dt.strftime("%l:%M %p on %B%e, %Y").blank? ? dt.localtime : dt.strftime("%l:%M %p on %B%e, %Y")
  end
  
  def showdate(dt)
    dt.strftime("%B%e, %Y").blank? ? dt.localtime : dt.strftime("%B%e, %Y")
  end
  
  def showzone
    return Time.now.localtime.zone
  end

end
