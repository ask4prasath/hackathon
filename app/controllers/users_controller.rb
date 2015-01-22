class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_super_user!, :except => [:reset_password, :update]

  layout "admin", except: "reset_password"

  def index
    @users = User.all
  end

  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def notications

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: "User created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in :user, @user, :bypass => true
        format.html { redirect_to root_path, notice: "Welcome #{@user.email}."  }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset_password
    @user = User.find_by_email Base64.decode64(params[:email])
  end

  def update_password
    @user = User.find_by_email(params[:email])
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.save
    sign_in :user, @user, :bypass => true
    redirect_to root_path
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit!
    end

    def authenticate_super_user!
       authenticate_user!
       raise "You are not a super user"  unless current_user.super_admin?
    end
end
