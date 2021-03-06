# EyeOfNewt

EyeOfNewt is an ingredient parser. It parses a variety of ingredients written in natural language, such as "1
can of crushed tomatoes" or "1 onion, diced".

## Installation

Add this line to your application's Gemfile:

    gem 'eye_of_newt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eye_of_newt

## Usage

```
ingredient = EyeOfNewt.parse("1 1/2 cups white flour, sifted")
ingredient.name # == 'white flour'
ingredient.amount # == 1.5
ingredient.unit # == 'cups'
ingredient.style # == 'sifted'
```

## Acknowledgements

The original list of units was taken from the [ingreedy project](https://github.com/iancanderson/ingreedy/blob/34d83a7f345efd1522065ac57f5ff0e9735e57de/lib/ingreedy/ingreedy_parser.rb#L59) by Ian C. Anderson

## Contributing

1. Fork it ( http://github.com/<my-github-username>/eye_of_newt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
