# frozen_string_literal: true

module BookLab::SML::Rules
  class Plantuml < Base
    def self.match?(node)
      tag_name(node) == "plantuml"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)
      renderer = opts[:renderer]

      code = (attrs[:code] || "").strip
      return "" if code.blank?

      src = attrs[:src]
      if src
        %(<img src="#{src}" class="plantuml-image" />)
      else
        svg_code = URI::encode(code)
        %(<img src="#{renderer.config.plantuml_service_host}/svg/#{svg_code}" class="plantuml-image" />)
      end
    end
  end
end
