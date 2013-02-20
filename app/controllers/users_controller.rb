class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = t('.all_users')
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @userposts = @user.userposts.paginate(:page => params[:page], :per_page => 10)
    @title = @user.name
  end
  
  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
      @title = t('.sign_up')
    end
  end
  
  def create
    if signed_in?
      redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = t('.welcome')
        redirect_to @user
      else
        @title = t('.sign_up')
        render 'new'
      end
    end
  end
  
  def edit
    @title = t('.edit_user')
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = t('.profile_up')
      redirect_to @user
    else
      @title = t('.edit_user')
      render 'edit'
    end
  end
  
  def destroy
    if User.find(params[:id]) == current_user
      flash[:error] = t('.n_eras_its')
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = t('.user_destroyed')
      redirect_to users_path
    end
  end
  
  private

    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
