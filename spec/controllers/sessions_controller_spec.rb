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
      assigns(:user).should_not be_a_new(User)
    end

    it "creates a new user" do
      @user.destroy

      post :create
      assigns(:user).should be_a_new(User)
    end

    it "redirects on failure" do
      post :create, {}
      assigns(:user).should be nil

      response.should redirect_to('/')
    end
  end # /create

  describe "POST destroy" do
    pending
  end # /destroy
end
