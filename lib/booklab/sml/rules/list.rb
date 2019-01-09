module BookLab::SML::Rules
  class List < Base
    def self.match?(node)
      tag_name(node) == "list"
    end

    INDENT_PX = 8

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs    = attributes(node)
      children = renderer.children_to_html(node)

      # Normal paragraph data
      text_align  = attrs[:align] || "left"
      indent      = attrs[:indent]
      text_indent = indent && indent[:firstline]
      indent_left = indent ? indent[:left] : 0

      # List style
      nid       = attrs[:nid]
      list_type = attrs[:type] || "bulleted"
      level     = attrs[:level] || 1
      num       = attrs[:num] || 1
      pstyle    = attrs[:pstyle] || "paragraph"

      wrap_tag = attrs[:type] == "bulleted" ? "ul" : "ol"
      item_tag = "li"

      case pstyle
      when "paragraph" then item_tag = "p"
      when "heading1" then item_tag = "h1"
      when "heading2" then item_tag = "h2"
      else item_tag = "p"
      end

      style = {
        "text-align": text_align,
        "text-indent": text_indent ? "#{4 * INDENT_PX}px" : "0px",
        "padding-left": "#{indent_left * INDENT_PX}px"
      }.map { |k,v| "#{k}: #{v};" }.join(" ")

      outs = []
      if opts[:prev] && tag_name(opts[:prev]) != "list"
        outs << %(<#{wrap_tag} style="#{style}">)
      end

      outs << %(<li>#{children}</li>)

      if opts[:next] && tag_name(opts[:next]) != "list"
        outs << "</#{wrap_tag}>"
      end
      outs.join("")
    end
  end
end