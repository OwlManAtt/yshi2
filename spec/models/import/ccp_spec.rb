describe Import::CCP do
  describe Import::CCP::ETL do
    subject { Import::CCP::ETL }
    it { should respond_to(:process) } 
    
    # TODO: Terrible test case.
    #
    # * It depends on other models for verifying it worked.
    # * It's DICK SLOW because it's doing a full import.
    # it "should load data" do
    #   Item::Type.find(:all).count.should eq 0
    #   expect { Import::CCP::ETL.process(true) }.to_not raise_error
    #   Item::Type.find(:all).count.should > 0
    # end 
  end # ETL

  describe Import::CCP::InvGroup do
    subject { Import::CCP::InvGroup.new }

    it { should respond_to(:groupName) }
    it { should respond_to(:description) }
    it { should respond_to(:inv_category) }

    it { should respond_to(:etl_map) }
  end # group

  describe Import::CCP::InvCategory do
    subject { Import::CCP::InvCategory.new }

    it { should respond_to(:categoryName) }
    it { should respond_to(:description) }
    it { should respond_to(:inv_groups) }

    it { should respond_to(:etl_map) }
  end # category

  describe Import::CCP::InvType do
    subject { Import::CCP::InvType.new }

    it { should respond_to(:typeName) }
    it { should respond_to(:description) }
    it { should respond_to(:basePrice) }
    it { should respond_to(:portionSize) }
    it { should respond_to(:mass) }
    it { should respond_to(:volume) }
    it { should respond_to(:capacity) }
    it { should respond_to(:radius) }
    it { should respond_to(:inv_group) }
    
    it { should respond_to(:etl_map) }
  end # item

  describe Import::CCP::InvBlueprintType do
    subject { Import::CCP::InvBlueprintType.new }

    it { should respond_to(:blueprintTypeID) }
    it { should respond_to(:productTypeID) }
    it { should respond_to(:productionTime) }
    it { should respond_to(:researchProductivityTime) }
    it { should respond_to(:researchMaterialTime) }
    it { should respond_to(:researchCopyTime) }
    it { should respond_to(:productivityModifier) }
    it { should respond_to(:wasteFactor) }
    it { should respond_to(:maxProductionLimit) }

    it { should respond_to(:etl_map) }
  end # bp details

  describe Import::CCP::InvBlueprintMaterial do
    subject { Import::CCP::InvBlueprintMaterial.new }
    
    it { should respond_to(:blueprintTypeID) } 
    it { should respond_to(:materialTypeID) }
    it { should respond_to(:quantity) }
    it { should respond_to(:typeID) }

    it { should respond_to(:etl_map) }
  end

  describe Import::CCP::RamTypeRequirement do
    subject { Import::CCP::RamTypeRequirement.new }
    
    it { should respond_to(:typeID) } 
    it { should respond_to(:requiredTypeID) }
    it { should respond_to(:quantity) }
    it { should respond_to(:damagePerJob) }
    it { should respond_to(:typeID) }

    it { should respond_to(:etl_map) }
  end

end
