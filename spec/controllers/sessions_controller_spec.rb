require 'spec_helper'

describe SessionsController do
  before(:all) do
    @provider = :google
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(@provider, {:uid => "user@example.com"})
  end # before all  

  before(:each) do
    @user = User.make!(:uid => "user@example.com", :provider => 'google')
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  describe "POST create" do
    it "creates a session for an existing user" do
      post :create
      assigns(:user).should be_an_instance_of(User)
    end

    it "creates a new user" do
      original_id = @user.id
      @user.destroy

      post :create
      assigns(:user).id.should_not eq original_id 
    end

    it "redirects on failure" do
      request.env.delete 'omniauth.auth'
      post :create

      assigns(:user).should eq nil
      response.should redirect_to('/')
    end
  end # /create

  describe "POST destroy" do
    it "should log you out" do
      session[:user_id] = @user.id

      post :destroy
      session[:user_id].should be nil
      response.should redirect_to('/')
    end
  end # /destroy
end
