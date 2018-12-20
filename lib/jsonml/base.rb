# frozen_string_literal: true

require "yaml"

module JsonML
  def self.parse(src, out = StringIO.new)
    ml = YAML.load(src)
    parse_node(ml).string
  end

  private

    # base code from: https://github.com/blambeau/jsonml-rb
    def self.parse_node(src, out = StringIO.new)
      has_attrs   = src[1].is_a?(Hash)
      first_child = has_attrs ? 2 : 1

      case src
      when Array
        out << "<#{src.first}"
        out << " " << attrs2html(src[1]) if has_attrs
        out << ">"
        src[first_child..-1].each { |child| parse_node(child, out) }
        out << "</#{src.first}>"
      when String
        out << src
      else
        raise "Unexpected node `#{src}`"
      end
    end

    def self.attrs2html(attrs)
      attrs.each_pair.map { |pair| attr2html(*pair) }.join(" ")
    end

    def self.attr2html(key, value)
      %(#{key}="#{value}")
    end
end
