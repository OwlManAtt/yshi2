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
  
  # meta as fuck.
  it "verifies webmock is set up" do
    api = EAAL::API.new(@key.identifier, @key.verification_code)
    api.APIKeyInfo.key.characters.map(&:characterName).should =~ ['OwlManAtt', 'Derp']
  end

  describe "::Base" do
    subject { CCP::Base.new(ApiKey.make!) }
    it { should respond_to(:key) }

    it "should reject bad keys" do
      key = ApiKey.make!(:expires_at => Date.today - 5.days)
      expect { CCP::Base.new(key) }.to raise_error CCP::PollingError
    end 

    it "should accept valid keys" do
      key = ApiKey.make!
      expect { CCP::Base.new(key) }.not_to raise_error CCP::PollingError
    end

    it "should trigger the observer" do
      key = ApiKey.make!(:virgin)
      base = CCP::Base.new(key)

      # TODO: Is there a better way to do this? This is making assumptions
      # about how the observer behaves, so I'm testing the observer as well
      # as the interaction here...
      base.after_api_access
      base.key.last_polled_at.should_not eq nil
    end
  end # Base 

  describe "::AccessObserver" do
    subject { CCP::AccessObserver.new(CCP::Base.new(ApiKey.make!)) } 
    it { should respond_to(:update).with(1).arguments }

    it "should update keys" do
      key = ApiKey.make!(:virgin)
      @obs = CCP::AccessObserver.new(CCP::Base.new(@key)) 

      orig_polled_at = @key.last_polled_at
      @obs.update

      @key.last_polled_at.should > orig_polled_at 
      @key.last_polled_result.should eq 'OK'

      @obs.update(CCP::PollingError.new())
      @key.last_polled_result.should eq 'ERROR'
    end 

  end # AccessObserver

  describe "::Character" do
    subject { CCP::Character.new(ApiKey.make!) }
    pending 
  end # Character

end
