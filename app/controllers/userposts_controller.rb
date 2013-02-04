class UserpostsController < ApplicationController
  before_filter :authenticate
  
  def create
    @userpost = current_user.userposts.build(params[:userpost])
    if @userpost.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  
  def destroy
  end
end
