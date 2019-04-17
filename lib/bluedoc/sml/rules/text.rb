# frozen_string_literal: true
require "active_support/core_ext"

module BlueDoc::SML::Rules
  class Text < Base
    def self.match?(node)
      node.is_a?(String)
    end

    def self.to_html(node, opts = {})
      ERB::Util.html_escape(node)
    end
  end
end
