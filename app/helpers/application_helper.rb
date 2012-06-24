module ApplicationHelper
  def generate_link_class(path)
    request.path == path ? 'live' : ''
  end

  def markdown(content)
    raw(RedCloth.new(content).to_html)
  end
end
