# Capistrano::nvm202x

This gem provides idiomatic nvm (Node Version Manager) support for Capistrano 3.x (and 3.x *only*).

## Please Note

**NOTE:** this gem is different from [capistrano-nvm](https://github.com/koenpunt/capistrano-nvm). Not sure why, but `capistrano-nvm` doesn't play with `capistrano-rbenv` which was the reason to create `capistrano-nvm202x`.

And also thanks a lot to [capistrano-rbenv](https://github.com/capistrano/rbenv) for the code this repo originates from.

-----------------------------------

(By original maintainer) Thanks a lot to [@yyuu](https://github.com/yyuu) for merging his gem with official one.

## Installation

Add this line to your application's Gemfile:

~~~ruby
  gem 'capistrano', '~> 3.19', require: false
  gem 'capistrano-nvm202x', require: false
~~~

And then execute:

    $ bundle install

## Usage

    # Capfile
    require "capistrano/nvm"

    # config/deploy.rb
    set :nvm_type, :user # or :system, depends on your nvm setup
    set :nvm_node, 'v23.1.0'

    # in case you want to set nvm version from the file:
    # set :nvm_node, File.read('.nvmrc').strip

    # optional configuration
    set :nvm_custom_path, '$HOME/.nvm' # sets custom `nvm_path`
    set :nvm_roles, :all
    set :nvm_map_bins, %w{corepack node npm npx yarn yarnpkg} # commands for which prefix is added

### Defining the node version

To set the Node version explicitly, add `:nvm_node` to your Capistrano configuration:

    # config/deploy.rb
    set :nvm_node, 'v23.1.0'

Alternatively, allow the remote host's `nvm` to determine the appropriate Node version](https://github.com/nvm-sh/nvm#usage) by omitting `:nvm_node`. This approach is useful if you have a `.nvmrc` file in your project.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
