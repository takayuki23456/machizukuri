# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ConstantsList
  def ja_error_messages_for(*params)
    result = error_messages_for(*params)
    result.sub!(/<h2>(\d+).*<\/h2>/) do
      ""
    end
    result.sub!(/<p>.*<\/p>/,"")
  end
   def put_error(model = nil,field = nil,text="")
    begin

      if error_message_on(model,field).to_s !=""
        return "<div style='background-color:#FFCCFF;'>" + text.to_s + error_message_on(model,field).to_s + "</div>"
      end
    rescue
      ""
    end
  end
end
