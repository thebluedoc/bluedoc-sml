# frozen_string_literal: true

module BookLab::SML::Rules
  class Paragraph < Base
    def self.match?(node)
      tag_name(node) == "p"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      children = renderer.children_to_html(node)
      attrs = attributes(node)

      style_attrs = style_for_attrs(attrs)

      %(<p#{style_attrs}>#{children}</p>)
    end
  end
end
