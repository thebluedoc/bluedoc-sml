# frozen_string_literal: true

require "test_helper"

class BookLab::SML::Test < ActiveSupport::TestCase
  test "base to_html" do
    ml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(ml)
  end

  test "complex" do
    ml = read_file("sample.sml")
    html = BookLab::SML.parse(ml)

    # puts beautify_html(html)

    assert_html_equal read_file("sample.html"), html
  end
end
