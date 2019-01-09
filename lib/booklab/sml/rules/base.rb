module BookLab::SML::Rules
  class SyntaxError < Exception; end

  class Base
    include BookLab::SML::Utils

    TAG_TYPE_MAP = {
      table: "table",
      tr: "table-row",
      tc: "table-cell"
    }

    def self.match?(node)
      false
    end

    def self.to_html(node, opts = {})
      children = opts[:renderer].children_to_html(node)
      tag = tag_name(node)
      %(<#{tag}>#{children}</#{tag}>)
    end

    protected
      # tr -> table-row
      def tag_to_type(tag_name)
        TAG_TYPE_MAP[tag_name.to_sym]
      end

      # table-row -> tr
      def type_to_tag(type)
        TAG_TYPE_MAP.key(type).to_s
      end
  end
end