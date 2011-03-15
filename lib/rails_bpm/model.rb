module RailsBpm::Model
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  
  
  attr_accessor :attributes
  def initialize(attributes = {})
    attributes ||= {}
    attributes.each do |name, value|
      send("#{name}=", value) unless name == "errors"
    end
  end
  def persisted?
    false
  end
end