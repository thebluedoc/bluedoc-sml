module BookLab::SML::Rules
  class List < Base
    def self.match?(node)
      tag_name(node) == "list"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)
      children = renderer.children_to_html(node)

      list_type = attrs[:type]
      level = attrs[:level]
      num = attrs[:num] || 0

      tag = attrs[:type] == "bulleted" ? "ul" : "ol"

      outs = []
      if tag_name(opts[:prev]) != "list"
        outs << "<#{tag}>"
      end

      outs << %(<li>#{children}</li>)

      if tag_name(opts[:next]) != "list"
        outs << "</#{tag}>"
      end
      outs.join("")
    end
  end
end