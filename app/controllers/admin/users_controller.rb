class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.order(:email)
  end

  def create
    params = user_params.dup
    params[:password_confirmation] = params[:password]

    @user = User.new(params)

    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been updated."
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end