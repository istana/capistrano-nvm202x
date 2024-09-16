# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-nvm202x"
  gem.version       = '3.0.0'
  gem.authors       = ["Ivan Stana", "Kir Shatrov", "Yamashita Yuu"]
  gem.email         = ["^_^@myrtana.sk", "shatrov@me.com", "yamashita@geishatokyo.com"]
  gem.description   = %q{nvm integration for Capistrano}
  gem.summary       = %q{nvm integration for Capistrano}
  gem.homepage      = "https://github.com/istana/capistrano-nvm202x/"
  gem.metadata      = {
    "changelog_uri" => "https://github.com/istana/capistrano-nvm202x/releases"
  }

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.licenses      = ["MIT"]

  gem.add_dependency 'capistrano', '~> 3.19'
  gem.add_dependency 'sshkit', '~> 1.3'

  gem.add_development_dependency 'danger'
end
