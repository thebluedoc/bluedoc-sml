# frozen_string_literal: true

module BookLab::SML::Rules
  class File < Base
    class << self
      include ActiveSupport::NumberHelper
    end

    def self.match?(node)
      tag_name(node) == "file"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)

      return attrs[:name] if attrs[:src].blank?

      humanize_size = number_to_human_size(attrs[:size] || 0)

      out = <<~HTML
      <a class="attachment-file" title="#{attrs[:name]}" target="_blank" href="#{attrs[:src]}">
        <span class="icon-box"><i class="fas fa-file"></i></span>
        <span class="filename">#{escape_html(attrs[:name])}</span>
        <span class="filesize">#{escape_html(humanize_size)}</span>
      </a>
      HTML

      out
    end
  end
end
