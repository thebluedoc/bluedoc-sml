module BookLab::SML::Rules
  class Br < Base
    def self.match?(node)
      tag_name(node) == "br"
    end

    def self.to_html(node, opts = {})
      %(<br>)
    end
  end
end