# JsonML

http://jsonml.org

JsonML-related tools for losslessly converting between XML/HTML and JSON for Ruby.

## Usage

```rb
gem "jsonml"
```

and then run `bundle install`

```rb
$ ml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
$ puts JsonML.parse(ml)
=> <html lang="en"><body><p>Hello world</p></body></html>
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
