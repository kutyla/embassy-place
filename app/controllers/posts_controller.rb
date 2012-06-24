class PostsController < ApplicationController
  PER_PAGE = 10
  @user_actions = [:new, :create, :edit, :update, :destroy]

  before_filter :require_user, :require_ssl, only: @user_actions

  def index
    @posts = Post.active.order_by([:placement, :desc]).page(params[:page]).per(PER_PAGE)
  end

  def show
    @post = Post.find_by_permalink(params[:id])
    redirect_if_deleted!

    @next = @post.next
    @previous = @post.previous
  end

  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new

    if @post.update_attributes(params[:post])
      flash[:notice] = t("controllers.posts.create.success")
      redirect_to post_path(@post)
    else
      flash.now[:error] = t("controllers.posts.create.failure")
      render :new, status: 400
    end
  end

  # GET /posts/:permalink/edit
  def edit
    @post = Post.find_by_permalink(params[:id])
    redirect_if_deleted!
  end

  # PUT /posts/:permalink
  def update
    @post = Post.find_by_permalink(params[:id])
    redirect_if_deleted!

    if @post.update_attributes(params[:post])
      flash[:notice] = t("controllers.posts.update.success")
      redirect_to post_path(@post)
    else
      flash.now[:error] = t("controllers.posts.update.failure")
      render :edit, status: 400
    end
  end

  # DELETE /posts/:permalink
  def destroy
    @post = Post.find_by_permalink(params[:id])
    redirect_if_deleted!

    @post.mark_as_deleted!
    flash[:notice] = t("controllers.posts.destroy.success")
    redirect_to posts_path
  end

  private

  def redirect_if_deleted!
    redirect_to posts_url({ protocol: "http://" }) and return unless @post.deleted_at.blank?
  end

end
