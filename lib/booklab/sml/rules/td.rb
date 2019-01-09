module BookLab::SML::Rules
  class Td < Base
    def self.match?(node)
      tag_name(node) == "tc"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)
      children = renderer.children_to_html(node)

      style = {}
      if attrs[:align]
        style["text-align"] = attrs[:align]
      end

      style_attrs = ""
      if style.any?
        style_attrs = %( style="#{styleize(style)}")
      end

      %(<td#{style_attrs}>#{children}</td>)
    end
  end
end