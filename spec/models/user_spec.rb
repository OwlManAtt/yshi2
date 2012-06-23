require 'spec_helper'

describe User do
  before(:all) do
    @mgmt_corp = Corporation.make!(:manager => true, :portal_access => true)
    @client_corp = Corporation.make!(:portal_access => true)
    @no_access_corp = Corporation.make!
  end # before all

  it { should respond_to(:name) } 
  it { should respond_to(:corporation) } 
  it { should respond_to(:portal_access?) } 
  it { should respond_to(:management_company?) } 
  it { should respond_to(:deleted?) }
  it { should respond_to(:characters) }
  it { should respond_to(:api_keys) }

  it "should be part of the management corp" do
    user = User.make!(:corporation => @mgmt_corp)
    
    user.corporation.should eq(@mgmt_corp)
    user.management_company?.should be true   
    user.portal_access?.should be true
  end

  it "should be a client w/ portal access" do
    user = User.make!(:corporation => @client_corp)

    user.management_company?.should_not be true
    user.portal_access?.should be true
  end

  it "should be a user with no corp" do
    user = User.make!

    user.portal_access?.should be false
    user.management_company?.should be false
  end

  it "should be a listed corp with no access" do
    user = User.make!(:corporation => @no_access_corp)
  end

  it "should have no access when deleted" do
    user = User.make!(:corporation => @mgmt_corp, :deleted => true)

    user.deleted?.should be true
    user.portal_access?.should be false
  end
end
