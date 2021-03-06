# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Tr < Base
    def self.match?(node)
      tag_name(node) == "tr"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      children = renderer.children_to_html(node)

      %(<tr>#{children}</tr>)
    end
  end
end
