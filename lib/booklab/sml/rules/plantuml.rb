module BookLab::SML::Rules
  class Plantuml < Base
    def self.match?(node)
      tag_name(node) == "plantuml"
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)

      config = opts[:config]

      svg_code = URI::encode(attrs[:code])
      %(<img src="#{config.plantuml_service_host}/svg/#{svg_code}" class="plantuml-image" />)
    end
  end
end