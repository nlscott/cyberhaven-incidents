# frozen_string_literal: true

require_relative "lib/cyberhaven/incidents/version"
require_relative "lib/cyberhaven/incidents/id"
require_relative "lib/cyberhaven/incidents/user"
require_relative "lib/cyberhaven/incidents/policy"

Gem::Specification.new do |spec|
  spec.name = "cyberhaven-incidents"
  spec.version = Cyberhaven::Incidents::VERSION
  spec.authors = ["nic scott"]
  spec.email = ["nls.inbox@gmail.com"]

  spec.summary = "A ruby gem that interacts with the Cyberhaven Incident API"
  spec.homepage = "https://github.com/nlscott/cyberhaven-incidents"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
