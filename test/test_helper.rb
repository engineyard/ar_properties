# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

SCHEMA_ROOT = File.expand_path("../models/",  __FILE__)

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'ar_properties'

# require 'active_record/test_fixtures'
# class ActiveSupport::TestCase
#   include ActiveRecord::TestFixtures

#   self.use_transactional_fixtures = true
# end

ActiveRecord::Base.configurations = { "ar_properties" => {
    "database" => "test/ar_properties.sqlite",
    "adapter" => "sqlite3"
  }}
ActiveRecord::Base.establish_connection 'ar_properties'
ActiveRecord::Properties.activate!

def load_schema
  # silence verbose schema loading
  original_stdout = $stdout
  $stdout = StringIO.new

  load SCHEMA_ROOT + "/schema.rb"
ensure
  $stdout = original_stdout
end

load_schema

require 'models/car'
require 'models/bulb'
require 'models/person'
