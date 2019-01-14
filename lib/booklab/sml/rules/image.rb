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

      html_attrs = {
        src: attrs[:src],
        alt: attrs[:name],
        width: attrs[:width],
        height: attrs[:height]
      }

      attr_html = html_attrs.map { |k, v| v.present? ? %(#{k}="#{v}") : nil }.compact.join(" ")
      %(<img #{attr_html}>)
    end
  end
end
