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
      # set new password
      ModelMailer.forgot_password(params[:email]).deliver
      flash[:notice] = "Password Reset Sent to #{params[:email]}"
      flash[:color]= "valid"
      redirect_to root_url
    else
      flash[:error] = "No User by that email found"
      flash[:color]= "invalid"
      redirect_to action: :reset_password
    end
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :u_number, :username, :email, :password, :password_confirmation)
    end
end