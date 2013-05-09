# mecab-ext
A handy extensions for mecab-ruby.

## Installation
At first install `Mecab` and `mecab-ruby`.
[See more detail](https://code.google.com/p/mecab/).

Then this line to your application's Gemfile:

    gem 'mecab-ext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mecab-ext

## Usage

```ruby
# require with original ruby-mecab
require "mecab/ext"

# "Mecab" for this gem. Original takes "MeCab"
Mecab #=> for this gem
MeCab #=> for original ruby-mecab

# Parse japanese text and get extented node instance
nodes = Mecab::Ext::Parser.parse("テスト文章")
nodes.class #=> Mecab::Ext::Node

# Call Mecab::Ext::Node#each to get each MeCab::Node object
nodes.each {|node| p node }

# Extented node class has Enumerable methods
nodes.map {|node| node.surface }
nodes.select {|node| node.surface == "テスト" }

# If you need only surfaces, call Mecab::Ext::Node#each_surface
nodes.each_surface {|surface| p surface }

# mecab-ext cuts beginning of line node and end of line node for handiness
nodes.size #=> 2
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 Taiki ONO

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
