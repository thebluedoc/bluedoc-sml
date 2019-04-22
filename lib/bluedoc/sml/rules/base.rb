# frozen_string_literal: true

require "escape_utils"

module BlueDoc::SML::Rules
  class SyntaxError < Exception; end

  class Base
    include BlueDoc::SML::Utils

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
      attrs = attributes(node)
      style_attrs = style_for_attrs(attrs)
      %(<#{tag}#{style_attrs}>#{children}</#{tag}>)
    end

    def self.to_text(node, opts = {})
      opts[:renderer].children_to_text(node)
    end

    protected
      def self.name_by_attrs(attrs)
        attrs ||= {}

        if !attrs[:nid]
          return ""
        end

        return %( nid="#{attrs[:nid]}")
      end

      def self.style_for_attrs(attrs, style = {})
        attrs ||= {}
        if attrs[:align]
          style["text-align"] = attrs[:align]
        end

        if attrs[:indent]
          if attrs[:indent].is_a?(Hash)
            # text-indent
            text_indent = attrs.dig(:indent, :firstline)
            style["text-indent"] = "#{4 * INDENT_PX}px" if text_indent && text_indent > 0

            # padding-left
            indent_left = attrs.dig(:indent, :left)
            style["padding-left"] = "#{indent_left * INDENT_PX}px" if indent_left && indent_left > 0
          end
        end

        # color
        if attrs[:cl]
          style["color"] = attrs[:cl];
        end

        props = css_attrs(style)
        return "" if props.strip.blank?
        %( style="#{props}")
      rescue => e
        ""
      end

      def self.css_attrs(style)
        style.map { |k, v| "#{k}: #{v};" }.join(" ")
      end

      def self.html_attrs(attrs, style_attr = nil)
        attrs[:width] = nil if attrs[:width].to_i == 0
        attrs[:height] = nil if attrs[:height].to_i == 0

        props = attrs.map { |k, v| v.present? ? %(#{k}="#{v}") : nil }.compact.join(" ")
        %( #{props})
      end
  end
end
