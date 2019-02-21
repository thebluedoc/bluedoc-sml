# BlueDoc::SML

[![CircleCI](https://circleci.com/gh/thebluedoc/bluedoc-sml/tree/master.svg?style=shield&circle-token=f1967fcb6f13fb9bcdb074769fc30038d36aee53)](https://circleci.com/gh/thebluedoc/bluedoc-sml/tree/master)

SML __(Slate markup language)__ is a rich text format for describe of the BlueDoc rich contents.

It base on [JsonML](http://jsonml.org) format, and including custom DSL.

## Usage

```rb
gem "bluedoc-sml"
```

and then run `bundle install`

```rb
$ sml = %(["p", { align: "center", indent: 1 }, "Hello world"])
$ renderer = BlueDoc::SML.parse(sml)
$ renderer.to_html
=> <p style="text-align: center; text-indent: 32px;">Hello world</p>
$ renderer.to_text
=> "Hello world"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
