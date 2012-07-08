class Map::SolarSystem < ActiveRecord::Base 
  belongs_to :constellation
  has_many :stations
end
