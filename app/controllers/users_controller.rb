class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @stocks = @user.stocks
    @stock = Stock.new
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if params[:password] == params[:password_confirmation] and @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
      else
        flash.now[:alert] = "There was an issue..."
        format.html { render 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    session.clear
    respond_to do |format|
      format.html { redirect_to :root, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation)
    end
end
