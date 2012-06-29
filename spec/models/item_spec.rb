require 'spec_helper'

describe Item do
  describe Item::Type do
    subject { Item::Type.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:npc_price) }
    it { should respond_to(:units_per_run) }
    it { should respond_to(:type_group) }
    it { should respond_to(:manufacturable?) }
    it { should respond_to(:recyclable?) }
    # TODO it { should respond_to(:market_group) }
  end # Type

  describe Item::TypeGroup do
    subject { Item::TypeGroup.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:manufacturable?) }
    it { should respond_to(:recyclable?) }
    it { should respond_to(:type_category) }
  end # TypeGroup

  describe Item::TypeCategory do
    subject { Item::TypeCategory.new }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
  end # TypeCategory
end
