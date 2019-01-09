require "escape_utils"

module BookLab::SML::Rules
  class SyntaxError < Exception; end

  class Base
    include BookLab::SML::Utils

    class << self
      include EscapeUtils
    end


    def self.match?(node)
      false
    end

    def self.to_html(node, opts = {})
      children = opts[:renderer].children_to_html(node)
      tag = tag_name(node)
      %(<#{tag}>#{children}</#{tag}>)
    end

    protected

      def self.styleize(style)
        style.map { |k,v| "#{k}: #{v};" }.join(" ")
      end
  end
end