class UsersController < ApplicationController
  before_filter :save_login_state, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash[:error] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end
  end

  def reset_password
  end

  def send_reset_password
    if user = User.find_by(email: params[:email])
      user.send_password_reset
      flash[:notice] = "Password Reset Sent to #{params[:email]}"
      flash[:color]= "valid"
      redirect_to root_url
    else
      flash[:error] = "No User by that email found"
      flash[:color]= "invalid"
      redirect_to action: :reset_password
    end
  end

  def edit_password_reset
    if @user = User.find_by_password_reset_token(params[:id])
    else
      flash[:error] = "Password Reset Token Expired. Try to send another."
      redirect_to reset_password_path
    end
  end

  def update_password_reset
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password Reset Token Expired"
      redirect_to reset_password_path
    elsif @user.update_attributes(user_params)
      flash[:notice] = "Password has been reset. You can log in now"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :password_reset_token)
    end
end