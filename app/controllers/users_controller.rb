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


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :u_number, :username, :email, :password, :password_confirmation)
    end
end