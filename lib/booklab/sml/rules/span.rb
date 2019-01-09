module BookLab::SML::Rules
  class Span < Base
    def self.match?(node)
      return false if tag_name(node) != "span"
      attrs = attributes(node)
      attrs[:t] == 1
    end

    def self.to_html(node, opts = {})
      renderer.children_to_html(node)
    end
  end
end