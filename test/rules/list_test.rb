# frozen_string_literal: true

require "test_helper"

class BlueDoc::SML::RulesTest < ActiveSupport::TestCase
  def render(sml, opts = {})
    BlueDoc::SML.parse(sml, opts).to_html
  end

  test "complex list" do
    # sml = <<~SML
    # ["root",{},
    #   ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"This is a shorthand"]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"This defines the default size of an element before the remaining space is distributed."]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"It can be a length "],["span",{"t":0,"b":1},"(e.g. 20%, 5rem, etc.)"],["span",{"t":0}," or a keyword."]]],
    #       ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"ordered"},["span",{"t":1},["span",{"t":0},"The auto keyword means look at my width or height property"]]],
    #       ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"ordered"},["span",{"t":1},["span",{"t":0},"The content "],["span",{"t":0,"cd":1},"keyword"],["span",{"t":0}," means size it based on the item's content - this keyword isn't well supported yet."]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"So it's hard to test and harder to know what its brethren."]]],
    #   ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"Look at my width or height property"]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"This is the shorthand for flex-grow, flex-shrink and flex-basis combined."]]],
    #       ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"The second and third parameters"]]],
    #         ["list",{"nid":"g5zxu3ly1io","level":4,"pstyle":"paragraph","indent":{"firstline":0,"left":16},"type":"ordered"},["span",{"t":1},["span",{"t":0,"b":1,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"It is recommended that you use this shorthand property."]]],
    #         ["list",{"nid":"g5zxu3ly1io","level":4,"pstyle":"paragraph","indent":{"firstline":0,"left":16},"type":"ordered"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"rather than set the individual properties."]]],
    #         ["list",{"nid":"g5zxu3ly1io","level":4,"pstyle":"paragraph","indent":{"firstline":0,"left":16},"type":"ordered"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"Pressing Enter insert a new list item."]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"The short hand sets the other values intelligently."]]],
    #     ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"Note that visually the spaces aren't equal"]]],
    #   ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"The extra space around content isn't factored in."]]],
    #   ["p",{},["span",{"t":1},["span",{"t":0},""]]]]
    # SML

    sml = <<~SML
    ["root",{},
      ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"This is a shorthand"]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"This defines the default size of an element before the remaining space is distributed."]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"It can be a length "],["span",{"t":0,"b":1},"(e.g. 20%, 5rem, etc.)"],["span",{"t":0}," or a keyword."]]],
          ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"ordered"},["span",{"t":1},["span",{"t":0},"The auto keyword means look at my width or height property"]]],
          ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"ordered"},["span",{"t":1},["span",{"t":0},"The content "],["span",{"t":0,"cd":1},"keyword"],["span",{"t":0}," means size it based on the item's content - this keyword isn't well supported yet."]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"ordered"},["span",{"t":1},["span",{"t":0},"So it's hard to test and harder to know what its brethren."]]],
      ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"Look at my width or height property"]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"This is the shorthand for flex-grow, flex-shrink and flex-basis combined."]]],
          ["list",{"nid":"g5zxu3ly1io","level":3,"pstyle":"paragraph","indent":{"firstline":0,"left":12},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"The second and third parameters"]]],
            ["list",{"nid":"g5zxu3ly1io","level":4,"pstyle":"paragraph","indent":{"firstline":0,"left":16},"type":"ordered"},["span",{"t":1},["span",{"t":0,"b":1,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"It is recommended that you use this shorthand property."]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"The short hand sets the other values intelligently."]]],
        ["list",{"nid":"g5zxu3ly1io","level":2,"pstyle":"paragraph","indent":{"firstline":0,"left":8},"type":"bulleted"},["span",{"t":1},["span",{"t":0,"cl":"rgb(46, 47, 62)","hl":"rgb(255, 255, 255)"},"Note that visually the spaces aren't equal"]]],
      ["list",{"nid":"g5zxu3ly1io","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"bulleted"},["span",{"t":1},["span",{"t":0},"The extra space around content isn't factored in."]]],
      ["p",{},["span",{"t":1},["span",{"t":0},""]]]]
    SML

    out = render(sml)

    html = <<~HTML
    <ul data-level="1">
      <li>This is a shorthand
        <ol data-level="2">
          <li>This defines the default size of an element before the remaining space is distributed.</li>
          <li>It can be a length <strong>(e.g. 20%, 5rem, etc.)</strong> or a keyword.
            <ol data-level="3">
              <li>The auto keyword means look at my width or height property</li>
              <li>The content <code>keyword</code> means size it based on the item's content - this keyword isn't well supported yet.</li>
            </ol>
          </li>
          <li>So it's hard to test and harder to know what its brethren.</li>
        </ol>
      </li>
      <li>Look at my width or height property
        <ul data-level="2">
          <li>This is the shorthand for flex-grow, flex-shrink and flex-basis combined.
            <ul data-level="3">
              <li>The second and third parameters
                <ol data-level="4">
                  <li><span style="color: rgb(46, 47, 62);"><strong>It is recommended that you use this shorthand property.</strong></span></li>
                </ol>
              </li>
            </ul>
          </li>
          <li><span style="color: rgb(46, 47, 62);">The short hand sets the other values intelligently.</span></li>
          <li><span style="color: rgb(46, 47, 62);">Note that visually the spaces aren't equal</span></li>
        </ul>
      </li>
      <li>The extra space around content isn't factored in.</li>
    </ul>
    <p></p>
    HTML

    assert_html_equal html, out
  end

  test "Invalid nested list will ignore" do
    sml = <<~SML
    ["root",{},
      ["list",{"nid":"jdewv","type":"bulleted","level":1},
        ["list",{"nid":"jdewv","type":"bulleted","level":2},["span",{},"Child 1"]],
        ["list",{"nid":"jdewv","type":"bulleted","level":2},["span",{},"Child 2"]],
        ["list",{"nid":"jdewv","type":"bulleted","level":2},["span",{},"Child 3"]],
      ],
      ["list",{"nid":"jdewv","type":"bulleted","level":1},["span",{},"Contact admin to get"]],
    ]
    SML

    out = render(sml)

    html = <<~HTML
    <ul data-level="1">
      <li></li>
      <li><span>Contact admin to get</span></li>
    </ul>
    HTML

    assert_html_equal html, out
  end

end