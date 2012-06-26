require 'spec_helper'

describe Character do
  it { should respond_to(:name) } 
  it { should respond_to(:user) } 
  it { should respond_to(:corporation) } 
  it { should respond_to(:api_character_id) } 
  it { should respond_to(:api_key) }
  it { should respond_to(:director?) } 
  it { should respond_to(:deleted?) } 
  it_should_behave_like "FromApi"

  it "should have a user" do
    char = Character.make!(:user => User.make!)
    char.user.should be_an_instance_of User
  end

  it "should have a corp" do
    char = Character.make!(:corporation => Corporation.make!)
    char.corporation.should be_an_instance_of Corporation
  end
end
