# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Link < Base
    def self.match?(node)
      tag_name(node) == "link"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)
      name = renderer.children_to_html(node)
      return name if attrs[:href].blank?

      %(<a href="#{attrs[:href]}" title="#{attrs[:title]}" target="_blank">#{name}</a>)
    end
  end
end
