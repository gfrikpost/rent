require 'spec_helper'

describe Userpost do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end
  
  it "should create a new instance given valid attributes" do
    @user.userposts.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @userpost = @user.userposts.create(@attr)
    end
    
    it "should have a user attribute" do
      @userpost.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @userpost.user_id.should == @user.id
      @userpost.user.should    == @user
    end
  end
end
