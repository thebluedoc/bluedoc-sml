# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bluedoc/sml/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "bluedoc-sml"
  spec.version     = BlueDoc::SML::VERSION
  spec.authors     = ["Jason Lee"]
  spec.email       = ["huacnlee@gmail.com"]
  spec.homepage    = "https://github.com/bluedoc-org/bluedoc-sml"
  spec.summary     = "SML is a rich text format for describe of the BlueDoc rich contents."
  spec.description = "SML is a rich text format for describe of the BlueDoc rich contents, base on [JsonML](http://jsonml.org)."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activesupport"
  spec.add_dependency "rouge"
  spec.add_dependency "escape_utils"
end
