# frozen_string_literal: true

module BlueDoc::SML
  module Utils
    extend ActiveSupport::Concern

    class_methods do
      def get_children(node)
        has_attributes?(node) ? node[2..-1] : node[1..-1]
      end

      def tag_name(node)
        return nil if node.blank?
        node[0] || ""
      end

      def list_tag_by_type(type)
        if type == "bulleted"
          return "ul"
        elsif type == "ordered"
          return "ol"
        else
          return nil
        end
      end

      def attributes(node, add_if_mission:  false)
        return {} if node.blank?
        return node[1].deep_symbolize_keys if has_attributes?(node)
        return {} unless add_if_mission

        name = node.shift || ""
        attrs = {}
        node.unshift(attrs)
        node.unshift(name)

        attrs
      end

      def has_attributes?(node)
        return false unless element?(node)
        attributes?(node[1])
      end

      def attributes?(node)
        return false if node.nil?
        node.is_a?(Hash)
      end

      def element?(node)
        node.is_a?(Array) && node[0].is_a?(String)
      end
    end
  end
end
