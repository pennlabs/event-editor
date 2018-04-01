module ApplicationHelper
  def absolute_url(url)
    /^http/i.match(url) ? url : "https://#{url}"
  end
end
