require "spec_helper"

describe ApiKeysController do
  describe "routing" do

    it "routes to #index" do
      get("/api_keys").should route_to("api_keys#index")
    end

    it "routes to #new" do
      get("/api_keys/new").should route_to("api_keys#new")
    end

    it "routes to #show" do
      get("/api_keys/1").should route_to("api_keys#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api_keys/1/edit").should route_to("api_keys#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api_keys").should route_to("api_keys#create")
    end

    it "routes to #update" do
      put("/api_keys/1").should route_to("api_keys#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api_keys/1").should route_to("api_keys#destroy", :id => "1")
    end

  end
end
