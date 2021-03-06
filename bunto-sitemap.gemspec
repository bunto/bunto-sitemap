# coding: utf-8

Gem::Specification.new do |spec|
  spec.name        = "bunto-sitemap"
  spec.summary     = "Automatically generate a sitemap.xml for your Bunto site."
  spec.version     = "4.0.0"
  spec.authors     = ["GitHub, Inc."]
  spec.email       = "support@github.com"
  spec.homepage    = "https://github.com/bunto/bunto-sitemap"
  spec.licenses    = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r!^bin/!) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r!^(test|spec|features)/!)
  spec.require_paths = ["lib"]

  spec.add_dependency "bunto", "~> 3.4"

  spec.add_development_dependency "bunto-last-modified-at", "2.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rubocop"
end
