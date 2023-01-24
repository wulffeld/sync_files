require_relative "lib/sync_files/version"

Gem::Specification.new do |spec|
  spec.name = "sync_files"
  spec.version = SyncFiles::VERSION
  spec.authors = ["Martin Moen Wulffeld"]
  spec.email = ["martin@wulffeld.dk"]

  spec.summary = "Synchronize web pages to disk."
  spec.description = "Adds a rake task to easily sync web pages to files. Handy for instance when you want to use a web page as a fixture in your, possibly scraping related, tests and the web page changes often."
  spec.homepage = "https://github.com/wulffeld/sync_files"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wulffeld/sync_files"
  spec.metadata["changelog_uri"] = "https://github.com/wulffeld/sync_files/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "httparty"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "rspec-rails"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
