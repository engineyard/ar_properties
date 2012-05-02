class Person < ActiveRecord::Base
  property :id, :primary_key
  property :first_name, :string
  property :gender, :string
  timestamps
end
