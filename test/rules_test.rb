require 'test_helper'

class BookLab::SML::RulesTest < ActiveSupport::TestCase
  test "div, html, body" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "link" do
    sml = %(["link", { href: "https://booklab.io", title: "BookLab" }, "Hello world"])
    html = %(<a href="https://booklab.io" title="BookLab">Hello world</a>)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["link", { title: "BookLab" }, "Hello world"])
    assert_equal "Hello world", BookLab::SML.parse(sml)
  end
end