# BookLab::SML

SML __(Slate markup language)__ is a rich text format for describe of the BookLab rich contents.

It base on [JsonML](http://jsonml.org) format, and including custom DSL.

## Usage

```rb
gem "booklab-sml"
```

and then run `bundle install`

```rb
$ sml = %(["p", { align: "center", indent: 1 }, "Hello world"])
$ BookLab::SML.parse(sml)
=> <p style="text-align: center; text-indent: 32px;">Hello world</p>
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
