# frozen_string_literal: true

require "rouge"
require "rouge/plugins/redcarpet"

module BlueDoc::SML::Rules
  class Codeblock < Base
    class << self
      include Rouge::Plugins::Redcarpet
    end

    def self.match?(node)
      tag_name(node) == "codeblock"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)

      language = attrs[:language]
      code = attrs[:code] || ""

       nid_attr = name_by_attrs(attrs)
       html = block_code(code, language)
       html.sub(%(class="highlight"), %(class="highlight"#{nid_attr}))
    end
  end
end
