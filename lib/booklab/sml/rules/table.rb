module BookLab::SML::Rules
  class Table < Base
    def self.match?(node)
      tag_name(node) == "table"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      children = renderer.children_to_html(node)

      %(<table>#{children}</table>)
    end
  end
end