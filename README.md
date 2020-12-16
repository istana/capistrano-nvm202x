# Capistrano::nvm202x

This gem provides idiomatic nvm support for Capistrano 3.x (and 3.x
*only*).

## Please Note

(By original maintainer) Thanks a lot to [@yyuu](https://github.com/yyuu) for merging his gem with official one.
And also thanks a lot to [capistrano-rbenv](https://github.com/capistrano/rbenv) for the code this repo originates from.

Note: this gem is different from [capistrano-nvm](https://github.com/koenpunt/capistrano-nvm). This one doesn't play with `capistrano-rbenv` which was the reason to create `capistrano-nvm202x`.

Current limitation: should be required after rbenv or after anything that adds environment variables.

## Installation

Add this line to your application's Gemfile:

~~~ruby
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-nvm202x', require: false
~~~

And then execute:

    $ bundle install

## Usage

    # Capfile
    require "capistrano/rbenv"
    require "capistrano/nvm" # after rbenv


    # config/deploy.rb
    set :nvm_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), depends on your nvm setup
    set :nvm_node, 'v14.15.1'

    # in case you want to set nvm version from the file:
    # set :nvm_node, File.read('.nvmrc').strip

    set :nvm_prefix, "source #{fetch(:nvm_path)}/nvm.sh; "
    set :nvm_map_bins, %w{rake gem bundle yarn rails}
    set :nvm_roles, :all # default value

If your nvm is located in some custom path, you can use `nvm_custom_path` to set it.

### Defining the ruby version

To set the Ruby version explicitly, add `:nvm_ruby` to your Capistrano configuration:

    # config/deploy.rb
    set :nvm_node, 'v14.15.1'

Alternatively, allow the remote host's `nvm` to determine the appropriate Node version](https://github.com/nvm-sh/nvm#usage) by omitting `:nvm_node`. This approach is useful if you have a `.nvmrc` file in your project.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
