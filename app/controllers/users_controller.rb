class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_login, only: [:update, :destroy]

  def homepage 
    render text: "Hello this users homepage"
  end
  def index
    users = User.all.paginate(page: params[:page], per_page: 20)
    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user, status: :ok
    else
      render_error(@user, :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  private

  def set_user
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      user = User.new
      user.errors.add(:id, "Wrong ID provided")
      render_error(user, 404) and return
    end
  end

  def user_params
      params.require(:user).permit(:name, :username, :password)
    end
end
