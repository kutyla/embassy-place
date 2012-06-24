class SitemapsController < ApplicationController
  # GET /sitemap.xml
  def index
    @posts = Post.active
  end

end
