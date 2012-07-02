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
    it { should respond_to(:blueprint?) }
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

  describe Item::Blueprint do
    subject { Item::Blueprint.new }

    it { should respond_to(:type) }
    it { should respond_to(:product_type) }
    it { should respond_to(:production_time) }
    it { should respond_to(:productivity_modifier) }
    it { should respond_to(:waste_factor) }
    it { should respond_to(:production_limit) }
    it { should respond_to(:research_material_time) }
    it { should respond_to(:research_productivity_time) }
    it { should respond_to(:copy_time) }

    it { should respond_to(:materials) }
    it { should respond_to(:skills) }
  end

  describe Item::BlueprintMaterial do
    subject { Item::BlueprintMaterial.new }

    it { should respond_to(:blueprint) }
    it { should respond_to(:material) }
    it { should respond_to(:quantity) }
    it { should respond_to(:damage_per_job) }
    it { should respond_to(:type) }
  end

  describe Item::BlueprintSkill do
    subject { Item::BlueprintSkill.new }

    it { should respond_to(:blueprint) }
    it { should respond_to(:skill) }
    it { should respond_to(:minimum_level) }
  end
end
