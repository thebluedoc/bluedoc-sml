# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Table < Base
    def self.match?(node)
      tag_name(node) == "table"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      children = renderer.children_to_html(node)
      attrs = attributes(node)
      nid_attr = name_by_attrs(attrs)

      %(<table#{nid_attr}>#{children}</table>)
    end
  end
end
