module BookLab::SML::Rules
  class Text < Base
    def self.match?(node)
      node.is_a?(String)
    end

    def self.to_html(node, opts = {})
      node
    end
  end
end