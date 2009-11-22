# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def showtime(dt)
    return dt.localtime.strftime("%l:%M%P on %B %e, %Y")
  end
  
  def showdate(dt)
    return dt.localtime.strftime("%B %e, %Y")
  end
  
  def showzone
    return Time.now.localtime.zone
  end
end
