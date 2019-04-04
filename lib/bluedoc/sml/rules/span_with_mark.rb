# frozen_string_literal: true

module BlueDoc::SML::Rules
  class SpanWithMark < Base
    MARKS = {
      cd: ["<code>", "</code>"],
      b: ["<strong>", "</strong>"],
      i: ["<i>", "</i>"],
      s: ["<del>", "</del>"],
      u: ["<u>", "</u>"],
      m: ["<mark>", "</mark>"],
      sup: ["<sup>", "</sup>"],
      sub: ["<sub>", "</sub>"],
    }


    def self.match?(node)
      return false unless tag_name(node) == "span"
      attrs = attributes(node)
      attrs[:t] == 0
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)
      renderer = opts[:renderer]
      if attrs[:cd] == 1
        children = renderer.children_to_text(node)
      else
        children = renderer.children_to_html(node)
      end

      case attrs[:va]
      when "superscript" then attrs[:sup] = 1
      when "subscript" then attrs[:sub] = 1
      end

      MARKS.each_key do |key|
        if attrs[key] == 1
          mark = MARKS[key]
          children = "#{mark.first}#{children}#{mark.last}"
        end
      end

      style_attrs = style_for_attrs(attrs)
      return children if style_attrs.blank?

      "<span#{style_attrs}>#{children}</span>"
    end
  end
end
