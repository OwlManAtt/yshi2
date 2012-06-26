require 'spec_helper'

describe Corporation do
  it { should respond_to(:name) }
  it { should respond_to(:ticker) }
  it { should respond_to(:portal_access?) }
  it { should respond_to(:manager?) }
  it { should respond_to(:deleted?) }
  it { should respond_to(:characters) }
  it { should respond_to(:users) }
  it_should_behave_like "FromApi"
  
  it "should have users" do
    corp = Corporation.make!(:users => [User.make!, User.make!])
    corp.users.should have_at_least(2).things
  end

  it "should have characters" do
    corp = Corporation.make!(:characters => [Character.make!, Character.make!])
    corp.characters.should have_at_least(2).things
  end
end
