class HomeController < ApplicationController
  def index
    #
  end

  def gallery
    #
  end

  def features
    #
  end

  def contact
    @note = Note.new
  end

  def create_contact
    @note = Note.new(params[:note])

    if @note.valid?
      ContactMailer.question_email(params[:note]).deliver
      flash[:success] = t(".controllers.home.create_contact.success")
      redirect_to root_path
    else
      flash.now[:error] = t(".controllers.home.create_contact.error")
      render :contact, status: 400
    end
  end

end
