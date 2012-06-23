require 'spec_helper'

describe "api_keys/show" do
  before(:each) do
    @api_key = assign(:api_key, stub_model(ApiKey))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
