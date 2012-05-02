$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ar_properties/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ar_properties"
  s.version     = ActiveRecord::Properties::VERSION
  s.authors     = ["Andy Delcambre", "Larry Diehl"]
  s.email       = ["engineering@engineyard.com"]
  s.homepage    = "http://github.com/engineyard/ar_properties"
  s.summary     = "Explicit properties for ActiveRecord"
  s.description = %{
    This gem turns off schema introspection in favor of declaring properties in your models.
    Instead, you declare the properties in the model itself and ActiveRecord will only
    read and write the columns that you specify.
  }

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "activerecord", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
end
