# frozen_string_literal: true

module BookLab::SML::Rules
  class Root < Base
    def self.match?(node)
      tag_name(node) == "root"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      renderer.children_to_html(node)
    end
  end
end
