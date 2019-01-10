# frozen_string_literal: true

require "test_helper"

class BookLab::SML::RulesTest < ActiveSupport::TestCase
  def render(sml, opts = {})
    BookLab::SML.parse(sml, opts)
  end

  test "root" do
    sml = %(["root", ["body", ["p", "Hello world"]]])
    html = %(<body><p>Hello world</p></body>)
    assert_equal html, render(sml)
  end

  test "div, html, body" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, render(sml)
  end

  test "paragraph" do
    sml = %(["p", { align: "center", indent: 1 }, "Hello world"])
    html = %(<p style="text-align: center; text-indent: 32px;">Hello world</p>)
    assert_equal html, render(sml)
  end

  test "span and marks" do
    sml = %(["span", {}, "Foo"])
    assert_equal %(<span>Foo</span>), render(sml)

    # code
    sml = %(["span", { t: 0, cd: 1 }, "code"])
    assert_equal %(<code>code</code>), render(sml)

    # bold
    sml = %(["span", { t: 0, b: 1 }, "bold"])
    assert_equal %(<strong>bold</strong>), render(sml)

    # italic
    sml = %(["span", { t: 0, i: 1 }, "italic"])
    assert_equal %(<i>italic</i>), render(sml)

    # strikethrough
    sml = %(["span", { t: 0, s: 1 }, "strikethrough"])
    assert_equal %(<del>strikethrough</del>), render(sml)

    # mark
    sml = %(["span", { t: 0, m: 1 }, "mark"])
    assert_equal %(<mark>mark</mark>), render(sml)

    # subscript
    sml = %(["span", { t: 0, sub: 1 }, "subscript"])
    assert_equal %(<sub>subscript</sub>), render(sml)

    # supscript
    sml = %(["span", { t: 0, sup: 1 }, "supscript"])
    assert_equal %(<sup>supscript</sup>), render(sml)
  end

  test "heading" do
    sml = %(["h1", {}, "Heading 1"])
    assert_equal %(<h1 id="heading-1"><a href="#heading-1" class="heading-anchor">#</a>Heading 1</h1>), render(sml)

    sml = %(["h2", {}, "确保 id 生成是固定的编号"])
    assert_equal %(<h2 id="583a03ad8"><a href="#583a03ad8" class="heading-anchor">#</a>确保 id 生成是固定的编号</h2>), render(sml)

    sml = %(["h3", {}, "This_? is"])
    assert_equal %(<h3 id="this-is"><a href="#this-is" class="heading-anchor">#</a>This_? is</h3>), render(sml)

    sml = %(["h4", {}, "Heading 4"])
    assert_equal %(<h4 id="heading-4"><a href="#heading-4" class="heading-anchor">#</a>Heading 4</h4>), render(sml)

    sml = %(["h5", {}, "Heading 5"])
    assert_equal %(<h5 id="heading-5"><a href="#heading-5" class="heading-anchor">#</a>Heading 5</h5>), render(sml)

    sml = %(["h6", {}, "Heading 6"])
    assert_equal %(<h6 id="heading-6"><a href="#heading-6" class="heading-anchor">#</a>Heading 6</h6>), render(sml)
  end

  test "link" do
    sml = %(["link", { href: "https://booklab.io", title: "BookLab" }, "Hello world"])
    html = %(<a href="https://booklab.io" title="BookLab" target="_blank">Hello world</a>)
    assert_equal html, render(sml)

    sml = %(["link", { title: "BookLab" }, "Hello world"])
    assert_equal "Hello world", render(sml)
  end

  test "hr" do
    sml = %(["hr"])
    assert_equal "<hr>", render(sml)
  end

  test "image" do
    sml = %(["image", { name: "Foo.jpg", src: "/uploads/foo.jpg", width: 300, height: 200 }])
    html = %(<img src="/uploads/foo.jpg" alt="Foo.jpg" width="300" height="200">)
    assert_equal html, render(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", width: 300 }])
    html = %(<img src="/uploads/foo.jpg" width="300">)
    assert_equal html, render(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", height: 300 }])
    html = %(<img src="/uploads/foo.jpg" height="300">)
    assert_equal html, render(sml)

    sml = %(["image", { name: "Foo.jpg", height: 300 }])
    assert_equal "Foo.jpg", render(sml)
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
    assert_equal html, render(sml)

    # escape html
    sml = %(["file", { name: "<script>-bar.pdf", src: "/uploads/foo.pdf", size: "<script>" }])
    html = <<~HTML
    <a class="attachment-file" title="<script>-bar.pdf" target="_blank" href="/uploads/foo.pdf">
      <span class="icon-box"><i class="fas fa-file"></i></span>
      <span class="filename">&lt;script&gt;-bar.pdf</span>
      <span class="filesize">&lt;script&gt;</span>
    </a>
    HTML
    assert_equal html, render(sml)
  end

  test "blockquote" do
    sml = %(["blockquote", ["p", "Hello world"]])
    html = %(<blockquote><p>Hello world</p></blockquote>)
    assert_equal html, render(sml)
  end

  test "br" do
    sml = %(["br"])
    html = %(<br>)
    assert_equal html, render(sml)
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
      <pre class="highlight ruby"><code><span class="k">class</span> <span class="nc">BookLab</span> <span class="k">def</span> <span class="nf">version</span> <span class="s1">'0.1.0'</span> <span class="k">end</span> <span class="k">end</span> </code></pre>
    </div>
    HTML
    assert_html_equal html, render(sml)
  end

  test "math" do
    sml = %(["math", { code: "x^2 + y = z" }])
    html = %(<img class="tex-image" src="https://localhost:4010/svg?tex=x%5E2%20+%20y%20=%20z">)
    assert_html_equal html, render(sml, mathjax_service_host: "https://localhost:4010")
  end

  test "plantuml" do
    code = <<~CODE
    @startuml
    Alice -> Bob: test
    @enduml
    CODE

    sml = %(["plantuml", { code: "#{code}" }])
    html = %(<img src="https://localhost:1020/svg/@startuml%20Alice%20-%3E%20Bob:%20test%20@enduml" class="plantuml-image" />)
    out = render(sml, plantuml_service_host: "https://localhost:1020")
    assert_equal html, out
  end

  test "video" do
    sml = %(["video", { src: "/uploads/foo.mov", type: "video/mov", width: 300, height: 200 }])
    html = <<~HTML
    <video controls preload="no" width="300" height="200">
      <source src="/uploads/foo.mov" type="video/mov">
    </video>
    HTML
    assert_html_equal html, render(sml)
  end

  test "list" do
    sml = <<~SML
    ["root",{},
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":0},["span",{"t":1},["span",{"t":0},"Bold text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":1},["span",{"t":1},["span",{"t":0},"Important text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"Italic text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":3,"indent":{"firstline":0,"left":12},"num":2},["span",{"t":1},["span",{"t":0},"Emphasized text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":4,"indent":{"firstline":0,"left":16},"num":3},["span",{"t":1},["span",{"t":0},"Marked text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":2},["span",{"t":1},["span",{"t":0},"Small text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":3},["span",{"t":1},["span",{"t":0},"Deleted text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":2},["span",{"t":1},["span",{"t":0},"Inserted text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"Subscript text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":3},["span",{"t":1},["span",{"t":0},"Superscript text"]]],
      ["p",{},["span",{"t":1},["span",{"t":0},""]]]
    ]
    SML

    html = %(
    <ul data-level="1">
      <li>Bold text</li>
      <li>Important text
        <ul data-level="2">
          <li>Italic text
            <ul data-level="3">
              <li>Emphasized text
                <ul data-level="4">
                  <li>Marked text</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
        <ul data-level="2">
          <li>Small text</li>
          <li>Deleted text</li>
        </ul>
      </li>
    </ul>
    <ul data-level="1">
      <li>Inserted text
        <ul data-level="2">
          <li>Subscript text</li>
        </ul>
      </li>
    </ul>
    <ul data-level="1">
      <li>Superscript text</li>
    </ul>
    <p></p>
    )
    out = render(sml)
    # puts out
    assert_html_equal html, out
  end

  test "list with other tag or empty after n depth" do
    sml = <<~SML
    ["root",
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":0},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":3,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":4,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["p", {}, "Hello world"]
    ]
    SML

    html = <<~HTML
    <ul data-level="1">
      <li>hello
        <ul data-level="2">
          <li>hello
            <ul data-level="3">
              <li>hello
                <ul data-level="4">
                  <li>hello</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
    <p>Hello world</p>
    HTML

    out = render(sml)
    # puts format_html(out)
    assert_html_equal html, out
  end

  test "table" do
    sml = %(["root",{},["table",{"colsWidth":[60,60,60]},["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"版本"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"功能"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"说明"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{"jc":"left"},["span",{"t":1},["span",{"t":0},"v2.1.0"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"Hello world"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.7.2"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"v2.0.8"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"修复一处 crash"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.5.21"]]]]]],["p",{},["span",{"t":1},["span",{"t":0},""]]]])
    html = %(<table><tr><td><p>版本</p></td><td><p>功能</p></td><td><p>说明</p></td></tr><tr><td><p>v2.1.0</p></td><td><p>Hello world</p></td><td><p>2018.7.2</p></td></tr><tr><td><p>v2.0.8</p></td><td><p>修复一处 crash</p></td><td><p>2018.5.21</p></td></tr></table><p></p>)
    out = render(sml)

    assert_equal html, out
  end

  test "td" do
    sml = %(["tc", { align: "right", indent: 1 }, "Hello world"])
    html = %(<td style="text-align: right; text-indent: 32px;">Hello world</td>)
    assert_equal html, render(sml)
  end
end
