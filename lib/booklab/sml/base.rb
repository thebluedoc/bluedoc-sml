# frozen_string_literal: true

require "yaml"

module BookLab
  module SML
    def self.parse(src, options = {})
      renderer = Renderer.new(src, options)
      renderer
    end
  end
end
