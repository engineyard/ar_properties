class Bulb < ActiveRecord::Base
  property :id, :primary_key
  property :name, :string
  property :name, :string
  property :frickinawesome, :boolean, :default => false

  belongs_to :car
end
