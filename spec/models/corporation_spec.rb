require 'spec_helper'

describe Corporation do
  it { should respond_to(:name) }
  it { should respond_to(:ticker) }
  it { should respond_to(:portal_access?) }
  it { should respond_to(:manager?) }
  it { should respond_to(:deleted?) }
  it { should respond_to(:characters) }
  it { should respond_to(:users) }
  
  it "should have users" do
    corp = Corporation.make!
    corp.users.should have_at_least(1).things
  end

  it "should have characters" do
    corp = Corporation.make!
    corp.characters.should have_at_least(1).things
  end
end
