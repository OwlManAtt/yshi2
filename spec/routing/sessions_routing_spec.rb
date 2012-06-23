require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #create" do
      post("/auth/google/callback").should route_to('sessions#create', :provider => 'google')
    end

    it "routes to failure" do
      get("/auth/failure").should route_to('sessions#failure')
    end

    it "routes to signout" do
      get("/signout").should route_to('sessions#destroy')
    end
  end
end
