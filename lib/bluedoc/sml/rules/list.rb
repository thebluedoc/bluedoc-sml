# frozen_string_literal: true

module BlueDoc::SML::Rules
  class List < Base
    def self.match?(node)
      tag_name(node) == "list"
    end

    INDENT_PX = 8

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)

      nid = attrs[:nid]
      list = renderer.list
      current = list[nid]
      html = []

      return "" if !current
      return "" if opts[:next] && nid == attributes(opts[:next])[:nid]

      current.length.times do |i|
        current_node = current[i]

        prev_node = current[i - 1]
        next_node = current[i + 1]

        current_attrs = attributes(current_node)
        prev_attrs = attributes(prev_node)
        next_attrs = attributes(next_node)

        current_tag = list_tag_by_type(current_attrs[:type])
        current_level = current_attrs[:level]

        prev_tag = nil
        prev_level = nil
        next_tag = nil
        next_level = nil

        if prev_node
          prev_tag = list_tag_by_type(prev_attrs[:type])
          prev_level = prev_attrs[:level]
        end

        if next_node
          next_tag = list_tag_by_type(next_attrs[:type])
          next_level = next_attrs[:level]
        end

        if (
          i == 0 ||
          prev_level < current_level ||
          (
            prev_level == current_level &&
            current_tag != prev_tag
          )
        )

          html << %(<#{current_tag} data-level="#{current_level}">)
        end

        children = renderer.children_to_html(current_node)
        li = %(<li>#{children})

        if i < current.length - 1
          if next_level < current_level
            (current_level - next_level).times do |j|
              prev_item = current[i - j]
              prev_item_attrs = attributes(prev_item)
              prev_item_tag = list_tag_by_type(prev_item_attrs[:type])
              li += %(</li></#{prev_item_tag}>)
            end

            li += %(</li>)
          elsif next_level == current_level
            if next_tag == current_tag
              li += %(</li>)
            else
              li += %(</li></#{current_tag}>)
            end
          end
        else
          current_level.times do |j|
            prev_item = current[i - j]
            prev_item_attrs = attributes(prev_item)
            prev_item_tag = list_tag_by_type(prev_item_attrs[:type])
            li += %(</li></#{prev_item_tag}>)
          end
        end

        html << li
      end

      html.join("\n")
    end

    def self.to_html1(node, opts = {})
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
