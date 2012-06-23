require 'spec_helper'

describe "api_keys/edit" do
  before(:each) do
    @api_key = assign(:api_key, stub_model(ApiKey))
  end

  it "renders the edit api_key form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => api_keys_path(@api_key), :method => "post" do
    end
  end
end
