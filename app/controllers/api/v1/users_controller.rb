class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :get_current_user]
  before_action :set_user, only: [:show]

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def show
    render json: @user
  end

  def get_current_user
    if logged_in?
      render json: current_user, status: :ok
    else
      render json: { message: ["Not Logged In"]}, status: :ok
    end
  end

  private

    def user_params
      params.permit(:email, :first_name, :last_name, :password)
    end

    def set_user
      @user = User.find_by_id(params[:id])
    end    
end
