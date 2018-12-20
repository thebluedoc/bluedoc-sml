require 'test_helper'

class JsonML::Test < ActiveSupport::TestCase
  test "base to_html" do
    ml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html lang="en"><body><p>Hello world</p></body></html>)
    assert_equal html, JsonML.parse(ml)
  end

  test "complex" do
    ml = read_file("sample.jsonml")
    html = JsonML.parse(ml)

    assert_html_equal read_file("sample.html"), html
  end
end
