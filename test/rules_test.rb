# frozen_string_literal: true

require "test_helper"

class BookLab::SML::RulesTest < ActiveSupport::TestCase
  test "root" do
    sml = %(["root", ["body", ["p", "Hello world"]]])
    html = %(<body><p>Hello world</p></body>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "div, html, body" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "link" do
    sml = %(["link", { href: "https://booklab.io", title: "BookLab" }, "Hello world"])
    html = %(<a href="https://booklab.io" title="BookLab" target="_blank">Hello world</a>)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["link", { title: "BookLab" }, "Hello world"])
    assert_equal "Hello world", BookLab::SML.parse(sml)
  end

  test "hr" do
    sml = %(["hr"])
    assert_equal "<hr>", BookLab::SML.parse(sml)
  end

  test "image" do
    sml = %(["image", { name: "Foo.jpg", src: "/uploads/foo.jpg", width: 300, height: 200 }])
    html = %(<img src="/uploads/foo.jpg" alt="Foo.jpg" width="300" height="200">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", width: 300 }])
    html = %(<img src="/uploads/foo.jpg" width="300">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", height: 300 }])
    html = %(<img src="/uploads/foo.jpg" height="300">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { name: "Foo.jpg", height: 300 }])
    assert_equal "Foo.jpg", BookLab::SML.parse(sml)
  end

  test "file" do
    sml = %(["file", { name: "Foo-bar.pdf", src: "/uploads/foo.pdf", size: 612821 }])
    html = <<~HTML
    <a class="attachment-file" title="Foo-bar.pdf" target="_blank" href="/uploads/foo.pdf">
      <span class="icon-box"><i class="fas fa-file"></i></span>
      <span class="filename">Foo-bar.pdf</span>
      <span class="filesize">598 KB</span>
    </a>
    HTML
    assert_equal html, BookLab::SML.parse(sml)

    # escape html
    sml = %(["file", { name: "<script>-bar.pdf", src: "/uploads/foo.pdf", size: "<script>" }])
    html = <<~HTML
    <a class="attachment-file" title="<script>-bar.pdf" target="_blank" href="/uploads/foo.pdf">
      <span class="icon-box"><i class="fas fa-file"></i></span>
      <span class="filename">&lt;script&gt;-bar.pdf</span>
      <span class="filesize">&lt;script&gt;</span>
    </a>
    HTML
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "blockquote" do
    sml = %(["blockquote", ["p", "Hello world"]])
    html = %(<blockquote><p>Hello world</p></blockquote>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "br" do
    sml = %(["br"])
    html = %(<br>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "codeblock" do
    code = <<~CODE
    class BookLab
      def version
        '0.1.0'
      end
    end
    CODE

    sml = %(["codeblock", { code: "#{code}", language: "ruby" }])

    html = <<~HTML
    <div class="highlight">
      <pre class="highlight ruby">
        <code><span class="k">class</span> <span class="nc">BookLab</span> <span class="k">def</span> <span class="nf">version</span> <span class="s1">'0.1.0'</span> <span class="k">end</span> <span class="k">end</span> </code>
      </pre>
    </div>
    HTML
    assert_html_equal html, BookLab::SML.parse(sml)
  end

  test "math" do
    sml = %(["math", { code: "x^2 + y = z" }])
    html = %(<img class="tex-image" src="https://localhost:4010/svg?tex=x%5E2%20+%20y%20=%20z">)
    assert_html_equal html, BookLab::SML.parse(sml, mathjax_service_host: "https://localhost:4010")
  end

  test "plantuml" do
    code = <<~CODE
    @startuml
    Alice -> Bob: test
    @enduml
    CODE

    sml = %(["plantuml", { code: "#{code}" }])
    html = %(<img src="https://localhost:1020/svg/@startuml%20Alice%20-%3E%20Bob:%20test%20@enduml" class="plantuml-image" />)
    out = BookLab::SML.parse(sml, plantuml_service_host: "https://localhost:1020")
    assert_equal html, out
  end

  test "list" do
    sml = %(["list",{"nid":"c50z4utzc9q","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"First line"]]],["list",{"nid":"c50z4utzc9q","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"Second line with indent 1"]]],["list",{"nid":"c50z4utzc9q","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"Third line with 2 ident"]]],["list",{"nid":"c50z4utzc9q","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"4th line"]]],["list",{"nid":"c50z4utzc9q","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"5thline"]]],["p",{},["span",{"t":1},["span",{"t":0},""]]])
    html = %()
    out = BookLab::SML.parse(sml)
    # puts out
    assert_equal html, out
  end

  test "table" do
    sml = %(["root",{},["table",{"colsWidth":[60,60,60]},["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"版本"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"功能"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"说明"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{"jc":"left"},["span",{"t":1},["span",{"t":0},"v2.1.0"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"Hello world"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.7.2"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"v2.0.8"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"修复一处 crash"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.5.21"]]]]]],["p",{},["span",{"t":1},["span",{"t":0},""]]]])
    html = %(<table><tr><td><p>版本</p></td><td><p>功能</p></td><td><p>说明</p></td></tr><tr><td><p>v2.1.0</p></td><td><p>Hello world</p></td><td><p>2018.7.2</p></td></tr><tr><td><p>v2.0.8</p></td><td><p>修复一处 crash</p></td><td><p>2018.5.21</p></td></tr></table><p></p>)
    out = BookLab::SML.parse(sml)

    assert_equal html, out
  end
end
