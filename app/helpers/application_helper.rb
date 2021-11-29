module ApplicationHelper
  def format_as_localtime(datetime)
    datetime.strftime "%d/%b/%Y, %k:%M:%S"
  end
end
