class Bulb < ActiveRecord::Base
  property :id, :primary_key
  property :name, :string
  property :name, :string
  property :frickinawesome, :boolean, :default => false
  property :car_id, :integer

  belongs_to :car
end
