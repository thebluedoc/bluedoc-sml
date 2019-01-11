# frozen_string_literal: true

module BookLab::SML::Rules
  class Video < Base
    def self.match?(node)
      tag_name(node) == "video"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)

      return "" if attrs[:src].blank?

      video_attrs = html_attrs(
        width: attrs[:width],
        height: attrs[:height]
      )

      out = <<~HTML
      <video controls preload="no"#{video_attrs}>
        <source src="#{attrs[:src]}" type="#{attrs[:type]}">
      </video>
      HTML

      out
    end
  end
end
