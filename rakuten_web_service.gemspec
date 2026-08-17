lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakuten_web_service/version'

Gem::Specification.new do |spec|
  spec.name          = 'rakuten_web_service'
  spec.version       = RakutenWebService::VERSION
  spec.authors       = ['Yukiko Asai']
  spec.email         = ['asai@ecdb.jp']
  spec.summary       = 'Ruby Client for Rakuten Web Service'
  spec.description   = 'Ruby client library for the Rakuten Web Service APIs ' \
                       '(Ichiba, Books, Travel, Kobo, GORA and Recipe). ' \
                       'A fork of rakuten-ws/rws-ruby-sdk maintained by ECDB.'
  spec.homepage      = 'https://github.com/ecdbinc/rws-ruby-sdk'
  spec.license       = 'MIT'

  spec.metadata = {
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/master/CHANGELOG.md",
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.2.0'

  spec.add_dependency 'json', '~> 2.3'

  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'terminal-table', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.9'
end
