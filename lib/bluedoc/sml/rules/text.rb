# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Text < Base
    def self.match?(node)
      node.is_a?(String)
    end

    def self.to_html(node, opts = {})
      node
    end
  end
end
