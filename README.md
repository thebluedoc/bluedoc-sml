# BookLab::SML

*SML* is a document format base on [JsonML](http://jsonml.org).

## Usage

```rb
gem "booklab-sml"
```

and then run `bundle install`

```rb
$ ml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
$ puts BookLab::SML.parse(ml)
=> <html lang="en"><body><p>Hello world</p></body></html>
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
