module ApplicationHelper
  def absolute_url(url)
    /^http/i =~ url ? url : "https://#{url}"
  end
end
