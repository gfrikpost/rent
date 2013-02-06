class UserpostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @user = User.find(params[:user_id])
    @title = "All posts" + " " + @user.name
    @userposts = @user.userposts.paginate(:page => params[:page], per_page: 15)
  end
  
  def new
    @title = "New Post"
    @userpost = Userpost.new if signed_in?
  end
  
  def create
    @userpost = current_user.userposts.build(params[:userpost])
    if @userpost.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = []
      render new_userpost_path
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
