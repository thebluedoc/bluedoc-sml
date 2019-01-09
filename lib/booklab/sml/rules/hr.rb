# frozen_string_literal: true

module BookLab::SML::Rules
  class Hr < Base
    def self.match?(node)
      tag_name(node) == "hr"
    end

    def self.to_html(node, opts = {})
      %(<hr>)
    end
  end
end
