# frozen_string_literal: true

require "active_support/core_ext"

module BookLab::SML
  class Renderer
    include BookLab::SML::Utils

    attr_accessor :sml, :config

    def initialize(sml, options)
      @sml = sml
      @config = Config.new
      @config.plantuml_service_host = options[:plantuml_service_host]
      @config.mathjax_service_host = options[:mathjax_service_host]
    end

    def to_html
      node_to_html(YAML.load(sml))
    end

    def node_to_html(node, opts = {})
      opts[:renderer] = self

      rule = BookLab::SML::Rules::find_by_node(node)
      rule.to_html(node, opts)
    end

    def children_to_html(node)
      return node if node.is_a?(String)

      children = self.class.get_children(node)
      children.each_with_index.map do |child, idx|
        prev_node = idx > 0 ? children[idx - 1] : nil
        next_node = idx < children.length ? children[idx + 1] : nil

        node_to_html(child)
      end.join("")
    end
  end
end
