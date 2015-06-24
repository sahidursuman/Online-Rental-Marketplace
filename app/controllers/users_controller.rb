class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :delete_account, :dashboard]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:success] = "Welcome to Armrack. Please check your e-mail to validate your account."
      redirect_back_or dashboard_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def delete_account
    User.find(params[:id]).destroy
    flash[:success] = "Your account and all personal data will be safely deleted after a 30 days grace period. You may log in to re-acitvate your account during this period."
    redirect_to root_url
  end

  def dashboard
    @user = User.find(session[:user_id])
  end

  def rack
    @user = User.find(session[:user_id])
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email,
  							:password, :password_confirmation, :organization)
  	end

    # Before filters

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
