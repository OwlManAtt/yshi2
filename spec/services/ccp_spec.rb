require 'spec_helper'

describe CCP do
  
  # WebMock nukes all the stubs after each test case is run. This can be used to
  # set them back up...
  def setup_stubs
    # Get a list of all mock responses && set them up
    #
    # TODO This should cache the req => response content instead of looking at the FS
    # for every test.
    Dir[Rails.root.join("spec/webmocks/ccp/**/*.xml.aspx")].each do |path|
      http_base = path.gsub(Rails.root.join('spec/webmocks/ccp/').to_s,'')
      
      # FIXME sure is hard-coded assumptions about EAAL
      uri = "http://api.eve-online.com/#{http_base}"
     
      stub_request(:get, /#{uri}\?keyid=.*&vcode=.*/i).to_return(:body => File.new(path), :status => 200) 
    end
  end

  before(:all) do
    # WebMock responses onry.
    WebMock.disable_net_connect!
    
    # See yshi #2 - nil not supported
    # EAAL.cache = nil 
  end # setup

  before(:each) do
    @key = ApiKey.make!
    setup_stubs
  end

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
    it { should respond_to(:api) }

    it "should reject known-bad keys" do
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

    it "should handle API outages" do
      stub_request(:get, /.*/i).to_timeout
      
      # TODO: Think of a way to do this that doesn't involve 
      # crossing in to the childrens of Base. 
      key = ApiKey.make!(:virgin)
      api = CCP::Vital.new(key)
      expect { api.fetch_info }.to raise_error

      api.key.last_polled_result_code.should > 0
      api.key.permanent_failure?.should eq false 
    end

    it "should handle temporary API failure codes" do
      stub_request(:get, /.*/i).to_return(:body => File.new('spec/webmocks/ccp/internal_error_518.xml'), :status => 200) 

      key = ApiKey.make!(:virgin)
      api = CCP::Vital.new(key)
      expect { api.fetch_info }.to raise_error

      api.key.last_polled_result_code.should > 0
      api.key.permanent_failure?.should eq false 
    end

    it "should handle permanent API failure codes" do
      stub_request(:get, /.*/i).to_return(:body => File.new('spec/webmocks/ccp/auth_error_203.xml'), :status => 200) 

      key = ApiKey.make!(:virgin)
      api = CCP::Vital.new(key)
      expect { api.fetch_info }.to raise_error

      api.key.last_polled_result_code.should > 0
      api.key.permanent_failure?.should eq true 
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
      @key.last_polled_result_code.should eq 0

      @obs.update(CCP::PollingError.new())
      @key.last_polled_result_code.should > 0
    end 

  end # AccessObserver

  describe "::Vital" do
    subject { CCP::Vital.new(@key) }
    it { should respond_to(:fetch_info) }
  
    it "should populate key details" do
      key = ApiKey.make!(:virgin)
      api = CCP::Vital.new(key)
      api.fetch_info

      api.key.access_mask.should eq 268435455 
    end

    it "should create characters" do
      api = CCP::Vital.new(@key)
      api.fetch_info
 
      api.key.characters.map(&:name).should =~ ['OwlManAtt', 'Derp']
    end

    it "should associate characters to the key's user" do
      pending "TODO"
    end

    it "should create corps" do
      corp_id_list = [1018389948, 1000168]

      api = CCP::Vital.new(@key)
      api.fetch_info
      
      Corporation.where(:eve_id => corp_id_list).map(&:eve_id).should =~ corp_id_list
    end
  end # key

  describe "::Character" do
    subject { CCP::Character.new(ApiKey.make!) }
    pending "Character details still TODO" 
  end # Character

end
