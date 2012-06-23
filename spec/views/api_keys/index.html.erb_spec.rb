require 'spec_helper'

describe "api_keys/index" do
  before(:each) do
    assign(:api_keys, [
      stub_model(ApiKey),
      stub_model(ApiKey)
    ])
  end

  it "renders a list of api_keys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
