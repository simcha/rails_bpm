class Room 
  include RailsBpm::Model
  include ActiveModel::Validations
   
  validates :temperature, :numericality => true
  validates :name, :presence => true
  
  attr_accessor :name, :temperature
  
end
