class UserpostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @user = User.find(params[:user_id])
    @title = t('.all_posts') + " " + @user.name
    @userposts = @user.userposts.paginate(:page => params[:page], per_page: 15)
  end
  
  def new
    @title = t('.new_post')
    @userpost = Userpost.new if signed_in?
  end
  
  def create
    @userpost = current_user.userposts.build(params[:userpost])
    if @userpost.save
      flash[:success] = t('.post_created')
      redirect_to root_path
    else
      @feed_items = []
      render new_userpost_path
    end
  end
  
  def edit
    @userpost = Userpost.find(params[:id])
    @title = t('.edit_post')
  end
  
  def update
    @userpost = Userpost.find(params[:id])
    if @userpost.update_attributes(params[:userpost])
      flash[:success] = t('.post_changed')
      redirect_to root_path
    else
      @title = t('.edit_post')
      render 'edit'
    end
  end
  
  def destroy
    @userpost.destroy
    redirect_back_or root_path
  end
  
  private
    
    def authorized_user
      @userpost = current_user.userposts.find_by_id(params[:id])
      redirect_to root_path if @userpost.nil?
    end
end
