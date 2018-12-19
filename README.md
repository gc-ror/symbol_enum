# Gcl::SymbolEnum

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gcl/symbol_enum`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcl-symbol_enum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gcl-symbol_enum

## Usage

Define model and enumeration

```ruby
class CreateExampleModels < ActiveRecord::Migration[5.2]
  def change
    create_table do |t|
      t.integer :example
    end
  end
end

class ExampleModel < ApplicationModel
  class Example < Gcl::SymbolEnum
    declare do
      item 1, :item1, 'Item 1'
      item 2, :item2, 'Item 2'
    end
  end
    
  serialize :example, Example
end
```

Using model

```ruby
em = ExampleModel.new
em.example = ExampleModel.item1
em.example = 1 # equivalent to above.
em.example = :test1 # equivalent to above.
em.save # INSERT INTO example_models(example) VALUES (1)

ems = ExampleModel.all

puts ems.map(&:example).map(:id).inspect # [1]
puts ems.map(&:example).map(:to_s).inspect # ['item1']
puts ems.map(&:example).map(:to_sym).inspect # [:item1]
puts ems.map(&:example).map(:text).inspect # ['Item 1']
```

Using in view(HAML)
```haml
= form_with model: @example_model do |f|
  = f.label :example
  = f.collection_select :example, ExampleModel::Example, :id, :text
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gc-ror/gcl-symbol_enum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gcl::SymbolEnum project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gcl-symbol_enum/blob/master/CODE_OF_CONDUCT.md).
