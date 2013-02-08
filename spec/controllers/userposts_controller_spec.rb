require 'spec_helper'

describe UserpostsController do
  render_views
  
  describe "access control" do
    
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :content => "" }
      end
      
      it "should not create a userpost" do
        lambda do
          post :create, :userpost => @attr 
        end.should_not change(Userpost, :count)
      end
      
      it "should render the home page" do
        post :create, :userpost => @attr
        response.should render_template(new_userpost_path)
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end
      
      it "should create a userpost" do
        lambda do
          post :create, :userpost => @attr
        end.should change(Userpost, :count).by(1)
      end
      
      it "should redirect to the home page" do
        post :create, :userpost => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash message" do
        post :create, :userpost => @attr
        flash[:success].should =~ /post created/i
      end
    end
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @userpost = Factory(:userpost, :user => @user)
    end
    
    it "should be successful" do
      get :edit, :id => @userpost
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @userpost
      response.should have_selector("title", :content => "Edit Post")
    end
  end
  
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @userpost = Factory(:userpost, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @userpost
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @userpost = Factory(:userpost, :user => @user)
      end

      it "should destroy the userpost" do
        lambda do
          delete :destroy, :id => @userpost
        end.should change(Userpost, :count).by(-1)
      end
    end
  end
end
