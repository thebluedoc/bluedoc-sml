# frozen_string_literal: true

module BookLab::SML::Rules
  class Span < Base
    def self.match?(node)
      return false unless tag_name(node) == "span"
      attrs = attributes(node)
      attrs[:t] == 1
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      renderer.children_to_html(node)
    end
  end
end
