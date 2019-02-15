# frozen_string_literal: true

require "bluedoc/sml/rules/base"

module BlueDoc::SML
  module Rules
    def self.all
      return @rules if defined? @rules
      rules = []
      Dir.glob(::File.expand_path("rules/*.rb", __dir__)).each do |path|
        rule_name = ::File.basename(path, ".rb")
        require "bluedoc/sml/rules/#{rule_name}"

        next if rule_name == "base"
        rules << "BlueDoc::SML::Rules::#{rule_name.classify}".constantize
      end
      @rules = rules
      @rules
    end

    def self.find_by_node(node)
      all.find { |rule| rule.match?(node) } || BlueDoc::SML::Rules::Base
    end
  end
end
