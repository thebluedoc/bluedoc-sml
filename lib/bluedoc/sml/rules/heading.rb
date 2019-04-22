# frozen_string_literal: true

require "digest/md5"

module BlueDoc::SML::Rules
  class Heading < Base
    def self.match?(node)
      %w[h1 h2 h3 h4 h5 h6].include?(tag_name(node))
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      title = (renderer.children_to_html(node) || "").strip
      heading_tag = tag_name(node)

      title_length = title.length
      min_length = title_length * 0.3
      words_length = /[a-z0-9]/i.match(title)&.length || 0
      header_id = title.gsub(/[^a-z0-9]+/i, "-").downcase.gsub(/^\-|\-$/, "")
      if title_length - header_id.length > min_length
        header_id = Digest::MD5.hexdigest(title.strip)[0..8]
      end

      attrs = attributes(node)
      nid_attr = name_by_attrs(attrs)

      if title.blank?
        %(<#{heading_tag}#{nid_attr}>#{title}</#{heading_tag}>)
      else
        %(<#{heading_tag} id="#{header_id}"#{nid_attr}><a href="##{header_id}" class="heading-anchor">#</a>#{title}</#{heading_tag}>)
      end
    end
  end
end
