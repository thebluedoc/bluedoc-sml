# frozen_string_literal: true

require "test_helper"

class BookLab::SML::Test < ActiveSupport::TestCase
  test "base to_html" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "complex" do
    sml = read_file("sample.sml")
    html = BookLab::SML.parse(sml)

    # puts format_html(html)

    assert_html_equal read_file("sample.html"), html
  end

  test "with invalid format" do
    sml = %(["span",{"t":1},["span",{"t":0},"pre/post - "]])
    html = BookLab::SML.parse(sml)
    assert_equal "pre/post - ", html
  end
end
