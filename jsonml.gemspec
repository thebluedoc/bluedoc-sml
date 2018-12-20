$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "jsonml/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "jsonml"
  spec.version     = JsonML::VERSION
  spec.authors     = ["Jason Lee"]
  spec.email       = ["huacnlee@gmail.com"]
  spec.homepage    = "https://github.com/booklab/jsonml"
  spec.summary     = "JsonML for Ruby."
  spec.description = "JsonML parser for Ruby."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activesupport"
end
