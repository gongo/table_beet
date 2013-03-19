# TableBeet

TableBeet is reference generator for [turnip](https://github.com/jnicklas/turnip) steps of existing.

[![Build Status](https://travis-ci.org/gongo/table_beet.png?branch=master)](https://travis-ci.org/gongo/table_beet)
[![Code Climate](https://codeclimate.com/github/gongo/table_beet.png)](https://codeclimate.com/github/gongo/table_beet)
[![Dependency Status](https://gemnasium.com/gongo/table_beet.png)](https://gemnasium.com/gongo/table_beet)
[![Coverage Status](https://coveralls.io/repos/gongo/table_beet/badge.png?branch=master)](https://coveralls.io/r/gongo/table_beet)

# Requirements

- Ruby
    - 1.9.3
    - 2.0.0

## Installation

### RubyGems

    $ gem install table_beet

### Bundler

Add this line to your application's Gemfile:

    gem 'table_beet'

And then execute:

    $ bundle install

## Usage

If you perform any of the following, reference page is generated under `--output DIRECTORY`.

### Command line

    $ table_beet -h
    Usage: table_beet [options]
            --output        Directory to output (default: ./stepdoc)
            --path          Directory that contains step file. (default: ./spec)
            --suffix        Suffix of step file  (default: _steps.rb)
        -n, --textmode      Display steps in plain text (No generate HTML)
        -v, --version       Print this version
        -h, --help          Display this help message.

e.g.

    $ table_beet --path /path/to/example --suffix _example_steps.rb
        # => Check step for /path/to/example/**/*_example_steps.rb

### With the execution of turnip

Add `(1)` and `(2)` line to your application's `spec_helper` file.

```ruby
require 'table_beet' # (1)

Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }

# (2)
# If not specify output directory, use './stepdoc'
TableBeet::Reporter.build(output: '/path/to/output')
```

Please describe the `(2)` after load the your application's steps.

## Example

The Example uses the [turnip examples](https://github.com/jnicklas/turnip/tree/master/examples).

    $ git clone git://github.com/jnicklas/turnip.git /tmp/turnip

### Command line version

    $ table_beet --path /tmp/turnip/examples/steps
    $ open ./stepdoc/index.html

The same page as the link below is generated.

http://gongo.github.com/table_beet/demo/index.html


### With the execution of turnip version.

    $ cd /tmp/turnip
    $ vim spec/spec_helper.rb

```diff
+require 'table_beet'
+
 Dir.glob("examples/**/*steps.rb") { |f| load f, true }
+
+TableBeet::Reporter.build
```

    $ rake test
    $ open ./stepdoc/index.html

### FYI

    $ table_beet --path /tmp/turnip/examples/steps --textmode

    turnip
    - I run :cmd	file:///tmp/turnip/examples/steps/backtick_steps.rb:1
    - there are :count monkeys with :color hair	file:///tmp/turnip/examples/steps/more_steps.rb:1
    - there should be 3 monkeys with blue hair	file:///tmp/turnip/examples/steps/more_steps.rb:5

    evil
    - the monster has an alignment	file:///tmp/turnip/examples/steps/alignment_steps.rb:12
    - that alignment should be :alignment	file:///tmp/turnip/examples/steps/alignment_steps.rb:4

    (skip..)

### License

see `LICENSE` .

