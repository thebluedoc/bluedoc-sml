# frozen_string_literal: true

module BookLab::SML
  module Rules
    def self.all
      return @rules if defined? @rules
      rules = []
      Dir.glob(::File.expand_path("rules/*.rb", __dir__)).each do |path|
        require path
        rule_name = ::File.basename(path, ".rb")
        next if rule_name == "base"
        rules << "BookLab::SML::Rules::#{rule_name.classify}".constantize
      end
      @rules = rules
      @rules
    end

    def self.find_by_node(node)
      all.find { |rule| rule.match?(node) } || BookLab::SML::Rules::Base
    end
  end
end
