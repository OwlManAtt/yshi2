require 'spec_helper'

describe Item do
  describe Item::Type do
    subject { Item::Type.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:npc_price) }
    it { should respond_to(:units_per_run) }
    it { should respond_to(:group) }
    it { should respond_to(:manufacturable?) }
    it { should respond_to(:recyclable?) }
    # TODO it { should respond_to(:market_group) }

    it "should have a group" do
      item = Item::Type.make!
      item.group.should_not be nil
    end
  end # Type

  describe Item::Group do
    subject { Item::Group.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:manufacturable?) }
    it { should respond_to(:recyclable?) }
    it { should respond_to(:category) }

    it "should have a category" do
      group = Item::Group.make!
      group.category.should_not be nil
    end
    
    it "should have types" do
      group = Item::Group.make!(:types => [Item::Type.make!, Item::Type.make!])
      group.types.size.should > 0
    end
  end # Group

  describe Item::Category do
    subject { Item::Category.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:groups) }

    it "should have groups" do
      cat = Item::Category.make!(:groups => [Item::Group.make!])
      cat.groups.size.should > 0
    end

  end # Category
end
