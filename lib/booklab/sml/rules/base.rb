# frozen_string_literal: true

require "escape_utils"

module BookLab::SML::Rules
  class SyntaxError < Exception; end

  class Base
    include BookLab::SML::Utils

    INDENT_PX = 8

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
      def self.style_for_attrs(attrs, style = {})
        attrs ||= {}
        if attrs[:align]
          style["text-align"] = attrs[:align]
        end
        if attrs[:indent]
          style["text-indent"] = "#{4 * INDENT_PX}px"
        end
        props = css_attrs(style)
        return "" if props.strip.blank?
        %( style="#{props}")
      end

      def self.css_attrs(style)
        style.map { |k, v| "#{k}: #{v};" }.join(" ")
      end

      def self.html_attrs(attrs)
        props = attrs.map { |k, v| v.present? ? %(#{k}="#{v}") : nil }.compact.join(" ")
        %( #{props})
      end
  end
end
