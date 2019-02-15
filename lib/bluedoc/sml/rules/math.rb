# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Math < Base
    def self.match?(node)
      tag_name(node) == "math"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)

      code = (attrs[:code] || "").strip
      return "" if code.blank?

      svg_code = URI::encode(code)
      src = "#{renderer.config.mathjax_service_host}/svg?tex=#{svg_code}"

      %(<img class="tex-image" src="#{src}">)
    end
  end
end
