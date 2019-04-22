# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Video < Base
    def self.match?(node)
      tag_name(node) == "video"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)

      return "" if attrs[:src].blank?

      width = attrs[:width]
      if width == 0 || width.blank?
        width = "100%"
      end

      video_attrs = html_attrs(
        width: width
      )

      nid_attr = name_by_attrs(attrs)

      out = <<~HTML
      <video controls preload="no"#{video_attrs}#{nid_attr}>
        <source src="#{attrs[:src]}" type="#{attrs[:type]}">
      </video>
      HTML

      out
    end
  end
end
