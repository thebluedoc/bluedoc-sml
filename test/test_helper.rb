# frozen_string_literal: true

require "minitest/autorun"
require "active_support"
require "htmlbeautifier"
require "booklab-sml"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

class ActiveSupport::TestCase
  def read_file(fname)
    File.open(File.expand_path(File.join(__FILE__, "..", "fixtures", fname))).read
  end

  def assert_html_equal(excepted, html)
    assert_equal beautify_html(excepted), beautify_html(html)
  end

  def beautify_html(html)
    HtmlBeautifier.beautify(html, indent: "  ")
  end
end
