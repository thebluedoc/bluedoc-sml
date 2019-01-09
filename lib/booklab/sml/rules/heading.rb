module BookLab::SML::Rules
  class Heading < Base
    def self.match?(node)
      %w[h1 h2 h3 h4 h5 h6].include?(tag_name(node))
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      title = renderer.children_to_html(node)
      heading_tag = tag_name(node)
      %(<#{heading_tag}>#{title}</#{heading_tag}>)
    end
  end
end