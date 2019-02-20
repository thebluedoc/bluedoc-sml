# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Mention < Base
    def self.match?(node)
      tag_name(node) == "mention"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)

      name = (attrs[:name] || "").strip
      username = (attrs[:username] || "").strip
      return "" if name.blank?

      if username.present?
        full_name = "#{name} (#{username})"

        %(<a class="user-mention" href="/#{username}" title="#{full_name}">@<span class="mention-name">#{name}</span></a>)
      else
        "@#{name}"
      end
    end
  end
end
