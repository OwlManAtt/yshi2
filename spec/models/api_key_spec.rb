describe ApiKey do
  before(:each) do 
    @key = ApiKey.make(:user => User.make!, :characters => [Character.make!, Character.make!])
  end

  it { should respond_to(:identifier) }
  it { should respond_to(:verification_code) }
  it { should respond_to(:type) }
  it { should respond_to(:access_mask) }
  it { should respond_to(:user) }
  it { should respond_to(:characters) }
  it { should respond_to(:deleted?) }
  it { should respond_to(:last_polled_at) }
  it { should respond_to(:last_polled_result) }
  it { should respond_to(:expires_at) }
  it { should respond_to(:expired?) }
  it { should respond_to(:pollable?) }
  it { should respond_to(:fetch_key_details) }
  
  it "should have a user" do
    @key.user.should be_an_instance_of User 
  end

  it "should have characters" do
    @key.characters.should have(2).things
  end

  it "should only allow valid types" do
    @key.type = 'Invalid Type~'
    @key.should_not be_valid

    ['Account', 'Corporation', 'Character'].each do |value| 
      @key.type = value
      @key.should be_valid 
    end
  end

  it "should only allow valid identifiers" do
    @key.identifier = "Identifiers are integers."
    @key.should_not be_valid
  end

  it "should expire keys" do
    @key.expired?.should eq false
    
    key = ApiKey.make!(:expires_at => Date.today - 1.day)
    key.expired?.should eq true
  end

  it "should determine pollable?" do
    @key.pollable?.should eq true 
    
    @key.expires_at = Date.today - 1.day
    @key.pollable?.should eq false

    @key.expires_at = Date.today + 1.day
    @key.last_polled_result = 'FAIL'
    @key.pollable?.should eq false
  end

  it "should translate the access mask" do
    pending "Figure out access mask stuff~"
  end
end
