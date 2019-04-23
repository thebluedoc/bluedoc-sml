# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Plantuml < Base
    def self.match?(node)
      tag_name(node) == "plantuml"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)
      renderer = opts[:renderer]

      code = (attrs[:code] || "").strip
      return "" if code.blank?

      svg_code = BlueDoc::Plantuml.encode(code)
      nid_attr = name_by_attrs(attrs)
      %(<div#{nid_attr} class="plantuml-box"><img src="#{renderer.config.plantuml_service_host}/svg/#{svg_code}" class="plantuml-image" /></div>)
    end
  end
end
