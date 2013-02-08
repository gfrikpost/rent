require 'spec_helper'

describe "Userposts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new userpost" do
        lambda do
          visit new_userpost_path(@user)
          fill_in :userpost_content, :with => ""
          click_button
          response.should render_template(new_userpost_path)
          response.should have_selector("div#error_explanation")
        end.should_not change(Userpost, :count)
      end
    end
    
    describe "success" do
      
      it "should make a new userpost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit new_userpost_path(@user)
          fill_in :userpost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Userpost, :count).by(1)
      end
    end
  end
  
  describe "should display the number of posts" do
    lambda do
      visit root_path
      response.should have_selector("span", :class => "userposts",
              :content => pluralize(current_user.userposts.count, "userpost"))
    end
  end
end
