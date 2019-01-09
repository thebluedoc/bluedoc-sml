require 'rouge'
require 'rouge/plugins/redcarpet'

module BookLab::SML::Rules
  class Codeblock < Base
    class << self
      include Rouge::Plugins::Redcarpet
    end

    def self.match?(node)
      tag_name(node) == "codeblock"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)

      language = attrs[:language]
      code = attrs[:code]

      block_code(code, language)
    end
  end
end