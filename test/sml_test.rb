# frozen_string_literal: true

require "test_helper"

class BookLab::SML::Test < ActiveSupport::TestCase
  test "base to_html" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(sml).to_html
  end

  test "base to_text" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"], ["p", "   "], ["p", " This is plain text "]]])
    html = %(Hello world This is plain text)
    assert_equal html, BookLab::SML.parse(sml).to_text
  end

  test "complex" do
    sml = read_file("sample.sml")
    renderer = BookLab::SML.parse(sml)

    # puts format_html(renderer.to_html)

    assert_html_equal read_file("sample.html"), renderer.to_html
    assert_html_equal read_file("sample.txt").strip, renderer.to_text.strip
  end

  test "with invalid format" do
    sml = %(["span",{"t":1},["span",{"t":0},"pre/post - "]])
    html = BookLab::SML.parse(sml).to_html
    assert_equal "pre/post - ", html
  end
end
