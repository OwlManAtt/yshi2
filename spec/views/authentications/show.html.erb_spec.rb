require 'spec_helper'

describe "authentications/show" do
  before(:each) do
    @authentication = assign(:authentication, stub_model(Authentication,
      :user_id => 1,
      :provider => "Provider",
      :uid => "Uid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Provider/)
    rendered.should match(/Uid/)
  end
end
