class Car < ActiveRecord::Base
  property :id, :primary_key
  property :name, :string

  has_many :bulbs
end
