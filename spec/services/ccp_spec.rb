require 'spec_helper'

describe CCP do
  before(:all) do
    @key = ApiKey.make!
    
    # WebMock responses onry.
    WebMock.disable_net_connect!
    
    # See yshi #2 - nil not supported
    # EAAL.cache = nil 

    # Get a list of all mock responses && set them up
    Dir[Rails.root.join("spec/webmocks/ccp/**/*.xml.aspx")].each do |path|
      http_base = path.gsub(Rails.root.join('spec/webmocks/ccp/').to_s,'')
      
       # FIXME sure is hard-coded assumptions about EAAL
      uri = "http://api.eve-online.com/#{http_base}"
      
      stub_request(:get, uri).with(:query => {:keyid => @key.identifier, :vcode => @key.verification_code}).to_return(:body => File.new(path), :status => 200) 
    end
  end # setup

  after(:all) do
    WebMock.allow_net_connect!
  end # teardown
  
  it "verifies webmock is setup" do
    api = EAAL::API.new(@key.identifier, @key.verification_code)
    api.APIKeyInfo
  end

  describe "::Base" do
    # Take a key and refresh it
    # Load characters 
      
  end # Base 

end
