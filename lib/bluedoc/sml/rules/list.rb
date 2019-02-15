# frozen_string_literal: true

module BlueDoc::SML::Rules
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
      num       = (attrs[:num] || 0) + 1

      style_attrs = style_for_attrs(attrs,
        "padding-left": "#{indent_left * INDENT_PX}px"
      )

      wrap_tag = list_type == "bulleted" ? "ul" : "ol"


      # <ul>
      #   <li>Bold text</li>
      #   <li>Important text
      #     <ul>
      #       <li>Emphasized text</li>
      #       <li>
      #         Small text
      #         <ul>
      #           <li>Subscript text</li>
      #         </ul>
      #       </li>
      #     </ul>
      #   </li>
      # </ul>

      # get prev attrs
      prev_name = tag_name(opts[:prev])
      next_name = tag_name(opts[:next])
      prev_level = attributes(opts[:prev])[:level]
      next_level = attributes(opts[:next])[:level]

      outs = []


      if prev_name != "list" || prev_level != level
        outs << %(<#{wrap_tag} data-level="#{level}">)
      end

      li_item = "<li>#{children}"

      if next_name == "list"
        if next_level < level
          (level - next_level + 1).times do
            li_item += "</li></#{wrap_tag}>"
          end
        elsif next_level == level
          li_item += "</li>"
        else
          li_item += "\n"
        end
      else
        (level - 1 + 1).times do
          li_item += "</li></#{wrap_tag}>"
        end
      end

      outs << li_item

      outs.join("\n")
    end
  end
end
