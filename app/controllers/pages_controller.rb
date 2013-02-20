class PagesController < ApplicationController
  
  def home
    @title = t('.home')
    if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def contact
    @title = t('.contact')
  end
  
  def about
    @title = t('.about')
  end
  
  def help
    @title = t('.help')
  end
end
