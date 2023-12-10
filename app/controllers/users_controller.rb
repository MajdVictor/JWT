#
class UsersController < ApplicationController
  before_action :authorize, except: :create

  def index
    # get users
    render json: { users: User.all }, status: :ok
  end

  def show
    begin
      @user = User.find(params[:nickname])
      render json: { user: @user }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation
    )
  end
end
