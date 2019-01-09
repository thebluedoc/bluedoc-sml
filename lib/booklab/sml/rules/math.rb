module BookLab::SML::Rules
  class Math < Base
    def self.match?(node)
      tag_name(node) == "math"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      config =
      attrs = attributes(node)

      svg_code = URI::encode(attrs[:code])
      src = "#{renderer.config.mathjax_service_host}/svg?tex=#{svg_code}"

      %(<img className="tex-image" src="#{src}">)
    end
  end
end