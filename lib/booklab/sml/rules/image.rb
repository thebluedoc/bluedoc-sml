# frozen_string_literal: true

module BookLab::SML::Rules
  class Image < Base
    def self.match?(node)
      tag_name(node) == "image"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)
      attrs[:name] ||= ""

      return attrs[:name] if attrs[:src].blank?

      attr_html = html_attrs(
        src: attrs[:src],
        alt: attrs[:name],
        width: attrs[:width],
        height: attrs[:height]
      )

      %(<img#{attr_html}>)
    end
  end
end
