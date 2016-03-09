class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  protect_from_forgery

  # GET /users
  # GET /users.json
  def index
    @users = User.where(archived: false)
    respond_to do |format|
      format.json { render json: @users, status: 200 }
      format.xml { render xml: @users, status: 200 }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.archived=false
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: 422
      end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: @user.errors, status: 422
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find_unarchived(params[:id])
    user.archive
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :name)
    end
end
