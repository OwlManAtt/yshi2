require 'spec_helper'

describe Map do
  describe Map::Region do
    subject { Map::Region.new }
    
    it { should respond_to(:name) } 
    it { should respond_to(:constellations) } 
  end

  describe Map::Constellation do
    subject { Map::Constellation.new }

    it { should respond_to(:name) } 
    it { should respond_to(:region) } 
    it { should respond_to(:solar_systems) } 
  end

  describe Map::SolarSystem do
    subject { Map::SolarSystem.new }

    it { should respond_to(:name) }
    it { should respond_to(:constellation) }
    it { should respond_to(:stations) }
  end

  describe Map::Station do
    subject { Map::Station.new }

    it { should respond_to(:name) }
    it { should respond_to(:solar_system) }
  end
end
