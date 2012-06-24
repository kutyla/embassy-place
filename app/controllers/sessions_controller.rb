class SessionsController < Clearance::SessionsController
  before_filter :require_ssl

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.valid? && @user = @user_session.authenticate!
      sign_in(@user)
      flash[:success] = t(".controllers.sessions.create.success")
      redirect_to root_path
    else
      flash.now[:error] = t(".controllers.sessions.create.error")
      render :new, status: 401
    end
  end

  def logout
    clear_return_to
    sign_out
    flash[:notice] = "You've successfully logged out."
    redirect_to root_path
  end

end
