# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Td < Base
    def self.match?(node)
      tag_name(node) == "tc"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)
      children = renderer.children_to_html(node)

      style = {}
      style_attrs = style_for_attrs(attrs, style)
      %(<td#{style_attrs}>#{children}</td>)
    end
  end
end
