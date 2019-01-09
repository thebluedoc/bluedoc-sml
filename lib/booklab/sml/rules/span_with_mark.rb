module BookLab::SML::Rules
  class SpanWithMark < Base
    MARKS = {
      cd: ['<code>', '</code>'],
      b: ['<strong>', '</strong>'],
      i: ['<em>', '</em>'],
      s: ['<del>', '</del>'],
      u: ['<u>', '<u>'],
      mt: ['$', '$'],
      m: ['==', '=='],
      sup: ['<sup>', '<sup>'],
      sub: ['<sub>', '<sub>'],
    }


    def self.match?(node)
      return false if tag_name(node) != "span"
      attrs = attributes(node)
      attrs[:t] == 0
    end

    def self.to_html(node, opts = {})
      attrs = attributes(node)
      renderer = opts[:renderer]
      children = renderer.children_to_html(node)

      case attrs[:va]
      when "superscript" then attrs[:sup] = 1
      when "subscript" then attrs[:sub] = 1
      end

      MARKS.each_key do |key|
        if attrs[key] == 1
          mark = MARKS[key]
          children = "#{mark.fiirst}#{children}#{mark.last}"
        end
      end

      children
    end
  end
end