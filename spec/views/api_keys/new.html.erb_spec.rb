require 'spec_helper'

describe "api_keys/new" do
  before(:each) do
    assign(:api_key, stub_model(ApiKey).as_new_record)
  end

  it "renders new api_key form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => api_keys_path, :method => "post" do
    end
  end
end
