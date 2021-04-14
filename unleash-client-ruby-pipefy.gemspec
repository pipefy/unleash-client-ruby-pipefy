lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "unleash/strategy/org_with_id"

Gem::Specification.new do |spec|
  spec.name          = "unleash-client-ruby-pipefy"
  spec.version       = 1.0
  spec.authors       = ["Anderson Campos, Gustavo Candido, Thais Caldeira"]
  spec.email         = ["anderson.campos@pipefy.com, gustavo.candido@pipefy.com, thais.caldeira@pipefy.com"]

  spec.summary       = 'Unleash client customizations for Pipefy'
  spec.description   = 'Unleash client customizations for Pipefy'
  spec.homepage      = "https://github.com/pipefy/unleash-client-ruby-pipefy"
  spec.metadata["homepage_uri"] = spec.homepage

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # spec.metadata["source_code_uri"] = "https://github.com/pipefy/unleash-client-ruby-org-id"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'unleash', '~> 3.2.2'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0.3"
  spec.add_development_dependency "rspec", "~> 3.10"
end
